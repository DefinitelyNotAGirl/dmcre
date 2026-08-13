//
//  Network.cpp
//  dmcre
//
//  Created by Lilith on 06.08.26.
//

#include <dispatch/dispatch.h>
#include <dmcre/Network.hpp>
#include "Impl.hpp"

namespace dmcre {
	dispatch_queue_t& networkDispatchQueue() {
		static dispatch_queue_t queue = dispatch_queue_create("dmcre.network", DISPATCH_QUEUE_SERIAL);
		return queue;
	}
	
	NetworkEndpoint::NetworkEndpoint() {
		impl = new Impl_T;
	}
	
	NetworkEndpoint::~NetworkEndpoint() {
		delete impl;
	}
	
	String NetworkEndpoint::toString() {
		switch (nw_endpoint_get_type(impl->endpoint)) {
			case nw_endpoint_type_address: {
				char* cstr = nw_endpoint_copy_address_string(impl->endpoint);
				String str(cstr);
				free(cstr);
				return str;
			}
				
			case nw_endpoint_type_host: {
				const char* hostname = nw_endpoint_get_hostname(impl->endpoint);
				std::string port = std::to_string(nw_endpoint_get_port(impl->endpoint));
				String str(hostname);
				str.append(":");
				str.append(port.c_str());
				return str;
			}
				
			case nw_endpoint_type_bonjour_service: {
				String str("_");
				str.append(nw_endpoint_get_bonjour_service_name(impl->endpoint));
				str.append("._");
				str.append(nw_endpoint_get_bonjour_service_type(impl->endpoint));
				str.append(".");
				str.append(nw_endpoint_get_bonjour_service_domain(impl->endpoint));
				
				return str;
				
			}
				
			default:
				
				return "<unknown endpoint>";
				
		}
		
	}
	
	NetworkEndpoint NetworkEndpoint::TCPOverIPv4(UInt32 address,UInt16 port) {
		sockaddr_in addr;
		addr.sin_addr.s_addr = address.ValueInMemory();
		addr.sin_port = port.BigEndian();
		addr.sin_family = AF_INET;
		addr.sin_len = sizeof(addr);
		
		NetworkEndpoint endpoint;
		endpoint.impl->endpoint = nw_endpoint_create_address((sockaddr*)&addr);
		return endpoint;
	}

	NetworkEndpoint NetworkEndpoint::TCPOverIPv6(IPv6Address address,UInt16 port) {
		sockaddr_in6 addr;
		memcpy(&addr.sin6_addr,&address.address,sizeof(addr.sin6_addr));
		addr.sin6_port = port.BigEndian();
		addr.sin6_family = AF_INET6;
		addr.sin6_len = sizeof(addr);
		
		NetworkEndpoint endpoint;
		endpoint.impl->endpoint = nw_endpoint_create_address((sockaddr*)&addr);
		return endpoint;
	}
	
	NetworkEndpoint NetworkEndpoint::TCPOverSystemDNS(String hostname,String port) {
		NetworkEndpoint endpoint;
		endpoint.impl->endpoint = nw_endpoint_create_host((const char*)hostname.encode(String::Format::CSTRING).raw(),(const char*)port.encode(String::Format::CSTRING).raw());
		return endpoint;
	}
}
