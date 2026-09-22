#include <dmcre/load>

void dmcre_onload() {
	dmcre::load::cxx(dmcre::load::Domain::WorkingDirectory,"test/2.cpp");
	dmcre::load::cxx(dmcre::load::Domain::WorkingDirectory,"test/3.cpp");
	std::cout << "test complete" << std::endl;
}
