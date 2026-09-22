//
//  type.cpp
//  Runtime
//
//  Created by Lilith on 04.04.26.
//

#include <dmcre/foundation>
#include <dmcre/string>

namespace dmcre {

#if __has_include(<cxxabi.h>)

#include <cxxabi.h>

	dmcre::String Typename(const std::type_info& type) {
		int status = 0;
		char* dem = abi::__cxa_demangle(type.name(), nullptr, nullptr, &status);
		dmcre::String result = (status == 0 && dem ? dem : type.name());
		free(dem);
		return result;
	}

#else

dmcre::String Typename(const std::type_info& type) {
	return type.name();
}

#endif
}
