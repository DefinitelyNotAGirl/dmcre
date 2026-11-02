#include "llvm/Support/Signals.h"
#include <csignal>
#include <iostream>

#include <dmcre/time>
#include <dmcre/http>
#include <dmcre/load>
#include <dmcre/debug>
#include <dmcre/error>
#include <dmcre/async>
#include <dmcre/ARC>
#include <dmcre/dmcred>
#include <dmcre/install>

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

	llvm::sys::AddSignalHandler(
		[](void*) {
			// Ensure PrintStackTrace output is visible.
			llvm::errs().flush();
		},
		nullptr
	);

	std::vector<std::string> argv_vector;

	for(auto i = 0;i<argc;i++) {
		argv_vector.push_back(argv[i]);
	}

	load::initialize();
	load::cxx::initialize();

	std::string exec = argv[1];
	llvm::Module* module = nullptr;
	if(exec.ends_with(".cpp")) {
		module = load::cxx::ToModule(load::Domain::WorkingDirectory,argv[1]);
		if(true) {
			std::error_code ec;
			llvm::raw_fd_ostream out(std::string(argv[1])+".ll", ec);
			std::cout << ec.category().name() << ": " << ec.message() << std::endl;
			module->print(out, nullptr);
			load::llvm_IR::CheckCacheValidity(module);
		}
	}
	else if(exec.ends_with(".ll")) {
		module = load::llvm_IR::ToModule(load::Domain::WorkingDirectory,argv[1]);
	}
	else {
		std::cerr << "ERROR: unrecognized file extension" << std::endl;
		return 1;
	}

	std::vector<llvm::Module*> modules = {module};

	auto dylib = dmcre::load::llvm_IR::ToProcess(modules, argv[1]);

	struct MainFunctionVariant {
		std::string Symbol;
		std::function<void(llvm::Expected<llvm::orc::ExecutorAddr>&)> onSymbolFound;
	};

	std::vector<MainFunctionVariant> MainFunctionVariants = {
		{
			"_Z10dmcre_mainRSt6vectorINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESaIS5_EE",
			[&](llvm::Expected<llvm::orc::ExecutorAddr>& symbol) {
				reinterpret_cast<void(*)(std::vector<std::string>&)>(symbol->getValue())(argv_vector);
			}
		}
	};

	for(auto& variant : MainFunctionVariants) {
		auto symbol = dmcre::load::llvmJIT->lookup(
			*dylib,
			variant.Symbol
		);
		if(symbol) {
			dmcre::CatchAll([&]{
				variant.onSymbolFound(symbol);
			});
			return 0;
		}
	}

	std::cerr << "no viable main function!" << std::endl;
	return 1;

#if false
	{
#ifdef _WIN32
		int pid = GetCurrentProcessId();
		const std::string HOME = std::string(getenv("USERPROFILE"));
#else
		int pid = getpid();
		const std::string HOME = std::string(getenv("HOME"));
#endif

#if defined(__APPLE__)
		if(!std::filesystem::exists(HOME + "/Library/Application Support/dmcre")) {
			std::filesystem::create_directory(HOME + "/Library/Application Support/dmcre");
		}
		
		if(!std::filesystem::exists(HOME + "/Library/Application Support/dmcre/runtime/")) {
			std::filesystem::create_directory(HOME + "/Library/Application Support/dmcre/runtime/");
		}
		
		dmcre::RuntimeDirectory = HOME + "/Library/Application Support/dmcre/runtime/" + std::to_string(pid);
#elif defined(_WIN32)
		if(not std::filesystem::exists(HOME + "\\AppData\\Local\\dmcre")) {
			std::filesystem::create_directory(HOME + "\\AppData\\Local\\dmcre");
		}
		
		if(not std::filesystem::exists(HOME + "\\AppData\\Local\\dmcre\\runtime")) {
			std::filesystem::create_directory(HOME + "\\AppData\\Local\\dmcre\\runtime");
		}
		
		dmcre::RuntimeDirectory = HOME + "\\AppData\\Local\\dmcre\\runtime\\" + std::to_string(pid);
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

    for(auto& dir : config::sdk::cxx::include) {
        load::cxx::SystemIncludeDirectories.push_back(dir);
    }

	CatchAll([&]{
		load::cppMacros.insert({"DMCRE_MODULE",std::string("\"")+argv[1]+"\""});
		load::cpp(load::Domain::WorkingDirectory,argv[1]);
	});

	// clean up and exit
	CleanRuntimeDirectory();
#endif
}

void CleanRuntimeDirectory() {
#if false
	std::filesystem::remove_all(dmcre::RuntimeDirectory);
#endif
}
