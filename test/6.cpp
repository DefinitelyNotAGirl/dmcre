#include <dmcre/load>
#include <dmcre/compile>
#include <dmcre/platform>
#include <dmcre/debug>

#include <clang/CodeGen/ModuleBuilder.h>
#include <clang/Frontend/TextDiagnosticPrinter.h>

void dmcre_onload() {
	std::cout << "test" << std::endl;

	clang::DiagnosticOptions DiagnosticOptions;
	auto DiagnosticConsumer = new clang::TextDiagnosticPrinter(llvm::errs(),DiagnosticOptions);

	clang::CodeGenOptions CodeGenOptions;
	CodeGenOptions.OptimizationLevel = 0;
	if(dmcre::platform == dmcre::Platform::Windows) {
		CodeGenOptions.setExceptionHandling(
			clang::CodeGenOptions::ExceptionHandlingKind::WinEH
		);
	}

	dmcre::debug::report();
	dmcre::compile::BasicCxxCompiler compiler(
		DiagnosticConsumer,
		dmcre::load::clangTargetInfo,
		dmcre::load::config::cxx::IncludeDirectories,
		CodeGenOptions
	);
	dmcre::debug::report();

	compiler.setMainFile("test.cpp", llvm::MemoryBuffer::getMemBufferCopy(llvm::StringRef("void dmcre_onload() {}")));
	dmcre::debug::report();

	auto codeGenerator = clang::CreateLLVMCodeGen(
		*compiler.getDiagnosticsEngine(),
		"test",
		compiler.getSourceManager()->getFileManager().getVirtualFileSystemPtr(),
		*compiler.getHeaderSearchOptions(),
		*compiler.getPreprocessorOptions(),
		CodeGenOptions,
		dmcre::load::llvmContext,
		nullptr
	);
	dmcre::debug::report();
	codeGenerator->Initialize(*compiler.getASTContext());
	dmcre::debug::report();

	dmcre::debug::report();
	compiler.compile(codeGenerator.get(),nullptr);
	dmcre::debug::report();

	dmcre::debug::report();
	auto module = codeGenerator->ReleaseModule();
	dmcre::debug::report();

	std::error_code ec;
	llvm::raw_fd_ostream out("test/6.ll",ec);
	module->print(out,nullptr);
	dmcre::debug::report();
}
