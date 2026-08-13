//
//  Engine.cpp
//  Runtime
//
//  Created by Lilith on 04.04.26.
//

#include <dmcre/Engine.hpp>

namespace dmcre {
	decltype(RuntimeDirectory) RuntimeDirectory;
	decltype(IncludeDirectory) IncludeDirectory = std::string(DMCRE_INSTALL_ROOT)+"/Headers/C++";
	decltype(InstallationDirectory) InstallationDirectory = DMCRE_INSTALL_ROOT;
	
	decltype(IncludeDirectories) IncludeDirectories;
	
	decltype(TargetPlatform) TargetPlatform = DMCRE_MACOSX_DEPLOYMENT_TARGET;
	decltype(SDKRoot) SDKRoot = DMCRE_SDKROOT;
	decltype(CXXLanguageStandard) CXXLanguageStandard = DMCRE_CLANG_CXX_LANGUAGE_STANDARD;
	decltype(CXXLibrary) CXXLibrary = DMCRE_CLANG_CXX_LIBRARY;
}
