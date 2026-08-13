#pragma once

#include <dmcre/IOStream.hpp>
#include <dmcre/Encoder.hpp>
#include <dmcre/Decoder.hpp>
#include <dmcre/Base64.hpp>
#include <dmcre/http.hpp>
#include <dmcre/Network.hpp>
#include <dmcre/Buffer.hpp>

#include <atomic>
#include <cerrno>
#include <functional>
#include <stdexcept>
#include <map>
#include <thread>
#include <unistd.h>

namespace dmcre {
	struct WebSocketFrame {
		Byte Byte0;
		BitField<decltype(Byte0),7> FIN() {return decltype(FIN())(Byte0);}
		BitField<decltype(Byte0),0,3> Opcode() {return decltype(Opcode())(Byte0);}

		Byte Byte1;
		BitField<decltype(Byte1),7> MASK() {return decltype(MASK())(Byte1);}
		BitField<decltype(Byte1),0,6> PayloadLength() {return decltype(PayloadLength())(Byte1);}
	};
	
	class WebSocketMaskCoder: public BufferEncoder, public BufferDecoder {
		ReadableBuffer& mask;
	public:
		virtual void Encode(const ReadableBuffer& input,WriteableBuffer& output) override {
			for(uint64_t i = 0;i<input.size();i++) {
				output[i] = input[i].HostEndian() xor mask[i % 4].HostEndian();
			}
		}
		
		virtual void Decode(const ReadableBuffer& input,WriteableBuffer& output) override {
			throw FunctionNotImplemented();
		}
		
		WebSocketMaskCoder(ReadableBuffer& mask): mask(mask) {
		}
	};

	class WebSocket {
		enum class State {
			closed,
			open
		};

		inline static const std::list<http::Header> headers_empty;
		IOStream& iostream;

		std::atomic<State> LocalState = State::closed;
		std::atomic<State> RemoteState = State::closed;

	public:
		std::function<void(DynamicBuffer& data)> onMessage = [](DynamicBuffer& data){
			// empty default handler, can be left as is if the client does not wish to handle incoming messages
		};
		
		WebSocket(IOStream& iostream): iostream(iostream) {
		}
		
		std::function<void(const std::type_info* type,void* exception_ptr)> onError;

		void send(const DynamicBuffer& data) {
			if(LocalState != State::open) {
				throw std::logic_error(".send called on closed WebSocket client");
			}

			DynamicBuffer payload;
			payload.resize(data.size());

			RandomDataBuffer maskingKeyBuffer;
			maskingKeyBuffer.resize(4);
			maskingKeyBuffer.randomize();
			
			WebSocketMaskCoder encoder(maskingKeyBuffer);
			encoder.Encode(data, payload);

			WebSocketFrame MessageFrame;
			MessageFrame.Byte0 = 0x80 | 2;
			MessageFrame.MASK().set(1);
			if(payload.size() <= 125) {
				MessageFrame.PayloadLength().set(payload.size().truncate<8>());
			    iostream.write(MessageFrame);
			}
			else if(payload.size() <= 65535) {
			    MessageFrame.PayloadLength().set(126);
			    UInt16_BE len = payload.size().truncate<16>().SwapEndianess<BigEndian>();
			    iostream.write(MessageFrame);
			    iostream.write(len);
			}
			else {
			    MessageFrame.PayloadLength().set(127);
			    UInt64_BE len = payload.size().SwapEndianess<BigEndian>();
			    iostream.write(MessageFrame);
			    iostream.write(len);
			}
			//::debug::report();
			iostream.write(maskingKeyBuffer);
			iostream.write(payload);
		}

		void close() {
			if(LocalState != State::open) return;

			this->LocalState = State::closed;

			RandomDataBuffer maskingKeyBuffer;
			maskingKeyBuffer.resize(4);
			maskingKeyBuffer.randomize();

			WebSocketFrame MessageFrame;
			MessageFrame.Byte0 = 0x80 | 8;
			MessageFrame.MASK().set(1);
			iostream.write(MessageFrame);
			iostream.write(maskingKeyBuffer);

			while(this->RemoteState == State::open) {
				sleep(1);// this kinda sucks but i'm too fucking lazy to fix it and it doesnt really matter all that much for now
			}

			iostream.close();
		}

		void connect(std::string path = "",const std::list<http::Header>& headers = headers_empty) {
			RandomDataBuffer secKeyBuffer;
			secKeyBuffer.resize(16);
			secKeyBuffer.randomize();
			
			DynamicBuffer encodedSecKeyBuffer;
			encodedSecKeyBuffer.resize(22);
			Base64::shared().Encode(secKeyBuffer, encodedSecKeyBuffer);

			http::Request request;
			request.Method = "GET";
			request.Path = "/";
			request.Protocol = "HTTP/1.1";
			request.Headers.push_back({"connection","upgrade"});
			request.Headers.push_back({"upgrade","websocket"});
			request.Headers.push_back({"sec-websocket-key",String::decode(encodedSecKeyBuffer, String::Format::ASCII)});
			request.Headers.push_back({"sec-websocket-version","13"});
			for(auto& i : headers) {
				request.Headers.push_back(i);
			}

			http::SendRequest(iostream, request);

			auto response = http::ReadResponse(iostream);
			//std::cout << response.StatusCode.HostEndian() < < " " << (char*)response.StatusMessage.encode(string::Format::CSTRING).raw() << std::endl;

			LocalState = State::open;
			RemoteState = State::open;

#if false
			std::thread([this]{
				try {
					while(this->RemoteState == State::open) {
						auto frame = iostream.read<WebSocketFrame>();
						
						if(frame.Byte0 == 0x88) {
							this->RemoteState = State::closed;
							return;
						}
						
						UInt64 PayloadSize = frame.PayloadLength().get().extend<64>();
						
						if(PayloadSize == 126) {
							PayloadSize = iostream.read<UInt16_BE>().extend<64>().SwapEndianess<HostEndianess>();
						}
						else if(PayloadSize == 127) {
							PayloadSize = iostream.read<UInt64_BE>().SwapEndianess<HostEndianess>();
						}
						
						DynamicBuffer MaskingKey;
						MaskingKey.resize(4);
						
						if(frame.MASK().get() == 1) {
							iostream.read(MaskingKey);
						}
						
						DynamicBuffer payload;
						payload.resize(PayloadSize.HostEndian());
						iostream.read(payload);
						
						if(frame.MASK().get() == 1) {
							WebSocketMaskCoder decoder(MaskingKey);
							decoder.Decode(payload, payload);
						}
						
						onMessage(payload);
					}
				} catch(...) {
					void* exception_ptr = abi::__cxa_current_primary_exception();
					const std::type_info* ti = abi::__cxa_current_exception_type();
					if (ti) {
						onError(ti,exception_ptr);
					} else {
						onError(nullptr,exception_ptr);
					}
				}
			}).detach();
#else
			while(this->RemoteState == State::open) {
				auto frame = iostream.read<WebSocketFrame>();
				
				if(frame.Byte0 == 0x88) {
					this->RemoteState = State::closed;
					return;
				}
				
				UInt64 PayloadSize = frame.PayloadLength().get().extend<64>();
				
				if(PayloadSize == 126) {
					PayloadSize = iostream.read<UInt16_BE>().extend<64>().SwapEndianess<HostEndianess>();
				}
				else if(PayloadSize == 127) {
					PayloadSize = iostream.read<UInt64_BE>().SwapEndianess<HostEndianess>();
				}
				
				DynamicBuffer MaskingKey;
				MaskingKey.resize(4);
				
				if(frame.MASK().get() == 1) {
					iostream.read(MaskingKey);
				}
				
				DynamicBuffer payload;
				payload.resize(PayloadSize.HostEndian());
				iostream.read(payload);
				
				if(frame.MASK().get() == 1) {
					WebSocketMaskCoder decoder(MaskingKey);
					decoder.Decode(payload, payload);
				}
				
				onMessage(payload);
			}
#endif
		}

		~WebSocket() {
			this->close();
		}
	};
}
