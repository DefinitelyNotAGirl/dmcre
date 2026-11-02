#include <functional>
#include <iostream>

#include <dmcre/compile>
#include <dmcre/load>
#include <dmcre/platform>

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
#include <clang/Lex/PPCallbacks.h>

#include <llvm/ADT/IntrusiveRefCntPtr.h>
#include <llvm/Support/MemoryBuffer.h>
#include <llvm/TargetParser/Host.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/AssemblyAnnotationWriter.h>
#include <llvm/Support/TargetSelect.h>
#include <llvm/Support/raw_os_ostream.h>

void init() {
	dmcre::load::cxx::initialize();
}

dmcre::compile::ClangCompiler* getCompiler(
	llvm::StringRef Filename,
	clang::DiagnosticConsumer* DiagnosticConsumer
) {
	auto FileManager = new clang::FileManager(dmcre::load::cxx::internals::FileSystemOptions);
	FileManager->setVirtualFileSystem(llvm::vfs::getRealFileSystem());

	auto DiagnosticsEngine = new clang::DiagnosticsEngine(clang::DiagnosticIDs::create(),dmcre::load::cxx::internals::DiagnosticOptions,DiagnosticConsumer,false);

	auto SourceManager = new clang::SourceManager(*DiagnosticsEngine,*FileManager,true);
	DiagnosticsEngine->setSourceManager(SourceManager);

	return dmcre::load::cxx::GetCompilerForLanguageServer(
		DiagnosticsEngine,
		SourceManager,
		FileManager,
		&dmcre::load::cxx::config::HeaderSearchOptions,
		&dmcre::load::cxx::config::PreprocessorOptions,
		&dmcre::load::cxx::config::LanguageOptions,
		dmcre::load::cxx::internals::TargetInfo,
		&dmcre::load::cxx::config::CodeGenOptions,
		[DiagnosticsEngine,SourceManager,FileManager] {
			delete SourceManager;
			delete DiagnosticsEngine;
			delete FileManager;
		}
	);
}
