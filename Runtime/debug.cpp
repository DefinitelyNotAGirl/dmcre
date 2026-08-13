//
//  debug.cpp
//  Runtime
//
//  Created by Lilith on 03.04.26.
//

#include <dmcre/debug.hpp>
#include <dmcre/WebSocket.hpp>

namespace dmcre::debug {
	WebSocket* ws = nullptr;
	
	void connect() {
	}
	
	void send(JSON event) {
		if(ws == nullptr) {
			return;
		}
		ws->send(String(event.toString("").c_str()).encode(String::Format::ASCII));
	}
	
	thread_local uint64_t stopwatch_time_start;
}
