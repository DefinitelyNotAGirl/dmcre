//
//  Console.hpp
//  dmcre
//
//  Created by Lilith on 11.08.26.
//
#pragma once

#include "foundation.hpp"
#include "String.hpp"
#include <source_location>

namespace dmcre {
	class ConsoleReference;

	class Console {
		__public class Representable {
			__public virtual String toConsoleString() const = 0;
		};
		
		__public virtual ~Console() = default;

		__private virtual void __info(const String& value,const std::source_location& caller) = 0;
		__private virtual void __warn(const String& value,const std::source_location& caller) = 0;
		__private virtual void __error(const String& value,const std::source_location& caller) = 0;
		__private virtual void __debug(const String& value,const std::source_location& caller) = 0;
		
		__public class Reference {
			__private Console* ptr;

			__public Reference(Console& console) : ptr(&console) {}
			
			__public Console& operator*() const {
				return *ptr;
			}
			
			__public void operator=(Console& console) {
				ptr = &console;
			}
			
			__public template<typename T>
			requires requires(const T& value) {
				{ value.toConsoleString() } -> std::convertible_to<String>;
			}
			String toConsoleString(const T& value) {
				return value.toConsoleString();
			}
			
			__public String toConsoleString(const char* value) {
				return String(value);
			}
			
			__public String toConsoleString(const std::string& value) {
				return String(value.c_str());
			}
			
			__public String toConsoleString(const String& value) {
				return value;
			}
			
			__public template<typename T>
			void info(const T& value,const std::source_location& caller = std::source_location::current()) {
				ptr->__info(toConsoleString(value), caller);
			}
			
			__public template<typename T>
			void warn(const T& value,const std::source_location& caller = std::source_location::current()) {
				ptr->__warn(toConsoleString(value), caller);
			}
			
			__public template<typename T>
			void error(const T& value,const std::source_location& caller = std::source_location::current()) {
				ptr->__error(toConsoleString(value), caller);
			}
			
			__public template<typename T>
			void debug(const T& value,const std::source_location& caller = std::source_location::current()) {
				ptr->__debug(toConsoleString(value), caller);
			}
		};
	};
	
	Console& basicStdioConsole();

	extern Console::Reference console;
}
