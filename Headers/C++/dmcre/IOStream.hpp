//
//  IOStream.hpp
//  dmcre
//
//  Created by Lilith on 07.04.26.
//

#pragma once

#include "IStream.hpp"
#include "OStream.hpp"

namespace dmcre {
	class IOStream: public IStream, public OStream {
	public:
		virtual void close() override = 0;
		
		virtual operator String() {
			return String("<anonymous ")+typeid(IOStream).name()+">";
		}
	};
}
