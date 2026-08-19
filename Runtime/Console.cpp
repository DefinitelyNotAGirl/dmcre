//
//  Console.cpp
//  dmcre
//
//  Created by Lilith on 11.08.26.
//

#include <dmcre/console>
#include <sstream>
#include <chrono>

namespace dmcre {
	class BasicStdIOConsole: public Console {
		__private virtual void __info(const String& value,const std::source_location& caller) {
			String message;

			std::stringstream stream;
			stream << "[" << std::chrono::system_clock::now() << "] ";
			message.append(stream.str().c_str());
			message.append(value);
			message.append(0x0a);

			auto outbuf = message.encode(String::Format::ASCII);
#if defined(_WIN32)
			std::cout.write(reinterpret_cast<const char*>(outbuf.raw()), outbuf.size().HostEndian());
			std::cout.flush();
#else
			write(STDOUT_FILENO,outbuf.raw(),outbuf.size().HostEndian());
#endif
		}

		__private virtual void __warn(const String& value,const std::source_location& caller) {
			String message;
			
			std::stringstream stream;
			stream << "[" << std::chrono::system_clock::now() << "] ";
			message.append(stream.str().c_str());
			message.append(value);
			message.append(0x0a);
			
			auto outbuf = message.encode(String::Format::ASCII);
#if defined(_WIN32)
			std::cout.write(reinterpret_cast<const char*>(outbuf.raw()), outbuf.size().HostEndian());
			std::cout.flush();
#else
			write(STDOUT_FILENO,outbuf.raw(),outbuf.size().HostEndian());
#endif
		}

		__private virtual void __error(const String& value,const std::source_location& caller) {
			String message;
			
			std::stringstream stream;
			stream << "[" << std::chrono::system_clock::now() << "] ";
			message.append(stream.str().c_str());
			message.append(value);
			message.append(0x0a);
			
			auto outbuf = message.encode(String::Format::ASCII);
#if defined(_WIN32)
			std::cout.write(reinterpret_cast<const char*>(outbuf.raw()), outbuf.size().HostEndian());
			std::cout.flush();
#else
			write(STDOUT_FILENO,outbuf.raw(),outbuf.size().HostEndian());
#endif
		}

		__private virtual void __debug(const String& value,const std::source_location& caller) {
			String message;
			
			std::stringstream stream;
			stream << "[" << std::chrono::system_clock::now() << "] ";
			message.append(stream.str().c_str());
			message.append(value);
			message.append(0x0a);
			
			auto outbuf = message.encode(String::Format::ASCII);
#if defined(_WIN32)
			std::cout.write(reinterpret_cast<const char*>(outbuf.raw()), outbuf.size().HostEndian());
			std::cout.flush();
#else
			write(STDOUT_FILENO,outbuf.raw(),outbuf.size().HostEndian());
#endif
		}
	};
	
	Console& basicStdioConsole() {
		static BasicStdIOConsole basicConsole;
		return basicConsole;
	}

	Console::Reference console = basicStdioConsole();
	
	// this function exists to verify that all these at least pass the compiler
	[[maybe_unused]] static void test() {
		console.info("C++ string literal");
		console.info(std::string("stdc++ string"));
		console.info(String("dmcre string"));
		
		class SomeConsoleRepresentable: public virtual Console::Representable {
			__public virtual String toConsoleString() const {
				return "actual content goes here";
			}
		};
		SomeConsoleRepresentable someConsoleRepresentable;
		
		console.info(someConsoleRepresentable);
	}
}
