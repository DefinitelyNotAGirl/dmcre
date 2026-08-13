#pragma once

#include <string>

#include <map>
#include "DynamicLibrary.hpp"

namespace dmcre::load {
	extern std::map<std::string,std::string> cppMacros;
	extern std::list<std::string> frameworks;
	extern std::list<std::string> frameworkDirectories;
	
	extern std::list<std::string> swiftSources;
	extern std::string swiftModuleName;
	
	extern std::list<std::string> swiftModuleMaps;
	
	extern std::string compileCommandsPath;
	
	extern bool useEngineLibrary;

	enum class Domain {
		LinkAndLoad, // LinkAndLoad function, Domain not applicable
		System, // dmcre installation directory
		WorkingDirectory, // cwd
		User, // user home directory
		Absolute // absolute path
	};
	
	class PreCompiledObject {
	public:
		std::string source;
		std::string object;
	};
	
	PreCompiledObject PreCompileCpp(Domain domain,std::string path,std::string object);
	PreCompiledObject PreCompileObjCpp(Domain domain,std::string path,std::string object);
	PreCompiledObject PreCompileSwift(Domain domain,std::string path,std::string object);
	DynamicLibrary LinkAndLoad(std::vector<PreCompiledObject>& objects,std::string ModuleId);
	void Link(std::vector<PreCompiledObject>& objects,std::string outputPath);
	void LinkMetal(std::vector<PreCompiledObject>& objects,std::string outputPath);
	PreCompiledObject PreCompileMetal(Domain domain,std::string path,std::string object);
	void LinkDylib(std::vector<PreCompiledObject>& objects,std::string dylibPath);

	DynamicLibrary cpp(Domain domain,std::string path);
	DynamicLibrary ObjCpp(Domain domain,std::string path);
	DynamicLibrary Swift(Domain domain,std::string path);
	DynamicLibrary dll(Domain domain,std::string path);
}
