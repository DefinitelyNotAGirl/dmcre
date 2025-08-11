#include <string>
#include "private.hpp"
#include <iostream>

std::string ResolveModulePath(const std::string& specifier) {
	std::cout << "Resolving module path for specifier: " << specifier << std::endl;
	const std::string HOME = [&](){
		#ifdef _WIN32
			return std::string(getenv("USERPROFILE"));
		#else
			return std::string(getenv("HOME"));
		#endif
	}();

	//
	// check for global::
	//
	{
		const std::string GlobalPrefix = "global::";
		const std::string GlobalPath = HOME+"/.dmcre/global/";
		if(specifier.length() >= GlobalPrefix.length() && specifier.substr(0,GlobalPrefix.length()) == GlobalPrefix) {
			return (GlobalPath+specifier.substr(GlobalPrefix.length()));
		}
	}

	return specifier;
}
