#include <dmcre/load>

#include <llvm/Support/TargetSelect.h>
#include <llvm/TargetParser/Host.h>

namespace dmcre::load {
	llvm::LLVMContext llvmContext;
	std::unique_ptr<llvm::orc::LLJIT> llvmJIT;
	llvm::IntrusiveRefCntPtr<llvm::vfs::FileSystem> llvmVirtualFileSystem;

	clang::TargetOptions clangTargetOptions;
	clang::TargetInfo* clangTargetInfo = nullptr;

	clang::FileSystemOptions clangFilesystemOptions;
	clang::FileManager* clangFileManager = nullptr;

	clang::SourceManager* clangSourceManager = nullptr;

	clang::DiagnosticsEngine* clangDiagnosticsEngine = nullptr;
	clang::DiagnosticConsumer* clangDiagnosticConsumer = nullptr;
	void InitializeClangDiagnosticsEngine();

	void initialize() {
		//
		// LLVM
		//
		llvm::InitializeNativeTarget();
    	llvm::InitializeNativeTargetAsmPrinter();

		//
		// file system
		//
		llvmVirtualFileSystem = llvm::vfs::getRealFileSystem();

		//
		// JIT
		//
		llvm::orc::LLJITBuilder jitBuilder;
		auto jitExpected = jitBuilder.create();
		if(not jitExpected) {
			throw std::runtime_error("failed to create llvmJIT");
		}

		llvmJIT = std::move(*jitExpected);

		auto& mainJD = llvmJIT->getMainJITDylib();

		auto hostSymbols = llvm::orc::DynamicLibrarySearchGenerator::GetForCurrentProcess(llvmJIT->getDataLayout().getGlobalPrefix());

		if (!hostSymbols) {
			throw std::runtime_error("Unable to access host-process symbols");
		}

		mainJD.addGenerator(std::move(*hostSymbols));

		//
		// diagnostics
		//
		InitializeClangDiagnosticsEngine();

		//
		// file manager
		//
		clangFileManager = new clang::FileManager(clangFilesystemOptions);
		clangFileManager->setVirtualFileSystem(llvmVirtualFileSystem);

		//
		// clang target
		//
		clangTargetOptions.Triple = llvm::sys::getDefaultTargetTriple();
		clangTargetOptions.CPU = llvm::sys::getHostCPUName().str();
		clangTargetInfo = clang::TargetInfo::CreateTargetInfo(*clangDiagnosticsEngine,clangTargetOptions);
	}
}
