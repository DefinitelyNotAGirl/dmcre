//
//  Thread.hpp
//  dmcre
//
//  Created by Lilith on 07.04.26.
//

#pragma once

#include <functional>
#include <thread>
#include <dmcre/foundation.hpp>
#include <dmcre/ARC.hpp>

#include <pthread.h>

namespace dmcre {
	extern std::atomic<int> BlockShutdown;

	class Thread {
	private:
		static void run(std::function<void()>& task);
		
	public:
		Thread(std::function<void()> task);
		
		static UInt64 getCurrentId();
	};
	
	class Mutex {
		std::atomic<UInt64> data;
		
		mutable pthread_mutex_t mtx = PTHREAD_MUTEX_INITIALIZER;
		mutable pthread_cond_t  cv  = PTHREAD_COND_INITIALIZER;

	public:
		Mutex() {
			pthread_mutex_init(&mtx, nullptr);
			
			pthread_condattr_t attr;
			pthread_condattr_init(&attr);
			pthread_cond_init(&cv, &attr);
			pthread_condattr_destroy(&attr);
		}
		
		~Mutex() {
			pthread_cond_destroy(&cv);
			pthread_mutex_destroy(&mtx);
		}
		
		void wakeOne() {
			pthread_mutex_lock(&mtx);
			pthread_cond_signal(&cv);
			pthread_mutex_unlock(&mtx);
		}
		
		void wakeAll() {
			pthread_mutex_lock(&mtx);
			pthread_cond_broadcast(&cv);
			pthread_mutex_unlock(&mtx);
		}
		
		UInt64 get() const {
			return data.load(std::memory_order_acquire);
		}

		void set(UInt64 value) {
			data.store(value, std::memory_order_release);
		}

		void wait(std::function<bool()> predicate) const {
			pthread_mutex_lock(&mtx);
			 
			while (!predicate()) {
				timespec ts;
				// we have to use CLOCK_REALTIME here because MacOS does not support CLOCK_MONOTONIC, which kinda sucks but oh well
				clock_gettime(CLOCK_REALTIME, &ts);
				ts.tv_sec += 1;
				pthread_cond_timedwait(&cv, &mtx, &ts);
			}
			
			pthread_mutex_unlock(&mtx);
		}
	};
	
	class Task: public ARC::Object {
		Mutex mutex;

	public:
		
		Task() {
			mutex.set(0);
		}
		
		void wake() {
			mutex.set(1);
			mutex.wakeAll();
		}

		void await() {
			mutex.wait([&]{
				return mutex.get() != 0;
			});
		}
	};

	class DispatchQueue {
	public:
		virtual ARC::Reference<Task> dispatch(std::function<void()> f) = 0;

		virtual void enforceExecutionContext() = 0;
	};
	
#if false
	DispatchQueue& mainDispatchQueue();
#endif
}
