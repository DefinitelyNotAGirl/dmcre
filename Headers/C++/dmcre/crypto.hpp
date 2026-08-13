#pragma once
#include <cstdint>
#include <functional>
#include <string>

// source of truth: https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.180-4.pdf

namespace dmcre::crypto {
	class HashBuffer {
	public:
		void* Data;
		uint64_t Size;

		HashBuffer(void* Data,uint64_t Size): Data(Data),Size(Size){}
		~HashBuffer() {
			free(this->Data);
		}

		std::string ToHexString() {
			/*
			std::string str;
			uint64_t bytes = this->Size / 8;
			str.resize(bytes);
			uint16_t buff;
			uint8_t* cbuff = (uint8_t*)(&buff);
			for(uint64_t b = 0;b<bytes;b++) {
				buff = Uint8ToHexAsciiMap[((uint8_t*)this->Data)[b]];
				str[(b*2)+0] = cbuff[0];
				str[(b*2)+1] = cbuff[1];
			}
			return str;
			*/
			static constexpr char hex_chars[] = "0123456789abcdef";
    		const unsigned char* bytes = static_cast<const unsigned char*>(this->Data);
    		std::string hex;
    		hex.reserve(this->Size * 2);
    		for (size_t i = 0; i < this->Size; ++i) {
    		    unsigned char byte = bytes[i];
    		    hex += hex_chars[(byte >> 4) & 0x0F];
    		    hex += hex_chars[byte & 0x0F];
    		}
    		return hex;
		}
	};

	class HashAlgorithm {
	private:
		using ft_hash = std::function<HashBuffer(void* Data,uint64_t DataSize)>;
		const ft_hash _hash;

	public:
		/**
			@param Data buffer holding the input data, buffer must be readable until at least ((uint8_t*)Data)+ceil(DataSize/8.0)
			@param DataSize buffer size in bits, i repeat, in bits, not bytes, if its given in bytes only the first 12.5% of the data will be used
		*/
		HashBuffer hash(void* Data,uint64_t DataSize) const {
			return this->_hash(Data,DataSize);
		}

		HashBuffer hash(std::string str) const {
			return this->_hash(str.data(),str.length());
		}
		
		HashAlgorithm(ft_hash hash): _hash(hash) {}
	};

	extern const HashAlgorithm sha1;
	extern const HashAlgorithm sha224;
	extern const HashAlgorithm sha256;
}
