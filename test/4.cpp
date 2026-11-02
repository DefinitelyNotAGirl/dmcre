#include <dmcre/load>

void dmcre_onload() {
	std::cout << "loading GraphicsKit..." << std::endl;
	dmcre::load::cxx(dmcre::load::Domain::Absolute,"C:\\Users\\lilit\\Documents\\DMCRE GraphicsKit\\module.cpp");
	dmcre::load::cxx(dmcre::load::Domain::WorkingDirectory,"test/5.cpp");
	std::cout << "test complete" << std::endl;
}