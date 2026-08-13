#pragma once
#include <cstring>
#include <stdexcept>
#include <string>
#include <fstream>
#include <sstream>
#include <cstdlib>
#include <cstdio>
#include <unistd.h>

namespace dmcre {
	static std::string fetch_url(const std::string& url) {
    	// Generate a temporary file path
    	char tmpPath[] = 
		#ifdef _WIN32
		        "curltmpXXXXXX.txt";
		    if (_mktemp(tmpPath) == nullptr)
		        throw std::runtime_error("Failed to create temporary filename");
		#else
		        "/tmp/curltmpXXXXXX";
		    int fd = mkstemp(tmpPath);
		    if (fd == -1)
		        throw std::runtime_error("Failed to create temporary file");
		    close(fd);
		#endif
	    // Form the command
	    std::string command = "curl --silent --fail --location ";
	    command += "\"" + url + "\" -o \"" + tmpPath + "\"";

	    // Execute the curl command
	    int code = std::system(command.c_str());
	    if (code != 0) {
	        std::remove(tmpPath);
	        throw std::runtime_error("curl failed with code " + std::to_string(code));
	    }
	    // Read the result
	    std::ifstream in(tmpPath, std::ios::binary);
	    if (!in)
	        throw std::runtime_error("Failed to open temporary file");
	    std::ostringstream ss;
	    ss << in.rdbuf();
	    in.close();
	    std::remove(tmpPath);
	    return ss.str();
	}

	static void fetch_url_bin(const std::string& url,void** data,uint64_t* size) {
    	// Generate a temporary file path
    	char tmpPath[] = 
		#ifdef _WIN32
		        "curltmpXXXXXX.txt";
		    if (_mktemp(tmpPath) == nullptr)
		        throw std::runtime_error("Failed to create temporary filename");
		#else
		        "/tmp/curltmpXXXXXX";
		    int fd = mkstemp(tmpPath);
		    if (fd == -1)
		        throw std::runtime_error("Failed to create temporary file");
		    close(fd);
		#endif
	    // Form the command
	    std::string command = "curl --silent --fail --location ";
	    command += "\"" + url + "\" -o \"" + tmpPath + "\"";

	    // Execute the curl command
	    int code = std::system(command.c_str());
	    if (code != 0) {
	        std::remove(tmpPath);
	        throw std::runtime_error("curl failed with code " + std::to_string(code));
	    }
	    // Read the result
		//system(("shasum -a 256 "+std::string(tmpPath)).c_str());
	    FILE* in = fopen(tmpPath,"rb");
		if (!in)
	        throw std::runtime_error("Failed to open temporary file");
		fseek(in,0,SEEK_END);
		*size = ftell(in);
		*data = malloc(*size);
		fseek(in,0,SEEK_SET);
		if(fread(*data,*size,1,in) != 1) {
			throw std::runtime_error("fread failed: "+std::string(strerror(errno)));
		}
		fclose(in);
	    std::remove(tmpPath);
	}
}