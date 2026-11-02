/*

shit that we shouldnt need but actually do need goes here

*/

#include <cstddef>
#include <cstdlib>
#include <limits>
#include <new>

namespace {
	template<typename T>
	T* allocate(std::size_t count) {
		if(count > std::numeric_limits<std::size_t>::max() / sizeof(T)) {
			throw std::bad_alloc();
		}

		if(auto* memory = static_cast<T*>(std::malloc(count * sizeof(T)))) {
			return memory;
		}

		throw std::bad_alloc();
	}
}

__declspec(dllexport) extern "C" wchar_t* allocator_wchar_allocate(void*, unsigned long) asm("_ZNSaIwE8allocateEy");
__declspec(dllexport) extern "C" wchar_t* allocator_wchar_allocate(void*, unsigned long count) {
	return allocate<wchar_t>(count);
}

__declspec(dllexport) extern "C" void allocator_wchar_deallocate(void*, wchar_t* memory, unsigned long) asm("_ZNSaIwE10deallocateEPwy");
__declspec(dllexport) extern "C" void allocator_wchar_deallocate(void*, wchar_t* memory, unsigned long) {
	std::free(memory);
}

__declspec(dllexport) extern "C" char* allocator_char_allocate(void*, unsigned long) asm("_ZNSaIcE8allocateEy");
__declspec(dllexport) extern "C" char* allocator_char_allocate(void*, unsigned long count) {
	return allocate<char>(count);
}

__declspec(dllexport) extern "C" void allocator_char_deallocate(void*, char* memory, unsigned long) asm("_ZNSaIcE10deallocateEPcy");
__declspec(dllexport) extern "C" void allocator_char_deallocate(void*, char* memory, unsigned long) {
	std::free(memory);
}


