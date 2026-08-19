const WindowsSDKRoot = `C:\\Dev\\Windows_10_0_28000_2526`;

export const sdk = {
	cxx: {
		compiler: `C:\\Dev\\LLVM_22_1_8\\bin\\clang++.exe`,
		standard: `c++23`,
		include: [
            `${WindowsSDKRoot}\\Include\\10.0.28000.0\\ucrt`,
			`${WindowsSDKRoot}\\Include\\10.0.28000.0\\shared`,
			`${WindowsSDKRoot}\\Include\\10.0.28000.0\\um`,
			`${WindowsSDKRoot}\\Include\\10.0.28000.0\\winrt`,
			`${WindowsSDKRoot}\\Include\\10.0.28000.0\\cppwinrt`
		]
	},
	windows: {
		lib: {
			um: `${WindowsSDKRoot}\\Lib\\10.0.28000.0\\um\\x64`
		}
	}
}
