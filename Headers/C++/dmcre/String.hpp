//
//  String.hpp
//  dmcre
//
//  Created by Lilith on 07.04.26.
//

#pragma once

#define PREV_FILE_DMCRE_STRING_HPP

#ifndef DMCRE_FOUNDATION_TYPENAME
	#define DMCRE_FOUNDATION_TYPENAME
#else
	#define DMCRE_STRING_I_HATE_THIS_LANGUAGE
#endif

#include <dmcre/integer.hpp>
#include <dmcre/Error.hpp>
#include <dmcre/Buffer.hpp>
#include <dmcre/Array.hpp>

#include <vector>

#ifndef DMCRE_STRING_I_HATE_THIS_LANGUAGE
	#undef DMCRE_FOUNDATION_TYPENAME
#endif

namespace dmcre {
	class DynamicBuffer;
	class WriteableBuffer;
	class ReadableBuffer;

	class String {
	public:
		using Character = UInt32;
		
		enum class Format {
			ASCII,
			CSTRING,
			UTF32,
		};
	
	private:
		std::vector<Character> data;

	public:
		String(const char* cstr);
		String(const String& other);
		String() {
		}

		~String() {
		}
		
		UInt64 length() const;
		
		void append(Character c);
		void append(const String& str);
		
		void toLowerInPlace();
		
		UInt64 toUnsignedInt() const;
		Int64 toSignedInt() const;
		double toDouble() const;
		
		String operator+(const String& str) const;
		
		bool operator==(const String& other) const;
		
		decltype(data.begin()) begin() {
			return data.begin();
		}
		
		decltype(data.end()) end() {
			return data.end();
		}
		
		template<int t_Bits,bool t_Signedness,bool t_Endianess>
		static String fromInteger(Integer<t_Bits,t_Signedness,t_Endianess> n) {
			if constexpr(t_Signedness == Signed) {
				String str;
				
				bool isNegative = false;
				if(n < 0) {
					isNegative = true;
					n.InvertSign();
				}
				
				if(n == 0) {
					str.data.insert(str.data.begin(),0x30);
					return str;
				}
				
				while(n > 0) {
					UInt32 c = UInt32(0x30 + (n % 10).ToUnsigned_ReinterpretSignBit().HostEndian());
					str.data.insert(str.data.begin(),c);
					n /= 10;
				}
				
				if(isNegative) {
					str.data.insert(str.data.begin(),0x2d);
				}
				
				return str;
			} else {
				String str;
				
				if(n == 0) {
					str.data.insert(str.data.begin(),0x30);
					return str;
				}
				
				while(n > 0) {
					UInt32 c = UInt32(0x30 + (n % 10).HostEndian());
					str.data.insert(str.data.begin(),c);
					n /= 10;
				}
				
				return str;
			}
		}
		
		template<int t_Bits,bool t_Endianess>
		static String hex(Integer<t_Bits,Unsigned,t_Endianess> n) {
			constexpr int Digits = ((64 / 4) + ((64 % 4) == 0 ? 0 : 1));
			char buffer[3 + Digits];
			buffer[0] = '0';
			buffer[1] = 'x';
			buffer[sizeof(buffer)-1] = 0x00;
			constexpr const char HEX[] = "0123456789abcdef";
			
			for(int digit = Digits-1;digit>=0;digit--) {
				buffer[2 + digit] = HEX[(n & 0xF).HostEndian()];
				n /= 16;
			}
			
			return String(buffer);
		}
		
		static String fromDouble(double n);
		
		DynamicBuffer encode(const Format format) const;
		void encode(WriteableBuffer& buffer,const Format format) const;
		
		template<typename t_T,unsigned long t_N>
		static String decode(Array<t_T,t_N> data,Format format) requires(IsSame<t_T,Byte>) {
			String str;
			if(format == Format::ASCII) {
				for(UInt64 i = 0;i<t_N;i++) {
					str.append((data[i]).template extend<32>());
				}
			}
			return str;
		}
		
		static String decode(const ReadableBuffer& buffer,const Format format);
		static String decode(const char* cstr);
		static String decode(const std::vector<Byte>& bytes,const Format format);
	};
}
