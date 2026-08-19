//
//  TLS.cpp
//  dmcre
//
//  Created by Lilith on 06.08.26.
//

#if defined (__APPLE__)

#include <dmcre/Network.hpp>

#include "Impl.hpp"

#include "../Memory.hpp"

namespace dmcre {
	class TLS::IOStream::Impl_T {
		__public nw_connection_t connection;
		
		__public NetworkEndpoint localEndpoint;
		__public NetworkEndpoint remoteEndpoint;
		
		__public std::atomic<bool> readError;
		
		dispatch_semaphore_t ioSemaphore = dispatch_semaphore_create(0);
	};

	TLS::IOStream::IOStream(NetworkEndpoint& p_remoteEndpoint) {
		impl = new Impl_T;
		
		impl->remoteEndpoint.impl->endpoint = p_remoteEndpoint.impl->endpoint;
		
		auto parameters = nw_parameters_create();
		nw_protocol_stack_t stack = nw_parameters_copy_default_protocol_stack(parameters);
		
		nw_protocol_options_t tcp = nw_tcp_create_options();
		nw_protocol_stack_set_transport_protocol(stack, tcp);
		
		nw_protocol_options_t tls = nw_tls_create_options();
		nw_protocol_stack_prepend_application_protocol(stack, tls);
		
		impl->connection = nw_connection_create(p_remoteEndpoint.impl->endpoint,parameters);
		
		nw_connection_set_queue(impl->connection,networkDispatchQueue());

		nw_connection_start(impl->connection);

		impl->localEndpoint.impl->endpoint = nw_path_copy_effective_local_endpoint(
			nw_connection_copy_current_path(impl->connection)
		);
	}
	
	void TLS::IOStream::read(WriteableBuffer& output) {
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
	
	void TLS::IOStream::write(ReadableBuffer& output) {
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
	
	void TLS::IOStream::close() {
		nw_connection_cancel(impl->connection);
	}
	
	NetworkEndpoint& TLS::IOStream::LocalNetworkEndpoint() {
		return impl->localEndpoint;
	}

	NetworkEndpoint& TLS::IOStream::RemoteNetworkEndpoint() {
		return impl->remoteEndpoint;
	}

	TLS::IOStream::operator String() {
		return impl->localEndpoint.toString() + " <==(TLS)==> " + impl->remoteEndpoint.toString();
	}
}

#endif
