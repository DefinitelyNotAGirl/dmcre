#include <csignal>
#include <iostream>

#include "private.hpp"

using namespace dmcre;

Core core;

/**
 * @Brief exists because windows, once again, is a stupid piece of shit
 */
int InnerMain(int argc, char** argv) {
	if(argc < 2) {
		std::cerr << "usage: dmcre [script source file]" << std::endl;
		std::cerr << "ERROR: no script source file provided" << std::endl;
		exit(1);
	}

	std::cout << "initializing runtime directory..." << std::endl;
	init::fs();

	std::cout << "initializing crash handler..." << std::endl;
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
		std::cout << "initializing core object..." << std::endl;
		core.LoadModule = [](std::string specifier,void* in) -> Module& {
			return LoadModule(specifier, in);
		};
	}

	InitialModuleIn init_in;
	init_in.argc = argc-1;
	init_in.argv = argv+1;

	std::cout << "loading initial module..." << std::endl;
	LoadModule(argv[1],&init_in);

	// clean up and exit
	std::cout << "cleaning runtime directory..." << std::endl;
	CleanRuntimeDirectory();

	return 0;
}

int main(int argc, char** argv) {
	try {
		return InnerMain(argc, argv);
	} catch(const std::exception& e) {
		std::cerr << "std::exception: " << e.what() << std::endl;
		return 1;
	}
}
