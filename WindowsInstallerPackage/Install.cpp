#include <string>
#include <vector>
#include <windows.h>
#include <fstream>
#include <filesystem>
#include "data.hpp"

void SetStatusText(const std::string& text);

extern std::vector<std::pair<std::string, DataBuffer<const uint8_t*>>> EmbeddedFiles;

void Install() {
    for(const auto& file : EmbeddedFiles) {
        std::string filePath = file.first;
        if(filePath[0] == '\xFF') {
            filePath = std::string(getenv("USERPROFILE")) + filePath.substr(1);
        }
        auto fileData = file.second;

        SetStatusText("Installing " + filePath + "...");

        // Create directories as needed
        std::filesystem::create_directories(std::filesystem::path(filePath).parent_path());

        // Write file data
        std::ofstream outFile(filePath, std::ios::binary);
        if (outFile.is_open()) {
            outFile.write(reinterpret_cast<const char*>(fileData.data), fileData.size);
            outFile.close();
        } else {
            SetStatusText("Failed to write " + filePath);
        }
    }

    // modify the PATH environment variable
    {
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
    }

    MessageBoxW(nullptr, L"Installation complete.", L"DMCRE Installer", MB_OK | MB_ICONINFORMATION);
    SetStatusText("Installation complete.");

    // Exit the application
    PostQuitMessage(0);
}