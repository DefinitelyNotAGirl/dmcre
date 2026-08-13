#pragma once

#include <dmcre/foundation.hpp>

namespace dmcre {
	template<typename t_T,unsigned long t_Size>
	class Array {
	public:
		using T = t_T;
		static constexpr unsigned long size = t_Size;
	
	private:
		T m_data[size];
	
	public:
		inline const T& operator[](UInt64 index) const {
			return this->m_data[index.HostEndian()];
		}

		inline T& operator[](UInt64 index) {
			return this->m_data[index.HostEndian()];
		}

		inline const T* data() const {
			return this->m_data;
		}

		inline T* data() {
			return this->m_data;
		}
	};

	template<typename t_T>
	class DynamicArray : UniquelyOwned {
	public:
		using T = t_T;

	private:
		T* m_data;

	public:
		inline DynamicArray(T* p_data): m_data(p_data) {
		}

		template<int t_Bits,bool t_Endianess>
		inline const T& operator[](Integer<t_Bits,Unsigned,t_Endianess> index) const {
			return this->m_data[index.HostEndian()];
		}

		template<int t_Bits,bool t_Endianess>
		inline T& operator[](Integer<t_Bits,Unsigned,t_Endianess> index) {
			return this->m_data[index.HostEndian()];
		}

		inline const T* data() const {
			return this->m_data;
		}

		inline T* data() {
			return this->m_data;
		}
	};

	template<typename t_T>
	class SizelessArray {
	public:
		using T = t_T;

	private:
		T m_data[];

	public:
		inline SizelessArray() {
		}

		inline const T& operator[](UInt64 index) const {
			return this->m_data[index.HostEndian()];
		}

		inline T& operator[](UInt64 index) {
			return this->m_data[index.HostEndian()];
		}

		inline const T* data() const {
			return this->m_data;
		}

		inline T* data() {
			return this->m_data;
		}
	};
}
