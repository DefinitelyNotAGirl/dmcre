//
//  Filesystem.h
//  dmcre
//
//  Created by Lilith on 07.04.26.
//

#pragma once

#include "Error.hpp"
#include "String.hpp"
#include "IOStream.hpp"

namespace dmcre {
	class FileStream: public IOStream {
		int fd = -1;

	public:
		FileStream(std::string path) {
			fd = open(path.c_str(), O_RDWR | O_CREAT, 0644);
			if(fd < 0) {
				throw Error(std::string("filesystem: ")+strerror(errno));
			}
		}
		
		virtual void close() override {
			if(fd != -1) {
				::close(fd);
				fd = -1;
			}
		}
		
		~FileStream() {
			close();
		}
		
		virtual void read(WriteableBuffer& output) override {
			DynamicBuffer buffer;
			buffer.resize(output.size());

			if(::read(fd,buffer.raw(),buffer.size().HostEndian()) != buffer.size().HostEndian()) {
				throw Error(std::string("filesystem: ")+strerror(errno));
			}
			
			for(UInt64 i = 0;i<buffer.size();i++) {
				output[i] = buffer[i];
			}
		}
		
		virtual void read(WriteableBuffer& output,SynchronousTimer& timeout) override {
			throw FunctionNotImplemented();
		}
		
		virtual void write(ReadableBuffer& input) override {
			DynamicBuffer buffer;
			buffer.resize(input.size());
			
			for(UInt64 i = 0;i<buffer.size();i++) {
				buffer[i] = input[i];
			}
			
			if(::write(fd,buffer.raw(),buffer.size().HostEndian()) != buffer.size().HostEndian()) {
				throw Error(std::string("filesystem: ")+strerror(errno));
			}
		}
		
		virtual void write(ReadableBuffer& input,SynchronousTimer& timeout) override {
			throw FunctionNotImplemented();
		}
	};
}
