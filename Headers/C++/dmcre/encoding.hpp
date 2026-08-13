#pragma once

#include <dmcre/Buffer.hpp>

namespace dmcre {
	static std::string toBase64(const BasicBuffer& buffer) {
		static const char Base64[64] = {
		    'A','B','C','D','E','F','G','H',
		    'I','J','K','L','M','N','O','P',
		    'Q','R','S','T','U','V','W','X',
		    'Y','Z','a','b','c','d','e','f',
		    'g','h','i','j','k','l','m','n',
		    'o','p','q','r','s','t','u','v',
		    'w','x','y','z','0','1','2','3',
		    '4','5','6','7','8','9','+','/'
		};

		std::list<bool> bits;

		std::string res;

		auto bytes = buffer.data();

		for(uint64_t i = 0;i<buffer.size();i++) {
			uint8_t byte = bytes[i].HostEndian();
			//std::cout << "byte: " << (unsigned long)byte << std::endl;
			//std::cout << "bits: ";
			for(uint64_t b = 0;b<8;b++) {
				bool bit = (byte & (1 << (8 - 1 - b))) != 0;
				//std::cout << (bit ? "1" : "0");
				bits.push_back(bit);
			}
			//std::cout << std::endl;
		}

		while(bits.size() % 6 != 0) {
			bits.push_back(0);
		}

		while(bits.size() >= 6) {
			uint8_t _6 = 0;
			for(int64_t b = 5;b>=0;b--) {
				_6 |= bits.front() << b;
				bits.pop_front();
			}
			res.push_back((unsigned char)Base64[_6]);
		}

		if(bits.size() != 0) {
			throw std::logic_error("did a dumb");
		}

		while(res.size() % 4 != 0) {
			res.push_back((unsigned char)'=');
		}

		return res;
	}
}
