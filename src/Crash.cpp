#include "private.hpp"

void CrashHandler(int sig) {
	// Restore default handler before doing anything else
	std::signal(sig, SIG_DFL);
	
	//delete the runtime directory, its content is largely worthless anyway
	CleanRuntimeDirectory();
	//re-raise signal
	raise(sig);
}
