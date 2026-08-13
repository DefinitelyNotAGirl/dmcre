#pragma once

#include <exception>
#include <functional>
#include <source_location>

#include <chrono>
#include <cstdint>
#include <iostream>

#ifdef _WIN32
	#define FTAN(name)
#else
	#define FTAN(name) name
#endif

#include "JSON.hpp"

#define DMCRE_DEBUG_HPP

namespace dmcre::debug {
	void connect();
	
	void send(JSON event);
	
	#ifndef FUCK_MY_LIFE
	inline void report(const std::source_location& caller = std::source_location::current()) {
		std::cout << caller.function_name() << " in " << caller.file_name() << " on line " << caller.line() << std::endl;
	}
	#endif
	
	extern thread_local uint64_t stopwatch_time_start;

	inline void stopwatch_start() {
		using namespace std::chrono;
		stopwatch_time_start = duration_cast<nanoseconds>(high_resolution_clock::now().time_since_epoch()).count();
	}
	
	inline uint64_t stopwatch_read() {
		using namespace std::chrono;
		uint64_t now = duration_cast<nanoseconds>(high_resolution_clock::now().time_since_epoch()).count();
		
		uint64_t elapsed_ns = now - stopwatch_time_start;
		
		return elapsed_ns;
	}
	
	class stopwatch {
		uint64_t start;
		std::string label;
	public:
		stopwatch(std::string p_label) {
			using namespace std::chrono;
			
			label = p_label;

			start = duration_cast<nanoseconds>(high_resolution_clock::now().time_since_epoch()).count();
		}
		
		stopwatch(const std::source_location& source = std::source_location::current()) {
			using namespace std::chrono;

			label = source.function_name();

			start = duration_cast<nanoseconds>(high_resolution_clock::now().time_since_epoch()).count();
		}
		
		~stopwatch() {
			using namespace std::chrono;
			
			uint64_t now = duration_cast<nanoseconds>(high_resolution_clock::now().time_since_epoch()).count();
			
			uint64_t elapsed_ns = now - start;
			
			std::cout << label << ": " << elapsed_ns << " ns" << std::endl;
		}
	};
}
