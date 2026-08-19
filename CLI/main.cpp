#include <csignal>
#include <iostream>

#include <dmcre/time>
#include <dmcre/http>
#include <dmcre/load>
#include <dmcre/debug>
#include <dmcre/error>
#include <dmcre/async>
#include <dmcre/ARC>
#include <dmcre/config>

#include <stdexcept>
#include <string>
#include <list>
#include <filesystem>
#include <system_error>
#if defined(__APPLE__)
	#include <mach-o/dyld.h>
#endif
#include <mutex>
#include <condition_variable>
#include <dmcre/destructor>

#if __has_include(<cxxabi.h>)
	#include <cxxabi.h>
#endif

using namespace dmcre;

void CrashHandler(int sig);
void CleanRuntimeDirectory();

namespace dmcre {
	void CatchAll(std::function<void()> f) {
		try {
			f();
		} catch(Error e) {
			std::cerr << "Error: " << e.message() << std::endl;
		} catch(std::exception e) {
			std::cerr << e.what() << std::endl;
		} catch(const char* e) {
			std::cerr << e << std::endl;
		} catch(int e) {
			std::cerr << e << std::endl;
		} catch(...) {
			#if __has_include(<cxxabi.h>)
			const std::type_info* ti = abi::__cxa_current_exception_type();
			if (ti) {
				int status = 0;
				char* demangled = abi::__cxa_demangle(ti->name(), nullptr, nullptr, &status);
				std::cout << "exception of type: " << (status == 0 ? demangled : ti->name()) << std::endl;
				std::free(demangled);
			} else {
				std::cerr << "Error of unknown type" << std::endl;
			}
			#else
			std::cerr << "error of unknown type, cannot determine without cxxabi.h" << std::endl;
			#endif
		}
	}
}

int main(int argc, char** argv) {
	if(argc < 2) {
		std::cerr << "usage: dmcre [script source file]" << std::endl;
		std::cerr << "ERROR: no script source file provided" << std::endl;
		exit(1);
	}
	
	{
#ifdef _WIN32
		int pid = GetCurrentProcessId();
		const std::string HOME = std::string(getenv("USERPROFILE"));
#else
		int pid = getpid();
		const std::string HOME = std::string(getenv("HOME"));
#endif

#if defined(__APPLE__)
		if(!std::filesystem::exists(HOME + "/Library/Application Support/" + BUNDLE_ID)) {
			std::filesystem::create_directory(HOME + "/Library/Application Support/" + BUNDLE_ID);
		}
		
		if(!std::filesystem::exists(HOME + "/Library/Application Support/" + BUNDLE_ID + "/runtime/")) {
			std::filesystem::create_directory(HOME + "/Library/Application Support/" + BUNDLE_ID + "/runtime/");
		}
		
		dmcre::RuntimeDirectory = HOME + "/Library/Application Support/" + BUNDLE_ID + "/runtime/" + std::to_string(pid);
#elif defined(_WIN32)
		if(not std::filesystem::exists(HOME + "\\AppData\\Local\\" + BUNDLE_ID)) {
			std::filesystem::create_directory(HOME + "\\AppData\\Local\\" + BUNDLE_ID);
		}
		
		if(not std::filesystem::exists(HOME + "\\AppData\\Local\\" + BUNDLE_ID + "\\runtime")) {
			std::filesystem::create_directory(HOME + "\\AppData\\Local\\" + BUNDLE_ID + "\\runtime");
		}
		
		dmcre::RuntimeDirectory = HOME + "\\AppData\\Local\\" + BUNDLE_ID + "\\runtime\\" + std::to_string(pid);
#else
#error missing logic
#endif
		
		std::filesystem::create_directory(dmcre::RuntimeDirectory);
	}
	
	std::signal(SIGSEGV, CrashHandler);
	std::signal(SIGABRT, CrashHandler);
	std::signal(SIGFPE,  CrashHandler);
	std::signal(SIGILL,  CrashHandler);
#ifndef _WIN32
	std::signal(SIGBUS,  CrashHandler);
#endif
	std::signal(SIGTERM, CrashHandler);
	std::signal(SIGINT,  CrashHandler);

    IncludeDirectories.push_back(config::install::headers::cxx);
    for(auto& dir : config::sdk::cxx::include) {
        load::cxx::SystemIncludeDirectories.push_back(dir);
    }

	CatchAll([&]{
		load::cpp(load::Domain::WorkingDirectory,argv[1]);
	});
	
	// clean up and exit
	CleanRuntimeDirectory();
}

void CleanRuntimeDirectory() {
	std::filesystem::remove_all(dmcre::RuntimeDirectory);
}
