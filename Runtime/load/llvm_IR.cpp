#include <dmcre/load>
#include <dmcre/debug>

#include <llvm/IRReader/IRReader.h>

#include <fstream>

namespace dmcre::load::llvm_IR {
	DMCRE_PUBLIC_API std::list<llvm::orc::JITDylib*> loadedLibraries;

	namespace config {
	}

	DMCRE_PUBLIC_API bool CheckCacheValidity(llvm::Module* module) {
		std::string dmcre_source_type = "";
		if(const llvm::NamedMDNode* NamedNode = module->getNamedMetadata("dmcre.source.type")) {
			if(NamedNode->getNumOperands() != 1) {
				return false;
			}
			auto node = NamedNode->getOperand(0);
			if(node->getNumOperands() != 1) {
				return false;
			}
			auto& operand = node->getOperand(0);
			const auto* value = llvm::dyn_cast<llvm::MDString>(operand.get());
			if(!value) {
				return false;
			}
			dmcre_source_type = value->getString();
		} else {
			return false;
		}

		std::string dmcre_source_directory = "";
		if(const llvm::NamedMDNode* NamedNode = module->getNamedMetadata("dmcre.source.directory")) {
			if(NamedNode->getNumOperands() != 1) {
				return false;
			}
			auto node = NamedNode->getOperand(0);
			if(node->getNumOperands() != 1) {
				return false;
			}
			auto& operand = node->getOperand(0);
			const auto* value = llvm::dyn_cast<llvm::MDString>(operand.get());
			if(!value) {
				return false;
			}
			dmcre_source_directory = value->getString();
		} else {
			return false;
		}

		unsigned long long dmcre_module_mtime = 0xFFFFFFFFFFFFFFFF;
		if(const llvm::NamedMDNode* NamedNode = module->getNamedMetadata("dmcre.module.mtime")) {
			if(NamedNode->getNumOperands() != 1) {
				return false;
			}
			auto node = NamedNode->getOperand(0);
			if(node->getNumOperands() != 1) {
				return false;
			}
			auto& operand = node->getOperand(0);
			const auto* value = llvm::dyn_cast<llvm::MDString>(operand.get());
			if(!value) {
				return false;
			}
			auto str = value->getString().str();
			dmcre_module_mtime = std::stoull(str);
		} else {
			return false;
		}

		if(const llvm::NamedMDNode* dmcre_cache_include = module->getNamedMetadata("dmcre.cache.include")) {
		    for (const llvm::MDNode *Node : dmcre_cache_include->operands()) {
		        for (const llvm::MDOperand &Operand : Node->operands()) {
		            const auto *String = llvm::dyn_cast<llvm::MDString>(Operand.get());
		            if (!String) {
		                return false;
		            }
				
		            std::string Value = String->getString().str();
					if(Value.starts_with("<")) {
						if(dmcre_source_type == "C++") {
							std::string header = Value.substr(1,Value.length()-2);
							bool found = false;
							for(auto& entry : cxx::config::HeaderSearchOptions.UserEntries) {
								if(entry.Group == clang::frontend::IncludeDirGroup::Angled) {
									std::string path = entry.Path+"/"+header;
									if(std::filesystem::exists(path)) {
										auto mtime = std::filesystem::last_write_time(path).time_since_epoch().count();
										if(dmcre_module_mtime <= mtime) {
											std::cout << "cache invalid, " << Value << " modified at " << mtime << std::endl;
											return false;
										}
										found = true;
										break;
									}
								}
							}
							if(not found) {
								std::cout << "cache invalid, bad header dependency reference: " << header << std::endl;
								return false;
							}
						}
						else {
							std::cout << "cache invalid, bad dmcre.source.type: " << dmcre_source_type << std::endl;
							return false;
						}
					}
					else if(Value.starts_with("./")) {
						auto path = dmcre_source_directory+"/"+Value.substr(2);
						if(std::filesystem::exists(path)) {
							auto mtime = std::filesystem::last_write_time(path).time_since_epoch().count();
							if(dmcre_module_mtime <= mtime) {
								std::cout << "cache invalid, " << Value << " modified at " << mtime << std::endl;
								return false;
							}
						} else {
							std::cout << "cache invalid, bad file reference: " << Value << std::endl;
						}
					}
					else {
						if(std::filesystem::exists(Value)) {
							auto mtime = std::filesystem::last_write_time(Value).time_since_epoch().count();
							if(dmcre_module_mtime <= mtime) {
								std::cout << "cache invalid, " << Value << " modified at " << mtime << std::endl;
								return false;
							}
						}
					}
		        }
		    }
		} else {
			return false;
		}

		return true;
	}

	DMCRE_PUBLIC_API llvm::Module* ToModule(std::string code,std::string name) {
		llvm::SMDiagnostic diagnostic;
		auto module = llvm::parseIR(llvm::MemoryBuffer::getMemBufferCopy(code)->getMemBufferRef(), diagnostic, dmcre::load::llvmContext);
		return module.release();
	}

	DMCRE_PUBLIC_API llvm::Module* ToModule(Domain domain,std::filesystem::path path) {
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

	DMCRE_PUBLIC_API llvm::orc::JITDylib* ToProcess(std::string code,std::string name) {
		std::vector<llvm::Module*> modules = {ToModule(code, name)};

		return ToProcess(modules, name);
	}

	DMCRE_PUBLIC_API llvm::orc::JITDylib* ToProcess(Domain domain,std::filesystem::path path) {
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

	DMCRE_PUBLIC_API llvm::orc::JITDylib* ToProcess(std::vector<FileSpecifier> files,std::string name) {
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

		return ToProcess(modules,name);
	}

	DMCRE_PUBLIC_API llvm::orc::JITDylib* ToProcess(std::vector<llvm::Module*> modules,std::string name) {
		auto dylib = llvmJIT->getExecutionSession().createJITDylib(name);
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

		llvm::orc::CtorDtorRunner constructorRunner(*dylib);
		for(auto module : modules) {
			constructorRunner.add(llvm::orc::getConstructors(*module));
		}

		for(auto& module : modules) {
			if(false) {
				for(auto& i : module->functions()) {
					if(i.hasInternalLinkage()) continue;
					if(i.isDeclaration()) continue;

					if(i.hasName()) {
						std::cout << i.getName().str() << std::endl;
					}
				}
			}

			// gotta do this awkward syntax nonsense because the compiler is a stupid piece of shit
			llvm::orc::ThreadSafeModule tsm = llvm::orc::ThreadSafeModule(std::unique_ptr<llvm::Module>(module),llvm::orc::ThreadSafeContext());

			if(auto error = llvmJIT->addIRModule(*dylib,(std::move(tsm)))) {
				throw std::runtime_error("addIRModule failed");
			}
		}

		loadedLibraries.push_back(&*dylib);

		if(auto error = constructorRunner.run()) {
			throw std::runtime_error(
				"Failed to run module static constructors: " + llvm::toString(std::move(error)));
		}

		return &*dylib;
	}
}