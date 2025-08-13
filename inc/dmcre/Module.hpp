#pragma once
#include <functional>
#include <string>

#ifdef _WIN32
	#define FTAN(name)
#else
	#define FTAN(name) name
#endif

namespace dmcre {
	class Module {
	public:
		virtual ~Module() = default;
	};

	class Core {
	public:
		std::function<Module&(std::string FTAN(specifier),void* FTAN(in))> LoadModule;
	};

	class InitialModuleIn {
	public:
		int argc;
		char** argv;
	};
}
