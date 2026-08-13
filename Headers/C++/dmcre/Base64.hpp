//
//  Base64.hpp
//  dmcre
//
//  Created by Lilith on 07.04.26.
//

#pragma once

#include "Encoder.hpp"
#include "Decoder.hpp"

namespace dmcre {
	class Base64: public BufferEncoder, public BufferDecoder {
	public:
		virtual void Encode(const ReadableBuffer& input,WriteableBuffer& output) override;
		
		virtual void Decode(const ReadableBuffer& input,WriteableBuffer& output) override;
		
		static Base64& shared();
	};
}
