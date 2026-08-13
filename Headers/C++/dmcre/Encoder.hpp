//
//  Encoder.hpp
//  dmcre
//
//  Created by Lilith on 06.04.26.
//

#pragma once

#include "foundation.hpp"
#include "Buffer.hpp"

namespace dmcre {
	class BufferEncoder {
	public:
		virtual void Encode(const ReadableBuffer& input,WriteableBuffer& output) = 0;
	};
}
