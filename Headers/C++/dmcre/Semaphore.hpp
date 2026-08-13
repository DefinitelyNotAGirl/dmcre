//
//  Semaphore.hpp
//  dmcre
//
//  Created by Lilith on 07.08.26.
//

#pragma once

#include "foundation.hpp"

namespace dmcre {
	class Semaphore {
		class Impl_T;
		Impl_T* impl;

		__public explicit Semaphore();
		__public ~Semaphore();
		
		__public void signal();
		
		__public void wait();
	};
}
