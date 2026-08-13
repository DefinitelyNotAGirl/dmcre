#pragma once

#include "type.hpp"

namespace dmcre {

constexpr bool Signed = true;
constexpr bool Unsigned = false;

constexpr bool LittleEndian = true;
constexpr bool BigEndian = false;
constexpr bool HostEndianess = LittleEndian;

template<int bits,bool Signedness>
class SoftwareInteger {
	static_assert(false, "SoftwareInteger not implemented");

	unsigned char data[(bits / 8) + (bits % 8 == 0 ? 0 : 1)];
public:
};

template<int bits,bool Signedness>
struct ____Integer_s {
	using type = SoftwareInteger<bits,Signedness>;
};

#ifdef __UINT8_TYPE__
template<>
struct ____Integer_s<8,Unsigned> {
	using type = __UINT8_TYPE__;
};
#endif

#ifdef __INT8_TYPE__
template<>
struct ____Integer_s<8,Signed> {
	using type = __INT8_TYPE__;
};
#endif

#ifdef __UINT16_TYPE__
template<>
struct ____Integer_s<16,Unsigned> {
	using type = __UINT16_TYPE__;
};
#endif

#ifdef __INT16_TYPE__
template<>
struct ____Integer_s<16,Signed> {
	using type = __INT16_TYPE__;
};
#endif

#ifdef __UINT32_TYPE__
template<>
struct ____Integer_s<32,Unsigned> {
	using type = __UINT32_TYPE__;
};
#endif

#ifdef __INT32_TYPE__
template<>
struct ____Integer_s<32,Signed> {
	using type = __INT32_TYPE__;
};
#endif

#ifdef __UINT64_TYPE__
template<>
struct ____Integer_s<64,Unsigned> {
	using type = __UINT64_TYPE__;
};
#endif

#ifdef __INT64_TYPE__
template<>
struct ____Integer_s<64,Signed> {
	using type = __INT64_TYPE__;
};
#endif

template<int bits,bool Signedness>
using ____Integer = ____Integer_s<bits,Signedness>::type;

template<bool Signedness>
struct ____Integer_CompilerMax_s {
};

#ifdef __UINTMAX_TYPE__
template<>
struct ____Integer_CompilerMax_s<Unsigned> {
	using type = __UINTMAX_TYPE__;
};
#endif

#ifdef __INTMAX_TYPE__
template<>
struct ____Integer_CompilerMax_s<Signed> {
	using type = __INTMAX_TYPE__;
};
#endif

template<bool Signedness>
using ____Integer_CompilerMax = ____Integer_CompilerMax_s<Signedness>::type;


template<typename T>
inline T ByteSwap(T v) {
	// the compiler should optimize this out since sizeof(T) is a compile-time constexpr
	switch(sizeof(T)) {
		case 1: return (T)v;
		case 2: return (T)__builtin_bswap16((____Integer<16,Unsigned>)v);
		case 4: return (T)__builtin_bswap32((____Integer<32,Unsigned>)v);
		case 8: return (T)__builtin_bswap64((____Integer<64,Unsigned>)v);
		default: __builtin_unreachable();
	}
}

template<int t_Bits,bool t_Signedness,bool t_Endianess>
class Integer {
    template<int, bool, bool>
    friend class Integer;

public:
	static constexpr bool Endianess = t_Endianess;
	static constexpr bool Signedness = t_Signedness;
	static constexpr int Bits = t_Bits;

private:
	using BaseIntegerType = ____Integer<Bits,Signedness>;

    BaseIntegerType value;

	static inline consteval BaseIntegerType __consteval_max() {
	    if constexpr (Signedness) {
	        // Max of signed N-bit integer: 2^(N-1) - 1
	        BaseIntegerType result = 0;
	        for(int i = 0; i < Bits - 1; ++i) {
	            result |= (BaseIntegerType(1) << i);
	        }
	        return result;
	    } else {
	        // Max of unsigned N-bit integer: all bits set
	        BaseIntegerType result = 0;
	        for(int i = 0; i < Bits; ++i) {
	            result |= (BaseIntegerType(1) << i);
	        }
	        return result;
	    }
	}

	static inline consteval BaseIntegerType __consteval_min() {
	    if constexpr (Signedness) {
	        if constexpr (Bits == sizeof(BaseIntegerType) * 8) {
	            // For full-width signed type, just return INT64_MIN
	            return BaseIntegerType(1) << (Bits - 1); // two's complement: MSB set
	        } else {
	            BaseIntegerType result = 0;
	            result |= (BaseIntegerType(1) << (Bits - 1));
	            return -result;
	        }
	    } else {
	        return 0;
	    }
	}

public:
	constexpr inline Integer(____Integer_CompilerMax<Signedness> v)
	    : value(Endianess == HostEndianess ? (BaseIntegerType)v : ByteSwap<BaseIntegerType>((BaseIntegerType)v)) {
	    if constexpr (IsConstEval()) {
	        if (v < __consteval_min() || v > __consteval_max()) {
				throw "immediate out of range";
			}
	    }
	}

	static inline consteval Integer<Bits,Signedness,Endianess> max() {
		return __consteval_max();
	}

	static inline consteval Integer<Bits,Signedness,Endianess> min() {
		return __consteval_min();
	}

    constexpr inline Integer() : value(0) {}

    constexpr inline BaseIntegerType LittleEndian() const {
		if(Endianess == dmcre::LittleEndian) {
			return this->value; 
		} else {
			return ByteSwap<BaseIntegerType>(this->value);
		}
	}

	constexpr inline BaseIntegerType BigEndian() const {
		if(Endianess == dmcre::BigEndian) {
			return this->value;
		} else {
			return ByteSwap<BaseIntegerType>(this->value); 
		}
	}

	constexpr inline BaseIntegerType HostEndian() const {
		return HostEndianess == dmcre::LittleEndian ? this->LittleEndian() : this->BigEndian();
	}

	constexpr inline BaseIntegerType ValueInMemory() const {
		return this->value;
	}

public:
    // Comparisons
    friend constexpr inline bool operator==	(Integer<Bits,Signedness,Endianess> a, Integer<Bits,Signedness,Endianess> b)	{	return a.HostEndian()	==	b.HostEndian(); }
    friend constexpr inline bool operator!=	(Integer<Bits,Signedness,Endianess> a, Integer<Bits,Signedness,Endianess> b)	{	return a.HostEndian()	!=	b.HostEndian(); }
	friend constexpr inline bool operator<=	(Integer<Bits,Signedness,Endianess> a, Integer<Bits,Signedness,Endianess> b)	{	return a.HostEndian()	<=	b.HostEndian(); }
    friend constexpr inline bool operator>=	(Integer<Bits,Signedness,Endianess> a, Integer<Bits,Signedness,Endianess> b)	{	return a.HostEndian()	>=	b.HostEndian(); }
    friend constexpr inline bool operator<	(Integer<Bits,Signedness,Endianess> a, Integer<Bits,Signedness,Endianess> b)	{	return a.HostEndian()	<	b.HostEndian(); }
    friend constexpr inline bool operator>	(Integer<Bits,Signedness,Endianess> a, Integer<Bits,Signedness,Endianess> b)	{	return a.HostEndian()	>	b.HostEndian(); }

	// Arithmetic
	template<int ft_Bits = Bits,bool ft_Endianess = Endianess>
	friend constexpr inline Integer<Bits,Signedness,Endianess> operator+(Integer<Bits,Signedness,Endianess> a, Integer<ft_Bits,Signedness,ft_Endianess> b) requires(ft_Bits <= Bits) {
		Integer<Bits,Signedness,Endianess> o;
		o.value = a.HostEndian() + b.HostEndian();
		if constexpr(Endianess != HostEndianess) {
			o.value = ByteSwap(o.value);
		}
		return o;
	}

	friend constexpr inline Integer<Bits,Signedness,Endianess> operator+(Integer<Bits,Signedness,Endianess> a, long long b) requires(Signedness == Signed) {
		return a + Integer<Bits,Signedness,Endianess>(b);
	}

	friend constexpr inline Integer<Bits,Signedness,Endianess> operator+(Integer<Bits,Signedness,Endianess> a, unsigned long long b) requires(Signedness == Unsigned) {
		return a + Integer<Bits,Signedness,Endianess>(b);
	}

	template<int ft_Bits = Bits,bool ft_Endianess = Endianess>
	friend constexpr inline Integer<Bits,Signedness,Endianess> operator-(Integer<Bits,Signedness,Endianess> a, Integer<ft_Bits,Signedness,ft_Endianess> b) requires(ft_Bits <= Bits) {
		Integer<Bits,Signedness,Endianess> o;
		o.value = a.HostEndian() - b.HostEndian();
		if constexpr(Endianess != HostEndianess) {
			o.value = ByteSwap(o.value);
		}
		return o;
	}

	friend constexpr inline Integer<Bits,Signedness,Endianess> operator-(Integer<Bits,Signedness,Endianess> a, long long b) requires(Signedness == Signed) {
		return a - Integer<Bits,Signedness,Endianess>(b);
	}

	friend constexpr inline Integer<Bits,Signedness,Endianess> operator-(Integer<Bits,Signedness,Endianess> a, unsigned long long b) requires(Signedness == Unsigned) {
		return a - Integer<Bits,Signedness,Endianess>(b);
	}

	template<int ft_Bits = Bits,bool ft_Endianess = Endianess>
	friend constexpr inline Integer<Bits,Signedness,Endianess> operator*(Integer<Bits,Signedness,Endianess> a, Integer<ft_Bits,Signedness,ft_Endianess> b) requires(ft_Bits <= Bits) {
		Integer<Bits,Signedness,Endianess> o;
		o.value = a.HostEndian() * b.HostEndian();
		if constexpr(Endianess != HostEndianess) {
			o.value = ByteSwap(o.value);
		}
		return o;
	}

	friend constexpr inline Integer<Bits,Signedness,Endianess> operator*(Integer<Bits,Signedness,Endianess> a, long long b) requires(Signedness == Signed) {
		return a * Integer<Bits,Signedness,Endianess>(b);
	}

	friend constexpr inline Integer<Bits,Signedness,Endianess> operator*(Integer<Bits,Signedness,Endianess> a, unsigned long long b) requires(Signedness == Unsigned) {
		return a * Integer<Bits,Signedness,Endianess>(b);
	}

	template<int ft_Bits = Bits,bool ft_Endianess = Endianess>
	friend constexpr inline Integer<Bits,Signedness,Endianess> operator/(Integer<Bits,Signedness,Endianess> a, Integer<ft_Bits,Signedness,ft_Endianess> b) requires(ft_Bits <= Bits) {
		Integer<Bits,Signedness,Endianess> o;
		o.value = a.HostEndian() / b.HostEndian();
		if constexpr(Endianess != HostEndianess) {
			o.value = ByteSwap(o.value);
		}
		return o;
	}

	friend constexpr inline Integer<Bits,Signedness,Endianess> operator/(Integer<Bits,Signedness,Endianess> a, long long b) requires(Signedness == Signed) {
		return a / Integer<Bits,Signedness,Endianess>(b);
	}

	friend constexpr inline Integer<Bits,Signedness,Endianess> operator/(Integer<Bits,Signedness,Endianess> a, unsigned long long b) requires(Signedness == Unsigned) {
		return a / Integer<Bits,Signedness,Endianess>(b);
	}

	template<int ft_Bits = Bits,bool ft_Endianess = Endianess>
	friend constexpr inline Integer<Bits,Signedness,Endianess> operator%(Integer<Bits,Signedness,Endianess> a, Integer<ft_Bits,Signedness,ft_Endianess> b) requires(ft_Bits <= Bits) {
		Integer<Bits,Signedness,Endianess> o;
		o.value = a.HostEndian() % b.HostEndian();
		if constexpr(Endianess != HostEndianess) {
			o.value = ByteSwap(o.value);
		}
		return o;
	}

	friend constexpr inline Integer<Bits,Signedness,Endianess> operator%(Integer<Bits,Signedness,Endianess> a, long long b) requires(Signedness == Signed) {
		return a % Integer<Bits,Signedness,Endianess>(b);
	}

	friend constexpr inline Integer<Bits,Signedness,Endianess> operator%(Integer<Bits,Signedness,Endianess> a, unsigned long long b) requires(Signedness == Unsigned) {
		return a % Integer<Bits,Signedness,Endianess>(b);
	}

	template<int ft_Bits = Bits,bool ft_Endianess = Endianess>
	friend constexpr inline Integer<Bits,Signedness,Endianess> operator&(Integer<Bits,Signedness,Endianess> a, Integer<ft_Bits,Signedness,ft_Endianess> b) requires(ft_Bits <= Bits) {
		Integer<Bits,Signedness,Endianess> o;
		o.value = a.HostEndian() & b.HostEndian();
		if constexpr(Endianess != HostEndianess) {
			o.value = ByteSwap(o.value);
		}
		return o;
	}

	friend constexpr inline Integer<Bits,Signedness,Endianess> operator&(Integer<Bits,Signedness,Endianess> a, long long b) requires(Signedness == Signed) {
		return a & Integer<Bits,Signedness,Endianess>(b);
	}

	friend constexpr inline Integer<Bits,Signedness,Endianess> operator&(Integer<Bits,Signedness,Endianess> a, unsigned long long b) requires(Signedness == Unsigned) {
		return a & Integer<Bits,Signedness,Endianess>(b);
	}

	template<int ft_Bits = Bits,bool ft_Endianess = Endianess>
	friend constexpr inline Integer<Bits,Signedness,Endianess> operator|(Integer<Bits,Signedness,Endianess> a, Integer<ft_Bits,Signedness,ft_Endianess> b) requires(ft_Bits <= Bits) {
		Integer<Bits,Signedness,Endianess> o;
		o.value = a.HostEndian() | b.HostEndian();
		if constexpr(Endianess != HostEndianess) {
			o.value = ByteSwap(o.value);
		}
		return o;
	}

	friend constexpr inline Integer<Bits,Signedness,Endianess> operator|(Integer<Bits,Signedness,Endianess> a, long long b) requires(Signedness == Signed) {
		return a | Integer<Bits,Signedness,Endianess>(b);
	}

	friend constexpr inline Integer<Bits,Signedness,Endianess> operator|(Integer<Bits,Signedness,Endianess> a, unsigned long long b) requires(Signedness == Unsigned) {
		return a | Integer<Bits,Signedness,Endianess>(b);
	}

	template<int ft_Bits = Bits,bool ft_Endianess = Endianess>
	friend constexpr inline Integer<Bits,Signedness,Endianess> operator<<(Integer<Bits,Signedness,Endianess> a, Integer<ft_Bits,Signedness,ft_Endianess> b) requires(ft_Bits <= Bits) {
		Integer<Bits,Signedness,Endianess> o;
		o.value = (typename Integer<Bits,Signedness,Endianess>::BaseIntegerType)(a.HostEndian() << b.HostEndian());
		if constexpr(Endianess != HostEndianess) {
			o.value = ByteSwap(o.value);
		}
		return o;
	}

	friend constexpr inline Integer<Bits,Signedness,Endianess> operator<<(Integer<Bits,Signedness,Endianess> a, long long b) requires(Signedness == Signed) {
		return a << Integer<Bits,Signedness,Endianess>(b);
	}

	friend constexpr inline Integer<Bits,Signedness,Endianess> operator<<(Integer<Bits,Signedness,Endianess> a, unsigned long long b) requires(Signedness == Unsigned) {
		return a << Integer<Bits,Signedness,Endianess>(b);
	}

	template<int ft_Bits = Bits,bool ft_Endianess = Endianess>
	friend constexpr inline Integer<Bits,Signedness,Endianess> operator>>(Integer<Bits,Signedness,Endianess> a, Integer<ft_Bits,Signedness,ft_Endianess> b) requires(ft_Bits <= Bits) {
		Integer<Bits,Signedness,Endianess> o;
		o.value = (typename Integer<Bits,Signedness,Endianess>::BaseIntegerType)(a.HostEndian() >> b.HostEndian());
		if constexpr(Endianess != HostEndianess) {
			o.value = ByteSwap(o.value);
		}
		return o;
	}

	friend constexpr inline Integer<Bits,Signedness,Endianess> operator>>(Integer<Bits,Signedness,Endianess> a, long long b) requires(Signedness == Signed) {
		return a >> Integer<Bits,Signedness,Endianess>(b);
	}

	friend constexpr inline Integer<Bits,Signedness,Endianess> operator>>(Integer<Bits,Signedness,Endianess> a, unsigned long long b) requires(Signedness == Unsigned) {
		return a >> Integer<Bits,Signedness,Endianess>(b);
	}

	// increment / decrement
	// prefix ++
	friend constexpr inline Integer<Bits,Signedness,Endianess>& operator++(Integer<Bits,Signedness,Endianess>& a) {
	    a.value = a.HostEndian() + 1; 
		if constexpr(Endianess != HostEndianess) {
			a.value = ByteSwap(a.value);
		}
	    return a;
	}

	// postfix ++
	friend constexpr inline Integer<Bits,Signedness,Endianess> operator++(Integer<Bits,Signedness,Endianess>& a, int) {
	    Integer<Bits,Signedness,Endianess> tmp = a;
	    a.value = a.HostEndian() + 1;
		if constexpr(Endianess != HostEndianess) {
			a.value = ByteSwap(a.value);
		}
	    return tmp;
	}

	// prefix --
	friend constexpr inline Integer<Bits,Signedness,Endianess>& operator--(Integer<Bits,Signedness,Endianess>& a) {
	    a.value = a.HostEndian() - 1;
		if constexpr(Endianess != HostEndianess) {
			a.value = ByteSwap(a.value);
		}
	    return a;
	}

	// postfix --
	friend constexpr inline Integer<Bits,Signedness,Endianess> operator--(Integer<Bits,Signedness,Endianess>& a, int) {
	    Integer<Bits,Signedness,Endianess> tmp = a;
	    a.value = a.HostEndian() - 1;
		if constexpr(Endianess != HostEndianess) {
			a.value = ByteSwap(a.value);
		}
	    return tmp;
	}

	// arithmetic assignment
	template<int ft_Bits = Bits,bool ft_Endianess = Endianess>
	constexpr inline Integer<Bits,Signedness,Endianess>& operator+=(const Integer<ft_Bits,Signedness,ft_Endianess>& other) requires(ft_Bits <= Bits) {
		this->value = this->HostEndian() + other.HostEndian();
		if constexpr(Endianess != HostEndianess) {
			this->value = ByteSwap(this->value);
		}
		return *this;
	}

	constexpr inline Integer<Bits,Signedness,Endianess>& operator+=(long long other) requires(Signedness == Signed) {
		this->value = this->HostEndian() + other;
		if constexpr(Endianess != HostEndianess) {
			this->value = ByteSwap(this->value);
		}
		return *this;
	}

	constexpr inline Integer<Bits,Signedness,Endianess>& operator+=(unsigned long long other) requires(Signedness == Unsigned) {
		this->value = this->HostEndian() + other;
		if constexpr(Endianess != HostEndianess) {
			this->value = ByteSwap(this->value);
		}
		return *this;
	}

	template<int ft_Bits = Bits,bool ft_Endianess = Endianess>
	constexpr inline Integer<Bits,Signedness,Endianess>& operator-=(const Integer<ft_Bits,Signedness,ft_Endianess>& other) requires(ft_Bits <= Bits) {
		this->value = this->HostEndian() - other.HostEndian();
		if constexpr(Endianess != HostEndianess) {
			this->value = ByteSwap(this->value);
		}
		return *this;
	}

	constexpr inline Integer<Bits,Signedness,Endianess>& operator-=(long long other) requires(Signedness == Signed) {
		this->value = this->HostEndian() - other;
		if constexpr(Endianess != HostEndianess) {
			this->value = ByteSwap(this->value);
		}
		return *this;
	}

	constexpr inline Integer<Bits,Signedness,Endianess>& operator-=(unsigned long long other) requires(Signedness == Unsigned) {
		this->value = this->HostEndian() - other;
		if constexpr(Endianess != HostEndianess) {
			this->value = ByteSwap(this->value);
		}
		return *this;
	}

	template<int ft_Bits = Bits,bool ft_Endianess = Endianess>
	constexpr inline Integer<Bits,Signedness,Endianess>& operator*=(const Integer<ft_Bits,Signedness,ft_Endianess>& other) requires(ft_Bits <= Bits) {
		this->value = this->HostEndian() * other.HostEndian();
		if constexpr(Endianess != HostEndianess) {
			this->value = ByteSwap(this->value);
		}
		return *this;
	}

	constexpr inline Integer<Bits,Signedness,Endianess>& operator*=(long long other) requires(Signedness == Signed) {
		this->value = this->HostEndian() * other;
		if constexpr(Endianess != HostEndianess) {
			this->value = ByteSwap(this->value);
		}
		return *this;
	}

	constexpr inline Integer<Bits,Signedness,Endianess>& operator*=(unsigned long long other) requires(Signedness == Unsigned) {
		this->value = this->HostEndian() * other;
		if constexpr(Endianess != HostEndianess) {
			this->value = ByteSwap(this->value);
		}
		return *this;
	}

	template<int ft_Bits = Bits,bool ft_Endianess = Endianess>
	constexpr inline Integer<Bits,Signedness,Endianess>& operator/=(const Integer<ft_Bits,Signedness,ft_Endianess>& other) requires(ft_Bits <= Bits) {
		this->value = this->HostEndian() / other.HostEndian();
		if constexpr(Endianess != HostEndianess) {
			this->value = ByteSwap(this->value);
		}
		return *this;
	}

	constexpr inline Integer<Bits,Signedness,Endianess>& operator/=(long long other) requires(Signedness == Signed) {
		this->value = this->HostEndian() / other;
		if constexpr(Endianess != HostEndianess) {
			this->value = ByteSwap(this->value);
		}
		return *this;
	}

	constexpr inline Integer<Bits,Signedness,Endianess>& operator/=(unsigned long long other) requires(Signedness == Unsigned) {
		this->value = this->HostEndian() / other;
		if constexpr(Endianess != HostEndianess) {
			this->value = ByteSwap(this->value);
		}
		return *this;
	}

	template<int ft_Bits = Bits,bool ft_Endianess = Endianess>
	constexpr inline Integer<Bits,Signedness,Endianess>& operator%=(const Integer<ft_Bits,Signedness,ft_Endianess>& other) requires(ft_Bits <= Bits) {
		this->value = this->HostEndian() % other.HostEndian();
		if constexpr(Endianess != HostEndianess) {
			this->value = ByteSwap(this->value);
		}
		return *this;
	}

	constexpr inline Integer<Bits,Signedness,Endianess>& operator%=(long long other) requires(Signedness == Signed) {
		this->value = this->HostEndian() % other;
		if constexpr(Endianess != HostEndianess) {
			this->value = ByteSwap(this->value);
		}
		return *this;
	}

	constexpr inline Integer<Bits,Signedness,Endianess>& operator%=(unsigned long long other) requires(Signedness == Unsigned) {
		this->value = this->HostEndian() % other;
		if constexpr(Endianess != HostEndianess) {
			this->value = ByteSwap(this->value);
		}
		return *this;
	}

	template<int ft_Bits = Bits,bool ft_Endianess = Endianess>
	constexpr inline Integer<Bits,Signedness,Endianess>& operator|=(const Integer<ft_Bits,Signedness,ft_Endianess>& other) requires(ft_Bits <= Bits) {
		this->value = this->HostEndian() | other.HostEndian();
		if constexpr(Endianess != HostEndianess) {
			this->value = ByteSwap(this->value);
		}
		return *this;
	}

	constexpr inline Integer<Bits,Signedness,Endianess>& operator|=(long long other) requires(Signedness == Signed) {
		this->value = this->HostEndian() | other;
		if constexpr(Endianess != HostEndianess) {
			this->value = ByteSwap(this->value);
		}
		return *this;
	}

	constexpr inline Integer<Bits,Signedness,Endianess>& operator|=(unsigned long long other) requires(Signedness == Unsigned) {
		this->value = this->HostEndian() | other;
		if constexpr(Endianess != HostEndianess) {
			this->value = ByteSwap(this->value);
		}
		return *this;
	}

	template<int ft_Bits = Bits,bool ft_Endianess = Endianess>
	constexpr inline Integer<Bits,Signedness,Endianess>& operator&=(const Integer<ft_Bits,Signedness,ft_Endianess>& other) requires(ft_Bits <= Bits) {
		this->value = this->HostEndian() & other.HostEndian();
		if constexpr(Endianess != HostEndianess) {
			this->value = ByteSwap(this->value);
		}
		return *this;
	}

	constexpr inline Integer<Bits,Signedness,Endianess>& operator&=(long long other) requires(Signedness == Signed) {
		this->value = this->HostEndian() & other;
		if constexpr(Endianess != HostEndianess) {
			this->value = ByteSwap(this->value);
		}
		return *this;
	}

	constexpr inline Integer<Bits,Signedness,Endianess>& operator&=(unsigned long long other) requires(Signedness == Unsigned) {
		this->value = this->HostEndian() & other;
		if constexpr(Endianess != HostEndianess) {
			this->value = ByteSwap(this->value);
		}
		return *this;
	}

	// pointer arithmetic
	template<typename T>
	friend constexpr inline T* operator+(T* a, Integer<Bits,Signedness,Endianess> b) {
		return (T*)(((____Integer<8,Unsigned>*)a) + b.HostEndian());
	}

	template<typename T>
	friend constexpr inline T* operator-(T* a, Integer<Bits,Signedness,Endianess> b) {
		return (T*)(____Integer<8,Unsigned>*)a - b.HostEndian();
	}

	constexpr inline Integer<Bits,Signed,Endianess> ToSigned_Truncate() const requires(Signedness == Unsigned) {
		using in	= Integer<Bits,Unsigned,Endianess>::BaseIntegerType;
		using out	= Integer<Bits,Signed,Endianess>::BaseIntegerType;

		in i = this->HostEndian();
		out o = (out)(i & Integer<Bits,Signed,Endianess>::__consteval_max());

		Integer<Bits,Signed,Endianess> r;
		if constexpr(Endianess != HostEndianess) {
			r.value = ByteSwap(o);
		} else {
			r.value = o;
		}
		return r;
	}

	constexpr inline Integer<Bits,Unsigned,Endianess> ToUnsigned_DropSignBit() const requires(Signedness == Signed) {
		using in	= Integer<Bits,Signed,Endianess>::BaseIntegerType;
		using out	= Integer<Bits,Unsigned,Endianess>::BaseIntegerType;

		in i = this->HostEndian();
		out o = (out)(i & Integer<Bits,Signed,Endianess>::__consteval_max());

		Integer<Bits,Unsigned,Endianess> r;
		if constexpr(Endianess != HostEndianess) {
			r.value = ByteSwap(o);
		} else {
			r.value = o;
		}
		return r;
	}

	constexpr inline Integer<Bits,Unsigned,Endianess> ToUnsigned_ReinterpretSignBit() const requires(Signedness == Signed) {
		using in	= Integer<Bits,Signed,Endianess>::BaseIntegerType;
		using out	= Integer<Bits,Unsigned,Endianess>::BaseIntegerType;

		in i = this->HostEndian();
		out o = (out)((out)i & Integer<Bits,Unsigned,Endianess>::__consteval_max());

		Integer<Bits,Unsigned,Endianess> r;
		if constexpr(Endianess != HostEndianess) {
			r.value = ByteSwap(o);
		} else {
			r.value = o;
		}
		return r;
	}

	constexpr inline Integer<Bits,Signed,Endianess> ToSigned_Reinterpret() const requires(Signedness == Unsigned) {
		using in	= Integer<Bits,Unsigned,Endianess>::BaseIntegerType;
		using out	= Integer<Bits,Signed,Endianess>::BaseIntegerType;

		in i = this->HostEndian();
		out o = *((out*)&i);

		Integer<Bits,Signed,Endianess> r;
		if constexpr(Endianess != HostEndianess) {
			r.value = ByteSwap(o);
		} else {
			r.value = o;
		}
		return r;
	}

	template<int ft_Bits>
	constexpr inline Integer<ft_Bits,Signedness,Endianess> truncate() const requires((Signedness == Unsigned) && (ft_Bits <= Bits)) {
		using in	= Integer<Bits,Signedness,Endianess>::BaseIntegerType;
		using out	= Integer<ft_Bits,Signedness,Endianess>::BaseIntegerType;

		in i = this->HostEndian();
		out o = (out)(i & Integer<ft_Bits,Signedness,Endianess>::__consteval_max());

		Integer<ft_Bits,Signedness,Endianess> r;
		if constexpr(Endianess != HostEndianess) {
			r.value = ByteSwap(o);
		} else {
			r.value = o;
		}
		return r;
	}

	template<int ft_Bits>
	constexpr inline Integer<ft_Bits,Signedness,Endianess> truncate() const requires((Signedness == Signed) && (ft_Bits <= Bits)) {
		using in	= Integer<Bits,Signedness,Endianess>::BaseIntegerType;
		using out	= Integer<ft_Bits,Signedness,Endianess>::BaseIntegerType;
		
		in i = this->HostEndian();
		out o = (out)(i & Integer<ft_Bits,Signedness,Endianess>::__consteval_max());
		
		Integer<ft_Bits,Signedness,Endianess> r;
		if constexpr(Endianess != HostEndianess) {
			r.value = ByteSwap(o);
		} else {
			r.value = o;
		}
		return r;
	}

	template<int ft_Bits>
	constexpr inline Integer<ft_Bits,Signedness,Endianess> extend() const requires((Signedness == Unsigned) && (ft_Bits >= Bits)) {
		using in	= Integer<Bits,Signedness,Endianess>::BaseIntegerType;
		using out	= Integer<ft_Bits,Signedness,Endianess>::BaseIntegerType;

		in i = this->HostEndian();
		out o = (out)i;

		Integer<ft_Bits,Signedness,Endianess> r;
		if constexpr(Endianess != HostEndianess) {
			r.value = ByteSwap(o);
		} else {
			r.value = o;
		}
		return r;
	}

	template<int ft_Bits>
	constexpr inline Integer<ft_Bits,Signedness,Endianess> extend() const requires((Signedness == Signed) && (ft_Bits >= Bits)) {
		using in	= Integer<Bits,Signedness,Endianess>::BaseIntegerType;
		using out	= Integer<ft_Bits,Signedness,Endianess>::BaseIntegerType;

		in i = this->HostEndian();
		out o = (out)(i & Integer<ft_Bits,Signedness,Endianess>::__consteval_max());

		Integer<ft_Bits,Signedness,Endianess> r;
		if constexpr(Endianess != HostEndianess) {
			r.value = ByteSwap(o);
		} else {
			r.value = o;
		}
		return r;
	}

	constexpr inline Integer<Bits,Signedness,Endianess> InvertSign() const requires(Signedness == Signed) {
		using in	= Integer<Bits,Signedness,Endianess>::BaseIntegerType;
		using out	= in;

		in i = this->HostEndian();
		out o = (out)((out)i & Integer<Bits,Signedness,Endianess>::__consteval_max());

		if(((((in)1) << (Bits - 2)) & i) == 0) {
			o |= ((in)1) << (Bits - 2);
		}

		Integer<Bits,Signedness,Endianess> r;
		if constexpr(Endianess != HostEndianess) {
			r.value = ByteSwap(o);
		} else {
			r.value = o;
		}
		return r;
	}

	constexpr inline Integer<Bits,Signedness,Endianess> InvertBits() const {
		using in	= Integer<Bits,Signedness,Endianess>::BaseIntegerType;
		using out	= in;

		in i = this->HostEndian();
		out o = (out)(~((out)i));

		Integer<Bits,Signedness,Endianess> r;
		if constexpr(Endianess != HostEndianess) {
			r.value = ByteSwap(o);
		} else {
			r.value = o;
		}
		return r;
	}

	template<typename ft_T>
	constexpr inline ft_T* ToPointer() const {
		return (ft_T*)(this->HostEndian());
	}

	template<bool ft_Endianess>
	constexpr inline Integer<Bits,Signedness,ft_Endianess> SwapEndianess() const {
		if constexpr (ft_Endianess == Endianess) {
			return *this;
		} else {
			Integer<Bits,Signedness,ft_Endianess> r;
			r.value = ByteSwap(this->value);
			return r;
		}
	}
};

using  UInt8_BE	= Integer<8,Unsigned,BigEndian>;
using UInt16_BE	= Integer<16,Unsigned,BigEndian>;
using UInt32_BE	= Integer<32,Unsigned,BigEndian>;
using UInt64_BE	= Integer<64,Unsigned,BigEndian>;
using  Int8_BE	= Integer<8,Signed,BigEndian>;
using Int16_BE	= Integer<16,Signed,BigEndian>;
using Int32_BE	= Integer<32,Signed,BigEndian>;
using Int64_BE	= Integer<64,Signed,BigEndian>;

using  UInt8_LE	= Integer<8,Unsigned,LittleEndian>;
using UInt16_LE	= Integer<16,Unsigned,LittleEndian>;
using UInt32_LE	= Integer<32,Unsigned,LittleEndian>;
using UInt64_LE	= Integer<64,Unsigned,LittleEndian>;
using  Int8_LE	= Integer<8,Signed,LittleEndian>;
using Int16_LE	= Integer<16,Signed,LittleEndian>;
using Int32_LE	= Integer<32,Signed,LittleEndian>;
using Int64_LE	= Integer<64,Signed,LittleEndian>;

using  UInt8 = Integer<8,Unsigned,HostEndianess>;
using UInt16 = Integer<16,Unsigned,HostEndianess>;
using UInt32 = Integer<32,Unsigned,HostEndianess>;
using UInt64 = Integer<64,Unsigned,HostEndianess>;
using  Int8  = Integer<8,Signed,HostEndianess>;
using Int16  = Integer<16,Signed,HostEndianess>;
using Int32  = Integer<32,Signed,HostEndianess>;
using Int64  = Integer<64,Signed,HostEndianess>;

using Byte = Integer<8,Unsigned,HostEndianess>;

static_assert(sizeof(Int8)  == 1, "Int8 must be 1 byte");
static_assert(sizeof(Int16) == 2, "Int16 must be 2 bytes");
static_assert(sizeof(Int32) == 4, "Int32 must be 4 bytes");
static_assert(sizeof(Int64) == 8, "Int64 must be 8 bytes");

static_assert(sizeof(UInt8)  == 1, "UInt8 must be 1 byte");
static_assert(sizeof(UInt16) == 2, "UInt16 must be 2 bytes");
static_assert(sizeof(UInt32) == 4, "UInt32 must be 4 bytes");
static_assert(sizeof(UInt64) == 8, "UInt64 must be 8 bytes");

static_assert(sizeof(Byte)  == 1, "Int8 must be 1 byte");

#if false
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused"
void test() {
	Integer<64,Signed,HostEndianess> _ = 0;

	auto max = _.max();

	//auto res = u8.ToSigned_DropSignBit();
}
#pragma clang diagnostic pop
#endif

}
