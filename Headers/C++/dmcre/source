//
//  Source.hpp
//  dmcre
//
//  Created by Lilith on 06.04.26.
//

#pragma once

#include <source_location>
#include <string>

namespace dmcre {
	class Source {
		std::string m_module;
		std::source_location m_location;
		
	public:
		Source(const std::source_location& location): m_location(location), m_module(DMCRE_MODULE) {
		}
		
		const std::string& Module() const {
			return m_module;
		}
		
		const std::source_location& Location() const {
			return m_location;
		}
	};
}
