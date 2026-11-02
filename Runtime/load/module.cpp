#include <dmcre/load>
#include <dmcre/debug>

namespace dmcre::load::module {
	static void LoadModule(std::filesystem::path root,std::string name) {
		std::filesystem::path module_ll_path = std::filesystem::path(root).append("module.ll");
		llvm::Module* module = nullptr;
		bool rebuild = true;
		if(std::filesystem::exists(module_ll_path)) {
			module = llvm_IR::ToModule(Domain::Absolute,module_ll_path);
			rebuild = not llvm_IR::CheckCacheValidity(module);
			if(rebuild) {
				delete module;
				module = nullptr;
			}
		}

		if(module == nullptr) {
			std::filesystem::path module_cpp_path = std::filesystem::path(root).append("module.cpp");
			if(std::filesystem::exists(module_cpp_path)) {
				module = cxx::ToModule(Domain::Absolute,module_cpp_path);
			}
			else {
				throw std::runtime_error("no module.cpp file in module directory!");
			}
		}

		if(rebuild) {
			std::error_code ec;
			llvm::raw_fd_ostream out(module_ll_path.string(), ec);
			std::cout << ec.category().name() << ": " << ec.message() << std::endl;
			module->print(out, nullptr);
		}

		std::vector<llvm::Module*> modules = {module};
		auto dylib = llvm_IR::ToProcess(modules,name);

		if(auto symbol = dmcre::load::llvmJIT->lookup(*dylib,"_Z27dmcre_ModifyLoadEnvironmentv")) {
			reinterpret_cast<void(*)()>(symbol->getValue())();
		}

		if(auto symbol = dmcre::load::llvmJIT->lookup(*dylib,"_Z16dmcre_LoadModulev")) {
			reinterpret_cast<void(*)()>(symbol->getValue())();
		} else {
			throw std::runtime_error("no _Z16dmcre_LoadModulev function in module");
		}
	}

	DMCRE_PUBLIC_API void ToProcess(std::string name) {
		#if defined(_WIN32)
			std::string Home = getenv("USERPROFILE");
		#else
			std::string Home = getenv("HOME");
		#endif

		for(auto& SearchDir : {
			Home+"/dmcre_modules"
		}) {
			for(auto& entry : std::filesystem::directory_iterator(SearchDir)) {
				if(entry.is_directory()) {
					if(entry.path().filename().string() == name) {
						LoadModule(entry.path(),name);
					}
				}
			}
		}
	}
}
