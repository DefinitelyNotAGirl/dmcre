//
//  Impl.hpp
//  dmcre
//
//  Created by Lilith on 06.08.26.
//

#pragma once

#include <Network/Network.h>

#include <dmcre/Network.hpp>

namespace dmcre {
	class NetworkEndpoint::Impl_T {
		__public nw_endpoint_t endpoint;
	};
	
	dispatch_queue_t& networkDispatchQueue();
}
