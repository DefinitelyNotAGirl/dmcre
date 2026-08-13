//
//  Destructor.hpp
//  dmcre
//
//  Created by Lilith on 04.04.26.
//

#pragma once

#include <functional>

namespace dmcre {
	class Destructor {
	private:
		bool cancelled = false;
		std::function<void()> onDestroy;
		
	public:
		[[nodiscard]] Destructor(decltype(onDestroy) p_onDestroy): onDestroy(p_onDestroy) {}
		
		void cancel() {
			this->cancelled = true;
		}
		
		void reinstate() {
			this->cancelled = false;
		}
		
		~Destructor() {
			if(!cancelled) {
				onDestroy();
			}
		}
	};
}
