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
    std::signal(SIGBUS,  CrashHandler);
    std::signal(SIGTERM, CrashHandler);
	std::signal(SIGINT,  CrashHandler);

	//.
	//. initialize core object
	//.
	{
		core.LoadModule = [](std::string specifier,void* in) -> Module& {
			return LoadModule(specifier, in);
		};
	}

	InitialModuleIn init_in;
	init_in.argc = argc-1;
	init_in.argv = argv+1;

	LoadModule(argv[1],&init_in);

	// clean up and exit
	CleanRuntimeDirectory();
}
