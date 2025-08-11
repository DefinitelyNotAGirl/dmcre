#pragma once
#include <functional>

namespace dmcre {
	class Module {
	public:
		virtual ~Module() = default;
	};

	class Core {
	public:
		std::function<Module&(std::string specifier,void* in)> LoadModule;
	};

	class InitialModuleIn {
	public:
		int argc;
		char** argv;
	};
}
