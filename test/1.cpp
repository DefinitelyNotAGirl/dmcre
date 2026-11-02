#include <dmcre/load>

void dmcre_main(std::vector<std::string>& argv) {
	dmcre::load::cxx::ToProcess(dmcre::load::Domain::WorkingDirectory,"2.cpp");
	dmcre::load::cxx::ToProcess(dmcre::load::Domain::WorkingDirectory,"3.cpp");
	std::cout << "test complete" << std::endl;
}
