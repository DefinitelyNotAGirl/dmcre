//
//  BufferStream.hpp
//  dmcre
//
//  Created by Lilith on 13.04.26.
//

#pragma once

#include "Buffer.hpp"
#include "IOStream.hpp"

namespace dmcre {
	class BufferBackedIStream : public RandomAccessIStream {
		ReadableBuffer& buffer;
		
		UInt64 head = 0;

	public:
		BufferBackedIStream(ReadableBuffer& p_buffer): buffer(p_buffer) {
		}
		
		virtual void read(WriteableBuffer& output) {
			for(UInt64 i = 0;i<output.size();i++) {
				if(head >= buffer.size()) {
					throw IStream::OutOfDataException();
				}
				output[i] = buffer[head];
				head++;
			}
		}
		
		virtual void read(WriteableBuffer& output,SynchronousTimer& timeout) {
			throw FunctionNotImplemented();
		}
		
		template<typename T>
		requires(IsTriviallyCopyable<T>)
		T read() {
			T object;
			auto _buffer = WriteableObjectBuffer<T>(object);
			read(_buffer);
			return object;
		}
		
		virtual void close() {
			// closure of buffer-backed stream is meaningless, no-op
		}
		
		virtual void seek(UInt64 position) {
			head = position;
		}

		virtual void seek_end() {
			head = buffer.size();
		}
		
		virtual UInt64 position() {
			return head;
		}
	};
	
	class BufferBackedOStream : public RandomAccessOStream {
		DynamicBuffer& buffer;

		UInt64 head = 0;
	
	public:
		
		BufferBackedOStream(DynamicBuffer& p_buffer): buffer(p_buffer) {
		}
		
		virtual void seek(UInt64 position) override {
			head = position;
		}
		
		virtual void seek_end() override {
			head = buffer.size();
		}
		
		virtual UInt64 position() override {
			return head;
		}
		
		virtual void write(ReadableBuffer& input) override {
			for(UInt64 i = 0;i<input.size();i++) {
				if(head >= this->buffer.size()) {
					this->buffer.resize(this->buffer.size()+1);
				}
				this->buffer[head] = input[i];
				head++;
			}
		}
		
		template<typename T>
		requires(IsTriviallyCopyable<T>)
		void write(const T& object) {
			auto _buffer = ReadableObjectBuffer<T>(object);
			write(_buffer);
		}
		
		virtual void write(ReadableBuffer& input,SynchronousTimer& timeout) override {
			throw FunctionNotImplemented();
		}
		
		virtual void close() override {
			// closing a buffer-backed stream is meaningless
		}
	};
}
