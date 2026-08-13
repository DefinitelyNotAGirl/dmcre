//
//  String.cpp
//  Runtime
//
//  Created by Lilith on 07.04.26.
//

#include <dmcre/String.hpp>
#include <dmcre/Error.hpp>
#include <dmcre/debug.hpp>

namespace dmcre {
	String::String(const String& other): data(other.data) {
	}
	
	String String::decode(const char* cstr) {
		// decode const char* as NULL terminated ASCII
		String str;
		while(*cstr) {
			str.append((unsigned char)*cstr);
			cstr++;
		}
		return str;
	}
	
	UInt64 String::length() const {
		return this->data.size();
	}
	
	void String::append(Character c) {
		this->data.push_back(c);
	}
	
	void String::append(const String& str) {
		for(Character c : str.data) {
			this->data.push_back(c);
		}
	}
	
	bool String::operator==(const String& other) const {
		if(other.length() != this->length()) {
			return false;
		}
		for(UInt64 i = 0;i<this->length();i++) {
			if(other.data[i.HostEndian()] != this->data[i.HostEndian()]) {
				return false;
			}
		}
		return true;
	}
	
	void String::encode(WriteableBuffer& buffer,const Format format) const {
		if(format == Format::UTF32) {
			for(UInt64 i = 0;i<this->length();i++) {
				UInt32_LE character = this->data.at(i.HostEndian());
				ReadableObjectBuffer cb(character);
				for(UInt64 b = 0;b<sizeof(character);b++) {
					Byte byte = cb[b];
					buffer[(i*sizeof(character))+b] = byte;
				}
			}
		} else {
			throw Error("string format not supported");
		}
	}
	
	UInt64 String::toUnsignedInt() const {
		// we dont have a pow function, the fact that thats not a compiler builtin is fucking ridiculous, but here we are
		// what do you fucking mean a compiler consisting of ~12.000.000 lines of code across >5.000 source files cant compute 10^n on its own?????
		// (no i am not implementing pow, kindly, eat my entire ass)
		UInt64 f = 1;
		for(UInt64 i = 0;i<(this->length()-UInt64(1));i++) f*=UInt64(10);
		UInt64 o = 0;
		for(auto c : this->data) {
			o += f * (c - UInt8(0x30));
			f/=UInt64(10);
		}
		return o;
	}
	
	String::String(const char* cstr) {
		// decode const char* as NULL terminated ASCII
		while(*cstr) {
			this->append((unsigned char)*cstr);
			cstr++;
		}
	}
	
	String String::decode(const ReadableBuffer& p_buffer,Format format) {
		String str;
		if(format == Format::CSTRING) {
			for(Byte byte : p_buffer) {
				if(byte == 0x00) {
					break;
				}
				str.append(byte.extend<32>());
			}
			return str;
		} else if(format == Format::ASCII) {
			for(Byte byte : p_buffer) {
				str.append(byte.extend<32>());
			}
			return str;
		} else if(format == Format::UTF32) {
			if((p_buffer.size() % 4) != 0) {
				throw Error("UTF32 strings may only be decoded from buffers where (p_buffer.size() % 4) == 0");
			}

			for(UInt64 i = 0;i<p_buffer.size();i+=4) {
				UInt32_LE character;
				WriteableObjectBuffer cb(character);
				for(UInt64 b = 0;b<4;b++) {
					cb[b] = p_buffer[i+b];
				}
				if(character == 0) {
					return str;
				}
				str.append(character);
			}
			return str;
		} else {
			throw Error("string format not supported");
		}
	}
	
	String String::decode(const std::vector<Byte>& bytes,const Format format) {
		String str;
		if(format == Format::ASCII) {
			for(Byte byte : bytes) {
				str.append(byte.extend<32>());
			}
		}
		return str;
	}
	
	DynamicBuffer String::encode(const Format format) const {
		//__debug_print_str("encoding string: ");
		//__debug_print_hex((Int64)this);
		//__debug_print_str(" => ");
		//__debug_print_hex((Int64)this->buffer.address());
		//__debug_print_str("\n");
		
		if(format == Format::ASCII || format == Format::CSTRING) {
			DynamicBuffer buffer;
			buffer.resize(this->length() + UInt64(format == Format::CSTRING ? 1 : 0));
			Byte* buf = (Byte*)buffer.raw();
			for(UInt64 i = 0;i<this->length();i++) {
				buf[i.HostEndian()] = this->data[i.HostEndian()].truncate<8>();
			}
			if(format == Format::CSTRING)buf[(buffer.size()-UInt64(1)).HostEndian()] = 0;
			return buffer;
		}
		else if(format == Format::UTF32) {
			DynamicBuffer buffer;
			buffer.resize(this->length() * 4);
			UInt32_LE* buf = (UInt32_LE*)buffer.raw();
			for(UInt64 i = 0;i<this->length();i++) {
				buf[i.HostEndian()] = this->data[i.HostEndian()].LittleEndian();
			}
			return buffer;
		}
		else {
			throw Error("string format not supported");
		}
	}
	
	void String::toLowerInPlace() {
		for(UInt32& c : this->data) {
			if(c >= 0x41 && c <= 0x5A) {
				c = c + 0x20;
			}
		}
	}
	
	Int64 String::toSignedInt() const {
		//__debug_print_str("decoding signed integer from string: ");
		//__debug_print_str((const char*)this->encode(Format::CSTRING).address());
		//__debug_print_str("\n");
		// we dont have a pow function, the fact that thats not a compiler builtin is fucking ridiculous, but here we are
		// what do you fucking mean a compiler consisting of ~12.000.000 lines of code across >5.000 source files cant compute 10^n on its own?????
		// (no i am not implementing pow, kindly, eat my entire ass)
		bool isNegative = false;
		if(this->data[0] == 0x2d) {
			isNegative = true;
		}
		
		UInt64 f = 1;
		for(UInt64 i = isNegative ? 1 : 0;i<(this->length()-UInt64(1));i++) f*=UInt64(10);
		Int64 o = 0;
		for(UInt64 i = isNegative ? 1 : 0;i<this->length();i++) {
			auto c = this->data[i.HostEndian()];
			o += (f * UInt32(c - 0x30)).ToSigned_Truncate();
			f/=UInt64(10);
		}
		//__debug_print_str("result: ");
		//__debug_print_hex(o);
		//__debug_print_str("\n");
		if(isNegative)return o * Int64(-1);
		return o;
	};
	
	String String::fromDouble(double n) {
		String str;
		if(n == 0.0) {
			str.data.insert(str.data.begin(),0x30);
			return str;
		}
		
		// Handle sign
		bool isNegative = false;
		if(n < 0.0) {
			isNegative = true;
			n = -n;
		}
		
		// Determine exponent for scientific notation if needed
		Int64 exponent = 0;
		if(n >= 10.0) {
			while(n >= 10.0) {
				n /= 10.0;
				exponent++;
			}
		} else if(n < 1.0) {
			while(n < 1.0) {
				n *= 10.0;
				exponent--;
			}
		}
		
		// Now n is in [1,10)
		Int64 intPart = static_cast<____Integer<64,Signed>>(n);
		double frac = n - static_cast<double>(intPart.HostEndian());
		
		str = String::fromInteger(intPart);
		
		// Append fractional part
		const int precision = 6;
		if(frac > 0.0) {
			str.append(0x2e); // '.'
			for(int i = 0; i < precision; i++) {
				frac *= 10.0;
				unsigned digit = static_cast<unsigned>(frac);
				str.append(UInt32(0x30 + digit));
				frac -= digit;
			}
		}
		
		// Append exponent if nonzero
		if(exponent != 0) {
			str.append(0x65); // 'e'
			for(auto c : String::fromInteger(exponent).data) {
				str.append(c);
			}
		}
		
		// Prepend sign if needed
		if(isNegative) str.data.insert(str.data.begin(),0x2d); // '-'
		
		return str;
	}
	
	double String::toDouble() const {
		//__debug_print_str("decoding double from string: ");
		//__debug_print_str((const char*)this->encode(Format::CSTRING).address());
		//__debug_print_str("\n");
		
		if(this->length() == 0) return 0.0;
		
		bool isNegative = false;
		UInt64 i = 0;
		if(this->data[0] == 0x2d) { // '-'
			isNegative = true;
			i = 1;
		}
		
		double integerPart = 0.0;
		double fractionalPart = 0.0;
		double divisor = 1.0;
		bool inFraction = false;
		bool inExponent = false;
		bool expNegative = false;
		Int64 exponent = 0;
		
		for(; i < this->length(); i++) {
			char c = char(this->data[i.HostEndian()].HostEndian());
			
			if(c == 0x2e && !inFraction && !inExponent) {
				inFraction = true;
				continue;
			}
			if((c == 0x65 || c == 0x45) && !inExponent) { // 'e' or 'E'
				inExponent = true;
				i++;
				if(i < this->length() && this->data[i.HostEndian()] == 0x2d) { expNegative = true; i++; }
				else if(i < this->length() && this->data[i.HostEndian()] == 0x2b) { i++; }
				for(; i < this->length(); i++) {
					UInt8 ec = this->data[i.HostEndian()].truncate<8>();
					if(ec < 0x30 || ec > 0x39) break;
					exponent = exponent * Int64(10) + (ec - UInt8(0x30)).extend<64>().ToSigned_Truncate();
				}
				break;
			}
			if(c < 0x30 || c > 0x39) continue;
			
			int digit = c - 0x30;
			if(!inFraction) {
				integerPart = integerPart * 10.0 + digit;
			} else {
				divisor *= 10.0;
				fractionalPart += digit / divisor;
			}
		}
		
		double value = integerPart + fractionalPart;
		if(expNegative) exponent *= Int64(-1);
		
		if(exponent > 0) {
			for(Int64 e = 0; e < exponent; e++) value *= 10.0;
		} else if(exponent < 0) {
			for(Int64 e = 0; e < (exponent * Int64(-1)); e++) value /= 10.0;
		}
		
		if(isNegative) value = -value;
		return value;
	}
	
	String String::operator+(const String& str) const {
		String res;
		for(auto i : this->data) res.append(i);
		for(auto i : str.data) res.append(i);
		return res;
	}
}
