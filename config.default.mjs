import * as os from "os";

import * as __version from './version.mjs'

export const version = __version.version;

var installRoot = "";
if(os.platform() == 'win32') {
	installRoot = `${process.env.USERPROFILE}/dmcre_${version}`;
}
else if(os.platform() == 'darwin') {
	installRoot = `${process.env.HOME}/dmcre_${version}`;
}

export const install = {
	root: installRoot,
	headers: {
		cxx: `${installRoot}/Headers/C++`
	},
	runtimeDylib: `${installRoot}/runtime${(os.platform() == 'win32') ? '.lib' : '_this_file_should_not_exist'}`,
    runtimeDll: `${installRoot}/runtime${(os.platform() == 'win32') ? '.dll' : (os.platform() == 'darwin' ? '.dylib' : '.so')}`,
	cliExe: `${installRoot}/dmcre${(os.platform() == 'win32') ? '.exe' : ''}`
}

export const target = {
	platform: os.platform(),
}

export const sdk = {
};

if(os.platform() == 'darwin') {
	const toolchainRoot = `/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain`;
	const sdkRoot = `/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX26.sdk`;

	target.MacOSX = {};
	target.MacOSX.version = '26.2';

	sdk.librarySearchPaths = [
		`${sdkRoot}/usr/lib`
	]

	sdk.cxx = {};
	sdk.cxx.compiler = `${toolchainRoot}/usr/bin/clang++`;
	sdk.cxx.standard = `c++23`;
	sdk.cxx.include = [
		`${sdkRoot}/usr/include/c++/v1`,
		`${sdkRoot}/usr/include`
	];
	sdk.cxx.frameworkDirectories = [
		`${sdkRoot}/System/Library/Frameworks`
	]

	sdk.objcxx = {};
	sdk.objcxx.compiler = `${toolchainRoot}/usr/bin/clang++`;
	sdk.objcxx.standard = `c++23`;
	sdk.objcxx.include = [
		`${sdkRoot}/usr/include/c++/v1`,
		`${sdkRoot}/usr/include`
	];
	sdk.objcxx.frameworkDirectories = [
		`${sdkRoot}/System/Library/Frameworks`
	]

	sdk.c = {};
	sdk.c.compiler = `${toolchainRoot}/usr/bin/clang`;
	sdk.c.include = [
		`${sdkRoot}/usr/include`
	];

	sdk.metal = {};
	sdk.metal.compiler = `${toolchainRoot}/usr/bin/metal`;

	sdk.swift = {};
	sdk.swift.compiler = `${toolchainRoot}/usr/bin/swift-frontend`;

	sdk.AMD64 = {};
	sdk.AMD64.compiler = `${toolchainRoot}/usr/bin/as`;

	sdk.ARM = {};
	sdk.ARM.compiler = `${toolchainRoot}/usr/bin/as`;
}
