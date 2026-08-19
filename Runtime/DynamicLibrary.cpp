//
//  DynamicLibrary.cpp
//  Runtime
//
//  Created by Lilith on 05.04.26.
//

#include <dmcre/DynamicLibrary>
#include <dmcre/error>
#include <dmcre/debug>

#if not defined(_WIN32)
	#include <dlfcn.h>
	#include <mach-o/dyld.h>
#endif

#if defined(_WIN32)
#include <Windows.h>
#endif
namespace dmcre {
#if defined(_WIN32)
	class DynamicLibraryPlatformData {
	public:
		HMODULE dll = nullptr;
	};

	DynamicLibrary::DynamicLibrary(std::string path,std::vector<DynamicLibrary::LoadFlag> flags) {
		this->data = new DynamicLibraryPlatformData;

		DynamicLibraryPlatformData* PlatformData = (DynamicLibraryPlatformData*)this->data;
		PlatformData->dll = LoadLibraryA(path.c_str());
		if(PlatformData->dll == nullptr) {
			DWORD errorCode = GetLastError();
			throw Error(std::string("LoadLibrary failed: ") + std::to_string(errorCode));
		}
	}

	void DynamicLibrary::unload() {
		DynamicLibraryPlatformData* PlatformData = (DynamicLibraryPlatformData*)this->data;
		if(PlatformData->dll) {
			FreeLibrary(PlatformData->dll);
		}
	}

	void* DynamicLibrary::getSymbol(std::string symbol) {
		DynamicLibraryPlatformData* PlatformData = (DynamicLibraryPlatformData*)this->data;

		FARPROC sym = GetProcAddress(PlatformData->dll, symbol.c_str());
		if(sym == nullptr) {
			throw Error(std::string("symbol not found: ")+symbol);
		}
		return reinterpret_cast<void*>(sym);
	}
#else
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
#endif
}
