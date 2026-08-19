//
//  Base64.cpp
//  Runtime
//
//  Created by Lilith on 07.04.26.
//

#include <dmcre/Base64>
#include <dmcre/error>

namespace dmcre {
	static const char Base64Chars[64] = {
		'A','B','C','D','E','F','G','H',
		'I','J','K','L','M','N','O','P',
		'Q','R','S','T','U','V','W','X',
		'Y','Z','a','b','c','d','e','f',
		'g','h','i','j','k','l','m','n',
		'o','p','q','r','s','t','u','v',
		'w','x','y','z','0','1','2','3',
		'4','5','6','7','8','9','+','/'
	};

	void Base64::Encode(const ReadableBuffer& input,WriteableBuffer& output) {
		std::list<bool> bits;
		
		for(Byte byte : input) {
			for(uint64_t b = 0;b<8;b++) {
				bool bit = (byte.HostEndian() & (1 << (8 - 1 - b))) != 0;
				//std::cout << (bit ? "1" : "0");
				bits.push_back(bit);
			}
		}
		
		while(bits.size() % 6 != 0) {
			bits.push_back(0);
		}
		
		UInt64 outputPosition = 0;
		while(bits.size() >= 6) {
			uint8_t _6 = 0;
			for(int64_t b = 5;b>=0;b--) {
				_6 |= bits.front() << b;
				bits.pop_front();
			}
			output[outputPosition++] = Base64Chars[_6];
		}
		
		if(bits.size() != 0) {
			throw Error("did a dumb");
		}
		
		while(outputPosition % 4 != 0) {
			output[outputPosition++] = '=';
		}
	}
	
	void Base64::Decode(const ReadableBuffer& input,WriteableBuffer& output) {
		throw FunctionNotImplemented();
	}
	
	Base64& Base64::shared() {
		static Base64 _;
		return _;
	}
}
