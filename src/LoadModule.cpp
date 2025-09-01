//
//  LoadModule.cpp
//  dmcre
//
//  Created by Lilith on 10.08.25.
//

#include <string>
#include <dmcre/Module.hpp>
#ifdef _WIN32
#else
	#include <dlfcn.h>
#endif
#include <dmcre/crypto.hpp>
#include <filesystem>
#include "private.hpp"
#include <iostream>

using dmcre::Module;
using namespace dmcre::crypto;
using namespace dmcre;

Module& LoadModule(const std::string& specifier,void* in) {
	//std::cout << "Loading module: " << specifier << std::endl;
	std::string path = ResolveModulePath(specifier);
	//std::cout << specifier << " => " << path << std::endl;
	std::string FileDigest = "";
	{
		std::string content;
		FILE* f = fopen(path.c_str(),"rb");
		fseek(f,0,SEEK_END);
		content.resize(ftell(f));
		fseek(f, 0, SEEK_SET);
		fread(content.data(),content.size(),1,f);
		fclose(f);
		FileDigest = crypto::sha256.hash(content).ToHexString();
	}
	#ifdef _WIN32
		std::string HOME = getenv("USERPROFILE");
		std::string compile_cmd = "clang++ -g -shared -std=c++20 -I"+HOME+"/.dmcre/global -x c++ "+path+" -o "+(RuntimeDir / FileDigest).str+".dll > NUL";
	#else
		std::string HOME = getenv("HOME");
		std::string compile_cmd = "c++ -g -shared -std=c++20 -I"+HOME+"/.dmcre/global  -undefined dynamic_lookup -x c++ "+path+" -o "+(RuntimeDir / FileDigest).str;
	#endif
	system(compile_cmd.c_str());
	
	#ifdef _WIN32
		HMODULE dll = LoadLibraryA(((RuntimeDir / FileDigest).str+".dll").c_str());
		if(dll == nullptr) {
			throw std::runtime_error("LoadLibraryA failed!");
		}
	#else
		void* dll = dlopen((RuntimeDir / FileDigest).str.c_str(),RTLD_NOW | RTLD_LOCAL);
		if(dll == nullptr) {
			throw std::runtime_error("dlopen failed!");
		}
	#endif
	//std::cout << "debug" << std::endl;
	LoadedFiles.push_back(
		LoadedFile(
			FileDigest,
			dll,
			([dll,in,path]() -> Module& {
				//std::cout << "resolving _module symbol from " << path << std::endl;
				#ifdef _WIN32
					FARPROC sym = GetProcAddress(dll,"module");
					if(!sym) {
						throw std::runtime_error("GetProcAddress failed!");
					}
				#else
					void* sym = dlsym(dll,"module");
					if(sym == nullptr) {
						throw std::runtime_error("dlsym failed!");
					}
				#endif
				//std::cout << "_module symbol address: " << sym << " from " << path << std::endl;
				Module*(*_module)(Core& core, void* in) = (Module*(*)(Core&,void*))(sym);
				//std::cout << "module initialized" << std::endl;
				return *(_module(core,in));
			})()
		)
	);
	return LoadedFiles.back().module;
}

void CleanRuntimeDirectory() {
	//std::cout << "Cleaning runtime directory: " << RuntimeDir.str << std::endl;
	std::filesystem::remove_all(RuntimeDir.str);
}
