#include <string>
#include "private.hpp"

std::string ResolveModulePath(const std::string& specifier) {
	const std::string HOME = [&](){
		#ifdef _WIN32
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
