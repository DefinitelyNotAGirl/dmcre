//
//  Semaphore.cpp
//  dmcre
//
//  Created by Lilith on 07.08.26.
//

#if defined (__APPLE__)

#include <dmcre/Semaphore.hpp>
#include <dispatch/dispatch.h>

namespace dmcre {
	class Semaphore::Impl_T {
		__public dispatch_semaphore_t semaphore;
	};
	
	Semaphore::Semaphore() {
		impl = new Impl_T;
		
		impl->semaphore = dispatch_semaphore_create(0);
	}
	
	void Semaphore::wait() {
		dispatch_semaphore_wait(impl->semaphore,DISPATCH_TIME_FOREVER);
	}
	
	void Semaphore::signal() {
		dispatch_semaphore_signal(impl->semaphore);
	}
	
	Semaphore::~Semaphore() {
		delete impl;
	}
}

#endif
