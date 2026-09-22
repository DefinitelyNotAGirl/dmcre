#include <dmcre/load>

namespace dmcre::load {
	std::filesystem::path ResolvePath(Domain domain,std::filesystem::path path) {
		if(domain == Domain::Absolute) {
			return path;
		}

		if(domain == Domain::System) {
			// some global system path
			throw std::runtime_error("system domain not implemented");
		}

		if(domain == Domain::User) {
			// some user-based path
			throw std::runtime_error("user domain not implemented");
		}

		if(domain == Domain::WorkingDirectory) {
			return (std::filesystem::current_path() / path).string();
		}

		throw std::logic_error("bad domain: "+std::to_string(int(domain)));
	}
}