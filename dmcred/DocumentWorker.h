#pragma once

#include <deque>
#include <mutex>
#include <queue>
#include <thread>
#include <condition_variable>

#include <dmcre/foundation>

#include <clang/Basic/Diagnostic.h>
#include <clang/Frontend/PrecompiledPreamble.h>
#include <clang/Frontend/PCHContainerOperations.h>

namespace dmcred {
	class DocumentWorker {
		__private std::string path;

		__private std::thread* WorkerThread;
		__private std::atomic<bool> StopWorkerThread;

		__private std::condition_variable UpdateWaitConditionVariable;

		__public DocumentWorker(std::string path); 

		__public ~DocumentWorker();

		__public void start();
		__public void stop();

		__public const std::string& getPath() const {
			return path;
		}

		__private std::mutex TaskMutex;
		__private std::condition_variable TaskConditionVariable;
		__private std::queue<std::function<void()>> TaskQueue;
		__public void QueueTask(std::function<void()> task);

		__private long long version;

		__public void QueueUpdate(std::string content,long long version);
		__private void update(std::string content,long long version);

		__private void BuildPreamble();
		__private clang::PreambleBounds PreambleBounds;
		__private std::unique_ptr<llvm::MemoryBuffer> PreambleContent;
		__private std::shared_ptr<clang::PCHBuffer> PreamblePCHBuffer;
	};

	extern std::mutex DocumentWorkerQueueMutex;
	extern std::deque<DocumentWorker*> DocumentWorkers;
	extern std::map<std::string,DocumentWorker*> ActiveWorkers;
}