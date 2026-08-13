//
//  ParserDebugger.hpp
//  dmcre
//
//  Created by Lilith on 09.08.26.
//

#include "foundation.hpp"
#include "String.hpp"
#include <cstdint>

namespace dmcre {
	class ParserDebugger {
		class Impl_T;
		Impl_T* impl;

		__public ParserDebugger(uint32_t* characters,uint64_t count);
		__public ~ParserDebugger();
		
		__public int sleep_us = 0;
		
		__public enum class CharacterState {
			consumed,
			skipped,
			unseen,
		};

		__public void setCharacterState(uint64_t n,CharacterState state);
		__public void setPosition(uint64_t n);
	};
}
