#pragma once
#include <string>

class path {
public:
	std::string str;

	path(std::string str): str(str) {}
};

static inline path operator/(path p1,path p2) {
	#ifndef _WIN32
		// normal file systems
		return path(p1.str+"/"+p2.str);
	#else
		// windows
		// why do you have to be like this, microsoft
		return path(p1.str+"\\"+p2.str);
	#endif
}

static inline path operator/(path p1,std::string p2) {
	return p1 / path(p2);
}

static inline path _path("");
