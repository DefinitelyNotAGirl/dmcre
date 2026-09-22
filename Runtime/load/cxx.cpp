#include <dmcre/load>
#include <dmcre/console>
#include <dmcre/debug>

#include <fstream>

#include <clang/Frontend/ASTUnit.h>
#include <clang/CodeGen/CodeGenAction.h>
#include <clang/Frontend/FrontendOptions.h>
#include <clang/Frontend/TextDiagnosticPrinter.h>
#include <clang/Basic/DiagnosticIDs.h>
#include <clang/Lex/Preprocessor.h>
#include <clang/Lex/PreprocessorOptions.h>
#include <clang/Parse/Parser.h>
#include <clang/Parse/ParseAST.h>
#include <clang/CodeGen/ModuleBuilder.h>
#include <clang/Sema/EnterExpressionEvaluationContext.h>
#include <clang/Basic/DirectoryEntry.h>

#include <llvm/ADT/IntrusiveRefCntPtr.h>
#include <llvm/Support/MemoryBuffer.h>
#include <llvm/TargetParser/Host.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/AssemblyAnnotationWriter.h>
#include <llvm/Support/TargetSelect.h>
#include <llvm/Support/raw_os_ostream.h>

namespace dmcre::load {
	void cxx(std::string code,std::string name) {
		console.info("load C++\n"+code);

		auto inputBuffer = llvm::MemoryBuffer::getMemBufferCopy(llvm::StringRef(code),name);

		//
		// source manager
		//
		clangSourceManager = new clang::SourceManager(*clangDiagnosticsEngine,*clangFileManager,true);
		clangDiagnosticsEngine->setSourceManager(clangSourceManager);

		clang::FrontendOptions frontendOptions;
		clang::PCHContainerOperations pchContainerOperations;

		clang::LangOptions languageOptions;
		std::vector<std::string> includes;
		clang::LangOptions::setLangDefaults(languageOptions, clang::Language::CXX, clangTargetInfo->getTriple(), includes, clang::LangStandard::lang_cxx23);
		languageOptions.GNUCVersion = 40201;
		languageOptions.Exceptions = true;
		languageOptions.CXXExceptions = true;
		languageOptions.CXXOperatorNames = true;
		languageOptions.RTTI = true;

		auto fileID = clangSourceManager->createFileID(
		    std::move(inputBuffer),
			clang::SrcMgr::C_User
		);

		clangSourceManager->setMainFileID(fileID);

		clang::HeaderSearchOptions headerSearchOptions;
		//headerSearchOptions.ResourceDir = "/Volumes/programming/dmcre/llvm-project/build/lib/clang/24";
		headerSearchOptions.AddPath(
			"/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX26.sdk/usr/include/c++/v1",
		    clang::frontend::CXXSystem,
		    false,
		    false
		);
		headerSearchOptions.AddPath(
			"/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX26.sdk/usr/include",
		    clang::frontend::System,
		    false,
		    false
		);
		headerSearchOptions.AddPath(
		    "/Volumes/programming/dmcre/llvm-project/build/lib/clang/24/include",
		    clang::frontend::ExternCSystem,
		    false,
		    true
		);
		headerSearchOptions.AddPath(
			"/Users/lilith/dmcre_2026092000/Headers/C++",
		    clang::frontend::Angled,
		    false,
		    false
		);
		for(auto i : {
			"/llvm-project/clang/include",
			"/llvm-project/build/tools/clang/include",
			"/llvm-project/build/include",
			"/llvm-project/llvm/include",
		}) {
			headerSearchOptions.AddPath(
				std::string("/Volumes/programming/dmcre")+i,
			    clang::frontend::Angled,
			    false,
			    false
			);
		}
		clang::HeaderSearch headerSearch(headerSearchOptions,*clangSourceManager,*clangDiagnosticsEngine,languageOptions,clangTargetInfo);
		clang::ApplyHeaderSearchOptions(headerSearch, headerSearchOptions, languageOptions, clangTargetInfo->getTriple());

		clang::TrivialModuleLoader moduleLoader;

		clang::PreprocessorOptions PreprocessorOptions;
		PreprocessorOptions.UsePredefines = true;
		PreprocessorOptions.addMacroDef("DMCRE_MODULE=\""+name+"\"");

		clang::CodeGenOptions codegenOptions;
		codegenOptions.OptimizationLevel = 0;

		clang::Preprocessor Preprocessor(
			PreprocessorOptions,
			*clangDiagnosticsEngine,
			languageOptions,
			*clangSourceManager,
			headerSearch,
			moduleLoader,
			nullptr,
			false,
			clang::TranslationUnitKind::TU_Complete
		);

		Preprocessor.Initialize(*clangTargetInfo);

		Preprocessor.getBuiltinInfo().InitializeTarget(*clangTargetInfo, nullptr);
		Preprocessor.getBuiltinInfo().initializeBuiltins(
			Preprocessor.getIdentifierTable(),
    		Preprocessor.getLangOpts()
		);
		clang::InitializePreprocessor(Preprocessor, PreprocessorOptions, pchContainerOperations.getRawReader(), frontendOptions, codegenOptions);

		clang::ASTContext astContext(
			languageOptions,
			*clangSourceManager,
			Preprocessor.getIdentifierTable(),
    		Preprocessor.getSelectorTable(),
    		Preprocessor.getBuiltinInfo(),
			clang::TranslationUnitKind::TU_Complete
		);
		astContext.InitBuiltinTypes(*clangTargetInfo);

		auto codeGenerator = clang::CreateLLVMCodeGen(*clangDiagnosticsEngine,"test",llvmVirtualFileSystem,headerSearchOptions,PreprocessorOptions,codegenOptions,llvmContext,nullptr);
		codeGenerator->Initialize(astContext);

		clangDiagnosticConsumer->BeginSourceFile(languageOptions, &Preprocessor);

		clang::Sema sema(Preprocessor,astContext,*codeGenerator,clang::TranslationUnitKind::TU_Complete);

		clang::Scope GlobalScope(nullptr, clang::Scope::DeclScope, astContext.getDiagnostics());
		sema.ActOnTranslationUnitScope(&GlobalScope);
		sema.Initialize();

		clang::Parser parser(Preprocessor, sema, false);

		Preprocessor.EnterMainSourceFile();
		bool HaveLexer = sema.getPreprocessor().getCurrentLexer();
		if(HaveLexer) {
			parser.Initialize();

			clang::Parser::DeclGroupPtrTy declGroup;
			clang::Sema::ModuleImportState importState;
			clang::EnterExpressionEvaluationContext PotentiallyEvaluated(sema, clang::Sema::ExpressionEvaluationContext::PotentiallyEvaluated);

			for (bool AtEOF = parser.ParseFirstTopLevelDecl(declGroup, importState); !AtEOF; AtEOF = parser.ParseTopLevelDecl(declGroup, importState)) {
    		  	// If we got a null return and something *was* parsed, ignore it.  This
    		  	// is due to a top-level semicolon, an action override, or a parse error skipping something.
    		  	if (declGroup && !codeGenerator->HandleTopLevelDecl(declGroup.get())) {
					break;
				}
    		}
		}

		for(clang::Decl* decl : sema.WeakTopLevelDecls()) {
			codeGenerator->HandleTopLevelDecl(clang::DeclGroupRef(decl));
		}

		codeGenerator->HandleTranslationUnit(sema.getASTContext());

		clangDiagnosticConsumer->EndSourceFile();

		auto Module = codeGenerator->ReleaseModule();

		if (Module) {
			//Module->print(llvm::outs(), nullptr);

			llvmModule(std::move(Module));
  		}
	}

	void cxx(Domain domain,std::filesystem::path path) {
		console.info("load C++ "+path.string());
		auto resolved = ResolvePath(domain, path);
		std::ifstream stream(resolved,std::ios_base::binary);
		std::string code;
		stream.seekg(0,std::ios::end);
		code.resize(stream.tellg());
		stream.seekg(0);
		stream.read(code.data(), code.size());
		stream.close();
		cxx(code,path);
	}
}