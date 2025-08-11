#include <iostream>
#include <filesystem>

#include "private.hpp"
#include <dmcre/time.hpp>
#include <dmcre/util.hpp>
using namespace dmcre;

path RuntimeDir("");

namespace init {
	void fs() {
		int pid = getpid();
		RuntimeDir = std::string(getenv("HOME")) / ".dmcre" / "rt" / (ToHexString_BE(&pid) + "-" + std::to_string(time::now().timestamp()));
		std::cout << "runtime dir: " << RuntimeDir.str << std::endl;
		std::filesystem::create_directory(RuntimeDir.str);
	}
}
