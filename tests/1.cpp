#include "../inc/dmcre/Module.hpp"
using namespace dmcre;

#include <iostream>

#include "2.hpp"

extern "C" __declspec(dllexport) Module* module(dmcre::Core& core,void* in) {
	std::cout << "module main" << std::endl;

	static Module2& m2 = dynamic_cast<Module2&>(core.LoadModule("tests/2.cpp",nullptr));
	m2.use();

	static Module self;
	return &self;
}