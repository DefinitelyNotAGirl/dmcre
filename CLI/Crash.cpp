#include <csignal>

void CleanRuntimeDirectory();

void CrashHandler(int sig) {
	// Restore default handler before doing anything else
	std::signal(sig, SIG_DFL);
	
	//delete the runtime directory
	CleanRuntimeDirectory();

	//re-raise signal
	raise(sig);
}
