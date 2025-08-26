/**
 * @file main.cpp
 * @brief I'm sorry
 */

#include <windows.h>
#include <string>
#include <iostream>

void Install();

std::string LicenseText = std::string("")
	+"Copyright (c) 2025 Lilith Nitschke-Höfer"
	+"\n\n"
	+"Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:"
	+"\n\n"
	+"The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software."
	+"\n\n"
	+"THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.";

HANDLE hConsole;

int main() {
	hConsole = GetStdHandle(STD_OUTPUT_HANDLE);

	SetConsoleTextAttribute(hConsole, FOREGROUND_INTENSITY | FOREGROUND_GREEN | FOREGROUND_BLUE);
	std::cout << "\n==============================================================\n" << std::endl;
	std::cout << LicenseText << std::endl;
	std::cout << "\n==============================================================\n" << std::endl;
	SetConsoleTextAttribute(hConsole, FOREGROUND_INTENSITY | FOREGROUND_BLUE | FOREGROUND_GREEN | FOREGROUND_RED);

	std::cout << "\n\n\nBy installing this software you agree to the terms and conditions of the license agreement." << std::endl;
	std::cout << "\nInstall software? (y/n): ";

	auto res = std::cin.get();
	std::cin.get();
	std::cout << "\n\n";
	if (res == 'y' || res == 'Y') {
		SetConsoleTextAttribute(hConsole, FOREGROUND_INTENSITY | FOREGROUND_GREEN);
		std::cout << "Installing..." << std::endl;
		SetConsoleTextAttribute(hConsole, FOREGROUND_INTENSITY | FOREGROUND_BLUE | FOREGROUND_GREEN | FOREGROUND_RED);
		Install();
	} else {
		SetConsoleTextAttribute(hConsole, FOREGROUND_INTENSITY | FOREGROUND_RED);
		std::cout << "Aborting installation." << std::endl;
		SetConsoleTextAttribute(hConsole, FOREGROUND_INTENSITY | FOREGROUND_BLUE | FOREGROUND_GREEN | FOREGROUND_RED);
	}

	std::cout << "Press Enter to exit." << std::endl;
	std::cin.get();
	return 0;
}
