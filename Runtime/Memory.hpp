//
//  Memory.hpp
//  dmcre
//
//  Created by Lilith on 06.08.26.
//

#include <dispatch/Dispatch.h>

#include <dmcre/Buffer.hpp>

namespace dmcre {
	inline void copyDispatchData(dispatch_data_t& source,WriteableBuffer& destination) {
		void* sourceBuffer;
		size_t sourceSize;
		[[maybe_unused]] auto __eat_my_ass = dispatch_data_create_map(source,(const void**)&sourceBuffer,&sourceSize);
		
		// check if destination implements WriteableContiguousInteropBuffer, in which case we can directly copy the memory content which is infinitely faster than copying it one byte at a time
		if(Implements<WriteableContiguousInteropBuffer>(destination)) {
			WriteableContiguousInteropBuffer& _destination = dynamic_cast<WriteableContiguousInteropBuffer&>(destination);
			std::memcpy(_destination.raw(),sourceBuffer,sourceSize);
			return;
		}
		
		// slow copy fallback
		for(size_t i = 0;i<sourceSize;i++) {
			destination[i] = ((Byte*)sourceBuffer)[i];
		}
	}
	
	inline dispatch_data_t toDispatchData(ReadableBuffer& source,dispatch_queue_t queue) {
		Byte* data = (Byte*)malloc(source.size().truncate<32>().HostEndian());
		
		// check if source implements ReadableContigousInteropBuffer, in which case we can directly copy the memory content which is infinitely faster than copying it one byte at a time
		if(Implements<ReadableContiguousInteropBuffer>(source)) {
			ReadableContiguousInteropBuffer& _source = dynamic_cast<ReadableContiguousInteropBuffer&>(source);
			std::memcpy(data,_source.raw(),source.size().truncate<32>().HostEndian());
		} else {
			// slow copy fallback
			for(UInt64 i = 0;i<source.size().truncate<32>().HostEndian();i++) {
				data[i.HostEndian()] = source[i];
			}
		}
		
		return dispatch_data_create(
			(void*)data,
			source.size().truncate<32>().HostEndian(),
			queue,
			^ () {
				free(data);
			}
		);
	}
}
