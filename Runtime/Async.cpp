//
//  Async.cpp
//  Runtime
//
//  Created by Lilith on 08.04.26.
//

#include <dmcre/Async.hpp>

namespace dmcre {
	UInt64 Thread::getCurrentId() {
		UInt64 tid;
		pthread_threadid_np(NULL, (unsigned long long*)&tid);
		return tid;
	}
}
