#include <iostream>
#include <filesystem>

#include "private.hpp"
#include <dmcre/time.hpp>
#include <dmcre/util.hpp>
using namespace dmcre;

path RuntimeDir("");

namespace init {
	void fs() {
		#ifdef _WIN32
			int pid = GetCurrentProcessId();
			const std::string HOME = std::string(getenv("USERPROFILE"));
		#else
			int pid = getpid();
			const std::string HOME = std::string(getenv("HOME"));
		#endif
		RuntimeDir = HOME / ".dmcre" / "rt" / (ToHexString_BE(&pid) + "-" + std::to_string(time::now().timestamp()));
		//std::cout << "runtime dir: " << RuntimeDir.str << std::endl;
		if(!std::filesystem::exists((HOME / ".dmcre" / "rt").str)) {
			std::filesystem::create_directory((HOME / ".dmcre" / "rt").str);
		}
		std::filesystem::create_directory(RuntimeDir.str);
	}
}
