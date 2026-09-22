#include <dmcre/console>
#include <dmcre/load>
#include <dmcre/debug>
#include <iostream>
#include <unistd.h>
#include <filesystem>

template<typename IteratorType>
void CollectMatchingFiles(const std::filesystem::path& basePath, const std::vector<std::string>& extensions, std::vector<std::string>& files) {
    for (const auto& entry : IteratorType(basePath)) {
        if (!entry.is_regular_file()) continue;
        std::string ext = entry.path().extension().string();
        std::transform(ext.begin(), ext.end(), ext.begin(), ::tolower);
        if (std::find(extensions.begin(), extensions.end(), ext) != extensions.end()) {
            files.push_back(entry.path().string());
        }
    }
}

std::vector<std::string> GetAllFilesOfExtensions(std::string BaseDir, std::vector<std::string> extensions, bool recursive) {
    std::vector<std::string> files;
    std::filesystem::path basePath(BaseDir);

    // Normalize extensions to lowercase with leading dot
    for (auto& ext : extensions) {
        if (!ext.empty() && ext[0] != '.') ext = "." + ext;
        std::transform(ext.begin(), ext.end(), ext.begin(), ::tolower);
    }

    if (recursive)
        CollectMatchingFiles<std::filesystem::recursive_directory_iterator>(basePath, extensions, files);
    else
        CollectMatchingFiles<std::filesystem::directory_iterator>(basePath, extensions, files);
	
    return files;
}

extern "C" void dmcre_onload() {
	dmcre::load::compileCommandsPath = "./compile_commands.json";
	dmcre::load::compileCommandsAbsoluteDir = "/Volumes/programming/dmcre";

	dmcre::load::useEngineLibrary = true;

	dmcre::IncludeDirectories.push_back("/Volumes/programming/LLVM-22.1.8-macOS-ARM64/include");

	dmcre::load::cxx::enableRTTI = false;

	auto PreCompileDirectory = [&](std::string module,std::string dir,std::vector<dmcre::load::PreCompiledObject>& Objects){
		dmcre::load::cppMacros.at("DMCRE_MODULE") = "\""+module+"\"";
		// C++
		{
			auto sources = GetAllFilesOfExtensions(dir,{"cpp"},true);
			for(auto source : sources) {
				std::string FileId = (char*)dmcre::String::decode(dmcre::transformBufferToBase64(dmcre::String(source.c_str()).encode(dmcre::String::Format::ASCII)),dmcre::String::Format::ASCII).encode(dmcre::String::Format::CSTRING).raw();
				std::cout << "[" << module << "] " << source << std::endl;
				Objects.push_back(dmcre::load::PreCompileCpp(dmcre::load::Domain::Absolute, source, "build/"+FileId));
			}
		}
	};

	dmcre::load::cppMacros.insert({"DMCRE_MODULE","\"dmcre documentation indexer\""});

	dmcre::load::librarySearchPaths.push_back("/Volumes/programming/LLVM-22.1.8-macOS-ARM64/lib");

	std::vector<dmcre::load::PreCompiledObject> objects;
	objects.push_back({.source = "",.object = "-Wl,-rpath,/Volumes/programming/LLVM-22.1.8-macOS-ARM64/lib"});
	objects.push_back({.source = "",.object = "-lclang-cpp"});
	try {
		PreCompileDirectory("dmcre documentation indexer","indexer-src",objects);
		dmcre::load::Link(objects,"indexer");
	} catch(std::exception& e) {
		std::cout << e.what() << std::endl;
	} catch(dmcre::Error e) {
		std::cout << e.message() << std::endl;
	}
}