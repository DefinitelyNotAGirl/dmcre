#include <dmcre/foundation>
#include <dmcre/debug>
#include <dmcre/serial>
#include <dmcre/load>
#include <fstream>
#include <stdexcept>
#include <errno.h>
#include <sys/stat.h>
#include <string>
#include <vector>
#include <vector>
#include <cstring>
#include <dmcre/BufferStream>
#include <dmcre/config>

#if not defined(_WIN32)
	#include <unistd.h>
#else
	#include <windows.h>
	#include <process.h>
	#include <bcrypt.h>
	#include <io.h>
#endif

#if not defined(_WIN32)
	#include <dlfcn.h>
#endif

#include "private.hpp"

#include <dmcre/DynamicLibrary>
#include <dmcre/error>

#include <filesystem>
#include <vector>

#include <fcntl.h>

static int run(const std::vector<std::string>& args) {
#if not defined(_WIN32)
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
		
		execvp(argv[0], argv.data());
		std::cout << "execvp: " << strerror(errno) << std::endl;
		_exit(127);
	}
	
	int status;
	waitpid(pid, &status, 0);
	
	if(WIFEXITED(status))
		return WEXITSTATUS(status);
	return -1;
#else
	if(args.empty()) {
		return 127;
	}

	auto quoteForCommandLine = [](const std::string& value) -> std::string {
		if(value.empty()) {
			return "\"\"";
		}
		bool needsQuotes = value.find_first_of(" \t\"") != std::string::npos;
		if(!needsQuotes) {
			return value;
		}
		std::string escaped;
		escaped.reserve(value.size() + 2);
		escaped.push_back('"');
		for(char ch : value) {
			if(ch == '"') {
				escaped += "\\\"";
			} else {
				escaped.push_back(ch);
			}
		}
		escaped.push_back('"');
		return escaped;
	};

	std::string commandLine = quoteForCommandLine(args[0]);
	for(size_t i = 1; i < args.size(); ++i) {
		commandLine += " ";
		commandLine += quoteForCommandLine(args[i]);
	}

	std::vector<char> commandLineBuffer(commandLine.begin(), commandLine.end());
	commandLineBuffer.push_back('\0');

	STARTUPINFOA startupInfo{};
	startupInfo.cb = sizeof(startupInfo);
	PROCESS_INFORMATION processInfo{};

	BOOL success = CreateProcessA(
		args[0].c_str(),
		commandLineBuffer.data(),
		nullptr,
		nullptr,
		FALSE,
		0,
		nullptr,
		nullptr,
		&startupInfo,
		&processInfo
	);
	if(!success) {
		return -1;
	}

	WaitForSingleObject(processInfo.hProcess, INFINITE);
	DWORD exitCode = 0;
	GetExitCodeProcess(processInfo.hProcess, &exitCode);
	CloseHandle(processInfo.hThread);
	CloseHandle(processInfo.hProcess);

	return static_cast<int>(exitCode);
#endif
}

static std::string SHA512Hash(const std::string& data) {
#if defined(_WIN32)
	BCRYPT_ALG_HANDLE hAlg = nullptr;
	BCRYPT_HASH_HANDLE hHash = nullptr;
	
	if (!BCRYPT_SUCCESS(BCryptOpenAlgorithmProvider(&hAlg, BCRYPT_SHA512_ALGORITHM, nullptr, 0))) {
		throw Error("Failed to open SHA512 algorithm");
	}
	
	if (!BCRYPT_SUCCESS(BCryptCreateHash(hAlg, &hHash, nullptr, 0, nullptr, 0, 0))) {
		BCryptCloseAlgorithmProvider(hAlg, 0);
		throw Error("Failed to create hash");
	}
	
	if (!BCRYPT_SUCCESS(BCryptHashData(hHash, (PUCHAR)data.data(), data.size(), 0))) {
		BCryptDestroyHash(hHash);
		BCryptCloseAlgorithmProvider(hAlg, 0);
		throw Error("Failed to hash data");
	}
	
	DWORD hashSize = 64; // SHA512 = 512 bits = 64 bytes
	std::vector<BYTE> hash(hashSize);
	
	if (!BCRYPT_SUCCESS(BCryptFinishHash(hHash, hash.data(), hashSize, 0))) {
		BCryptDestroyHash(hHash);
		BCryptCloseAlgorithmProvider(hAlg, 0);
		throw Error("Failed to finish hash");
	}
	
	BCryptDestroyHash(hHash);
	BCryptCloseAlgorithmProvider(hAlg, 0);
	
	// Convert to hex string
	std::string hexStr;
	hexStr.reserve(128);
	for (int i = 0; i < 64; i++) {
		char buf[3];
		snprintf(buf, sizeof(buf), "%02x", hash[i]);
		hexStr += buf;
	}
	return hexStr;
#else
	// Unix/Linux fallback - use existing base64 method
	auto inBuf = String(data.c_str()).encode(String::Format::ASCII);
	auto base64Buf = transformBufferToBase64(inBuf);
	return std::string((const char*)(String::decode(base64Buf,String::Format::ASCII).encode(String::Format::CSTRING).raw()));
#endif
}

namespace dmcre {
	DMCRE_PUBLIC_API std::string RuntimeDirectory = "";
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
			return (std::filesystem::current_path() / "compile_commands.json").string();
		}

		throw std::runtime_error("lizard");
	}

	DMCRE_PUBLIC_API std::string compileCommandsAbsoluteDir = "";
	
	std::string GetDirectoryForCompileCommands(Domain domain,std::string path) {
		if(domain == Domain::Absolute) {
			return compileCommandsAbsoluteDir;
		} else if(domain == Domain::WorkingDirectory) {
			return std::filesystem::current_path().string();
		}

		throw std::runtime_error("lizard");
	}
	
	std::string ResolvePath(Domain domain,std::string path) {
		if(domain == Domain::Absolute) {
			return path;
		}
		else if(domain == Domain::WorkingDirectory) {
			return (std::filesystem::current_path() / path).string();
		}
		throw Error("bad domain");
	}

	static DynamicLibrary FinalLoadDLL(
		std::string path,
		std::string load_path,
		Domain load_domain,
		std::string load_type
	) {
		DynamicLibrary library(path,{DynamicLibrary::LoadFlag::Global});
		
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

	void readMakeDependencyFile(const std::string& file,std::vector<std::string>& dependencies) {
		auto fileHandle = fopen(file.c_str(),"r");
		fseek(fileHandle,0,SEEK_END);
		DynamicBuffer fileBuffer;
		fileBuffer.resize(ftell(fileHandle));
		fseek(fileHandle,0,SEEK_SET);
		fread(fileBuffer.raw(),fileBuffer.size().HostEndian(),1,fileHandle);
		fclose(fileHandle);
		BufferBackedIStream fileStream(fileBuffer);

		auto b = fileStream.read<Byte>();
		while((b != ':')) {
			b = fileStream.read<Byte>();
		}
		b = fileStream.read<Byte>();
		
		while(true) {
			while((b == ' ') or (b == '\t') or (b == '\n')) {
				b = fileStream.read<Byte>();
			}
			std::string dependency;
			while(b != ' ' and b != '\n') {
				dependency.push_back(b.HostEndian());
				b = fileStream.read<Byte>();
			}
			dependencies.push_back(dependency);
			if(b == '\n') {
				return;
			}
			b = fileStream.read<Byte>();
			if(b == '\\') {
				b = fileStream.read<Byte>();
			}
		}
	}

	DMCRE_PUBLIC_API void ExecuteBuildSequence(
		Domain domain,std::string path,bool doBuildDependencyTree,std::string out,
		std::function<void(const std::string& source,const std::string& sourceDigest,const std::string& out,std::vector<std::string>& args)> buildArguments,
		std::function<void(const std::string& source,const std::string& sourceDigest,const std::string& out,std::vector<std::string>& args)> buildFinalArguments,
		std::function<void(const std::string& source,const std::string& sourceDigest,const std::string& out,std::vector<std::string>& dependencies)> buildDependencies,
		std::function<void(const std::string& source,const std::string& sourceDigest,const std::string& out)> postBuild
	) {
		std::string source = ResolvePath(domain,path);

		std::string sourceDigest = "";
		{
			std::string content;
			FILE* f = fopen(source.c_str(),"rb");
			if(f == nullptr) {
				throw Error(std::string("failed to open file: ")+strerror(errno));
			}
			fseek(f,0,SEEK_END);
			content.resize(ftell(f));
			fseek(f, 0, SEEK_SET);
			fread(content.data(),content.size(),1,f);
			fclose(f);

			sourceDigest = SHA512Hash(content);
		}

		if(out == "") {
			out = dmcre::RuntimeDirectory + "/" + sourceDigest;
		}

		std::vector<std::string> args;

		buildArguments(source,sourceDigest,out,args);

		const std::string CompileCommands_File = GetCompileCommandsPath(domain, path);
		auto compileCommandsFileHandle = fopen(CompileCommands_File.c_str(),"rb");
		fseek(compileCommandsFileHandle,0,SEEK_END);
		DynamicBuffer compileCommandsFileBuffer;
		compileCommandsFileBuffer.resize(ftell(compileCommandsFileHandle));
		fseek(compileCommandsFileHandle,0,SEEK_SET);
		fread(compileCommandsFileBuffer.raw(),compileCommandsFileBuffer.size().HostEndian(),1,compileCommandsFileHandle);
		fseek(compileCommandsFileHandle,0,SEEK_SET);

		BufferBackedIStream compileCommandsIStream(compileCommandsFileBuffer);
		SerialObject CompileCommands = JsonReaderUTF8(compileCommandsIStream).read();

		SerialObject& CompileCommandsEntry = [&]() -> SerialObject& {
			for(SerialObject& entry : CompileCommands.items()) {
				try {
					if(entry.GetProperty("file").string() == path.c_str()) {
						return entry;
					}
				}catch(...){}
			}
			SerialObject entry(SerialObject::Type::Object);
			entry.properties().push_back({"file",path.c_str()});
			entry.properties().push_back({"arguments",SerialObject(SerialObject::Type::List)});
			CompileCommands.items().push_back(entry);
			return CompileCommands.items().back();
		}();
			
		try {
			CompileCommandsEntry.GetProperty("arguments").items().clear();
		} catch(...) {
			CompileCommandsEntry.properties().push_back({"arguments",SerialObject(SerialObject::Type::List)});
		}
			
		try {
			CompileCommandsEntry.GetProperty("directory").string() = GetDirectoryForCompileCommands(domain,path).c_str();
		} catch(...) {
			CompileCommandsEntry.properties().push_back({"directory",GetDirectoryForCompileCommands(domain,path).c_str()});
		}
			
		for(auto i : args) {
			CompileCommandsEntry.GetProperty("arguments").items().push_back(i.c_str());
		}

		fclose(compileCommandsFileHandle);
		compileCommandsFileBuffer.resize(0);
		compileCommandsFileHandle = fopen(CompileCommands_File.c_str(),"wb");
		BufferBackedOStream compileCommandsOStream(compileCommandsFileBuffer);
		JsonWriterUTF8(compileCommandsOStream).write(CompileCommands);
		fwrite(compileCommandsFileBuffer.raw(),compileCommandsFileBuffer.size().HostEndian(),1,compileCommandsFileHandle);
		fclose(compileCommandsFileHandle);

		buildFinalArguments(source,sourceDigest,out,args);

		bool doBuild = true;

		const std::string commandDigest = SHA512Hash([&]{
			std::string res;
			for(auto i : args) {
				res += " "+i;
			}
			return res;
		}());

		if(std::filesystem::exists(out+".json")) {
			FILE* outJsonFileHandle = fopen((out+".json").c_str(),"rb");
			fseek(outJsonFileHandle,0,SEEK_END);
			DynamicBuffer outJsonFileBuffer;
			outJsonFileBuffer.resize(ftell(outJsonFileHandle));
			fseek(outJsonFileHandle,0,SEEK_SET);
			fread(outJsonFileBuffer.raw(),outJsonFileBuffer.size().HostEndian(),1,outJsonFileHandle);
			fclose(outJsonFileHandle);

			BufferBackedIStream outJsonIStream(outJsonFileBuffer);
			SerialObject outJson = JsonReaderUTF8(outJsonIStream).read();
			doBuild = false;
			
			if(outJson.GetProperty("commandDigest").string() != commandDigest.c_str()) doBuild = true;
			if(outJson.GetProperty("sourceDigest").string() != sourceDigest.c_str()) doBuild = true;
			
			auto btime = outJson.GetProperty("btime").Integer().HostEndian();
			
			for(auto& i : outJson.GetProperty("dependencies").items()) {
				struct stat st;
				if (stat((char*)i.string().encode(String::Format::CSTRING).raw(), &st) != 0) {
					//std::cout << "rebuilding, " << (char*)i.string().encode(String::Format::CSTRING).raw() << " no stats" << std::endl;
					doBuild = true;
				} else {
					if(static_cast<int64_t>(st.st_mtime) > btime) {
						//std::cout << "rebuilding, " << (char*)i.string().encode(String::Format::CSTRING).raw() << " changed" << std::endl;
						doBuild = true;
					}
				}
			}
		}

		if(not doBuild) {
			return;
		}

		const int exitCode = run(args);

		if(doBuildDependencyTree) {
			std::vector<std::string> dependencies;

			buildDependencies(source,sourceDigest,out,dependencies);

			//.
			//. write .json
			//.
			FILE* outJsonFileHandle = fopen((out+".json").c_str(),"wb");
			SerialObject outJson(SerialObject::Type::Object);
			outJson.properties().push_back({"source",source.c_str()});
			outJson.properties().push_back({"btime",Int64(static_cast<int64_t>(time(nullptr)))});
			outJson.properties().push_back({"sourceDigest",sourceDigest.c_str()});
			outJson.properties().push_back({"commandDigest",commandDigest.c_str()});
			SerialObject serial_dependencies(SerialObject::Type::List);
			for(auto i : dependencies) {
				serial_dependencies.items().push_back(i.c_str());
			}
			outJson.properties().push_back({"dependencies",serial_dependencies});

			DynamicBuffer outJsonFileBuffer;
			BufferBackedOStream outJsonOStream(outJsonFileBuffer);
			JsonWriterUTF8(outJsonOStream).write(outJson);
			fwrite(outJsonFileBuffer.raw(),outJsonFileBuffer.size().HostEndian(),1,outJsonFileHandle);
			fclose(outJsonFileHandle);
		}

		postBuild(source,sourceDigest,out);
	}

	DynamicLibrary cpp(Domain domain,std::string path) {
		std::string out_dll;
		ExecuteBuildSequence(
			domain,
			path,
			false,
			"",
			[&](const std::string& source,const std::string& sourceDigest,const std::string& out,std::vector<std::string>& args){
				args.push_back(dmcre::config::sdk::cxx::compiler);

				args.push_back("-g");
				args.push_back("-shared");

				#if defined(_WIN32)
					args.push_back("-target");
					args.push_back("x86_64-pc-windows-msvc");
					args.push_back("-D_CRT_SECURE_NO_WARNINGS");
				#endif

				#if defined(__APPLE__)
					args.push_back("-undefined");
					args.push_back("dynamic_lookup");
				#endif
				
				args.push_back("-std=c++20");

				args.push_back("-Wno-system-headers");
				
				for(auto dir : IncludeDirectories) {
					args.push_back("-I"+dir);
				}

				for(auto dir : cxx::SystemIncludeDirectories) {
					args.push_back("-isystem"+dir);
				}
			},
			[&](const std::string& source,const std::string& sourceDigest,const std::string& out,std::vector<std::string>& args){
				out_dll = out+".dll";

				args.push_back("-Xlinker");
				args.push_back("/NOEXP");
				args.push_back("-Xlinker");
				args.push_back("/NOIMPLIB");
				args.push_back("-Xlinker");
				args.push_back(dmcre::config::install::runtimeDylib);
                args.push_back("-Xlinker");
                args.push_back("/libpath:"+config::sdk::windows::lib::um);
				args.push_back("-x");
				args.push_back("c++");
				args.push_back(source);
				args.push_back("-o");
				args.push_back(out_dll);
			},
			[&](const std::string& source,const std::string& sourceDigest,const std::string& out,std::vector<std::string>& dependencies){
			},
			[&](const std::string& source,const std::string& sourceDigest,const std::string& out){
			}
		);

		return FinalLoadDLL(
			out_dll,
			path,
			domain,
			"c++"
		);
	}

	DynamicLibrary ObjCpp(Domain domain,std::string path) {
		std::string out_dll;
		ExecuteBuildSequence(
			domain,
			path,
			false,
			"",
			[&](const std::string& source,const std::string& sourceDigest,const std::string& out,std::vector<std::string>& args){
				// compiler executable
				args.push_back(dmcre::config::sdk::cxx::compiler);

				args.push_back("-g");
				args.push_back("-shared");

				#if defined(_WIN32)
					args.push_back("-target");
					args.push_back("x86_64-pc-windows-msvc");
					args.push_back("-D_CRT_SECURE_NO_WARNINGS");
				#endif

				#if defined(__APPLE__)
					args.push_back("-undefined");
					args.push_back("dynamic_lookup");
				#endif
				
				args.push_back("-std=c++20");
				
				for(auto dir : IncludeDirectories) {
					args.push_back("-I"+dir);
				}
			},
			[&](const std::string& source,const std::string& sourceDigest,const std::string& out,std::vector<std::string>& args){
				out_dll = out+".dll";

				args.push_back("-Xlinker");
				args.push_back("/NOEXP");
				args.push_back("-Xlinker");
				args.push_back("/NOIMPLIB");
				args.push_back("-Xlinker");
				args.push_back(dmcre::config::install::runtimeDylib);
				args.push_back("-x");
				args.push_back("objective-c++");
				args.push_back(source);
				args.push_back("-o");
				args.push_back(out_dll);
			},
			[&](const std::string& source,const std::string& sourceDigest,const std::string& out,std::vector<std::string>& dependencies){
			},
			[&](const std::string& source,const std::string& sourceDigest,const std::string& out){
			}
		);

		return FinalLoadDLL(
			out_dll,
			path,
			domain,
			"objective-c++"
		);
	}

	DynamicLibrary Swift(Domain domain,std::string path) {
		std::string out_dll;
		ExecuteBuildSequence(
			domain,
			path,
			false,
			"",
			[&](const std::string& source,const std::string& sourceDigest,const std::string& out,std::vector<std::string>& args){
				args.push_back("swift-frontend");

				// swift language version
				args.push_back("-swift-version");
				args.push_back("6");
				
				// no top level code
				args.push_back("-parse-as-library");
				
				// target
				args.push_back("-target");
				args.push_back("arm64-apple-macosx26");
				
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
			},
			[&](const std::string& source,const std::string& sourceDigest,const std::string& out,std::vector<std::string>& args){
				out_dll = out+".dll";

				// dependencies
				args.push_back("-emit-dependencies");
				// debug symbols
				args.push_back("-g");
				// do not compile
				args.push_back("-c");
				// source
				args.push_back("-primary-file");
				args.push_back(source);
				// output
				args.push_back("-emit-object");
				args.push_back("-o");
				args.push_back(out+".o");
			},
			[&](const std::string& source,const std::string& sourceDigest,const std::string& out,std::vector<std::string>& dependencies){
			},
			[&](const std::string& source,const std::string& sourceDigest,const std::string& out){
			}
		);

		return FinalLoadDLL(
			out_dll,
			path,
			domain,
			"swift"
		);
	}
	
	PreCompiledObject PreCompileCpp(Domain domain,std::string path,std::string object) {
		std::string out_object;
		std::string in_source;
		ExecuteBuildSequence(
			domain,
			path,
			true,
			object,
			[&](const std::string& source,const std::string& sourceDigest,const std::string& out,std::vector<std::string>& args){
				in_source = source;

				args.push_back(dmcre::config::sdk::cxx::compiler);

				#if defined(_WIN32)
					args.push_back("-target");
					args.push_back("x86_64-pc-windows-msvc");
					args.push_back("-D_CRT_SECURE_NO_WARNINGS");
				#endif
				
				args.push_back("-std=c++20");

				args.push_back("-Wno-system-headers");
				
				for(auto dir : IncludeDirectories) {
					args.push_back("-I"+dir);
				}

				for(auto dir : cxx::SystemIncludeDirectories) {
					args.push_back("-isystem"+dir);
				}

				for(auto& i : cppMacros) {
					args.push_back("-D"+i.first+"="+i.second);
				}

				args.push_back("-Wno-pragma-once-outside-header");
			},
			[&](const std::string& source,const std::string& sourceDigest,const std::string& out,std::vector<std::string>& args){
				out_object = out+".o";

				args.push_back("-MMD");
				args.push_back("-c");
				args.push_back("-g");
				args.push_back("-x");
				args.push_back("c++");
				args.push_back(source);
				args.push_back("-o");
				args.push_back(out_object);
			},
			[&](const std::string& source,const std::string& sourceDigest,const std::string& out,std::vector<std::string>& dependencies){
				readMakeDependencyFile(out+".d", dependencies);
			},
			[&](const std::string& source,const std::string& sourceDigest,const std::string& out){
				#if not defined(_WIN32)
					unlink((object+".d").c_str());
				#else
					_unlink((object+".d").c_str());
				#endif
			}
		);
		
		return PreCompiledObject {
			.source = in_source,
			.object = out_object,
		};
	}

	PreCompiledObject PreCompileObjCpp(Domain domain,std::string path,std::string object) {
		std::string out_object;
		std::string in_source;
		ExecuteBuildSequence(
			domain,
			path,
			true,
			object,
			[&](const std::string& source,const std::string& sourceDigest,const std::string& out,std::vector<std::string>& args){
				in_source = source;

				args.push_back(dmcre::config::sdk::cxx::compiler);

				#if defined(_WIN32)
					args.push_back("-target");
					args.push_back("x86_64-pc-windows-msvc");
					args.push_back("-D_CRT_SECURE_NO_WARNINGS");
				#endif
				
				args.push_back("-std=c++20");
				
				for(auto dir : IncludeDirectories) {
					args.push_back("-I"+dir);
				}

				args.push_back("-Wno-pragma-once-outside-header");
			},
			[&](const std::string& source,const std::string& sourceDigest,const std::string& out,std::vector<std::string>& args){
				out_object = out+".o";

				args.push_back("-Xlinker");
				args.push_back(dmcre::config::install::runtimeDylib);
				args.push_back("-MMD");
				args.push_back("-c");
				args.push_back("-g");
				args.push_back("-x");
				args.push_back("objective-c++");
				args.push_back(source);
				args.push_back("-o");
				args.push_back(out_object);
			},
			[&](const std::string& source,const std::string& sourceDigest,const std::string& out,std::vector<std::string>& dependencies){
				readMakeDependencyFile(out+".d", dependencies);
			},
			[&](const std::string& source,const std::string& sourceDigest,const std::string& out){
				#if not defined(_WIN32)
					unlink((object+".d").c_str());
				#else
					_unlink((object+".d").c_str());
				#endif
			}
		);
		
		return PreCompiledObject {
			.source = in_source,
			.object = out_object,
		};
	}

	PreCompiledObject PreCompileSwift(Domain domain,std::string path,std::string object) {
		std::string out_object;
		std::string in_source;
		ExecuteBuildSequence(
			domain,
			path,
			true,
			object,
			[&](const std::string& source,const std::string& sourceDigest,const std::string& out,std::vector<std::string>& args){
				in_source = source;

				// compiler executable
				args.push_back("swift-frontend");

				// swift language version
				args.push_back("-swift-version");
				args.push_back("6");
				
				// no top level code
				args.push_back("-parse-as-library");
				
				// target
				args.push_back("-target");
				args.push_back("arm64-apple-macosx26");
				
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
			},
			[&](const std::string& source,const std::string& sourceDigest,const std::string& out,std::vector<std::string>& args){
				out_object = out+".o";

				// dependencies
				args.push_back("-emit-dependencies");
				// debug symbols
				args.push_back("-g");
				// do not compile
				args.push_back("-c");
				// source
				args.push_back("-primary-file");
				args.push_back(source);
				// output
				args.push_back("-emit-object");
				args.push_back("-o");
				args.push_back(out+".o");
			},
			[&](const std::string& source,const std::string& sourceDigest,const std::string& out,std::vector<std::string>& dependencies){
				readMakeDependencyFile(out+".d", dependencies);
			},
			[&](const std::string& source,const std::string& sourceDigest,const std::string& out){
				#if not defined(_WIN32)
					unlink((object+".d").c_str());
				#else
					_unlink((object+".d").c_str());
				#endif
			}
		);
		
		return PreCompiledObject {
			.source = in_source,
			.object = out_object,
		};
	}

	PreCompiledObject PreCompileMetal(Domain domain,std::string path,std::string object) {
		std::string out_object;
		std::string in_source;
		ExecuteBuildSequence(
			domain,
			path,
			false,
			object,
			[&](const std::string& source,const std::string& sourceDigest,const std::string& out,std::vector<std::string>& args){
				in_source = source;

				// compiler executable
				args.push_back("xcrun");
				args.push_back("metal");
				
				args.push_back("-std=c++20");
				
				for(auto dir : IncludeDirectories) {
					args.push_back("-I"+dir);
				}

				args.push_back("-Wno-pragma-once-outside-header");
			},
			[&](const std::string& source,const std::string& sourceDigest,const std::string& out,std::vector<std::string>& args){
				out_object = out+".o";

				args.push_back("-g");
				// do not link
				args.push_back("-c");
				// source
				args.push_back(source);
				// output
				args.push_back("-o");
				args.push_back(out+".o");
			},
			[&](const std::string& source,const std::string& sourceDigest,const std::string& out,std::vector<std::string>& dependencies){
			},
			[&](const std::string& source,const std::string& sourceDigest,const std::string& out){
			}
		);
		
		return PreCompiledObject {
			.source = in_source,
			.object = out_object,
		};
	}
	
	void Link(std::vector<PreCompiledObject>& objects,std::string outputPath) {
		std::vector<std::string> CompilerArgs;
		CompilerArgs.push_back(dmcre::config::sdk::cxx::compiler);
		CompilerArgs.push_back("-g");
		CompilerArgs.push_back("-target");
		CompilerArgs.push_back("x86_64-pc-windows-msvc");
		CompilerArgs.push_back("-Xlinker");
		CompilerArgs.push_back("/libpath:"+config::sdk::windows::lib::um);
		#if defined(__APPLE__)
			CompilerArgs.push_back("-mmacos-version-min="+TargetPlatform);
			for(std::string i : frameworkDirectories) {
				CompilerArgs.push_back("-F");
				CompilerArgs.push_back(i);
			}
			for(std::string i : frameworks) {
				CompilerArgs.push_back("-framework");
				CompilerArgs.push_back(i);
			}
		#endif
		if(useEngineLibrary) {
			CompilerArgs.push_back(dmcre::config::install::runtimeDylib);
		}
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
		#if not defined(_WIN32)
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
		#else
			(void)frameworkDirectories;
			(void)frameworks;
		#endif
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
#if defined(_WIN32)
			dmcre::RuntimeDirectory +"/"+ ModuleId + ".dll",
#else
			dmcre::RuntimeDirectory +"/"+ ModuleId,
#endif
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
		#if not defined(_WIN32)
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
		#else
			(void)frameworkDirectories;
			(void)frameworks;
		#endif
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
				return (std::filesystem::current_path() / path).string();
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
