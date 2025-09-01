#include <csignal>
#include <iostream>

#include "private.hpp"

using namespace dmcre;

Core core;

int main(int argc, char** argv) {
	if(argc < 2) {
		std::cerr << "usage: dmcre [script source file]" << std::endl;
		std::cerr << "ERROR: no script source file provided" << std::endl;
		exit(1);
	}

	init::fs();

	std::signal(SIGSEGV, CrashHandler);
    std::signal(SIGABRT, CrashHandler);
    std::signal(SIGFPE,  CrashHandler);
    std::signal(SIGILL,  CrashHandler);
	#ifndef _WIN32
    	std::signal(SIGBUS,  CrashHandler);
	#endif
    std::signal(SIGTERM, CrashHandler);
	std::signal(SIGINT,  CrashHandler);

	//.
	//. initialize core object
	//.
	{
		core.LoadModule = [](std::string specifier,void* in) -> Module& {
			try {
				return LoadModule(specifier, in);
			} catch(const std::exception& e) {
				std::cerr << "Error loading module '" << specifier << "': " << e.what() << std::endl;
				abort();
			}
		};
	}

	InitialModuleIn init_in;
	init_in.argc = argc-1;
	init_in.argv = argv+1;

	const std::string InitialSpecifier = argv[1];
	try {
		LoadModule(InitialSpecifier,&init_in);
	} catch(const std::exception& e) {
		std::cerr << "Error loading script '" << InitialSpecifier << "': " << e.what() << std::endl;
		abort();
	}

	//unload all modules
	for(auto& file : LoadedFiles) {
		#ifdef _WIN32
			FreeLibrary((HMODULE)file.dll);
		#else
			// not sure this is necessary, it's been working fine without unloading modules on MacOS, but let's be safe
			dlclose(file.dll);
		#endif
	}

	// clean up and exit
	CleanRuntimeDirectory();

	return 0;
}
