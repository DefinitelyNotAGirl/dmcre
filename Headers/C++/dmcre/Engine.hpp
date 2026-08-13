//
//  Engine.hpp
//  dmcre
//
//  Created by Lilith on 04.04.26.
//
#pragma once

#include <string>
#include <list>

namespace dmcre {
	extern std::string RuntimeDirectory;
	extern std::string IncludeDirectory;
	extern std::string InstallationDirectory;
	
	extern std::list<std::string> IncludeDirectories;
	
	extern std::string TargetPlatform;
	extern std::string SDKRoot;
	extern std::string CXXLanguageStandard;
	extern std::string CXXLibrary;
}
