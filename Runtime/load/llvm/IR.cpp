#include <dmcre/load>
#include <dmcre/debug>

#include <llvm/ExecutionEngine/Orc/LLJIT.h>
#include <llvm/ExecutionEngine/Orc/ThreadSafeModule.h>
#include <llvm/ExecutionEngine/Orc/ExecutionUtils.h>

namespace dmcre::load {
	std::list<llvm::orc::JITDylib*> loadedLibraries;

	void llvmModule(std::unique_ptr<llvm::Module> module) {
		//for(auto& i : module->functions()) {
		//	if(i.hasName()) {
		//		std::cout << i.getName().str() << std::endl;
		//	}
		//}

		const std::string moduleName = module->getName().str();

		// gotta do this awkward syntax nonsense because the compiler is a stupid piece of shit
		llvm::orc::ThreadSafeModule tsm = llvm::orc::ThreadSafeModule(std::move(module),llvm::orc::ThreadSafeContext());

		std::cout << "llvmJIT->getExecutionSession(): " << &llvmJIT->getExecutionSession() << std::endl; // this does not come out as a nullptr and is thus presumably fine

		auto dylib = llvmJIT->getExecutionSession().createJITDylib(moduleName);
		if(not dylib) {
			throw std::runtime_error("createJITDylib failed");
		}

		dylib->addToLinkOrder({
		    {&(llvmJIT->getMainJITDylib()), llvm::orc::JITDylibLookupFlags::MatchAllSymbols}
		});

		for(auto lib : loadedLibraries) {
			dylib->addToLinkOrder({
			    {lib, llvm::orc::JITDylibLookupFlags::MatchAllSymbols}
			});
		}

		if(auto error = llvmJIT->addIRModule(*dylib,(std::move(tsm)))) {
			throw std::runtime_error("addIRModule failed");
		}

		auto symbol = llvmJIT->lookup(*dylib,"_Z12dmcre_onloadv");

		loadedLibraries.push_back(&*dylib);

		if(symbol) {
			void* addr = (void*)symbol->getValue();
			std::cout << "dmcre_onload: " << addr << std::endl;
			auto dmcre_onload = (void(*)())(addr);
			dmcre_onload();
		}
	}
}
