//
//  TCP.cpp
//  Runtime
//
//  Created by Lilith on 07.04.26.
//

#if false

namespace dmcre {
}

#include <dmcre/Network.hpp>
#include <dmcre/Error.hpp>
#include <dmcre/Destructor.hpp>
#include <dmcre/debug.hpp>

#include <unistd.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <sys/select.h>
#include <thread>

namespace dmcre {
#if false
	class NetworkEndpoint::Impl_T {
	public:
		union {
			::sockaddr Base;
			::sockaddr_in Internetv4;
			::sockaddr_in6 Internetv6;
			::sockaddr_un Unix;
		} sockaddr;
		
		String toString(int fd = -1) const {
			if(sockaddr.Base.sa_family == AF_UNSPEC) {
				return "unspecified network endpoint";
			}
			
			if(sockaddr.Base.sa_family == AF_INET) {
				std::string str = (
					"IPv4@"
					+std::to_string((sockaddr.Internetv4.sin_addr.s_addr << 0) & 0b11111111)+"."
					+std::to_string((sockaddr.Internetv4.sin_addr.s_addr << 8) & 0b11111111)+"."
					+std::to_string((sockaddr.Internetv4.sin_addr.s_addr << 16) & 0b11111111)+"."
					+std::to_string((sockaddr.Internetv4.sin_addr.s_addr << 24) & 0b11111111)
				);
				
				int type;
				socklen_t len = sizeof(type);
				if (getsockopt(fd, SOL_SOCKET, SO_TYPE, &type, &len) == -1) {
					// unable to determine socket type
				} else {
					if(type == SOCK_STREAM /* internet stream is always TCP under MacOS */) {
						str += "::TCP@"+std::to_string(ntohs(sockaddr.Internetv4.sin_port));
					}
					else if(type == SOCK_DGRAM /* internet datagram is always UDP under MacOS */) {
						str += "::UDP@"+std::to_string(ntohs(sockaddr.Internetv4.sin_port));
					}
					else if(type == SOCK_SEQPACKET) {
						str += "::SEQPACKET";
					}
					else if(type == SOCK_RAW) {
					}
					else {
						str += "::<"+std::to_string(type)+">";
					}
				}

				return str.c_str();
			}
			
			return "unidentified network endpoint";
		}
	};
	
	TCPOverIPv4Endpoint::operator String() const {
		return impl->toString();
	}
	
	TCPOverIPv4Endpoint::Impl_T& TCPOverIPv4Endpoint::getImpl() {
		return *impl;
	}
	
	const TCPOverIPv4Endpoint::Impl_T& TCPOverIPv4Endpoint::getImpl() const {
		return *impl;
	}
	
	TCPOverIPv4Endpoint::TCPOverIPv4Endpoint(UInt32 address,UInt16 port) {
		impl = new Impl_T;
		
		impl->sockaddr.Base.sa_family = AF_INET;
		impl->sockaddr.Base.sa_len = sizeof(sockaddr_in);
		
		impl->sockaddr.Internetv4.sin_addr.s_addr = address.BigEndian();
		impl->sockaddr.Internetv4.sin_port = port.BigEndian();
	}
	
	TCPOverIPv4Endpoint::~TCPOverIPv4Endpoint() {
		delete impl;
	}
	
	UnspecifiedNetworkEndpoint::operator String() const {
		return impl->toString();
	}
	
	UnspecifiedNetworkEndpoint::Impl_T& UnspecifiedNetworkEndpoint::getImpl() {
		return *impl;
	}
	
	const UnspecifiedNetworkEndpoint::Impl_T& UnspecifiedNetworkEndpoint::getImpl() const {
		return *impl;
	}
	
	UnspecifiedNetworkEndpoint::UnspecifiedNetworkEndpoint() {
		impl = new Impl_T;
		
		impl->sockaddr.Base.sa_family = AF_UNSPEC;
	}
	
	UnspecifiedNetworkEndpoint::UnspecifiedNetworkEndpoint(const UnspecifiedNetworkEndpoint& other) {
		impl = new Impl_T;
		
		memcpy(this->impl,other.impl,sizeof(Impl_T));
	}
	
	UnspecifiedNetworkEndpoint::~UnspecifiedNetworkEndpoint() {
		delete impl;
	}
	
	class TCP::IOStream::Impl_T {
	public:
		int fd;
	};
	
	NetworkEndpoint& TCP::IOStream::LocalNetworkEndpoint() {
		return m_localEndpoint;
	}
	
	NetworkEndpoint& TCP::IOStream::RemoteNetworkEndpoint() {
		return m_remoteEndpoint;
	}
	
	void TCP::IOStream::close() {
		::close(impl->fd);
	}
	
	TCP::IOStream::~IOStream() {
		delete impl;
	}
	
	void TCP::IOStream::read(WriteableBuffer& output) {
		Byte* buffer = (Byte*)::malloc(output.size().HostEndian());
		anonymous Destructor(
			[&] {
				::free(buffer);
			}
		);
		
		Byte* ptr = buffer;
		UInt64 remaining = output.size();
		
		while (remaining > 0) {
			fd_set readfds;
			FD_ZERO(&readfds);
			FD_SET(impl->fd, &readfds);
			
			int ret = select(impl->fd + 1, &readfds, nullptr, nullptr, nullptr);
			if (ret == 0) throw std::runtime_error(std::string("read timeout"));
			if (ret < 0) {
				if (errno == EINTR) continue;
				throw Error("read failed");
			}
			
			ssize_t n = ::read(impl->fd, ptr, remaining.HostEndian());
			if (n < 0) {
				if (errno == EINTR) continue;
				throw Error("read failed");
			}
			if (n == 0) throw Error("connection closed");
			
			ptr += n;
			remaining -= Int64(n).ToUnsigned_DropSignBit();
		}
		
		for(uint64_t i = 0;i<output.size();i++) {
			output[i] = buffer[i];
		}
	}
	
	void TCP::IOStream::read(WriteableBuffer& output,SynchronousTimer& timeout) {
		throw FunctionNotImplemented();
	}
	
	void TCP::IOStream::write(ReadableBuffer& input) {
		Byte* buffer = (Byte*)::malloc(input.size().HostEndian());
		anonymous Destructor(
			[&] {
				::free(buffer);
			}
		);
		
		for(uint64_t i = 0;i<input.size();i++) {
			buffer[i] = input[i];
		}

		Byte* ptr = buffer;
		UInt64 remaining = input.size();
		
		while (remaining > 0) {
			ssize_t n = ::write(impl->fd, ptr, remaining.HostEndian());
			if (n < 0) {
				if (errno == EINTR) continue;
				throw Error(std::string("write failed: ")+strerror(errno));
			}
			ptr += n;
			remaining -= Int64(n).ToUnsigned_DropSignBit();
		}
	}
	
	void TCP::IOStream::write(ReadableBuffer& input,SynchronousTimer& timeout) {
		throw FunctionNotImplemented();
	}
	
	TCP::IOStream::IOStream(NetworkEndpoint& p_localEndpoint,NetworkEndpoint& p_remoteEndpoint): m_localEndpoint(p_localEndpoint),m_remoteEndpoint(p_remoteEndpoint) {
		this->impl = new Impl_T;
		
		impl->fd = ::socket(m_remoteEndpoint.getImpl().sockaddr.Base.sa_family, SOCK_STREAM, 0);
		if(impl->fd < 0) {
			throw Error(std::string("socket creation failure: ")+strerror(errno));
		}
		
		if(m_localEndpoint.getImpl().sockaddr.Base.sa_family != AF_UNSPEC) {
			int status = ::bind(impl->fd, (::sockaddr*)&m_localEndpoint.getImpl().sockaddr, m_localEndpoint.getImpl().sockaddr.Base.sa_len);
			if(status != 0) {
				throw Error(std::string("bind failure: ")+strerror(errno));
			}
		}
		
		int status = ::connect(impl->fd, (::sockaddr*)&m_remoteEndpoint.getImpl().sockaddr, m_remoteEndpoint.getImpl().sockaddr.Base.sa_len);
		if(status < 0) {
			throw Error(std::string("connection failure: ")+strerror(errno));
		}
	}
	
	TCP::IOStream::IOStream(NetworkEndpoint& p_localEndpoint,NetworkEndpoint& p_remoteEndpoint,int sockfd): m_localEndpoint(p_localEndpoint),m_remoteEndpoint(p_remoteEndpoint) {
		this->impl = new Impl_T;
		
		impl->fd = sockfd;
	}
	
	TCP::IOStream::operator String() {
		return (
			this->m_localEndpoint.getImpl().toString(this->impl->fd)
			+" <=> "+
			this->m_remoteEndpoint.getImpl().toString(this->impl->fd)
		);
	}
	
	class TCP::Listener::Impl_T {
	public:
		int fd;
	};
	
	TCP::Listener::Listener(NetworkEndpoint& p_localEndpoint): m_localEndpoint(p_localEndpoint) {
		this->impl = new Impl_T;
		
		impl->fd = ::socket(m_localEndpoint.getImpl().sockaddr.Base.sa_family, SOCK_STREAM, 0);
		if(impl->fd < 0) {
			throw Error(std::string("socket creation failure: ")+strerror(errno));
		}
		
		int _i = 1;
		::setsockopt(impl->fd, SOL_SOCKET, SO_REUSEADDR, &_i, sizeof(_i));
		::setsockopt(impl->fd, SOL_SOCKET, SO_REUSEPORT, &_i, sizeof(_i));
		
		if(m_localEndpoint.getImpl().sockaddr.Base.sa_family != AF_UNSPEC) {
			int status = ::bind(impl->fd, (::sockaddr*)&m_localEndpoint.getImpl().sockaddr, m_localEndpoint.getImpl().sockaddr.Base.sa_len);
			if(status != 0) {
				throw Error(std::string("bind failure: ")+strerror(errno));
			}
		}
	}
	
	void TCP::Listener::listen() {
		::listen(this->impl->fd,512);

		while(true) {
			UnspecifiedNetworkEndpoint remoteEndpoint;
			
			socklen_t sockaddr_len = sizeof(remoteEndpoint.getImpl().sockaddr);
			int remoteFD = ::accept(this->impl->fd,(::sockaddr*)&remoteEndpoint.getImpl().sockaddr,&sockaddr_len);
			if(remoteFD == -1) {
				break;
			}
			
			std::thread(
				[this,remoteEndpoint,remoteFD]() mutable {
					TCP::IOStream iostream(this->m_localEndpoint,remoteEndpoint,remoteFD);
					this->onAccept(this->m_localEndpoint, remoteEndpoint, iostream);
				}
			).detach();
		}
	}
	
	void TCP::Listener::close() {
		if(this->impl->fd != -1) {
			::close(this->impl->fd);
		}
		this->impl->fd = -1;
	}
	
	TCP::Listener::~Listener() {
		if(this->impl->fd != -1) {
			::close(this->impl->fd);
		}
		delete this->impl;
	}
#endif
}

#endif
