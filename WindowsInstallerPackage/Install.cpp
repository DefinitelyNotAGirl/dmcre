#include <string>
#include <vector>
#include <windows.h>
#include <fstream>
#include <filesystem>
#include "data.hpp"
#include <iostream>

extern std::vector<std::pair<std::string, DataBuffer<const uint8_t*>>> EmbeddedFiles;
extern HANDLE hConsole;

bool UnpackFiles() {
	std::cout << "\n\nUnpacking files..." << std::endl;
	for(const auto& file : EmbeddedFiles) {
		std::string filePath = file.first;
		if(filePath[0] == '\xFF') {
			filePath = std::string(getenv("USERPROFILE")) + filePath.substr(1);
		}
		auto fileData = file.second;


		std::cout << "Installing " << filePath << "...";

		// Create directories as needed
		std::filesystem::create_directories(std::filesystem::path(filePath).parent_path());

		// Write file data
		std::ofstream outFile(filePath, std::ios::binary);
		if (outFile.is_open()) {
			outFile.write(reinterpret_cast<const char*>(fileData.data), fileData.size);
			outFile.close();
			SetConsoleTextAttribute(hConsole, FOREGROUND_INTENSITY | FOREGROUND_GREEN);
			std::cout << "\b\b\b [OK]" << std::endl;
			SetConsoleTextAttribute(hConsole, FOREGROUND_INTENSITY | FOREGROUND_BLUE | FOREGROUND_GREEN | FOREGROUND_RED);
		} else {
			SetConsoleTextAttribute(hConsole, FOREGROUND_INTENSITY | FOREGROUND_RED);
			std::cout << "\b\b\b [ERROR]" << std::endl;
			std::cout << "Failed to open " << filePath << " for writing." <<  std::endl;
			std::cout << "Installation aborted." << std::endl;
			SetConsoleTextAttribute(hConsole, FOREGROUND_INTENSITY | FOREGROUND_BLUE | FOREGROUND_GREEN | FOREGROUND_RED);
			return false;
		}
	}
	return true;
}

bool UpdatePath() {
	std::cout << "\n\nUpdating PATH environment variable...";
	std::wstring binPath = L"%USERPROFILE%\\.dmcre\\bin";
	// Get current user PATH
	wchar_t pathValue[32767];
	DWORD len = GetEnvironmentVariableW(L"PATH", pathValue, 32767);

	std::wstring newPath;
	if (len > 0 && wcsstr(pathValue, binPath.c_str()) == nullptr) {
		newPath = std::wstring(pathValue) + L";" + binPath;
	} else if (len == 0) {
		newPath = binPath;
	} else {
		newPath = pathValue; // Already present
	}

	// Set user environment variable permanently
	HKEY hKey;
	if (RegOpenKeyExW(HKEY_CURRENT_USER, L"Environment", 0, KEY_SET_VALUE, &hKey) == ERROR_SUCCESS) {
		RegSetValueExW(hKey, L"PATH", 0, REG_EXPAND_SZ,
			reinterpret_cast<const BYTE*>(newPath.c_str()),
			static_cast<DWORD>((newPath.size() + 1) * sizeof(wchar_t)));
		RegCloseKey(hKey);
	}

	SetConsoleTextAttribute(hConsole, FOREGROUND_INTENSITY | FOREGROUND_GREEN);
	std::cout << "\b\b\b [OK]" << std::endl;
	SetConsoleTextAttribute(hConsole, FOREGROUND_INTENSITY | FOREGROUND_BLUE | FOREGROUND_GREEN | FOREGROUND_RED);

	return true;
}

bool CheckDependencies() {
	std::cout << "\n\nChecking dependencies..." << std::endl;

	//
	// clang
	//
	while(system("clang++ --version >nul 2>&1") != 0) {
		SetConsoleTextAttribute(hConsole, FOREGROUND_INTENSITY | FOREGROUND_RED);
		std::cout << "clang++ not found in PATH. Please install LLVM and ensure clang++ is accessible from the command line." << std::endl;
		std::cout << "Installation aborted." << std::endl;
		SetConsoleTextAttribute(hConsole, FOREGROUND_INTENSITY | FOREGROUND_BLUE | FOREGROUND_GREEN | FOREGROUND_RED);
		return false;
	}
	std::cout << "Clang";
	SetConsoleTextAttribute(hConsole, FOREGROUND_INTENSITY | FOREGROUND_GREEN);
	std::cout << " [OK]" << std::endl;
	SetConsoleTextAttribute(hConsole, FOREGROUND_INTENSITY | FOREGROUND_BLUE | FOREGROUND_GREEN | FOREGROUND_RED);

	return true;
}

void Install() {
	if(!CheckDependencies())return;
	if(!UnpackFiles())return;
	if(!UpdatePath())return;

	MessageBoxW(nullptr, L"Installation complete.", L"DMCRE Installer", MB_OK | MB_ICONINFORMATION);
	SetConsoleTextAttribute(hConsole, FOREGROUND_INTENSITY | FOREGROUND_GREEN);
	std::cout << "\n\nInstallation Complete" << std::endl;
	SetConsoleTextAttribute(hConsole, FOREGROUND_INTENSITY | FOREGROUND_BLUE | FOREGROUND_GREEN | FOREGROUND_RED);
}