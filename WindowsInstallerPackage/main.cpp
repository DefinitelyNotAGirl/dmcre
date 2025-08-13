/**
 * @file main.cpp
 * @brief I'm sorry
 */

#include <windows.h>
#include <string>
#include <iostream>

void Install();

HWND StatusText = nullptr;

void SetStatusText(const std::string& text) {
    SetWindowTextW(StatusText, std::wstring(text.begin(), text.end()).c_str());
}

LRESULT CALLBACK WindowProc(HWND hwnd, UINT uMsg, WPARAM wParam, LPARAM lParam) {
    switch (uMsg) {
    case WM_COMMAND:
        if (LOWORD(wParam) == 1) { // Button clicked
            SetStatusText("Installing...");
            Install();
        }
        break;
    case WM_DESTROY:
        PostQuitMessage(0);
        return 0;
    }
    return DefWindowProcW(hwnd, uMsg, wParam, lParam);
}

int WINAPI wWinMain(HINSTANCE hInstance, HINSTANCE, PWSTR, int nCmdShow) {
    std::cout << "DMCRE Installer started" << std::endl;
    const wchar_t CLASS_NAME[] = L"ExampleWindowClass";

    WNDCLASSW wc = {};
    wc.lpfnWndProc   = WindowProc;
    wc.hInstance     = hInstance;
    wc.lpszClassName = CLASS_NAME;

    RegisterClassW(&wc);

    HWND hwnd = CreateWindowExW(
        0,
        CLASS_NAME,
        L"DMCRE Installer",
        WS_OVERLAPPED | WS_CAPTION | WS_SYSMENU,
        CW_USEDEFAULT, CW_USEDEFAULT, 400, 200,
        nullptr,
        nullptr,
        hInstance,
        nullptr
    );

    if (hwnd == nullptr) {
        return 0;
    }

    // Create static text (larger, more modern font)
    HWND hText1 = CreateWindowExW(
        0, L"STATIC", L"Welcome to DMCRE Installer",
        WS_CHILD | WS_VISIBLE,
        20, 20, 340, 30,
        hwnd, nullptr, hInstance, nullptr
    );
    StatusText = CreateWindowExW(
        0, L"STATIC", L"Clicking \"Install\" will install DMCRE to %USERPROFILE%\\.dmcre",
        WS_CHILD | WS_VISIBLE,
        20, 55, 340, 20,
        hwnd, nullptr, hInstance, nullptr
    );

    // Create button
    HWND hButton = CreateWindowExW(
        0, L"BUTTON", L"Install",
        WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON,
        20, 90, 120, 35,
        hwnd, (HMENU)1, hInstance, nullptr
    );

    // Set fonts for a modern look
    HFONT hFontTitle = CreateFontW(
        20, 0, 0, 0, FW_BOLD, FALSE, FALSE, FALSE,
        DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS,
        CLEARTYPE_QUALITY, DEFAULT_PITCH | FF_DONTCARE, L"Segoe UI"
    );
    HFONT hFontText = CreateFontW(
        14, 0, 0, 0, FW_NORMAL, FALSE, FALSE, FALSE,
        DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS,
        CLEARTYPE_QUALITY, DEFAULT_PITCH | FF_DONTCARE, L"Segoe UI"
    );
    HFONT hFontButton = CreateFontW(
        16, 0, 0, 0, FW_SEMIBOLD, FALSE, FALSE, FALSE,
        DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS,
        CLEARTYPE_QUALITY, DEFAULT_PITCH | FF_DONTCARE, L"Segoe UI"
    );

    SendMessageW(hText1, WM_SETFONT, (WPARAM)hFontTitle, TRUE);
    SendMessageW(StatusText, WM_SETFONT, (WPARAM)hFontText, TRUE);
    SendMessageW(hButton, WM_SETFONT, (WPARAM)hFontButton, TRUE);

    ShowWindow(hwnd, nCmdShow);

    MSG msg = {};
    while (GetMessageW(&msg, nullptr, 0, 0)) {
        TranslateMessage(&msg);
        DispatchMessageW(&msg);
    }
    return 0;
}
