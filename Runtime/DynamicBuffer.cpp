#if false
#include <dmcre/DynamicBuffer.hpp>
namespace dmcre {
	DynamicBuffer::~DynamicBuffer() {
		if(this->m_address == nullptr) return;
		if(this->bufferOwnsMemory == false)return;
		free(this->m_address);
	}

	DynamicBuffer::DynamicBuffer(UInt64 size) {
		if(size == 0) {
			this->m_size = 0;
			this->m_address = 0;
			return;
		}
		this->m_address = (Byte*)malloc(size.truncate<32>().ToSigned_Reinterpret().HostEndian());
		this->m_size = size;
	}

	DynamicBuffer::DynamicBuffer(const DynamicBuffer& buf) {
		this->m_address = (Byte*)malloc(buf.size().truncate<32>().ToSigned_Reinterpret().HostEndian());
		this->m_size = buf.size();
		this->bufferOwnsMemory = buf.bufferOwnsMemory;
		memcpy(this->m_address,buf.m_address,buf.m_size.HostEndian());
	}

	DynamicBuffer::DynamicBuffer(DynamicBuffer&& buf) noexcept {
		this->bufferOwnsMemory = buf.bufferOwnsMemory;

		this->m_address = buf.m_address;
		buf.m_address = nullptr;

		this->m_size = buf.m_size;
		buf.m_size = 0;
	}

	DynamicBuffer& DynamicBuffer::operator=(const DynamicBuffer& buf) {
		this->~DynamicBuffer();

		this->m_address = (Byte*)malloc(buf.size().truncate<32>().ToSigned_Reinterpret().HostEndian());
		this->m_size = buf.size();
		this->bufferOwnsMemory = buf.bufferOwnsMemory;
		memcpy(this->m_address,buf.m_address,this->m_size.HostEndian());
		return *this;
	}

	void DynamicBuffer::resize(UInt64 size) {
		this->m_size = size;
		this->m_address = (Byte*)realloc(this->m_address,size.truncate<32>().ToSigned_Reinterpret().HostEndian());
	}

	void DynamicBuffer::copyToPosition(const DynamicBuffer& src,UInt64 position) {
		if((position + src.size()) > this->m_size) {
			throw OutOfBoundsException({
				.BufferSize = this->m_size,
				.RequestedPosition = position + src.size()
			});
		}

		for(UInt64 i = 0;i<src.size();i++) {
			this->byte(position+i) = src.byte(i);
		}
	}

	DynamicBuffer DynamicBuffer::cloneExternalBuffer(const void* source,UInt64 bytes) {
		DynamicBuffer buf(bytes);
		const Byte* ext = (const Byte*)source;
		for(UInt64 i = 0;i<bytes;i++) {
			buf.byte(i) = ext[i.HostEndian()];
		}
		return buf;
	}

	void DynamicBuffer::dropFront(UInt64 bytes) {
		if(bytes > this->m_size) {
			throw OutOfBoundsException({
				.BufferSize = this->m_size,
				.RequestedPosition = bytes
			});
		}
		memmove(this->m_address,this->m_address+bytes,(this->m_size-bytes).HostEndian());
		this->resize(this->m_size-bytes);
	}

	DynamicBuffer DynamicBuffer::partialCopy(UInt64 start,UInt64 bytes) const {
		if(bytes+start > this->m_size) {
			throw OutOfBoundsException({
				.BufferSize = this->m_size,
				.RequestedPosition = bytes+start
			});
		}

		DynamicBuffer out(bytes);
		for(UInt64 i = 0;i<bytes;i++) {
			out.byte(i) = this->byte(start + i);
		}
		return out;
	}
}
#endif

#include <dmcre/Buffer.hpp>
namespace dmcre {
	UInt64 DynamicBuffer::size() const {
		return m_size;
	}
	
	const Byte* DynamicBuffer::raw() const {
		return m_data;
	}
	
	Byte* DynamicBuffer::raw() {
		return m_data;
	}
	
	const Byte* DynamicBuffer::begin() const {
		return m_data;
	}

	const Byte* DynamicBuffer::end() const {
		return m_data+m_size;
	}
	
	const Byte& DynamicBuffer::operator[](UInt64 index) const {
		return m_data[index.HostEndian()];
	}

	Byte& DynamicBuffer::operator[](UInt64 index) {
		return m_data[index.HostEndian()];
	}
	
	void DynamicBuffer::resize(UInt64 size) {
		m_data = (Byte*)realloc(m_data,size.HostEndian());
		this->m_size = size;
	}
	
	void DynamicBuffer::append(const ReadableBuffer& source) {
		m_data = (Byte*)realloc(m_data,(m_size+source.size()).HostEndian());
		
		UInt64 i = 0;
		for(Byte byte : source) {
			this->m_data[(m_size+i).HostEndian()] = byte;
			i++;
		}

		m_size = (m_size+source.size()).HostEndian();
	}
	
	void DynamicBuffer::copy(ReadableBuffer& source) {
		// check if source implements ReadableContigousInteropBuffer, in which case we can directly copy the memory content which is infinitely faster than copying it one byte at a time
		if(Implements<ReadableContiguousInteropBuffer>(source)) {
			ReadableContiguousInteropBuffer& _source = dynamic_cast<ReadableContiguousInteropBuffer&>(source);
			std::memcpy(this->raw(),_source.raw(),this->size().HostEndian());
			return;
		}
		
		// slow copy fallback
		for(UInt64 i = 0;i<this->size();i++) {
			this->operator[](i) = source[i];
		}
	}
	
	DynamicBuffer transformBufferToBase64(const ReadableContiguousInteropBuffer& input) {
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
		
		DynamicBuffer output;
		
		std::list<bool> bits;
		
		for(int i = 0;i<input.size().HostEndian();i++) {
			Byte byte = input.raw()[i];
			for(uint64_t b = 0;b<8;b++) {
				bool bit = (byte.HostEndian() & (1 << (8 - 1 - b))) != 0;
				//std::cout << (bit ? "1" : "0");
				bits.push_back(bit);
			}
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
			ReadableObjectBuffer buf(Base64Chars[_6]);
			output.append(buf);
		}
		
		if(bits.size() != 0) {
			throw Error("did a dumb");
		}
		
		while(output.size() % 4 != 0) {
			ReadableObjectBuffer buf('=');
			output.append(buf);
		}
		
		return output;
	}
}
