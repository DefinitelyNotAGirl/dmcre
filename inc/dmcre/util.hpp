#include <cstdint>
#include <cstdlib>
#include <string>
#include <dmcre/data.hpp>

template<typename T>
static inline std::string ToHexString_BE(const T* data) {
	uint8_t* __data = (uint8_t*)data;
	uint16_t out[(sizeof(T)*2) + 1] = {0};
	for(uint64_t byte = 0;byte<sizeof(T);byte++) {
		uint8_t v = __data[byte];
		out[byte*2] = Uint8ToHexAsciiMap[v];
	}
	std::string res = (char*)out;
	//free(out);
	return res;
}
