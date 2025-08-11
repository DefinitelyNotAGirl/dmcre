#include <string>
#include <csignal>
#include <cstdio>
#include <cstdlib>
#include <stdexcept>
#include <string>
#include <unistd.h>
#include <vector>

#include <dmcre/fs.hpp>
#include <dmcre/Module.hpp>

void CrashHandler(int sig);
std::string ResolveModulePath(const std::string& specifier);
dmcre::Module& LoadModule(const std::string& path,void* in);

/**
 * @Brief deletes the active runtime directory
 */
void CleanRuntimeDirectory();

/**
 * @Brief runtime directory base path
 */
extern path RuntimeDir;

namespace init {
	/**
	 * @Brief initializes the runtime directory
	 */
	void fs();
}

class LoadedFile {
public:
	std::string digest;
	void* dll;
	dmcre::Module& module;
	
	LoadedFile(
			   std::string digest,
			   void* dll,
			   dmcre::Module& module
			   ): module(module),digest(digest),dll(dll) {}
};
extern std::vector<LoadedFile> LoadedFiles;

extern dmcre::Core core;
