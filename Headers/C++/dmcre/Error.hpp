//
//  Error.hpp
//  dmcre
//
//  Created by Lilith on 06.04.26.
//

#pragma once

#include <string>
#include <dmcre/Source.hpp>

namespace dmcre {
	class Error {
		std::string m_message;
		Source m_source;
		
	public:
		Error(std::string p_message,Source p_source = std::source_location::current()): m_message(p_message),m_source(p_source) {
		}
		
		decltype(m_message)& message() {
			return m_message;
		}
		
		const decltype(m_message)& message() const {
			return m_message;
		}
		
		decltype(m_source)& source() {
			return m_source;
		}
		
		const decltype(m_source)& source() const {
			return m_source;
		}
	};
	
	inline Error FunctionNotImplemented(Source p_source = std::source_location::current()) {
		return Error(p_source.Location().function_name() + std::string(" has not been implemented."));
	}
}
