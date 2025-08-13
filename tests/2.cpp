#include "../inc/dmcre/Module.hpp"
using namespace dmcre;

#include "2.hpp"

#include <iostream>

#ifndef dmcre_export
	#define dmcre_export
#endif

dmcre_export Module* module(dmcre::Core& core,void* in) {
	static Module2 _m;
	_m.use = []{
		std::cout << "module function used!" << std::endl;
	};
	return &_m;
}