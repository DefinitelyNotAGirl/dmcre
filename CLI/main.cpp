#include <csignal>
#include <iostream>

#include <dmcre/Time.hpp>
#include <dmcre/JSON.hpp>
#include <dmcre/http.hpp>
#include <dmcre/Network.hpp>
#include <dmcre/load.hpp>
#include <dmcre/debug.hpp>
#include <dmcre/WebSocket.hpp>
#include <dmcre/Engine.hpp>
#include <dmcre/Error.hpp>
#include <dmcre/Async.hpp>
#include <dmcre/ARC.hpp>

#include <string>
#include <list>
#include <filesystem>
#include <mach-o/dyld.h>
#include <mutex>
#include <condition_variable>
#include <dmcre/Destructor.hpp>

using namespace dmcre;

void CrashHandler(int sig);
void CleanRuntimeDirectory();

namespace dmcre {
	void CatchAll(std::function<void()> f) {
		try {
			f();
		} catch(Error e) {
			std::cerr << "Error: " << e.message() << std::endl;
		} catch(...) {
			const std::type_info* ti = abi::__cxa_current_exception_type();
			if (ti) {
				int status = 0;
				char* demangled = abi::__cxa_demangle(ti->name(), nullptr, nullptr, &status);
				std::cout << "exception of type: " << (status == 0 ? demangled : ti->name()) << std::endl;
				std::free(demangled);
			} else {
				std::cerr << "Error of unknown type" << std::endl;
			}
		}
	}
	
	std::atomic<int> BlockShutdown;

	void Thread::run(std::function<void()>& task) {
		CatchAll([&]{
			task();
		});
	}
	
	Thread::Thread(std::function<void()> task) {
		std::thread([task] () mutable {
			run(task);
		}).detach();
	};
}

#if false
namespace dmcre {
	class MainDispatchQueue: public DispatchQueue {
		class Entry {
		public:
			std::function<void()> f;
			ARC::Reference<Task> task;
		};
		std::list<Entry> tasks;

		std::mutex mutex;
		std::condition_variable cv;
		
		UInt64 runThread = 0;

	public:
		virtual ARC::Reference<Task> dispatch(std::function<void()> f) override {
			ARC::Reference<Task> task = ARC::create<Task>();
			
			if(Thread::getCurrentId() == runThread) {
				f();
				task.get()->wake();
			} else {
				{
					std::lock_guard<std::mutex> lock(mutex);
					tasks.push_back({
						.f = std::move(f),
						.task = task
					});
				}
				cv.notify_one();
			}
			
			return task;
		}
		
		virtual void enforceExecutionContext() override {
			if(Thread::getCurrentId() != runThread) {
				throw Error("");
			}
		}
		
		void run() {
			runThread = Thread::getCurrentId();
			while(true) {
				Entry* task;

				{
					std::unique_lock<std::mutex> lock(mutex);
					
					cv.wait(lock, [&] {
						return !tasks.empty() || (BlockShutdown.load() <= 0);
					});
					
					if (BlockShutdown.load() <= 0 && tasks.empty())
						break;
					
					task = new Entry(std::move(tasks.front()));
					tasks.pop_front();
				}
				
				task->f();
				task->task.get()->wake();
				
				delete task;
			}
		}
		
		static MainDispatchQueue& shared() {
			static MainDispatchQueue queue;
			return queue;
		}
	};

	DispatchQueue& mainDispatchQueue() {
		return MainDispatchQueue::shared();
	}
}
#endif

int main(int argc, char** argv) {
#if false
	BlockShutdown.store(0);

	std::function<void()> task = [&]{
		{
			char buf[4096] = {0};
			uint32_t size = sizeof(buf)-1;
			if(_NSGetExecutablePath(buf, &size) != 0) {
				std::cerr << "failed to determine dmcre installation directory" << std::endl;
				exit(1);
			}
			
			std::string execPath = buf;
			
			while(std::filesystem::is_symlink(execPath)) {
				execPath = std::filesystem::read_symlink(execPath);
			}
			
			dmcre::InstallationDirectory = std::filesystem::path(execPath).parent_path().parent_path().parent_path().string();
			dmcre::IncludeDirectory = dmcre::InstallationDirectory + "/Contents/Resources/Headers/C++";
		}
		
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
			
			if(!std::filesystem::exists(HOME + "/Library/Application Support/" + BUNDLE_ID)) {
				std::filesystem::create_directory(HOME + "/Library/Application Support/" + BUNDLE_ID);
			}
			
			if(!std::filesystem::exists(HOME + "/Library/Application Support/" + BUNDLE_ID + "/runtime/")) {
				std::filesystem::create_directory(HOME + "/Library/Application Support/" + BUNDLE_ID + "/runtime/");
			}
			
			#ifdef __APPLE__
				dmcre::RuntimeDirectory = HOME + "/Library/Application Support/" + BUNDLE_ID + "/runtime/" + std::to_string(pid);
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
		
		BlockShutdown.store(BlockShutdown.load()+1);
		Thread([path = argv[1]]{
			//dmcre::debug::connect();
			CatchAll([&]{
				load::cpp(load::Domain::WorkingDirectory,path);
			});
			BlockShutdown.store(BlockShutdown.load()-1);
		});

		MainDispatchQueue::shared().run();
		
		// clean up and exit
		CleanRuntimeDirectory();
	};
	Thread::run(task);

	return 0;
#else
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
		
		if(!std::filesystem::exists(HOME + "/Library/Application Support/" + BUNDLE_ID)) {
			std::filesystem::create_directory(HOME + "/Library/Application Support/" + BUNDLE_ID);
		}
		
		if(!std::filesystem::exists(HOME + "/Library/Application Support/" + BUNDLE_ID + "/runtime/")) {
			std::filesystem::create_directory(HOME + "/Library/Application Support/" + BUNDLE_ID + "/runtime/");
		}
		
#ifdef __APPLE__
		dmcre::RuntimeDirectory = HOME + "/Library/Application Support/" + BUNDLE_ID + "/runtime/" + std::to_string(pid);
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
	
	//dmcre::debug::connect();
	CatchAll([&]{
		load::cpp(load::Domain::WorkingDirectory,argv[1]);
	});
	
	// clean up and exit
	CleanRuntimeDirectory();
#endif
}

void CleanRuntimeDirectory() {
	std::filesystem::remove_all(dmcre::RuntimeDirectory);
}
