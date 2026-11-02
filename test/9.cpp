#include <vector>
#include <string>

#include <dmcre/load>
#include <dmcre/debug>

void dmcre_main(std::vector<std::string>& argv) {
	dmcre::load::module::ToProcess("GraphicsKit");
}