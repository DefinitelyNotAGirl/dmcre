//
//  LoadModule.cpp
//  dmcre
//
//  Created by Lilith on 10.08.25.
//

#include <string>
#include <dmcre/Module.hpp>
#include <dlfcn.h>
#include <dmcre/crypto.hpp>
#include <filesystem>
#include "private.hpp"

using dmcre::Module;
using namespace dmcre::crypto;
using namespace dmcre;

Module& LoadModule(const std::string& specifier,void* in) {
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
	std::string HOME = getenv("HOME");
	std::string compile_cmd = "c++ -g -shared -std=c++20 -I"+HOME+"/.dmcre/global  -undefined dynamic_lookup -x c++ "+path+" -o "+(RuntimeDir / FileDigest).str;
	system(compile_cmd.c_str());
	
	void* dll = dlopen((RuntimeDir / FileDigest).str.c_str(),RTLD_NOW | RTLD_LOCAL);
	if(dll == nullptr) {
		throw std::runtime_error("dlopen failed!");
	}
	LoadedFiles.push_back(
		LoadedFile(
			FileDigest,
			dll,
			([dll,in]() -> Module& {
				void* sym = dlsym(dll,"module");
				if(sym == nullptr) {
					throw std::runtime_error("dlsym failed!");
				}
				Module*(*_module)(Core& core, void* in) = (Module*(*)(Core&,void*))(sym);
				return *(_module(core,in));
			})()
		)
	);
	return LoadedFiles.back().module;
}

void CleanRuntimeDirectory() {
	std::filesystem::remove_all(RuntimeDir.str);
}
