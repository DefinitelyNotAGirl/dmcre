//
//  DynamicLibrary.cpp
//  Runtime
//
//  Created by Lilith on 05.04.26.
//

#include <dmcre/DynamicLibrary.hpp>
#include <dmcre/Error.hpp>
#include <dmcre/debug.hpp>

#include <dlfcn.h>
#include <mach-o/dyld.h>

namespace dmcre {
	class DynamicLibraryPlatformData {
	public:
		void* dll = nullptr;
	};

	DynamicLibrary::DynamicLibrary(std::string path,std::vector<DynamicLibrary::LoadFlag> flags) {
		this->data = new DynamicLibraryPlatformData;

		DynamicLibraryPlatformData* PlatformData = (DynamicLibraryPlatformData*)this->data;

		int sysFlags = RTLD_NOW;
		for(auto flag : flags) {
			if(flag == DynamicLibrary::LoadFlag::Global) {
				sysFlags |= RTLD_GLOBAL;
			}
		}

		PlatformData->dll = dlopen(path.c_str(),sysFlags);
		if(PlatformData->dll == nullptr) {
			const char* err = dlerror();
			throw Error(std::string("dlopen failed: ") + (err ? err : "unknown"));
		}
	}
	
	void DynamicLibrary::unload() {
		DynamicLibraryPlatformData* PlatformData = (DynamicLibraryPlatformData*)this->data;
		dlclose(PlatformData->dll);
	}
	
	void* DynamicLibrary::getSymbol(std::string symbol) {
		DynamicLibraryPlatformData* PlatformData = (DynamicLibraryPlatformData*)this->data;

		void* sym = dlsym(PlatformData->dll,symbol.c_str());
		if(sym == nullptr) {
			throw Error(std::string("symbol not found: ")+symbol);
		}
		return sym;
	}
}
