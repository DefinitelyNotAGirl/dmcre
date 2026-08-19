//
//  TCP.cpp
//  dmcre
//
//  Created by Lilith on 06.08.26.
//

#if defined (__APPLE__)

#include <dmcre/Network.hpp>

#include "Impl.hpp"

#include "../Memory.hpp"

#include <thread>

#include <dmcre/debug.hpp>

namespace dmcre {
	class TCP::IOStream::Impl_T {
		__public nw_connection_t connection;
		
		__public NetworkEndpoint localEndpoint;
		__public NetworkEndpoint remoteEndpoint;
		
		__public std::atomic<bool> readError;
		
		dispatch_semaphore_t ioSemaphore = dispatch_semaphore_create(0);
	};
	
	TCP::IOStream::IOStream(NetworkEndpoint& p_remoteEndpoint) {
		impl = new Impl_T;
		
		impl->remoteEndpoint.impl->endpoint = p_remoteEndpoint.impl->endpoint;
		
		auto parameters = nw_parameters_create();
		nw_protocol_stack_t stack = nw_parameters_copy_default_protocol_stack(parameters);
		
		nw_protocol_options_t tcp = nw_tcp_create_options();
		nw_protocol_stack_set_transport_protocol(stack, tcp);
		
		impl->connection = nw_connection_create(p_remoteEndpoint.impl->endpoint,parameters);
		
		nw_connection_set_queue(impl->connection,networkDispatchQueue());
		
		nw_connection_start(impl->connection);
		
		impl->localEndpoint.impl->endpoint = nw_path_copy_effective_local_endpoint(
			nw_connection_copy_current_path(impl->connection)
		);
	}
	
	void TCP::IOStream::close() {
		nw_connection_cancel(impl->connection);
	}
	
	TCP::IOStream::IOStream(void* connection) {
		impl = new Impl_T;
		
		impl->connection = (nw_connection_t)connection;
		
		nw_connection_set_queue(impl->connection,networkDispatchQueue());
		
		nw_connection_start(impl->connection);
		
		impl->localEndpoint.impl->endpoint = nw_path_copy_effective_local_endpoint(
			nw_connection_copy_current_path(impl->connection)
		);
	}
	
	void TCP::IOStream::read(WriteableBuffer& output) {
		nw_connection_receive(
							  impl->connection,
							  output.size().truncate<32>().HostEndian(),
							  output.size().truncate<32>().HostEndian(),
							  ^ (dispatch_data_t data,nw_content_context_t context,bool is_complete,nw_error_t error) {
								  if(data == nil) {
									  impl->readError.store(true);
									  dispatch_semaphore_signal(impl->ioSemaphore);
								  } else {
									  impl->readError.store(false);
									  copyDispatchData(data, output);
									  dispatch_semaphore_signal(impl->ioSemaphore);
								  }
							  }
							  );
		dispatch_semaphore_wait(impl->ioSemaphore, DISPATCH_TIME_FOREVER);
		if(impl->readError.load() == true) {
			throw Error("read failed");
		}
	}
	
	void TCP::IOStream::write(ReadableBuffer& output) {
		nw_connection_send(
						   impl->connection,
						   toDispatchData(output,networkDispatchQueue()),
						   NW_CONNECTION_DEFAULT_MESSAGE_CONTEXT,
						   true,
						   ^ (nw_error_t error) {
							   dispatch_semaphore_signal(impl->ioSemaphore);
						   }
						   );
		dispatch_semaphore_wait(impl->ioSemaphore, DISPATCH_TIME_FOREVER);
	}
	
	NetworkEndpoint& TCP::IOStream::LocalNetworkEndpoint() {
		return impl->localEndpoint;
	}
	
	NetworkEndpoint& TCP::IOStream::RemoteNetworkEndpoint() {
		return impl->remoteEndpoint;
	}
	
	TCP::IOStream::operator String() {
		return impl->localEndpoint.toString() + " <==(TCP)==> " + impl->remoteEndpoint.toString();
	}
	
	class TCP::Listener::Impl_T {
		__public nw_listener_t listener;
		__public nw_parameters_t parameters;
		
		__public dispatch_semaphore_t closeSemaphore = dispatch_semaphore_create(0);
	};
	
	TCP::Listener::Listener() {
		impl = new Impl_T;
		
		impl->parameters = nw_parameters_create();
		nw_protocol_stack_t stack = nw_parameters_copy_default_protocol_stack(impl->parameters);
		
		nw_protocol_options_t tcp = nw_tcp_create_options();
		nw_protocol_stack_set_transport_protocol(stack, tcp);
	}
	
	void TCP::Listener::close() {
		nw_listener_cancel(impl->listener);
		dispatch_semaphore_signal(impl->closeSemaphore);
	}
	
	void TCP::Listener::listen(String port) {
		impl->listener = nw_listener_create_with_port((const char*)port.encode(String::Format::CSTRING).raw(),impl->parameters);
		nw_listener_set_queue(impl->listener,networkDispatchQueue());

		nw_listener_set_new_connection_handler(impl->listener, ^(nw_connection_t connection) {
			nw_retain(connection);
			std::thread([connection,this]{
				TCP::IOStream iostream(connection);
				onAccept(iostream);
				nw_release(connection);
			}).detach();
		});
		
		nw_listener_start(impl->listener);
		
		dispatch_semaphore_wait(impl->closeSemaphore, DISPATCH_TIME_FOREVER);
	}
	
	void TCP::Listener::requireInterfaceByName(String ifname) {
		nw_path_monitor_t monitor = nw_path_monitor_create();
		nw_path_monitor_set_update_handler(monitor, ^(nw_path_t path) {
			__block nw_interface_t wanted = NULL;
			nw_path_enumerate_interfaces(path, ^bool(nw_interface_t interface) {
				const char *name = nw_interface_get_name(interface);
				if (name && String(name) == ifname) {
					wanted = interface;
					return false; // stop enumeration
				}
				return true;
			});
			
			if (wanted) {
				nw_parameters_require_interface(impl->parameters, wanted);
				nw_path_monitor_cancel(monitor);
			}
		});
		nw_path_monitor_set_queue(monitor, networkDispatchQueue());
		nw_path_monitor_start(monitor);
	}
	
	TCP::Listener::~Listener() {
		delete impl;
	}
}

#endif
