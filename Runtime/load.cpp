#include "dmcre/JSON.hpp"
#include "dmcre/crypto.hpp"
#include "dmcre/debug.hpp"
#include <dmcre/load.hpp>
#include <stdexcept>
#include <unistd.h>
#include <sys/stat.h>

#ifdef _WIN32
#else
	#include <dlfcn.h>
#endif

#include "private.hpp"

#include <dmcre/Engine.hpp>
#include <dmcre/DynamicLibrary.hpp>
#include <dmcre/Error.hpp>

#include <filesystem>

#include <fcntl.h>
#include <unistd.h>

static int run(const std::vector<std::string>& args) {
	pid_t pid = fork();
	if(pid == 0) {
		std::vector<std::string> args_copy = args; // ensure stable storage
		std::vector<std::vector<char>> storage;
		std::vector<char*> argv;
		
		int devnull = open("/dev/null", O_WRONLY);
		if (devnull == -1) return 1;
		
		if (dup2(devnull, STDOUT_FILENO) == -1) return 1;
		
		for(auto& s : args_copy) {
			storage.emplace_back(s.begin(), s.end());
			storage.back().push_back('\0');
			argv.push_back(storage.back().data());
		}
		argv.push_back(nullptr);
		
		//std::cout << "argv[0]: " << argv[0] << std::endl;
		
		execvp(argv[0], argv.data());
		std::cout << "execvp: " << strerror(errno) << std::endl;
		_exit(127);
	}
	
	int status;
	waitpid(pid, &status, 0);
	
	if(WIFEXITED(status))
		return WEXITSTATUS(status);
	return -1;
}

namespace dmcre::load {
	decltype(cppMacros) cppMacros;
	decltype(frameworks) frameworks;
	decltype(frameworkDirectories) frameworkDirectories;
	decltype(swiftSources) swiftSources;
	decltype(swiftModuleName) swiftModuleName;
	decltype(useEngineLibrary) useEngineLibrary;
	decltype(swiftModuleMaps) swiftModuleMaps;
	
	decltype(compileCommandsPath) compileCommandsPath = "";
	
	std::string GetCompileCommandsPath(Domain domain,std::string path) {
		if(compileCommandsPath != "") {
			return compileCommandsPath;
		}

		if(domain == Domain::WorkingDirectory) {
			char _cwd[4096];
			auto cwd_out = getcwd(_cwd, sizeof(_cwd));
			std::string cwd = cwd_out;
			return cwd+"/"+"compile_commands.json";
		}
		
		throw std::runtime_error("lizard");
	}
	
	std::string GetDirectoryForCompileCommands(Domain domain,std::string path) {
		if(domain == Domain::Absolute) {
			return "/";
		} else if(domain == Domain::WorkingDirectory) {
			char _cwd[4096];
			auto cwd_out = getcwd(_cwd, sizeof(_cwd));
			std::string cwd = cwd_out;
			return cwd;
		}
		
		throw std::runtime_error("lizard");
	}
	
	std::string ResolvePath(Domain domain,std::string path) {
		if(domain == Domain::Absolute) {
			return path;
		}
		else if(domain == Domain::WorkingDirectory) {
			char _cwd[4096];
			auto cwd_out = getcwd(_cwd, sizeof(_cwd));
			std::string cwd = cwd_out;
			return cwd+"/"+path;
		}
		
		throw std::runtime_error("lizard");
	}

	static DynamicLibrary FinalLoadDLL(
		std::string path,
		std::string load_path,
		Domain load_domain,
		std::string load_type
	) {
		DynamicLibrary library(path,{DynamicLibrary::LoadFlag::Global});
		
		debug::send(JSON::object({
			JSON("event","modules/load"),
			JSON("path",load_path),
			JSON("type",load_type),
			JSON("domain",[&]{
				if(load_domain == Domain::System) return "system";
				if(load_domain == Domain::User) return "user";
				if(load_domain == Domain::WorkingDirectory) return "cwd";
				if(load_domain == Domain::LinkAndLoad) return "LinkAndLoad";
				throw std::runtime_error("bad domain value");
			}())
		}));
		
		void(*dmcre_onload)() = nullptr;
		try {
			dmcre_onload = library.getSymbol<void(*)()>("dmcre_onload");
		} catch(...) {
		}
		
		if(dmcre_onload) {
			dmcre_onload();
		}
		
		return library;
	}

	DynamicLibrary cpp(Domain domain,std::string path) {
		std::string resolvedPath = ResolvePath(domain,path);

		std::string FileDigest = "";
		{
			std::string content;
			FILE* f = fopen(resolvedPath.c_str(),"rb");
			if(f == nullptr) {
				throw Error(std::string("failed to open file: ")+strerror(errno));
			}
			fseek(f,0,SEEK_END);
			content.resize(ftell(f));
			fseek(f, 0, SEEK_SET);
			fread(content.data(),content.size(),1,f);
			fclose(f);
			FileDigest = crypto::sha256.hash(content).ToHexString();
		}
		
		std::list<std::string> args;

		{
			// compiler executable
			#ifdef _WIN32
				args.push_back("clang++");
			#else
				args.push_back("/usr/bin/c++");
			#endif

			// dmcre_export
			#ifdef _WIN32
				args.push_back("-Ddmcre_export=extern \"C\" __declspec(dllexport)");
			#else
				args.push_back("-Ddmcre_export=extern \"C\"");
			#endif
			
			// dynamic library
			args.push_back("-g");
			args.push_back("-shared");
			args.push_back("-undefined");
			args.push_back("dynamic_lookup");
			
			// c++ standard
			args.push_back("-std=c++20");
			
			// include directories
			args.push_back("-I"+dmcre::IncludeDirectory);
			for(auto dir : IncludeDirectories) {
				args.push_back("-I"+dir);
			}
		}
		
		{
			const std::string CompileCommands_File = GetCompileCommandsPath(domain, path);
			JSON CompileCommands;
			if(std::filesystem::exists(CompileCommands_File)) {
				CompileCommands.load(CompileCommands_File);
			} else {
				CompileCommands = JSON::list({});
			}
			
			JSON& CompileCommandsEntry = [&]() -> JSON& {
				for(JSON& entry : CompileCommands.children) {
					try {
						if(entry.GetString("file") == path) {
							return entry;
						}
					}catch(JSONNoSuchChild){}
				}
				CompileCommands.add(JSON::object({
					JSON("file",path),
					JSON::list("arguments",{})
				}));
				return CompileCommands.children.back();
			}();
			
			try {
				JSON& args = CompileCommandsEntry["arguments"];
				args = JSON::list("arguments",{});
			} catch(JSONNoSuchChild) {
				CompileCommandsEntry.add(JSON::list("arguments",{}));
			}
			
			try {
				CompileCommandsEntry["directory"] = JSON("directory",GetDirectoryForCompileCommands(domain,path));
			} catch(JSONNoSuchChild) {
				CompileCommandsEntry.add(JSON("directory",GetDirectoryForCompileCommands(domain,path)));
			}
			
			for(auto i : args) {
				CompileCommandsEntry["arguments"].add(i);
			}
			
			CompileCommandsEntry["arguments"].add(path);
			
			CompileCommands.save(CompileCommands_File);
		}
		
		std::vector<std::string> CompilerArgs;
		for(auto i : args) {
			CompilerArgs.push_back(i);
		}
		CompilerArgs.push_back("-x");
		CompilerArgs.push_back("c++");
		CompilerArgs.push_back(resolvedPath);
		CompilerArgs.push_back("-o");
		#ifdef _WIN32
			CompilerArgs.push_back(""+(dmcre::RuntimeDirectory +"/"+ FileDigest)+".dll");
		#else
			CompilerArgs.push_back(""+(dmcre::RuntimeDirectory +"/"+ FileDigest)+"");
		#endif
		
		//for(std::string i : CompilerArgs) {
		//	std::cout << i << " ";
		//}
		//std::cout << std::endl;

		const int compilerExitCode = run(CompilerArgs);
		if(compilerExitCode != 0) {
			throw Error("compiler error: "+std::to_string(compilerExitCode));
		}

		return FinalLoadDLL(
			dmcre::RuntimeDirectory +"/"+ FileDigest,
			path,
			domain,
			"c++"
		);
	}
	
	DynamicLibrary ObjCpp(Domain domain,std::string path) {
		std::string resolvedPath = ResolvePath(domain,path);
		
		std::string FileDigest = "";
		{
			std::string content;
			FILE* f = fopen(resolvedPath.c_str(),"rb");
			if(f == nullptr) {
				throw Error(std::string("failed to open file: ")+strerror(errno));
			}
			fseek(f,0,SEEK_END);
			content.resize(ftell(f));
			fseek(f, 0, SEEK_SET);
			fread(content.data(),content.size(),1,f);
			fclose(f);
			FileDigest = crypto::sha256.hash(content).ToHexString();
		}
		
		std::list<std::string> args;
		
		{
			// compiler executable
#ifdef _WIN32
			args.push_back("clang++");
#else
			args.push_back("/usr/bin/c++");
#endif
			
			// dmcre_export
#ifdef _WIN32
			args.push_back("-Ddmcre_export=extern \"C\" __declspec(dllexport)");
#else
			args.push_back("-Ddmcre_export=extern \"C\"");
#endif
			
			// dynamic library
			args.push_back("-g");
			args.push_back("-shared");
			args.push_back("-undefined");
			args.push_back("dynamic_lookup");
			
			// c++ standard
			args.push_back("-std=c++20");
			
			// include directories
			args.push_back("-I"+dmcre::IncludeDirectory);
			for(auto dir : IncludeDirectories) {
				args.push_back("-I"+dir);
			}
		}
		
		{
			const std::string CompileCommands_File = GetCompileCommandsPath(domain,path);
			JSON CompileCommands;
			if(std::filesystem::exists(CompileCommands_File)) {
				CompileCommands.load(CompileCommands_File);
			} else {
				CompileCommands = JSON::list({});
			}
			
			JSON& CompileCommandsEntry = [&]() -> JSON& {
				for(JSON& entry : CompileCommands.children) {
					try {
						if(entry.GetString("file") == path) {
							return entry;
						}
					}catch(JSONNoSuchChild){}
				}
				CompileCommands.add(JSON::object({
					JSON("file",path),
					JSON::list("arguments",{})
				}));
				return CompileCommands.children.back();
			}();
			
			try {
				JSON& args = CompileCommandsEntry["arguments"];
				args = JSON::list("arguments",{});
			} catch(JSONNoSuchChild) {
				CompileCommandsEntry.add(JSON::list("arguments",{}));
			}
			
			try {
				CompileCommandsEntry["directory"] = JSON("directory",GetDirectoryForCompileCommands(domain,path));
			} catch(JSONNoSuchChild) {
				CompileCommandsEntry.add(JSON("directory",GetDirectoryForCompileCommands(domain,path)));
			}
			
			for(auto i : args) {
				CompileCommandsEntry["arguments"].add(i);
			}
			
			CompileCommandsEntry["arguments"].add(path);
			
			CompileCommands.save(CompileCommands_File);
		}
		
		std::vector<std::string> CompilerArgs;
		for(auto i : args) {
			CompilerArgs.push_back(i);
		}
		CompilerArgs.push_back("-x");
		CompilerArgs.push_back("objective-c++");
		CompilerArgs.push_back(resolvedPath);
		CompilerArgs.push_back("-o");
#ifdef _WIN32
		CompilerArgs.push_back(""+(dmcre::RuntimeDirectory +"/"+ FileDigest)+".dll");
#else
		CompilerArgs.push_back(""+(dmcre::RuntimeDirectory +"/"+ FileDigest)+"");
#endif
		
		//for(std::string i : CompilerArgs) {
		//	std::cout << i << " ";
		//}
		//std::cout << std::endl;
		
		const int compilerExitCode = run(CompilerArgs);
		if(compilerExitCode != 0) {
			throw Error("compiler error: "+std::to_string(compilerExitCode));
		}
		
		return FinalLoadDLL(
							dmcre::RuntimeDirectory +"/"+ FileDigest,
							path,
							domain,
							"c++"
							);
	}
	
	DynamicLibrary Swift(Domain domain,std::string path) {
		std::string resolvedPath = ResolvePath(domain,path);
		
		std::string FileDigest = "";
		{
			std::string content;
			FILE* f = fopen(resolvedPath.c_str(),"rb");
			if(f == nullptr) {
				throw Error(std::string("failed to open file: ")+strerror(errno));
			}
			fseek(f,0,SEEK_END);
			content.resize(ftell(f));
			fseek(f, 0, SEEK_SET);
			fread(content.data(),content.size(),1,f);
			fclose(f);
			FileDigest = crypto::sha256.hash(content).ToHexString();
		}
		
		std::list<std::string> args;
		
		{
			// compiler executable
			args.push_back("swift-frontend");
			
			// swift language version
			args.push_back("-swift-version");
			args.push_back("6");
			
			// no top level code
			args.push_back("-parse-as-library");
			
			// target
			args.push_back("-target");
			args.push_back("arm64-apple-macosx"+TargetPlatform);
			
			// sdk
			args.push_back("-sdk");
			args.push_back("/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk");
			
			// c++ interop
			args.push_back("-cxx-interoperability-mode=default");
			
			// module maps
			for(auto& i : swiftModuleMaps) {
				args.push_back("-Xcc");
				args.push_back("-fmodule-map-file="+i);
			}
			
			// module maps
			for(auto& i : IncludeDirectories) {
				args.push_back("-Xcc");
				args.push_back("-I"+i);
			}
			
			// plugins
			args.push_back("-load-plugin-library");
			args.push_back("/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift/host/plugins/libObservationMacros.dylib");
			
			// module name
			args.push_back("-module-name");
			args.push_back(swiftModuleName);
			
			// other sources
			for(std::string& source : swiftSources) {
				if(source != path) {
					args.push_back(source);
				}
			}
		}
		
		{
			const std::string CompileCommands_File = GetCompileCommandsPath(domain,path);
			JSON CompileCommands;
			if(std::filesystem::exists(CompileCommands_File)) {
				CompileCommands.load(CompileCommands_File);
			} else {
				CompileCommands = JSON::list({});
			}
			
			JSON& CompileCommandsEntry = [&]() -> JSON& {
				for(JSON& entry : CompileCommands.children) {
					try {
						if(entry.GetString("file") == path) {
							return entry;
						}
					}catch(JSONNoSuchChild){}
				}
				CompileCommands.add(JSON::object({
					JSON("file",path),
					JSON::list("arguments",{})
				}));
				return CompileCommands.children.back();
			}();
			
			try {
				JSON& args = CompileCommandsEntry["arguments"];
				args = JSON::list("arguments",{});
			} catch(JSONNoSuchChild) {
				CompileCommandsEntry.add(JSON::list("arguments",{}));
			}
			
			try {
				CompileCommandsEntry["directory"] = JSON("directory",GetDirectoryForCompileCommands(domain,path));
			} catch(JSONNoSuchChild) {
				CompileCommandsEntry.add(JSON("directory",GetDirectoryForCompileCommands(domain,path)));
			}
			
			for(auto i : args) {
				CompileCommandsEntry["arguments"].add(i);
			}
			
			CompileCommandsEntry["arguments"].add(path);
			
			CompileCommands.save(CompileCommands_File);
		}
		
		std::vector<std::string> CompilerArgs;
		for(auto i : args) {
			CompilerArgs.push_back(i);
		}
		// dependencies
		CompilerArgs.push_back("-emit-dependencies");
		// debug symbols
		CompilerArgs.push_back("-g");
		// do not compile
		CompilerArgs.push_back("-c");
		// source
		CompilerArgs.push_back("-primary-file");
		CompilerArgs.push_back(resolvedPath);
		// output
		CompilerArgs.push_back("-emit-object");
		CompilerArgs.push_back("-o");
		CompilerArgs.push_back(""+(dmcre::RuntimeDirectory +"/"+ FileDigest)+"");
		
		const int compilerExitCode = run(CompilerArgs);
		if(compilerExitCode != 0) {
			throw Error("compiler error: "+std::to_string(compilerExitCode));
		}
		
		return FinalLoadDLL(
							dmcre::RuntimeDirectory +"/"+ FileDigest,
							path,
							domain,
							"c++"
							);
	}
	
	PreCompiledObject PreCompileCpp(Domain domain,std::string path,std::string object) {
		std::string resolvedPath = ResolvePath(domain,path);
		
		std::string FileDigest = "";
		{
			std::string content;
			FILE* f = fopen(resolvedPath.c_str(),"rb");
			if(f == nullptr) {
				throw Error(std::string("failed to open file: ")+strerror(errno));
			}
			fseek(f,0,SEEK_END);
			content.resize(ftell(f));
			fseek(f, 0, SEEK_SET);
			fread(content.data(),content.size(),1,f);
			fclose(f);
			FileDigest = crypto::sha256.hash(content).ToHexString();
		}
		
		std::list<std::string> args;
		
		{
			// compiler executable
			#ifdef _WIN32
				args.push_back("clang++");
			#else
				args.push_back("/usr/bin/c++");
			#endif
			
			// dmcre_export
			#ifdef _WIN32
				args.push_back("-Ddmcre_export=extern \"C\" __declspec(dllexport)");
			#else
				args.push_back("-Ddmcre_export=extern \"C\"");
			#endif
			
			args.push_back("-mmacos-version-min="+TargetPlatform);
			
			for(auto macro : cppMacros) {
				args.push_back("-D"+macro.first+"="+macro.second);
			}
			
			// c++ standard
			args.push_back("-std=c++20");
			
			// include directories
			args.push_back("-I"+dmcre::IncludeDirectory);
			for(auto dir : IncludeDirectories) {
				args.push_back("-I"+dir);
			}
		}
		
		{
			const std::string CompileCommands_File = GetCompileCommandsPath(domain,path);
			JSON CompileCommands;
			if(std::filesystem::exists(CompileCommands_File)) {
				CompileCommands.load(CompileCommands_File);
			} else {
				CompileCommands = JSON::list({});
			}
			
			JSON& CompileCommandsEntry = [&]() -> JSON& {
				for(JSON& entry : CompileCommands.children) {
					try {
						if(entry.GetString("file") == path) {
							return entry;
						}
					}catch(JSONNoSuchChild){}
				}
				CompileCommands.add(JSON::object({
					JSON("file",path),
					JSON::list("arguments",{})
				}));
				return CompileCommands.children.back();
			}();
			
			try {
				JSON& args = CompileCommandsEntry["arguments"];
				args = JSON::list("arguments",{});
			} catch(JSONNoSuchChild) {
				CompileCommandsEntry.add(JSON::list("arguments",{}));
			}
			
			try {
				CompileCommandsEntry["directory"] = JSON("directory",GetDirectoryForCompileCommands(domain,path));
			} catch(JSONNoSuchChild) {
				CompileCommandsEntry.add(JSON("directory",GetDirectoryForCompileCommands(domain,path)));
			}
			
			for(auto i : args) {
				CompileCommandsEntry["arguments"].add(i);
			}
			
			CompileCommandsEntry["arguments"].add(path);
			
			CompileCommands.save(CompileCommands_File);
		}
		
		std::vector<std::string> CompilerArgs;
		for(auto i : args) {
			CompilerArgs.push_back(i);
		}
		// debug symbols
		CompilerArgs.push_back("-g");
		// dependencies
		CompilerArgs.push_back("-MMD");
		// C++
		CompilerArgs.push_back("-x");
		CompilerArgs.push_back("c++");
		// warning config
		CompilerArgs.push_back("-Wno-pragma-once-outside-header");
		// do not compile
		CompilerArgs.push_back("-c");
		// source
		CompilerArgs.push_back(resolvedPath);
		// output
		CompilerArgs.push_back("-o");
		CompilerArgs.push_back(object);
		
		const std::string CommandDigest = crypto::sha256.hash([&]{
			std::string res;
			for(auto i : CompilerArgs) {
				res += " "+i;
			}
			return res;
		}()).ToHexString();
		
		if(std::filesystem::exists(object+".json")) {
			JSON config = JSON::object({});
			config.load(object+".json");
			bool rebuild = false;
			
			if(config.GetString("cdigest") != CommandDigest) rebuild = true;
			if(config.GetString("fdigest") != FileDigest) rebuild = true;
			
			auto btimeStr = config.GetString("btime");
			auto btime = strtoll(btimeStr.data(),(char**)(btimeStr.data() + btimeStr.size()),10);
			
			for(JSON& i : config["dependencies"].children) {
				struct stat st;
				if (stat(i.StringValue.c_str(), &st) != 0) {
					//std::cout << "rebuilding, " << i.StringValue << " no stats" << std::endl;
					rebuild = true;
				} else {
					if(static_cast<i64>(st.st_mtime) > btime) {
						//std::cout << "rebuilding, " << i.StringValue << " changed" << std::endl;
						rebuild = true;
					}
				}
			}

			if(not rebuild) {
				return PreCompiledObject {
					.source = path,
					.object = object,
				};
			}
		}
		
		const int compilerExitCode = run(CompilerArgs);
		if(compilerExitCode != 0) {
			throw Error("compiler error: "+std::to_string(compilerExitCode));
		}
		
		//
		// consume .d file and write .dependencies.json
		//
		{
			//.
			//. load file
			//.
			std::string DFileContent;
			{
				FILE* f = fopen((object+".d").c_str(),"rb");
				if(!f) {
					throw std::runtime_error("fopen failed! cannot open .d file");
				}
				fseek(f,0,SEEK_END);
				DFileContent.resize(ftell(f));
				fseek(f,0,SEEK_SET);
				fread(DFileContent.data(),DFileContent.size(),1,f);
				fclose(f);
			}
			std::vector<std::string> files;
			std::string working;
			bool SkippedFirstLine = false;
			for(auto i = 0;i<DFileContent.size();i++) {
				char c = DFileContent[i];
				auto PushFile = [&]{
					for(int i = working.length()-1;i>=0;i--) {
						char c = working[i];
						if(c == '\\' || c == ' ') {
							working.pop_back();
						} else {
							break;
						}
					}
					if(working != "") {
						files.push_back(working);
					}
					working = "";
				};
				if(c == '\n') {
					if(!SkippedFirstLine) {
						SkippedFirstLine = true;
						continue;
					}
					PushFile();
				} else if(!SkippedFirstLine) {
					// this is deliberately empty
				} else if(c == ' ' && working == "") {
					// do not push character
				} else if(c == '\\') {
					if(DFileContent[i+1] != '\n') {
						working.push_back(DFileContent[i+1]);
						i++;
					}
				} else if(c == ' ') {
					// we will just ignore the potential problem of an escaped space in the path of a dependency
					// if anyone asks they have someone who worked on GCC to thank for that
					// this whole dependency situation is fucking ridiculous
					// note:
					// GNU make dependency generation will be deprecated in NextToolchain
					// therefore this is a contained problem which i am unwilling to deal with
					PushFile();
				} else {
					working.push_back(c);
				}
			}
			//.
			//. write .dependencies.json
			//.
			JSON config = JSON::object({});
			config.add(JSON("file",path));
			config.add(JSON("btime",std::to_string(static_cast<i64>(time(nullptr)))));
			config.add({"fdigest",FileDigest});
			config.add({"cdigest",CommandDigest});
			config.add(JSON::list("dependencies",{}));
			for(auto file : files) {
				config["dependencies"].add(JSON(file));
			}
			config.save(object+".json");
			unlink((object+".d").c_str());
		}
		
		return PreCompiledObject {
			.source = path,
			.object = object,
		};
	}
	
	PreCompiledObject PreCompileObjCpp(Domain domain,std::string path,std::string object) {
		std::string resolvedPath = ResolvePath(domain,path);
		
		std::string FileDigest = "";
		{
			std::string content;
			FILE* f = fopen(resolvedPath.c_str(),"rb");
			if(f == nullptr) {
				throw Error(std::string("failed to open file: ")+strerror(errno));
			}
			fseek(f,0,SEEK_END);
			content.resize(ftell(f));
			fseek(f, 0, SEEK_SET);
			fread(content.data(),content.size(),1,f);
			fclose(f);
			FileDigest = crypto::sha256.hash(content).ToHexString();
		}
		
		std::list<std::string> args;
		
		{
			// compiler executable
#ifdef _WIN32
			args.push_back("clang++");
#else
			args.push_back("/usr/bin/c++");
#endif
			
			// dmcre_export
#ifdef _WIN32
			args.push_back("-Ddmcre_export=extern \"C\" __declspec(dllexport)");
#else
			args.push_back("-Ddmcre_export=extern \"C\"");
#endif
			
			args.push_back("-mmacos-version-min="+TargetPlatform);
			
			for(auto macro : cppMacros) {
				args.push_back("-D"+macro.first+"="+macro.second);
			}
			
			// c++ standard
			args.push_back("-std=c++20");
			
			// include directories
			args.push_back("-I"+dmcre::IncludeDirectory);
			for(auto dir : IncludeDirectories) {
				args.push_back("-I"+dir);
			}
			
#if false
			for(std::string i : frameworkDirectories) {
				args.push_back("-F");
				args.push_back(i);
			}
			for(std::string i : frameworks) {
				args.push_back("-framework");
				args.push_back(i);
			}
#endif
		}
		
		{
			const std::string CompileCommands_File = GetCompileCommandsPath(domain,path);
			JSON CompileCommands;
			if(std::filesystem::exists(CompileCommands_File)) {
				CompileCommands.load(CompileCommands_File);
			} else {
				CompileCommands = JSON::list({});
			}
			
			JSON& CompileCommandsEntry = [&]() -> JSON& {
				for(JSON& entry : CompileCommands.children) {
					try {
						if(entry.GetString("file") == path) {
							return entry;
						}
					}catch(JSONNoSuchChild){}
				}
				CompileCommands.add(JSON::object({
					JSON("file",path),
					JSON::list("arguments",{})
				}));
				return CompileCommands.children.back();
			}();
			
			try {
				JSON& args = CompileCommandsEntry["arguments"];
				args = JSON::list("arguments",{});
			} catch(JSONNoSuchChild) {
				CompileCommandsEntry.add(JSON::list("arguments",{}));
			}
			
			try {
				CompileCommandsEntry["directory"] = JSON("directory",GetDirectoryForCompileCommands(domain,path));
			} catch(JSONNoSuchChild) {
				CompileCommandsEntry.add(JSON("directory",GetDirectoryForCompileCommands(domain,path)));
			}
			
			for(auto i : args) {
				CompileCommandsEntry["arguments"].add(i);
			}
			
			CompileCommandsEntry["arguments"].add(path);
			
			CompileCommands.save(CompileCommands_File);
		}
		
		std::vector<std::string> CompilerArgs;
		for(auto i : args) {
			CompilerArgs.push_back(i);
		}
		// debug symbols
		CompilerArgs.push_back("-g");
		// dependencies
		CompilerArgs.push_back("-MMD");
		// C++
		CompilerArgs.push_back("-x");
		CompilerArgs.push_back("objective-c++");
		// warning config
		CompilerArgs.push_back("-Wno-pragma-once-outside-header");
		// do not compile
		CompilerArgs.push_back("-c");
		// source
		CompilerArgs.push_back(resolvedPath);
		// output
		CompilerArgs.push_back("-o");
		CompilerArgs.push_back(object);
		
		const std::string CommandDigest = crypto::sha256.hash([&]{
			std::string res;
			for(auto i : CompilerArgs) {
				res += " "+i;
			}
			return res;
		}()).ToHexString();
		
		if(std::filesystem::exists(object+".json")) {
			JSON config = JSON::object({});
			config.load(object+".json");
			bool rebuild = false;
			
			if(config.GetString("cdigest") != CommandDigest) rebuild = true;
			if(config.GetString("fdigest") != FileDigest) rebuild = true;
			
			auto btimeStr = config.GetString("btime");
			auto btime = strtoll(btimeStr.data(),(char**)(btimeStr.data() + btimeStr.size()),10);
			
			for(JSON& i : config["dependencies"].children) {
				struct stat st;
				if (stat(i.StringValue.c_str(), &st) != 0) {
					//std::cout << "rebuilding, " << i.StringValue << " no stats" << std::endl;
					rebuild = true;
				} else {
					if(static_cast<i64>(st.st_mtime) > btime) {
						//std::cout << "rebuilding, " << i.StringValue << " changed" << std::endl;
						rebuild = true;
					}
				}
			}
			
			if(not rebuild) {
				return PreCompiledObject {
					.source = path,
					.object = object,
				};
			}
		}
		
		const int compilerExitCode = run(CompilerArgs);
		if(compilerExitCode != 0) {
			throw Error("compiler error: "+std::to_string(compilerExitCode));
		}
		
		//
		// consume .d file and write .dependencies.json
		//
		{
			//.
			//. load file
			//.
			std::string DFileContent;
			{
				FILE* f = fopen((object+".d").c_str(),"rb");
				if(!f) {
					throw std::runtime_error("fopen failed! cannot open .d file");
				}
				fseek(f,0,SEEK_END);
				DFileContent.resize(ftell(f));
				fseek(f,0,SEEK_SET);
				fread(DFileContent.data(),DFileContent.size(),1,f);
				fclose(f);
			}
			std::vector<std::string> files;
			std::string working;
			bool SkippedFirstLine = false;
			for(auto i = 0;i<DFileContent.size();i++) {
				char c = DFileContent[i];
				auto PushFile = [&]{
					for(int i = working.length()-1;i>=0;i--) {
						char c = working[i];
						if(c == '\\' || c == ' ') {
							working.pop_back();
						} else {
							break;
						}
					}
					if(working != "") {
						files.push_back(working);
					}
					working = "";
				};
				if(c == '\n') {
					if(!SkippedFirstLine) {
						SkippedFirstLine = true;
						continue;
					}
					PushFile();
				} else if(!SkippedFirstLine) {
					// this is deliberately empty
				} else if(c == ' ' && working == "") {
					// do not push character
				} else if(c == '\\') {
					if(DFileContent[i+1] != '\n') {
						working.push_back(DFileContent[i+1]);
						i++;
					}
				} else if(c == ' ') {
					// we will just ignore the potential problem of an escaped space in the path of a dependency
					// if anyone asks they have someone who worked on GCC to thank for that
					// this whole dependency situation is fucking ridiculous
					// note:
					// GNU make dependency generation will be deprecated in NextToolchain
					// therefore this is a contained problem which i am unwilling to deal with
					PushFile();
				} else {
					working.push_back(c);
				}
			}
			//.
			//. write .dependencies.json
			//.
			JSON config = JSON::object({});
			config.add(JSON("file",path));
			config.add(JSON("btime",std::to_string(static_cast<i64>(time(nullptr)))));
			config.add({"fdigest",FileDigest});
			config.add({"cdigest",CommandDigest});
			config.add(JSON::list("dependencies",{}));
			for(auto file : files) {
				config["dependencies"].add(JSON(file));
			}
			config.save(object+".json");
			unlink((object+".d").c_str());
		}
		
		return PreCompiledObject {
			.source = path,
			.object = object,
		};
	}
	
	PreCompiledObject PreCompileSwift(Domain domain,std::string path,std::string object) {
		std::string resolvedPath = ResolvePath(domain,path);
		
		std::string FileDigest = "";
		{
			std::string content;
			FILE* f = fopen(resolvedPath.c_str(),"rb");
			if(f == nullptr) {
				throw Error(std::string("failed to open file: ")+strerror(errno));
			}
			fseek(f,0,SEEK_END);
			content.resize(ftell(f));
			fseek(f, 0, SEEK_SET);
			fread(content.data(),content.size(),1,f);
			fclose(f);
			FileDigest = crypto::sha256.hash(content).ToHexString();
		}
		
		std::list<std::string> args;
		
		{
			// compiler executable
			args.push_back("swift-frontend");
			
			// swift language version
			args.push_back("-swift-version");
			args.push_back("6");
			
			// no top level code
			args.push_back("-parse-as-library");
			
			// target
			args.push_back("-target");
			args.push_back("arm64-apple-macosx"+TargetPlatform);
			
			// sdk
			args.push_back("-sdk");
			args.push_back("/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk");
			
			// c++ interop
			args.push_back("-cxx-interoperability-mode=default");
			
			// module maps
			for(auto& i : swiftModuleMaps) {
				args.push_back("-Xcc");
				args.push_back("-fmodule-map-file="+i);
			}
			
			// module maps
			for(auto& i : IncludeDirectories) {
				args.push_back("-Xcc");
				args.push_back("-I"+i);
			}
			
			// plugins
			args.push_back("-load-plugin-library");
			args.push_back("/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift/host/plugins/libObservationMacros.dylib");
			
			// module name
			args.push_back("-module-name");
			args.push_back(swiftModuleName);
			
			// other sources
			for(std::string& source : swiftSources) {
				if(source != path) {
					args.push_back(source);
				}
			}
		}
		
		{
			const std::string CompileCommands_File = GetCompileCommandsPath(domain,path);
			JSON CompileCommands;
			if(std::filesystem::exists(CompileCommands_File)) {
				CompileCommands.load(CompileCommands_File);
			} else {
				CompileCommands = JSON::list({});
			}
			
			JSON& CompileCommandsEntry = [&]() -> JSON& {
				for(JSON& entry : CompileCommands.children) {
					try {
						if(entry.GetString("file") == path) {
							return entry;
						}
					}catch(JSONNoSuchChild){}
				}
				CompileCommands.add(JSON::object({
					JSON("file",path),
					JSON::list("arguments",{})
				}));
				return CompileCommands.children.back();
			}();
			
			try {
				JSON& args = CompileCommandsEntry["arguments"];
				args = JSON::list("arguments",{});
			} catch(JSONNoSuchChild) {
				CompileCommandsEntry.add(JSON::list("arguments",{}));
			}
			
			try {
				CompileCommandsEntry["directory"] = JSON("directory",GetDirectoryForCompileCommands(domain,path));
			} catch(JSONNoSuchChild) {
				CompileCommandsEntry.add(JSON("directory",GetDirectoryForCompileCommands(domain,path)));
			}
			
			for(auto i : args) {
				CompileCommandsEntry["arguments"].add(i);
			}
			
			CompileCommandsEntry["arguments"].add(path);
			
			CompileCommands.save(CompileCommands_File);
		}
		
		std::vector<std::string> CompilerArgs;
		for(auto i : args) {
			CompilerArgs.push_back(i);
		}
		// dependencies
		CompilerArgs.push_back("-emit-dependencies");
		// debug symbols
		CompilerArgs.push_back("-g");
		// do not compile
		CompilerArgs.push_back("-c");
		// source
		CompilerArgs.push_back("-primary-file");
		CompilerArgs.push_back(resolvedPath);
		// output
		CompilerArgs.push_back("-emit-object");
		CompilerArgs.push_back("-o");
		CompilerArgs.push_back(object);
		
		const std::string CommandDigest = crypto::sha256.hash([&]{
			std::string res;
			for(auto i : CompilerArgs) {
				res += " "+i;
			}
			return res;
		}()).ToHexString();
		
		if(std::filesystem::exists(object+".json")) {
			JSON config = JSON::object({});
			config.load(object+".json");
			bool rebuild = false;
			
			if(config.GetString("cdigest") != CommandDigest) rebuild = true;
			if(config.GetString("fdigest") != FileDigest) rebuild = true;
			
			auto btimeStr = config.GetString("btime");
			auto btime = strtoll(btimeStr.data(),(char**)(btimeStr.data() + btimeStr.size()),10);
			
			for(JSON& i : config["dependencies"].children) {
				struct stat st;
				if (stat(i.StringValue.c_str(), &st) != 0) {
					//std::cout << "rebuilding, " << i.StringValue << " no stats" << std::endl;
					rebuild = true;
				} else {
					if(static_cast<i64>(st.st_mtime) > btime) {
						//std::cout << "rebuilding, " << i.StringValue << " changed" << std::endl;
						rebuild = true;
					}
				}
			}
			
			if(not rebuild) {
				return PreCompiledObject {
					.source = path,
					.object = object,
				};
			}
		}
		
		const int compilerExitCode = run(CompilerArgs);
		if(compilerExitCode != 0) {
			throw Error("compiler error: "+std::to_string(compilerExitCode));
		}
		
		//
		// consume .d file and write .dependencies.json
		//
		{
			//.
			//. load file
			//.
			std::string DFileContent;
			{
				FILE* f = fopen((object+".d").c_str(),"rb");
				if(!f) {
					throw std::runtime_error("fopen failed! cannot open .d file");
				}
				fseek(f,0,SEEK_END);
				DFileContent.resize(ftell(f));
				fseek(f,0,SEEK_SET);
				fread(DFileContent.data(),DFileContent.size(),1,f);
				fclose(f);
			}
			std::vector<std::string> files;
			std::string working;
			bool SkippedFirstLine = false;
			for(auto i = 0;i<DFileContent.size();i++) {
				char c = DFileContent[i];
				auto PushFile = [&]{
					for(int i = working.length()-1;i>=0;i--) {
						char c = working[i];
						if(c == '\\' || c == ' ') {
							working.pop_back();
						} else {
							break;
						}
					}
					if(working != "") {
						files.push_back(working);
					}
					working = "";
				};
				if(c == '\n') {
					if(!SkippedFirstLine) {
						SkippedFirstLine = true;
						continue;
					}
					PushFile();
				} else if(!SkippedFirstLine) {
					// this is deliberately empty
				} else if(c == ' ' && working == "") {
					// do not push character
				} else if(c == '\\') {
					if(DFileContent[i+1] != '\n') {
						working.push_back(DFileContent[i+1]);
						i++;
					}
				} else if(c == ' ') {
					// we will just ignore the potential problem of an escaped space in the path of a dependency
					// if anyone asks they have someone who worked on GCC to thank for that
					// this whole dependency situation is fucking ridiculous
					// note:
					// GNU make dependency generation will be deprecated in NextToolchain
					// therefore this is a contained problem which i am unwilling to deal with
					PushFile();
				} else {
					working.push_back(c);
				}
			}
			//.
			//. write .dependencies.json
			//.
			JSON config = JSON::object({});
			config.add(JSON("file",path));
			config.add(JSON("btime",std::to_string(static_cast<i64>(time(nullptr)))));
			config.add({"fdigest",FileDigest});
			config.add({"cdigest",CommandDigest});
			config.add(JSON::list("dependencies",{}));
			for(auto file : files) {
				config["dependencies"].add(JSON(file));
			}
			config.save(object+".json");
			unlink((object+".d").c_str());
		}
		
		return PreCompiledObject {
			.source = path,
			.object = object,
		};
	}
	
	PreCompiledObject PreCompileMetal(Domain domain,std::string path,std::string object) {
		std::string resolvedPath = ResolvePath(domain,path);
		
		std::list<std::string> args;

		{
			// compiler executable
			args.push_back("xcrun");
			args.push_back("metal");
		}
		
		{
			const std::string CompileCommands_File = GetCompileCommandsPath(domain,path);
			JSON CompileCommands;
			if(std::filesystem::exists(CompileCommands_File)) {
				CompileCommands.load(CompileCommands_File);
			} else {
				CompileCommands = JSON::list({});
			}
			
			JSON& CompileCommandsEntry = [&]() -> JSON& {
				for(JSON& entry : CompileCommands.children) {
					try {
						if(entry.GetString("file") == path) {
							return entry;
						}
					}catch(JSONNoSuchChild){}
				}
				CompileCommands.add(JSON::object({
					JSON("file",path),
					JSON::list("arguments",{})
				}));
				return CompileCommands.children.back();
			}();
			
			try {
				JSON& args = CompileCommandsEntry["arguments"];
				args = JSON::list("arguments",{});
			} catch(JSONNoSuchChild) {
				CompileCommandsEntry.add(JSON::list("arguments",{}));
			}
			
			try {
				CompileCommandsEntry["directory"] = JSON("directory",GetDirectoryForCompileCommands(domain,path));
			} catch(JSONNoSuchChild) {
				CompileCommandsEntry.add(JSON("directory",GetDirectoryForCompileCommands(domain,path)));
			}
			
			for(auto i : args) {
				CompileCommandsEntry["arguments"].add(i);
			}
			
			CompileCommandsEntry["arguments"].add(path);
			
			CompileCommands.save(CompileCommands_File);
		}
		
		std::vector<std::string> CompilerArgs;
		for(auto i : args) {
			CompilerArgs.push_back(i);
		}
		// debug symbols
		CompilerArgs.push_back("-g");
		// do not link
		CompilerArgs.push_back("-c");
		// source
		CompilerArgs.push_back(resolvedPath);
		// output
		CompilerArgs.push_back("-o");
		CompilerArgs.push_back(object);
		
		const int compilerExitCode = run(CompilerArgs);
		if(compilerExitCode != 0) {
			throw Error("compiler error: "+std::to_string(compilerExitCode));
		}
		
		return PreCompiledObject {
			.source = path,
			.object = object,
		};
	}
	
	void Link(std::vector<PreCompiledObject>& objects,std::string outputPath) {
		std::vector<std::string> CompilerArgs;
		CompilerArgs.push_back("clang++");
		CompilerArgs.push_back("-g");
		CompilerArgs.push_back("-mmacos-version-min="+TargetPlatform);
		for(std::string i : frameworkDirectories) {
			CompilerArgs.push_back("-F");
			CompilerArgs.push_back(i);
		}
		for(std::string i : frameworks) {
			CompilerArgs.push_back("-framework");
			CompilerArgs.push_back(i);
		}
		for(auto& object : objects) {
			CompilerArgs.push_back(object.object);
		}
		CompilerArgs.push_back("-o");
		CompilerArgs.push_back(outputPath);
		
		if(useEngineLibrary) {
			CompilerArgs.push_back(DMCRE_RUNTIME_DYLIB_PATH);
		}
		
		const int compilerExitCode = run(CompilerArgs);
		if(compilerExitCode != 0) {
			throw Error("compiler error: "+std::to_string(compilerExitCode));
		}
	}
	
	void LinkMetal(std::vector<PreCompiledObject>& objects,std::string outputPath) {
		std::vector<std::string> CompilerArgs;
		CompilerArgs.push_back("xcrun");
		CompilerArgs.push_back("metallib");
		for(auto& object : objects) {
			CompilerArgs.push_back(object.object);
		}
		CompilerArgs.push_back("-o");
		CompilerArgs.push_back(outputPath);

		const int compilerExitCode = run(CompilerArgs);
		if(compilerExitCode != 0) {
			throw Error("compiler error: "+std::to_string(compilerExitCode));
		}
	}
	
	DynamicLibrary LinkAndLoad(std::vector<PreCompiledObject>& objects,std::string ModuleId) {
		std::vector<std::string> CompilerArgs;
		CompilerArgs.push_back("clang++");
		CompilerArgs.push_back("-g");
		CompilerArgs.push_back("-shared");
		CompilerArgs.push_back("-mmacos-version-min="+TargetPlatform);
		for(std::string i : frameworkDirectories) {
			CompilerArgs.push_back("-F");
			CompilerArgs.push_back(i);
		}
		for(std::string i : frameworks) {
			CompilerArgs.push_back("-framework");
			CompilerArgs.push_back(i);
		}
		CompilerArgs.push_back("-undefined");
		CompilerArgs.push_back("dynamic_lookup");
		for(auto& object : objects) {
			CompilerArgs.push_back(object.object);
		}
		CompilerArgs.push_back("-o");
		#ifdef _WIN32
			CompilerArgs.push_back(""+(dmcre::RuntimeDirectory +"/"+ ModuleId)+".dll");
		#else
			CompilerArgs.push_back(""+(dmcre::RuntimeDirectory +"/"+ ModuleId)+"");
		#endif
		
		const int compilerExitCode = run(CompilerArgs);
		if(compilerExitCode != 0) {
			throw Error("compiler error: "+std::to_string(compilerExitCode));
		}
		
		return FinalLoadDLL(
			dmcre::RuntimeDirectory +"/"+ ModuleId,
			ModuleId,
			Domain::LinkAndLoad,
			"PreCompiled"
		);
	}
	
	void LinkDylib(std::vector<PreCompiledObject>& objects,std::string dylibPath) {
		std::vector<std::string> CompilerArgs;
		CompilerArgs.push_back("clang++");
		CompilerArgs.push_back("-g");
		CompilerArgs.push_back("-shared");
		CompilerArgs.push_back("-mmacos-version-min="+TargetPlatform);
		for(std::string i : frameworkDirectories) {
			CompilerArgs.push_back("-F");
			CompilerArgs.push_back(i);
		}
		for(std::string i : frameworks) {
			CompilerArgs.push_back("-framework");
			CompilerArgs.push_back(i);
		}
		CompilerArgs.push_back("-undefined");
		CompilerArgs.push_back("dynamic_lookup");
		for(auto& object : objects) {
			CompilerArgs.push_back(object.object);
		}
		CompilerArgs.push_back("-o");
		CompilerArgs.push_back(dylibPath);
		
		const int compilerExitCode = run(CompilerArgs);
		if(compilerExitCode != 0) {
			throw Error("compiler error: "+std::to_string(compilerExitCode));
		}
	}

	DynamicLibrary dll(Domain domain,std::string path) {
		std::string resolvedPath = [&]{
			if(domain == Domain::WorkingDirectory) {
				char _cwd[4096];
				auto cwd_out = getcwd(_cwd, sizeof(_cwd));
				std::string cwd = cwd_out;
				return cwd+"/"+path;
			}

			throw std::runtime_error("lizard");
		}();

		return FinalLoadDLL(
			resolvedPath,
			path,
			domain,
			"dll"
		);
	}
}
