//
//  Context.hpp
//  dmcre
//
//  Created by Lilith on 19.04.26.
//

#pragma once

#include <stack>

namespace dmcre {
	template<typename T>
	class Context {
		std::stack<T> data;

	public:
		void push(const T& d) {
			data.push(d);
		}
		
		void pop() {
			data.pop();
		}
		
		T& get() {
			return data.top();
		}
		
		T* operator->() {
			return &data.top();
		}
		
		Context() {
			data.push(T());
		}
		
		Context(T d) {
			data.push(d);
		}
	};
}
