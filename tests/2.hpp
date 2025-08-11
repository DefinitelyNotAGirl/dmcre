#include "../inc/dmcre/Module.hpp"

class Module2 : public dmcre::Module {
public:
	std::function<void()> use;
};