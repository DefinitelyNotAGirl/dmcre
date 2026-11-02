#include <dmcre/load>
#include <dmcre/platform>

#include <llvm/Support/TargetSelect.h>
#include <llvm/TargetParser/Host.h>

namespace dmcre::load {
	DMCRE_PUBLIC_API llvm::LLVMContext llvmContext;
	DMCRE_PUBLIC_API std::unique_ptr<llvm::orc::LLJIT> llvmJIT;
	DMCRE_PUBLIC_API llvm::IntrusiveRefCntPtr<llvm::vfs::FileSystem> llvmVirtualFileSystem;

	DMCRE_PUBLIC_API clang::TargetOptions clangTargetOptions;
	DMCRE_PUBLIC_API clang::TargetInfo* clangTargetInfo = nullptr;

	DMCRE_PUBLIC_API clang::FileSystemOptions clangFilesystemOptions;
	DMCRE_PUBLIC_API clang::FileManager* clangFileManager = nullptr;

	DMCRE_PUBLIC_API clang::SourceManager* clangSourceManager = nullptr;

	DMCRE_PUBLIC_API clang::DiagnosticsEngine* clangDiagnosticsEngine = nullptr;
	DMCRE_PUBLIC_API clang::DiagnosticConsumer* clangDiagnosticConsumer = nullptr;
	void InitializeClangDiagnosticsEngine();

	DMCRE_PUBLIC_API void initialize() {
		static bool initialized = false;
		if(initialized) {
			return;
		}
		initialized = true;
		//
		// LLVM
		//
		llvm::InitializeNativeTarget();
    	llvm::InitializeNativeTargetAsmPrinter();

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

		auto addLibraryGenerator = [&](const char* path) {
		    auto generator = llvm::orc::DynamicLibrarySearchGenerator::Load(
		        path, llvmJIT->getDataLayout().getGlobalPrefix());
			
		    if (!generator) {
		        throw std::runtime_error(
		            "Unable to load JIT symbol library " + std::string(path) +
		            ": " + llvm::toString(generator.takeError()));
		    }
		
		    mainJD.addGenerator(std::move(*generator));
		};

		addLibraryGenerator("libstdc++-6.dll");
		addLibraryGenerator("libgcc_s_seh-1.dll");
		addLibraryGenerator("libwinpthread-1.dll");
		addLibraryGenerator("dmcre_runtime.dll");
	}
}
