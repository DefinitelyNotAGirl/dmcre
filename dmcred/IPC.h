#pragma once

#include <windows.h>
#include <iostream>
#include <io.h>
#include <fcntl.h>
#include <cerrno>
#include <climits>
#include <vector>
#include <iomanip>
#include <string>
#include <map>
#include <typeindex>
#include <functional>
#include <mutex>
#include <condition_variable>
#include <optional>

#include <dmcre/foundation>

namespace dmcred {
	class IPC {
		__private int in;
		__private int out;

		__public IPC(int in,int out): in(in),out(out) {
			if(_setmode(in,_O_BINARY) == -1 || _setmode(out,_O_BINARY) == -1) {
				throw std::system_error(errno,std::system_category(),"failed to set IPC streams to binary mode");
			}
		}

		__public class Object {
		public:
			std::type_index type;
			void* ptr;

			Object(std::vector<std::pair<std::string,Object>>* value): type(typeid(decltype(*value))),ptr(value) {
			}
		
			Object(std::vector<Object>* value): type(typeid(decltype(*value))),ptr(value) {
			}
		
			Object(std::string* value): type(typeid(decltype(*value))),ptr(value) {
			}
		
			Object(double* value): type(typeid(decltype(*value))),ptr(value) {
			}
		
			Object(bool* value): type(typeid(decltype(*value))),ptr(value) {
			}
		
			Object(Object&& other): type(other.type),ptr(other.ptr) {
				other.ptr = nullptr;
			}
		
			template<typename T>
			T& as() {
				if(type != typeid(T)) {
					throw std::runtime_error("bad type");
				}
			
				return *reinterpret_cast<T*>(ptr);
			}

			__private void copy(const Object& other) {
				if(type == typeid(std::vector<std::pair<std::string,Object>>)) {
					ptr = new std::vector<std::pair<std::string,Object>>(*reinterpret_cast<std::vector<std::pair<std::string,Object>>*>(other.ptr));
				}
				else if(type == typeid(std::vector<Object>)) {
					ptr = new std::vector<Object>(*reinterpret_cast<std::vector<Object>*>(other.ptr));
				}
				else if(type == typeid(std::string)) {
					ptr = new std::string(*reinterpret_cast<std::string*>(other.ptr));
				}
				else if(type == typeid(double)) {
					ptr = new double(*reinterpret_cast<double*>(other.ptr));
				}
				else if(type == typeid(bool)) {
					ptr = new bool(*reinterpret_cast<bool*>(other.ptr));
				}
			}
		
			__public Object(const Object& other): type(other.type) {
				copy(other);
			}

			__private void destroy() {
				if(type == typeid(std::vector<std::pair<std::string,Object>>)) {
					auto value = reinterpret_cast<std::vector<std::pair<std::string,Object>>*>(ptr);
					delete value;
				}
				else if(type == typeid(std::vector<Object>)) {
					auto value = reinterpret_cast<std::vector<Object>*>(ptr);
					delete value;
				}
				else if(type == typeid(std::string)) {
					auto value = reinterpret_cast<std::string*>(ptr);
					delete value;
				}
				else if(type == typeid(double)) {
					auto value = reinterpret_cast<double*>(ptr);
					delete value;
				}
				else if(type == typeid(bool)) {
					auto value = reinterpret_cast<bool*>(ptr);
					delete value;
				}
			}

			__public Object& operator=(const Object& other) {
				if(this == &other) {
					return *this;
				}

				Object copied(other);
				this->destroy();
				this->type = copied.type;
				this->ptr = copied.ptr;
				copied.ptr = nullptr;
				return *this;
			}
		
			__public ~Object() {
				destroy();
			}
		};

		__private void read(void* buffer,size_t bytes) {
			int n = 0;
			while(n < bytes) {
				int x = _read(in,((std::byte*)buffer)+n,bytes-n);
				if(x == -1) {
					throw std::system_error(std::error_code(GetLastError(), std::system_category()));
				}
				if(x == 0) {
					throw std::system_error(std::error_code(GetLastError(), std::system_category()));
				}
				n+=x;
			}
		}

		__private template<typename T>
		void read(T& obj) {
			this->read(&obj,sizeof(T));
		}

		__private void write(void* buffer,size_t bytes) {
			size_t offset = 0;
			while(offset < bytes) {
				auto remaining = bytes - offset;
				unsigned int chunk = static_cast<unsigned int>(remaining > INT_MAX ? INT_MAX : remaining);
				int n = _write(out,static_cast<std::byte*>(buffer)+offset,chunk);
				if(n < 0) {
					throw std::system_error(std::error_code(GetLastError(), std::system_category()));
				}
				if(n == 0) {
					throw std::runtime_error("IPC write made no progress");
				}
				offset += static_cast<size_t>(n);
			}
		}

		__private template<typename T>
		void write(T& obj) {
			this->write(&obj,sizeof(T));
		}

		__private std::string ReadString() {
			std::string str;

			uint64_t length;
			this->read(length);

			std::cerr << "IPC string length: " << length << std::endl;

			str.resize(length);

			std::vector<uint32_t> data;
			data.resize(str.length());
			this->read(data.data(),data.size() * 4);

			for(auto i = 0;i<data.size();i++) {
				if(data[i] <= 127) {
					str[i] = data[i];
				} else {
					str[i] = 0x07;
				}
			}
		
			return str;
		}

		__private Object ReadObject() {
			uint16_t type;
			this->read(type);
			if(type == 0x0001) {
				uint32_t entryCount;
				this->read(entryCount);
				auto entries = new std::vector<Object>();
				for(uint32_t i = 0;i<entryCount;i++) {
					entries->push_back(ReadObject());
				}
			
				return entries;
			}
			else if(type == 0x0002) {
				uint32_t entryCount;
				this->read(entryCount);
				auto entries = new std::vector<std::pair<std::string,Object>>();
				for(uint32_t i = 0;i<entryCount;i++) {
					std::string name = ReadString();
					auto obj = ReadObject();
					entries->push_back({name,std::move(obj)});
				}
			
				return entries;
			}
			else if(type == 0x0003) {
				std::string value = ReadString();
			
				return new std::string(value);
			}
			else if(type == 0x0004) {
				auto value = new double;
				this->read(*value);
			
				return value;
			}
			else if(type == 0x0005) {
				auto value = new bool;
				this->read(*value);
			
				return value;
			}
			throw std::runtime_error("bad value type: "+std::to_string(type));
		}

		__private void WriteString(std::string& str) {
			std::vector<uint32_t> data;
			data.resize(str.length());
		
			uint64_t length = str.length();
			this->write(length);
		
			for(int i = 0;i<length;i++) {
				data[i] = str[i];
			}
		
			this->write(data.data(),data.size() * 4);
		}

		__private void WriteObject(Object& obj) {
			if(obj.type == typeid(std::vector<std::pair<std::string,Object>>)) {
				auto value = reinterpret_cast<std::vector<std::pair<std::string,Object>>*>(obj.ptr);
				uint16_t type = 0x0002;
				this->write(type);
				uint32_t count = value->size();
				this->write(count);
				for(auto& i : *value) {
					WriteString(i.first);
					WriteObject(i.second);
				}
			}
			else if(obj.type == typeid(std::vector<Object>)) {
				auto value = reinterpret_cast<std::vector<Object>*>(obj.ptr);
				uint16_t type = 0x0001;
				this->write(type);
				uint32_t count = value->size();
				this->write(count);
				for(auto& i : *value) {
					WriteObject(i);
				}
			}
			else if(obj.type == typeid(std::string)) {
				auto value = reinterpret_cast<std::string*>(obj.ptr);
				uint16_t type = 0x0003;
				this->write(type);
				WriteString(*value);
			}
			else if(obj.type == typeid(double)) {
				auto value = reinterpret_cast<double*>(obj.ptr);
				uint16_t type = 0x0004;
				this->write(type);
				this->write(*value);
			}
			else if(obj.type == typeid(bool)) {
				auto value = reinterpret_cast<bool*>(obj.ptr);
				uint16_t type = 0x0005;
				this->write(type);
				this->write(*value);
			}
		}

		__private std::mutex WriteMutex;

		__private std::map<std::string,std::function<void(Object data,std::function<void(Object&)> reply)>> FunctionMap;
		__private std::map<uint64_t,std::function<void(Object&)>> ReplyCallbackMap;
		__private std::mutex ReplyCallbackMutex;
		__private uint64_t NextCallId = 0;

		__public Object call(std::string function,Object& data) {
			uint32_t type = 0x00000001;
			uint64_t CallId;

			std::condition_variable cv;
			std::mutex mtx;
			std::unique_lock lock(mtx);
			std::optional<Object> obj;

			{
				std::lock_guard callbackLock(ReplyCallbackMutex);
				CallId = NextCallId++;
				ReplyCallbackMap.insert({CallId,[&](Object& result){
					{
						std::lock_guard resultLock(mtx);
						obj.emplace(result);
					}
					cv.notify_one();
				}});
			}

			{
				std::lock_guard WriteLock(WriteMutex);
				this->write(type);
				this->write(CallId);
				WriteString(function);
				WriteObject(data);
			}

			cv.wait(lock,[&]{ return obj.has_value(); });

			return std::move(*obj);
		}

		__public void RegisterFunction(std::string function,decltype(FunctionMap)::value_type::second_type callback) {
			this->FunctionMap.insert({function,callback});
		}

		__public void run() {
			while(true) {
				uint32_t type;
				this->read(type);

				if(type == 0x00000001) {
					uint64_t CallId;
					this->read(CallId);
					auto func = ReadString();
					Object data = ReadObject();
					std::cerr << "[" << std::hex << std::setfill('0') << std::setw(16) << std::hex << CallId << std::dec << "] " << func << std::endl;
					if(FunctionMap.contains(func)) {
						FunctionMap.at(func)(data,[this,CallId](Object& obj) mutable {
							std::lock_guard lock(this->WriteMutex);
							uint32_t out_type = 0x00000002;
							this->write(out_type);
							this->write(CallId);
							uint32_t status = 0x00000000;
							this->write(status);
							WriteObject(obj);
						});
					} else {
						std::lock_guard lock(WriteMutex);
						uint32_t out_type = 0x00000002;
						this->write(out_type);
						this->write(CallId);
						uint32_t status = 0x00000001;
						this->write(status);
					}
				}
				else if(type == 0x00000002) {
					uint64_t CallId;
					this->read(CallId);
					uint32_t status;
					this->read(status);
					auto result = this->ReadObject();
					std::function<void(Object&)> callback;
					{
						std::lock_guard callbackLock(ReplyCallbackMutex);
						auto i = ReplyCallbackMap.find(CallId);
						if(i != ReplyCallbackMap.end()) {
							callback = std::move(i->second);
							ReplyCallbackMap.erase(i);
						}
					}
					if(callback) {
						callback(result);
					} else {
						std::cerr << "received reply for unknown call " << CallId << std::endl;
					}
				}
				else {
					std::cerr << "bad message type: " << type << std::endl;
				}
			}
		}
	};
}
