#include "../inc/dmcre/Module.hpp"
using namespace dmcre;

#include "2.hpp"

#include <iostream>

extern "C" Module* module(dmcre::Core& core,void* in) {
	static Module2 _m;
	_m.use = []{
		std::cout << "module function used!" << std::endl;
	};
	return &_m;
}