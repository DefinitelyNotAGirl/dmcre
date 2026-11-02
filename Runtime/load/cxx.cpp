#include <dmcre/load>
#include <dmcre/console>
#include <dmcre/debug>
#include <dmcre/platform>
#include <dmcre/install>
#include <dmcre/compile>

#include <fstream>

#include <clang/Frontend/ASTUnit.h>
#include <clang/CodeGen/CodeGenAction.h>
#include <clang/Frontend/FrontendOptions.h>
#include <clang/Frontend/TextDiagnosticPrinter.h>
#include <clang/Basic/DiagnosticIDs.h>
#include <clang/Lex/MacroInfo.h>
#include <clang/Lex/Preprocessor.h>
#include <clang/Lex/PreprocessorOptions.h>
#include <clang/Lex/Token.h>
#include <clang/Parse/Parser.h>
#include <clang/Parse/ParseAST.h>
#include <clang/CodeGen/ModuleBuilder.h>
#include <clang/Sema/EnterExpressionEvaluationContext.h>
#include <clang/Basic/DirectoryEntry.h>
#include <clang/Lex/PPCallbacks.h>
#include <clang/Frontend/MultiplexConsumer.h>
#include <clang/AST/RecordLayout.h>

#include <llvm/ADT/IntrusiveRefCntPtr.h>
#include <llvm/ADT/ArrayRef.h>
#include <llvm/Support/MemoryBuffer.h>
#include <llvm/TargetParser/Host.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/AssemblyAnnotationWriter.h>
#include <llvm/Support/TargetSelect.h>
#include <llvm/Support/raw_os_ostream.h>

namespace dmcre::load::cxx {
	bool initialized = false;

	class MainFileMacroCallbacks final : public clang::PPCallbacks {
		compile::ClangCompiler::Context* context;

		void setMacroEnabled(bool enabled, clang::SourceLocation location) {
			auto* name = this->context->Preprocessor->getIdentifierInfo("dmcre_IsMainFile");
			auto* varargs = this->context->Preprocessor->getIdentifierInfo("__VA_ARGS__");
			auto* macro = this->context->Preprocessor->AllocateMacroInfo(location);
			macro->setIsFunctionLike();
			macro->setIsC99Varargs();
			macro->setIsAllowRedefinitionsWithoutWarning(true);
			macro->setParameterList(
				llvm::ArrayRef<clang::IdentifierInfo*>(&varargs, 1),
				this->context->Preprocessor->getPreprocessorAllocator());

			if(enabled) {
				clang::Token token;
				token.startToken();
				token.setKind(clang::tok::identifier);
				token.setIdentifierInfo(varargs);
				token.setLocation(location);
				token.setLength(varargs->getLength());
				macro->setTokens(
					llvm::ArrayRef<clang::Token>(token),
					this->context->Preprocessor->getPreprocessorAllocator());
			}

			this->context->Preprocessor->appendDefMacroDirective(name, macro, location);
		}

	  public:
		MainFileMacroCallbacks(compile::ClangCompiler::Context* context)
			: context(context) {}

		void FileChanged(
			clang::SourceLocation location,
			FileChangeReason reason,
			clang::SrcMgr::CharacteristicKind,
			clang::FileID) override {
			if(reason != EnterFile && reason != ExitFile) {
				return;
			}

			// Rebind at file boundaries because macro expansion has no call-site callback.
			this->setMacroEnabled(
				this->context->SourceManager->isWrittenInMainFile(location),
				location
			);
		}
	};

	namespace config {
		DMCRE_PUBLIC_API clang::CodeGenOptions CodeGenOptions;
		DMCRE_PUBLIC_API clang::HeaderSearchOptions HeaderSearchOptions;

		DMCRE_PUBLIC_API clang::PreprocessorOptions PreprocessorOptions;
		DMCRE_PUBLIC_API clang::LangOptions LanguageOptions;
	} // namespace config

	namespace internals {

		DMCRE_PUBLIC_API clang::FileSystemOptions FileSystemOptions;
		DMCRE_PUBLIC_API clang::DiagnosticOptions DiagnosticOptions;
		DMCRE_PUBLIC_API clang::TargetOptions TargetOptions;

		DMCRE_PUBLIC_API clang::FileManager* FileManager = nullptr;
		DMCRE_PUBLIC_API clang::SourceManager* SourceManager = nullptr;
		DMCRE_PUBLIC_API clang::DiagnosticsEngine* DiagnosticsEngine = nullptr;
		DMCRE_PUBLIC_API clang::DiagnosticConsumer* DiagnosticConsumer = nullptr;
		DMCRE_PUBLIC_API clang::TargetInfo* TargetInfo = nullptr;
	} // namespace internals

	DMCRE_PUBLIC_API void initialize() {
		if(initialized) {
			return;
		}

		internals::FileManager = new clang::FileManager(internals::FileSystemOptions);
		internals::FileManager->setVirtualFileSystem(llvm::vfs::getRealFileSystem());

		internals::DiagnosticConsumer = new clang::TextDiagnosticPrinter(llvm::outs(), internals::DiagnosticOptions);

		internals::DiagnosticsEngine = new clang::DiagnosticsEngine(clang::DiagnosticIDs::create(), internals::DiagnosticOptions, internals::DiagnosticConsumer, false);

		internals::SourceManager = new clang::SourceManager(*internals::DiagnosticsEngine, *internals::FileManager, true);
		internals::DiagnosticsEngine->setSourceManager(internals::SourceManager);

		if(dmcre::platform == dmcre::Platform::Windows) {
			internals::TargetOptions.Triple = "x86_64-w64-windows-gnu";
		} else {
			internals::TargetOptions.Triple = llvm::sys::getDefaultTargetTriple();
		}
		internals::TargetOptions.CPU = llvm::sys::getHostCPUName().str();
		internals::TargetInfo = clang::TargetInfo::CreateTargetInfo(*internals::DiagnosticsEngine, internals::TargetOptions);

		std::vector<std::string> DummyIncludes;
		clang::LangOptions::setLangDefaults(config::LanguageOptions, clang::Language::CXX, internals::TargetInfo->getTriple(), DummyIncludes, clang::LangStandard::lang_cxx23);
#if defined(_WIN32)
		config::LanguageOptions.MicrosoftExt = true;
		config::LanguageOptions.DeclSpecKeyword = true;
		config::LanguageOptions.GNUMode = true;
		config::LanguageOptions.GNUCVersion = 40201;
#endif
#if defined(__APPLE__)
		config::languageOptions.GNUCVersion = 40201;
#endif
		config::LanguageOptions.Exceptions = true;
		config::LanguageOptions.CXXExceptions = true;
		config::LanguageOptions.CXXOperatorNames = true;
		config::LanguageOptions.RTTI = true;
		config::LanguageOptions.CPlusPlus11 = true;
		config::LanguageOptions.CPlusPlus14 = true;
		config::LanguageOptions.CPlusPlus17 = true;
		config::LanguageOptions.CPlusPlus20 = true;
		config::LanguageOptions.CPlusPlus23 = true;

		config::HeaderSearchOptions.ResourceDir = dmcre::InstallationDirectory + "/clang";
		config::HeaderSearchOptions.AddPath(
			dmcre::InstallationDirectory + "/clang/include",
			clang::frontend::ExternCSystem,
			false,
			true);
		for(auto& i : dmcre::load::CxxSystemIncludeDirectories) {
			config::HeaderSearchOptions.AddPath(
				i,
				clang::frontend::CXXSystem,
				false,
				false);
		}
		config::HeaderSearchOptions.AddPath(
			dmcre::InstallationDirectory + "/Headers/C++",
			clang::frontend::Angled,
			false,
			false);
		config::HeaderSearchOptions.AddPath(
			dmcre::InstallationDirectory + "/llvm-include",
			clang::frontend::Angled,
			false,
			false);

		config::PreprocessorOptions.UsePredefines = true;
#if defined(_WIN32)
		config::PreprocessorOptions.addMacroDef("_GLIBCXX_ASSERTIONS=1");
		config::PreprocessorOptions.addMacroDef("_GLIBCXX_EXTERN_TEMPLATE=-1");
#endif
		config::PreprocessorOptions.Includes.emplace_back("string");
		config::PreprocessorOptions.Includes.emplace_back("vector");
		config::PreprocessorOptions.Includes.emplace_back("dmcre/EnumStringConverter");

		config::CodeGenOptions.OptimizationLevel = 0;
		if(dmcre::platform == dmcre::Platform::Windows) {
			config::CodeGenOptions.setExceptionHandling(
				clang::CodeGenOptions::ExceptionHandlingKind::WinEH);
		}

		initialized = true;
	}

	class DMCRE_PUBLIC_API ReflectionSystem final : public clang::ASTConsumer, public clang::PPCallbacks {
		__private compile::ClangCompiler::Context* context;

		__private clang::NamespaceDecl* namespace_dmcre = nullptr;
		__private clang::NamespaceDecl* namespace_dmcre_reflection = nullptr;

		__private clang::FunctionDecl* function_dmcre_reflection_RegisterClassByStdTypeInfo = nullptr;

		__public ReflectionSystem(
			compile::ClangCompiler::Context* context
		): context(context) {
		}

		__private void AfterPredefines() {
			auto* tu = this->context->ASTContext->getTranslationUnitDecl();

			auto& dmcreName = this->context->ASTContext->Idents.get("dmcre");
			auto dmcreResult = tu->lookup(clang::DeclarationName(&dmcreName));

			for (clang::NamedDecl* decl : dmcreResult) {
			    if (auto* ns = llvm::dyn_cast<clang::NamespaceDecl>(decl)) {
			        namespace_dmcre = ns;
			        break;
			    }
			}
			if (not namespace_dmcre) {
				std::cerr << "dmcre namespace missing!" << std::endl;
			    return;
			}

			auto& reflectionName = this->context->ASTContext->Idents.get("reflection");
			auto reflectionResult = namespace_dmcre->getPrimaryContext()->lookup(
			    clang::DeclarationName(&reflectionName)
			);
					
			for (clang::NamedDecl* decl : reflectionResult) {
			    if (auto* ns = llvm::dyn_cast<clang::NamespaceDecl>(decl)) {
			        namespace_dmcre_reflection = ns;
			        break;
			    }
			}
			if (not namespace_dmcre_reflection) {
			    std::cerr << "dmcre::reflection namespace missing!" << std::endl;
			    return;
			}

			auto& FunctionIdentifier = this->context->ASTContext->Idents.get("RegisterClassByStdTypeInfo");
			auto FunctionResult = namespace_dmcre_reflection->getPrimaryContext()->lookup(
			    clang::DeclarationName(&FunctionIdentifier)
			);

			for (clang::NamedDecl* decl : FunctionResult) {
			    if (auto* function = llvm::dyn_cast<clang::FunctionDecl>(decl)) {
			        function_dmcre_reflection_RegisterClassByStdTypeInfo = function;
			        break;
			    }
			}

			if (not function_dmcre_reflection_RegisterClassByStdTypeInfo) {
			    std::cerr << "dmcre::reflection::RegisterClassByStdTypeInfo function missing!" << std::endl;
			    return;
			}
		}

		__public void FileChanged(clang::SourceLocation location,FileChangeReason reason,clang::SrcMgr::CharacteristicKind,clang::FileID previousFile) override {
			if (reason == ExitFile && previousFile == this->context->Preprocessor->getPredefinesFileID()) {
    		    AfterPredefines();
    		}
		}

		__private unsigned long long ctorFunctionCounter = 0;

		__private void GenerateConstructorFunction(
			clang::TranslationUnitDecl* TranslationUnit,
			std::function<void(
				clang::FunctionDecl* function,
				std::function<void(clang::Stmt*)> out
			)> GenerateStatements
		) {
			auto& initName = this->context->ASTContext->Idents.get("__dmcre_reflection_init_"+std::to_string(ctorFunctionCounter++));
			const clang::SourceLocation loc;

			llvm::SmallVector<clang::QualType, 0> noParams;
			auto initType = this->context->ASTContext->getFunctionType(
			    this->context->ASTContext->VoidTy,
			    noParams,
			    clang::FunctionProtoType::ExtProtoInfo()
			);

			auto* initFunction = clang::FunctionDecl::Create(
			    *this->context->ASTContext,
			    TranslationUnit,
			    loc,
			    loc,
			    clang::DeclarationName(&initName),
			    initType,
			    nullptr,
			    clang::SC_Static
			);

			std::vector<clang::Stmt*> statements;
			GenerateStatements(
				initFunction,
				[&](clang::Stmt* stmt) {
					statements.push_back(stmt);
				}
			);

			// Set a body containing the initialization work you want performed.
			initFunction->setBody(
				clang::CompoundStmt::Create(
					*this->context->ASTContext,
					statements,
					clang::FPOptionsOverride(),
					loc,
					loc
				)
			);

			initFunction->addAttr(
			    clang::ConstructorAttr::CreateImplicit(*this->context->ASTContext, nullptr)
			);

			TranslationUnit->addHiddenDecl(initFunction);
			context->ASTConsumer->HandleTopLevelDecl(clang::DeclGroupRef(initFunction));
		}

		__private void ReflectEnumDecl(clang::EnumDecl* EnumDecl) {
			for(clang::EnumConstantDecl* enumerator : EnumDecl->enumerators()) {
				std::cerr << EnumDecl->getDeclName().getAsString() << "::" << enumerator->getDeclName().getAsString() << std::endl;
			}

			clang::TranslationUnitDecl* TranslationUnit = this->context->ASTContext->getTranslationUnitDecl();

			clang::DeclContext* DeclContext = TranslationUnit;

			clang::QualType enumType = this->context->ASTContext->getTypeDeclType(llvm::cast<clang::TypeDecl>(EnumDecl));
			clang::QualType returnType = this->context->ASTContext->getPointerType(
				this->context->ASTContext->CharTy.withConst());

			clang::QualType parameterTypes[] = {enumType};
			auto functionType = this->context->ASTContext->getFunctionType(
				returnType,
				parameterTypes,
				clang::FunctionProtoType::ExtProtoInfo());

			auto& functionName = this->context->ASTContext->Idents.get("EnumeratorToString");
			auto& parameterName = this->context->ASTContext->Idents.get("value");

			auto* function = clang::FunctionDecl::Create(
				*this->context->ASTContext,
				DeclContext,
				clang::SourceLocation(),
				clang::SourceLocation(),
				clang::DeclarationName(&functionName),
				functionType,
				nullptr,
				clang::SC_Extern
			);

			auto* parameter = clang::ParmVarDecl::Create(
				*this->context->ASTContext,
				function,
				clang::SourceLocation(),
				clang::SourceLocation(),
				&parameterName,
				enumType,
				nullptr,
				clang::SC_None,
				nullptr
			);
			function->setParams({parameter});

			llvm::SmallVector<clang::Stmt*, 8> statements;
			const clang::SourceLocation loc;
			for(auto* enumerator : EnumDecl->enumerators()) {
				// Build:
				//   if (value == EnumName::Enumerator) return "Enumerator";
				//
				// These helpers stand for the corresponding Clang AST nodes:
				// DeclRefExprs, a BO_EQ BinaryOperator, an IfStmt, and a
				// ReturnStmt containing a StringLiteral.

				auto* ValueRef = clang::DeclRefExpr::Create(
					*this->context->ASTContext,
					clang::NestedNameSpecifierLoc(),
					loc,
					parameter,
					false,
					loc,
					parameter->getType(),
					clang::VK_LValue
				);

				auto* enumeratorRef = clang::DeclRefExpr::Create(
					*this->context->ASTContext,
					clang::NestedNameSpecifierLoc(),
					loc,
					enumerator,
					false,
					loc,
					enumerator->getType(),
					clang::VK_PRValue
				);

				auto* condition = clang::BinaryOperator::Create(
					*this->context->ASTContext,
					ValueRef,
					enumeratorRef,
					clang::BO_EQ,
					this->context->ASTContext->BoolTy,
					clang::VK_PRValue,
					clang::OK_Ordinary,
					loc,
					clang::FPOptionsOverride()
				);

				const std::string name = enumerator->getNameAsString();

				auto* stringLiteral = clang::StringLiteral::Create(
					*this->context->ASTContext,
					name,
					clang::StringLiteralKind::Ordinary,
					false,
					this->context->ASTContext->getStringLiteralArrayType(
						this->context->ASTContext->CharTy,
						static_cast<unsigned>(name.size() + 1)
					),
					loc
				);

				auto* returnValue = clang::ImplicitCastExpr::Create(
					*this->context->ASTContext,
					returnType,
					clang::CK_ArrayToPointerDecay,
					stringLiteral,
					nullptr,
					clang::VK_PRValue,
					clang::FPOptionsOverride()
				);

				auto* returnStmt = clang::ReturnStmt::Create(
					*this->context->ASTContext,
					loc,
					returnValue,
					nullptr
				);

				auto IfStmt = clang::IfStmt::Create(
					*this->context->ASTContext,
					loc,
					clang::IfStatementKind::Ordinary,
					nullptr,
					nullptr,
					condition,
					loc,
					loc,
					returnStmt,
					loc,
					nullptr
				);

				statements.push_back(IfStmt);
			}

			{
    			constexpr char message[] = "bad enumerator";

    			auto* literal = clang::StringLiteral::Create(
    			    *this->context->ASTContext,
    			    llvm::StringRef(message, sizeof(message) - 1),
    			    clang::StringLiteralKind::Ordinary,
    			    false,
    			    this->context->ASTContext->getStringLiteralArrayType(
    			        this->context->ASTContext->CharTy,
    			        sizeof(message)
    			    ),
    			    loc
    			);
			
    			statements.push_back(
					new (*this->context->ASTContext) clang::CXXThrowExpr(
					    literal,
					    this->context->ASTContext->VoidTy,
					    loc,
					    false
					)
				);
			}

			function->setBody(
				clang::CompoundStmt::Create(
					*this->context->ASTContext,
					statements,
					clang::FPOptionsOverride(),
					loc,
					loc
				)
			);

			DeclContext->addDecl(function);
			this->context->ASTConsumer->HandleTopLevelDecl(clang::DeclGroupRef(function));

			//
			// reflection init
			//
			this->GenerateConstructorFunction(TranslationUnit, [&](clang::FunctionDecl* function,std::function<void(clang::Stmt*)> out){
			});
		}

		__private void ReflectCXXRecordDecl(clang::CXXRecordDecl* CXXRecordDecl) {
			const clang::SourceLocation loc;

			clang::TranslationUnitDecl* TranslationUnit = this->context->ASTContext->getTranslationUnitDecl();

			//
			// reflection init
			//
			this->GenerateConstructorFunction(TranslationUnit, [&](clang::FunctionDecl* function,std::function<void(clang::Stmt*)> out){
				std::vector<clang::Expr*> args;
				args.push_back(
					new (*this->context->ASTContext) clang::CXXTypeidExpr(
						this->function_dmcre_reflection_RegisterClassByStdTypeInfo->getParamDecl(0)->getType().getNonReferenceType(),
						this->context->ASTContext->getTrivialTypeSourceInfo(
							this->context->ASTContext->getTypeDeclType(llvm::cast<clang::TypeDecl>(CXXRecordDecl))
						),
						clang::SourceRange(loc,loc)
					)
				);
				auto* registerCall = clang::CallExpr::Create(
					*this->context->ASTContext,
					clang::ImplicitCastExpr::Create(
						*this->context->ASTContext,
						this->context->ASTContext->getPointerType(
							this->function_dmcre_reflection_RegisterClassByStdTypeInfo->getType()
						),
						clang::CK_FunctionToPointerDecay,
						clang::DeclRefExpr::Create(
							*this->context->ASTContext,
							clang::NestedNameSpecifierLoc(),
							loc,
							this->function_dmcre_reflection_RegisterClassByStdTypeInfo,
							false,
							loc,
							this->function_dmcre_reflection_RegisterClassByStdTypeInfo->getType(),
							clang::VK_LValue
						),
						nullptr,
						clang::VK_PRValue,
						clang::FPOptionsOverride()
					),
					args,
					this->function_dmcre_reflection_RegisterClassByStdTypeInfo->getCallResultType(),
					clang::ExprValueKind::VK_PRValue,
					loc,
					clang::FPOptionsOverride(),
					0,
					clang::CallExpr::ADLCallKind::NotADL
				);

				auto& reflectedDeclName = this->context->ASTContext->Idents.get("reflectedDecl");
				auto* reflectedDecl = clang::VarDecl::Create(
					*this->context->ASTContext,
					function,
					loc,
					loc,
					&reflectedDeclName,
					registerCall->getType(),
					nullptr,
					clang::SC_None
				);
				reflectedDecl->setInit(registerCall);
				reflectedDecl->setInitStyle(clang::VarDecl::CInit);
				function->addDecl(reflectedDecl);
				out(new (*this->context->ASTContext) clang::DeclStmt(
					clang::DeclGroupRef(reflectedDecl),
					loc,
					loc
				));

				const clang::ASTRecordLayout& layout = context->ASTContext->getASTRecordLayout(CXXRecordDecl);

				for(clang::FieldDecl* field : CXXRecordDecl->fields()) {
					std::cerr << CXXRecordDecl->getDeclName().getAsString() << "::" << field->getDeclName().getAsString() << "@+" << layout.getFieldOffset(field->getFieldIndex()) << std::endl;
				}
			});
		}

		__public virtual void HandleTagDeclDefinition(clang::TagDecl* decl) override {
			if(this->context->SourceManager->isInMainFile(decl->getLocation())) {
				std::cerr << "tag decl: " << decl->getDeclName().getAsString() << std::endl;
				if(auto CXXRecordDecl = llvm::dyn_cast<clang::CXXRecordDecl>(decl)) {
					ReflectCXXRecordDecl(CXXRecordDecl);
				} else if(auto EnumDecl = llvm::dyn_cast<clang::EnumDecl>(decl)) {
					ReflectEnumDecl(EnumDecl);
				}
			}
		}
	};

	class DMCRE_PUBLIC_API EnumStringConverter final : public clang::ASTConsumer, public clang::PPCallbacks {
		__private compile::ClangCompiler::Context* context;

		__private clang::NamespaceDecl* namespace_dmcre = nullptr;
		__private clang::NamespaceDecl* namespace_std = nullptr;
		__private clang::CXXRecordDecl* class_std_string = nullptr;

		__public EnumStringConverter(
			compile::ClangCompiler::Context* context
		): context(context) {
		}

		__private void AfterPredefines() {
			auto* tu = this->context->ASTContext->getTranslationUnitDecl();

			auto& dmcreName = this->context->ASTContext->Idents.get("dmcre");
			auto dmcreResult = tu->lookup(clang::DeclarationName(&dmcreName));

			for (clang::NamedDecl* decl : dmcreResult) {
			    if (auto* ns = llvm::dyn_cast<clang::NamespaceDecl>(decl)) {
			        namespace_dmcre = ns;
			        break;
			    }
			}
			if (not namespace_dmcre) {
				std::cerr << "dmcre namespace missing!" << std::endl;
			    return;
			}
		}

		__public void FileChanged(clang::SourceLocation location,FileChangeReason reason,clang::SrcMgr::CharacteristicKind,clang::FileID previousFile) override {
			if (reason == ExitFile && previousFile == this->context->Preprocessor->getPredefinesFileID()) {
    		    AfterPredefines();
    		}
		}

		__private void GenerateFunctionsForEnumDecl(clang::EnumDecl* EnumDecl) {
			clang::TranslationUnitDecl* TranslationUnit = this->context->ASTContext->getTranslationUnitDecl();

			clang::DeclContext* DeclContext = TranslationUnit;

			clang::QualType enumType = this->context->ASTContext->getTypeDeclType(llvm::cast<clang::TypeDecl>(EnumDecl));
			clang::QualType returnType = this->context->ASTContext->getPointerType(
				this->context->ASTContext->CharTy.withConst());

			clang::QualType parameterTypes[] = {enumType};
			auto functionType = this->context->ASTContext->getFunctionType(
				returnType,
				parameterTypes,
				clang::FunctionProtoType::ExtProtoInfo());

			auto& functionName = this->context->ASTContext->Idents.get("EnumeratorToString");
			auto& parameterName = this->context->ASTContext->Idents.get("value");

			auto* function = clang::FunctionDecl::Create(
				*this->context->ASTContext,
				DeclContext,
				clang::SourceLocation(),
				clang::SourceLocation(),
				clang::DeclarationName(&functionName),
				functionType,
				nullptr,
				clang::SC_Extern
			);

			auto* parameter = clang::ParmVarDecl::Create(
				*this->context->ASTContext,
				function,
				clang::SourceLocation(),
				clang::SourceLocation(),
				&parameterName,
				enumType,
				nullptr,
				clang::SC_None,
				nullptr
			);
			function->setParams({parameter});

			llvm::SmallVector<clang::Stmt*, 8> statements;
			const clang::SourceLocation loc;
			for(auto* enumerator : EnumDecl->enumerators()) {
				// Build:
				//   if (value == EnumName::Enumerator) return "Enumerator";
				//
				// These helpers stand for the corresponding Clang AST nodes:
				// DeclRefExprs, a BO_EQ BinaryOperator, an IfStmt, and a
				// ReturnStmt containing a StringLiteral.

				auto* ValueRef = clang::DeclRefExpr::Create(
					*this->context->ASTContext,
					clang::NestedNameSpecifierLoc(),
					loc,
					parameter,
					false,
					loc,
					parameter->getType(),
					clang::VK_LValue
				);

				auto* enumeratorRef = clang::DeclRefExpr::Create(
					*this->context->ASTContext,
					clang::NestedNameSpecifierLoc(),
					loc,
					enumerator,
					false,
					loc,
					enumerator->getType(),
					clang::VK_PRValue
				);

				auto* condition = clang::BinaryOperator::Create(
					*this->context->ASTContext,
					ValueRef,
					enumeratorRef,
					clang::BO_EQ,
					this->context->ASTContext->BoolTy,
					clang::VK_PRValue,
					clang::OK_Ordinary,
					loc,
					clang::FPOptionsOverride()
				);

				const std::string name = enumerator->getNameAsString();

				auto* stringLiteral = clang::StringLiteral::Create(
					*this->context->ASTContext,
					name,
					clang::StringLiteralKind::Ordinary,
					false,
					this->context->ASTContext->getStringLiteralArrayType(
						this->context->ASTContext->CharTy,
						static_cast<unsigned>(name.size() + 1)
					),
					loc
				);

				auto* returnValue = clang::ImplicitCastExpr::Create(
					*this->context->ASTContext,
					returnType,
					clang::CK_ArrayToPointerDecay,
					stringLiteral,
					nullptr,
					clang::VK_PRValue,
					clang::FPOptionsOverride()
				);

				auto* returnStmt = clang::ReturnStmt::Create(
					*this->context->ASTContext,
					loc,
					returnValue,
					nullptr
				);

				auto IfStmt = clang::IfStmt::Create(
					*this->context->ASTContext,
					loc,
					clang::IfStatementKind::Ordinary,
					nullptr,
					nullptr,
					condition,
					loc,
					loc,
					returnStmt,
					loc,
					nullptr
				);

				statements.push_back(IfStmt);
			}

			{
    			constexpr char message[] = "bad enumerator";

    			auto* literal = clang::StringLiteral::Create(
    			    *this->context->ASTContext,
    			    llvm::StringRef(message, sizeof(message) - 1),
    			    clang::StringLiteralKind::Ordinary,
    			    false,
    			    this->context->ASTContext->getStringLiteralArrayType(
    			        this->context->ASTContext->CharTy,
    			        sizeof(message)
    			    ),
    			    loc
    			);
			
    			statements.push_back(
					new (*this->context->ASTContext) clang::CXXThrowExpr(
					    literal,
					    this->context->ASTContext->VoidTy,
					    loc,
					    false
					)
				);
			}

			function->setBody(
				clang::CompoundStmt::Create(
					*this->context->ASTContext,
					statements,
					clang::FPOptionsOverride(),
					loc,
					loc
				)
			);

			DeclContext->addDecl(function);
			this->context->ASTConsumer->HandleTopLevelDecl(clang::DeclGroupRef(function));
		}

		__public virtual void HandleTagDeclDefinition(clang::TagDecl* decl) override {
			if(this->context->SourceManager->isInMainFile(decl->getLocation())) {
				if(auto EnumDecl = llvm::dyn_cast<clang::EnumDecl>(decl)) {
					GenerateFunctionsForEnumDecl(EnumDecl);
				}
			}
		}
	};

	class DMCRE_PUBLIC_API Compiler final : public compile::ClangCompiler {
		__private clang::FrontendOptions* FrontendOptions;

		// objects we own
		__private clang::ASTContext* ASTContext = nullptr;
		__private clang::Preprocessor* Preprocessor = nullptr;
		__private clang::HeaderSearch* HeaderSearch = nullptr;
		__private clang::TrivialModuleLoader* ModuleLoader = nullptr;
		__private clang::Sema* Sema = nullptr;
		__private clang::MultiplexConsumer* MultiplexConsumer = nullptr;
		__private Context* Context;

		// weak references
		__private clang::DiagnosticsEngine* DiagnosticsEngine;
		__private clang::SourceManager* SourceManager;
		__private clang::FileManager* FileManager;
		__private clang::HeaderSearchOptions* HeaderSearchOptions;
		__private clang::PreprocessorOptions* PreprocessorOptions;
		__private clang::LangOptions* LanguageOptions;
		__private clang::TargetInfo* TargetInfo;
		__private clang::CodeGenOptions* CodeGenOptions;

		__private std::vector<std::function<void()>> onDestroy;

		__private void init() {
			this->Context = new class Context;
			this->Context->SourceManager = this->SourceManager;
			this->Context->FileManager = this->FileManager;
			this->Context->DiagnosticsEngine = this->DiagnosticsEngine;

			this->FrontendOptions = new clang::FrontendOptions;

			clang::PCHContainerOperations pchContainerOperations;

			this->HeaderSearch = new clang::HeaderSearch(*this->HeaderSearchOptions, *this->SourceManager, *this->DiagnosticsEngine, *this->LanguageOptions, this->TargetInfo);
			clang::ApplyHeaderSearchOptions(*this->HeaderSearch, *this->HeaderSearchOptions, *this->LanguageOptions, this->TargetInfo->getTriple());
			this->Context->HeaderSearch = this->HeaderSearch;

			this->ModuleLoader = new clang::TrivialModuleLoader;

			this->Preprocessor = new clang::Preprocessor(
				*this->PreprocessorOptions,
				*this->DiagnosticsEngine,
				*this->LanguageOptions,
				*this->SourceManager,
				*this->HeaderSearch,
				*this->ModuleLoader,
				nullptr,
				false,
				clang::TranslationUnitKind::TU_Complete);

			this->Preprocessor->Initialize(*this->TargetInfo);

			this->Context->Preprocessor = this->Preprocessor;

			this->Preprocessor->getBuiltinInfo().initializeBuiltins(
				this->Preprocessor->getIdentifierTable(),
				this->Preprocessor->getLangOpts());
			clang::InitializePreprocessor(*this->Preprocessor, *this->PreprocessorOptions, pchContainerOperations.getRawReader(), *this->FrontendOptions, *this->CodeGenOptions);

			this->ASTContext = new clang::ASTContext(
				*this->LanguageOptions,
				*this->SourceManager,
				this->Preprocessor->getIdentifierTable(),
				this->Preprocessor->getSelectorTable(),
				this->Preprocessor->getBuiltinInfo(),
				clang::TranslationUnitKind::TU_Complete);
			this->ASTContext->InitBuiltinTypes(*this->TargetInfo);
			this->Context->ASTContext = this->ASTContext;
		}

		__public Compiler() {
			this->DiagnosticsEngine = internals::DiagnosticsEngine;
			this->SourceManager = internals::SourceManager;
			this->FileManager = internals::FileManager;
			this->HeaderSearchOptions = &config::HeaderSearchOptions;
			this->PreprocessorOptions = &config::PreprocessorOptions;
			this->LanguageOptions = &config::LanguageOptions;
			this->TargetInfo = internals::TargetInfo;
			this->CodeGenOptions = &config::CodeGenOptions;

			init();
		}

		__public Compiler(
			clang::DiagnosticsEngine* DiagnosticsEngine,
			clang::SourceManager* SourceManager,
			clang::FileManager* FileManager,
			clang::HeaderSearchOptions* HeaderSearchOptions,
			clang::PreprocessorOptions* PreprocessorOptions,
			clang::LangOptions* LanguageOptions,
			clang::TargetInfo* TargetInfo,
			clang::CodeGenOptions* CodeGenOptions,
			std::function<void()> onDestroy
		) {
			this->DiagnosticsEngine = DiagnosticsEngine;
			this->SourceManager = SourceManager;
			this->FileManager = FileManager;
			this->HeaderSearchOptions = HeaderSearchOptions;
			this->PreprocessorOptions = PreprocessorOptions;
			this->LanguageOptions = LanguageOptions;
			this->TargetInfo = TargetInfo;
			this->CodeGenOptions = CodeGenOptions;
			this->onDestroy.push_back(onDestroy);

			init();
		}

		__public virtual ~Compiler() {
			delete this->Sema;
			delete this->MultiplexConsumer;
			delete this->ASTContext;
			delete this->Preprocessor;
			delete this->HeaderSearch;
			delete this->ModuleLoader;

			delete this->FrontendOptions;

			delete this->Context;

			for(auto& f : this->onDestroy) {
				f();
			}
		}

		__public virtual clang::DiagnosticsEngine* getDiagnosticsEngine() override {
			return this->DiagnosticsEngine;
		}

		__public virtual clang::Preprocessor* getPreprocessor() override {
			return this->Preprocessor;
		}

		__public virtual clang::SourceManager* getSourceManager() override {
			return this->SourceManager;
		}

		__public virtual clang::ASTContext* getASTContext() override {
			return this->ASTContext;
		}

		__public virtual clang::Sema* getSema() override {
			return this->Sema;
		}

		__public virtual class Context* getContext() override {
			return this->Context;
		}

		__public virtual clang::CodeGenOptions* getCodeGenOptions() override {
			return this->CodeGenOptions;
		}

		__private std::vector<clang::ASTConsumer*> ASTConsumers;

		__public virtual void addASTConsumer(clang::ASTConsumer* ASTConsumer) override {
			this->ASTConsumers.push_back(ASTConsumer);
		}

		__public virtual void addPPCallbacks(clang::PPCallbacks* PPCallbacks) override {
			this->Preprocessor->addPPCallbacks(std::make_unique<compile::BorrowedPPCallbacks>(PPCallbacks));
		}

		__public virtual clang::HeaderSearchOptions* getHeaderSearchOptions() override {
			return this->HeaderSearchOptions;
		}

		__public virtual clang::PreprocessorOptions* getPreprocessorOptions() override {
			return this->PreprocessorOptions;
		}

		__public virtual clang::LangOptions* getLanguageOptions() override {
			return this->LanguageOptions;
		}

		__public virtual clang::FileID setMainFile(llvm::StringRef Filename, std::unique_ptr<llvm::MemoryBuffer> content) override {
			auto File = this->FileManager->getVirtualFileRef(Filename, content->getBufferSize(), 0);
			this->SourceManager->overrideFileContents(File, std::move(content));
			auto fileID = this->SourceManager->createFileID(File, clang::SourceLocation(), clang::SrcMgr::C_User);

			this->SourceManager->setMainFileID(fileID);

			return fileID;
		}

		__public virtual std::string getCompilerAndConfigurationId() override {
			return "";
		}

		__public virtual void addDestructor(std::function<void()> destructor) override {
			this->onDestroy.push_back(destructor);
		}

		__public virtual void InitializeSema(clang::CodeCompleteConsumer* CodeCompleteConsumer = nullptr) override {
			std::vector<std::unique_ptr<clang::ASTConsumer>> consumers;
			for(clang::ASTConsumer* consumer : this->ASTConsumers) {
				consumers.push_back(std::make_unique<compile::BorrowedConsumer>(consumer));
			}
			this->MultiplexConsumer = new clang::MultiplexConsumer(std::move(consumers));
			this->Context->ASTConsumer = this->MultiplexConsumer;

			this->Sema = new clang::Sema(
				*this->Preprocessor,
				*this->ASTContext,
				*this->MultiplexConsumer,
				clang::TranslationUnitKind::TU_Complete,
				CodeCompleteConsumer);

			this->Sema->Initialize();

			this->Context->Sema = this->Sema;
		}

		__public virtual void compile() override {
			clang::Parser parser(*this->Preprocessor, *this->Sema, false);

			//std::cerr << "EnterMainSourceFile()" << std::endl;
			this->Preprocessor->EnterMainSourceFile();

			bool HaveLexer = this->Sema->getPreprocessor().getCurrentLexer();
			if(HaveLexer) {
				parser.Initialize();

				clang::Parser::DeclGroupPtrTy declGroup;
				clang::Sema::ModuleImportState importState;
				clang::EnterExpressionEvaluationContext PotentiallyEvaluated(*this->Sema, clang::Sema::ExpressionEvaluationContext::PotentiallyEvaluated);

				for(bool AtEOF = parser.ParseFirstTopLevelDecl(declGroup, importState); !AtEOF; AtEOF = parser.ParseTopLevelDecl(declGroup, importState)) {
					// If we got a null return and something *was* parsed, ignore it.  This
					// is due to a top-level semicolon, an action override, or a parse error skipping something.
					if(declGroup && !this->Sema->getASTConsumer().HandleTopLevelDecl(declGroup.get())) {
						break;
					}
				}
			}

			this->Sema->ActOnEndOfTranslationUnit();

			for(clang::Decl* decl : this->Sema->WeakTopLevelDecls()) {
				this->Sema->getASTConsumer().HandleTopLevelDecl(clang::DeclGroupRef(decl));
			}

			this->Sema->getASTConsumer().HandleTranslationUnit(this->Sema->getASTContext());
		}
	};

	static void AttachCompilerExtensions(Compiler* compiler) {
		auto EnumStringConverter = new class EnumStringConverter(compiler->getContext());
		compiler->addPPCallbacks(EnumStringConverter);
		compiler->addASTConsumer(EnumStringConverter);

		compiler->getContext()->Preprocessor->addPPCallbacks(std::make_unique<MainFileMacroCallbacks>(compiler->getContext()));

		compiler->addDestructor([EnumStringConverter]{
			delete EnumStringConverter;
		});
	} 

	DMCRE_PUBLIC_API compile::ClangCompiler* GetCompiler() {
		auto compiler = new Compiler();

		AttachCompilerExtensions(compiler);

		return compiler;
	}

	DMCRE_PUBLIC_API compile::ClangCompiler* GetCompilerForLanguageServer(
		clang::DiagnosticsEngine* DiagnosticsEngine,
		clang::SourceManager* SourceManager,
		clang::FileManager* FileManager,
		clang::HeaderSearchOptions* HeaderSearchOptions,
		clang::PreprocessorOptions* PreprocessorOptions,
		clang::LangOptions* LanguageOptions,
		clang::TargetInfo* TargetInfo,
		clang::CodeGenOptions* CodeGenOptions,
		std::function<void()> onDestroy
	) {
		auto compiler = new Compiler(
			DiagnosticsEngine,
			SourceManager,
			FileManager,
			HeaderSearchOptions,
			PreprocessorOptions,
			LanguageOptions,
			TargetInfo,
			CodeGenOptions,
			onDestroy
		);

		AttachCompilerExtensions(compiler);

		return compiler;
	}

	DMCRE_PUBLIC_API llvm::Module* ToModule(Domain domain, std::filesystem::path path) {
		console.info("load C++ " + path.string());
		auto resolved = ResolvePath(domain, path);
		std::ifstream stream(resolved, std::ios_base::binary);
		std::string code;
		stream.seekg(0, std::ios::end);
		code.resize(stream.tellg());
		stream.seekg(0);
		stream.read(code.data(), code.size());
		stream.close();
		return ToModule(code, path.filename().string());
	}

	class DependencyRecorder : public clang::PPCallbacks {
		__public std::set<std::string> IncludeDependencies;
		__private compile::ClangCompiler::Context* context;

		__public DependencyRecorder(compile::ClangCompiler::Context* context): context(context) {
		}

		__public virtual void InclusionDirective(
			clang::SourceLocation HashLoc,
			const clang::Token& IncludeTok, clang::StringRef FileName,
			bool IsAngled, clang::CharSourceRange FilenameRange,
			clang::OptionalFileEntryRef File,
			clang::StringRef SearchPath, clang::StringRef RelativePath,
			const clang::Module* SuggestedModule,
			bool ModuleImported,
			clang::SrcMgr::CharacteristicKind FileType
		) {
			std::string path = File->getName().str();

			for(auto& i : CxxSystemIncludeDirectories) {
				if(path.starts_with(i)) {
					return;
				}
			}

			for(auto& i : {
				dmcre::InstallationDirectory + "/clang/include",
				dmcre::InstallationDirectory + "/llvm-include"
			}) {
				if(path.starts_with(i)) {
					return;
				}
			}

			if(IsAngled) {
				IncludeDependencies.insert("<"+FileName.str()+">");
			} else {
				const auto& entry = File->getFileEntry();
    			clang::StringRef realPath = entry.tryGetRealPathName();
    			std::string path = (realPath.empty() ? File->getName() : realPath).str();
				IncludeDependencies.insert(path);
			}
		}
	};

	DMCRE_PUBLIC_API llvm::Module* ToModule(std::string code, std::string name) {
		auto compiler = GetCompiler();

		auto DependencyRecorder = new class DependencyRecorder(compiler->getContext());
		compiler->addPPCallbacks(DependencyRecorder);

		compiler->setMainFile(name, llvm::MemoryBuffer::getMemBufferCopy(llvm::StringRef(code)));

		internals::DiagnosticConsumer->BeginSourceFile(*compiler->getLanguageOptions(), compiler->getPreprocessor());

		auto codeGenerator = clang::CreateLLVMCodeGen(
			*compiler->getDiagnosticsEngine(),
			name,
			compiler->getSourceManager()->getFileManager().getVirtualFileSystemPtr(),
			*compiler->getHeaderSearchOptions(),
			*compiler->getPreprocessorOptions(),
			config::CodeGenOptions,
			dmcre::load::llvmContext,
			nullptr
		);
		codeGenerator->Initialize(*compiler->getASTContext());

		compiler->addASTConsumer(codeGenerator.get());

		compiler->InitializeSema();

		compiler->compile();

		internals::DiagnosticConsumer->EndSourceFile();

		auto module = codeGenerator->ReleaseModule().release();

		module->getOrInsertNamedMetadata("dmcre.module.mtime")->addOperand(llvm::MDNode::get(module->getContext(),llvm::MDString::get(module->getContext(), std::to_string(std::filesystem::file_time_type::clock::now().time_since_epoch().count()))));

		module->getOrInsertNamedMetadata("dmcre.source.type")->addOperand(llvm::MDNode::get(module->getContext(),llvm::MDString::get(module->getContext(), "C++")));;

		module->getOrInsertNamedMetadata("dmcre.source.directory")->addOperand(llvm::MDNode::get(module->getContext(),llvm::MDString::get(module->getContext(), std::filesystem::current_path().string())));;

		llvm::SmallVector<llvm::Metadata *, 4> dmcre_cache_include_Items;
		for (const std::string& S : DependencyRecorder->IncludeDependencies) {
			dmcre_cache_include_Items.push_back(llvm::MDString::get(module->getContext(), S));
		}
		module->getOrInsertNamedMetadata("dmcre.cache.include")->addOperand(llvm::MDNode::get(module->getContext(), dmcre_cache_include_Items));

		delete compiler;

		delete DependencyRecorder;

		return module;
	}

	DMCRE_PUBLIC_API llvm::orc::JITDylib* ToProcess(std::string code, std::string name) {
		console.info("load C++\n" + code);

		std::vector<llvm::Module*> modules = {ToModule(code, name)};

		return llvm_IR::ToProcess(modules, name);
	}

	DMCRE_PUBLIC_API llvm::orc::JITDylib* ToProcess(Domain domain, std::filesystem::path path) {
		console.info("load C++ " + path.string());
		auto resolved = ResolvePath(domain, path);
		std::ifstream stream(resolved, std::ios_base::binary);
		std::string code;
		stream.seekg(0, std::ios::end);
		code.resize(stream.tellg());
		stream.seekg(0);
		stream.read(code.data(), code.size());
		stream.close();
		return ToProcess(code, path.filename().string());
	}

	DMCRE_PUBLIC_API llvm::orc::JITDylib* ToProcess(std::vector<FileSpecifier> files, std::string name) {
		std::vector<llvm::Module*> modules;

		for(auto& file : files) {
			console.info("load C++ " + file.path.string());
			auto resolved = ResolvePath(file.domain, file.path);
			std::ifstream stream(resolved, std::ios_base::binary);
			std::string code;
			stream.seekg(0, std::ios::end);
			code.resize(stream.tellg());
			stream.seekg(0);
			stream.read(code.data(), code.size());
			stream.close();
			modules.push_back(ToModule(code, file.path.string()));
		}

		return llvm_IR::ToProcess(modules, name);
	}
}