import * as fs from 'fs';
import * as child_process from 'child_process';
import * as process from 'process';
import * as os from 'os';

import * as defaultConfig from './config.default.mjs'
import * as localConfig from './config.mjs'

/**
 * Simple object check.
 * @param item
 * @returns {boolean}
 */
export function isObject(item) {
	return (item && typeof item === 'object' && !Array.isArray(item));
}

/**
 * Deep merge two objects.
 * @param target
 * @param ...sources
 */
export function mergeDeep(target, ...sources) {
	if (!sources.length) return target;
	const source = sources.shift();

	if (isObject(target) && isObject(source)) {
		for (const key in source) {
			if (isObject(source[key])) {
				if (!target[key]) Object.assign(target, { [key]: {} });
				mergeDeep(target[key], source[key]);
			} else {
				Object.assign(target, { [key]: source[key] });
			}
		}
	}

	return mergeDeep(target, ...sources);
}

const config = mergeDeep({}, defaultConfig, localConfig);

var compileCommandsJson = JSON.parse(fs.readFileSync('compile_commands.json'));

var EngineConfigDepth = 0;
var CxxEngineConfigHeader = `#pragma once\n#include <string>\n#include <vector>\n#include "foundation"\n\n`;

function OnEngineConfigProperty(path, key, value) {
	if (typeof (value) == 'object') {
		if (Object.prototype.toString.call(value) === '[object Array]') {
			CxxEngineConfigHeader += `${'\t'.repeat(EngineConfigDepth)}#define ${path.replaceAll('.','_')}\n`;
			CxxEngineConfigHeader += `${'\t'.repeat(EngineConfigDepth)}extern DMCRE_PUBLIC_API const std::vector<std::string> ${key} DMCRE_IF_INCLUDE_LEVEL_0(= std::initializer_list<std::string>({\n`;
			EngineConfigDepth++;
			Object.entries(value).forEach(([propertyKey, propertyValue],index,array) => {
				CxxEngineConfigHeader += `${'\t'.repeat(EngineConfigDepth)}"${propertyValue.replaceAll('\\', '\\\\')}"${index == (array.length-1) ? '' : ','}\n`;
			});
			EngineConfigDepth--;
			CxxEngineConfigHeader += `${'\t'.repeat(EngineConfigDepth)}}));\n`;
		}
		else {
			if(path != 'dmcre') {
				CxxEngineConfigHeader += `${'\t'.repeat(EngineConfigDepth)}#define ${path.replaceAll('.','_')}\n`;
			}
			CxxEngineConfigHeader += `${'\t'.repeat(EngineConfigDepth)}namespace ${key} {\n`;
			EngineConfigDepth++;
			Object.entries(value).forEach(([propertyKey, propertyValue]) => {
				OnEngineConfigProperty(path+'.'+propertyKey,propertyKey, propertyValue);
			});
			EngineConfigDepth--;
			CxxEngineConfigHeader += `${'\t'.repeat(EngineConfigDepth)}}\n`;
		}
	}
	else if (typeof (value) == 'string') {
		CxxEngineConfigHeader += `${'\t'.repeat(EngineConfigDepth)}#define ${path.replaceAll('.','_')}\n`;
		CxxEngineConfigHeader += `${'\t'.repeat(EngineConfigDepth)}extern DMCRE_PUBLIC_API const std::string ${key} DMCRE_IF_INCLUDE_LEVEL_0(= "${value.replaceAll('\\', '\\\\')}");\n`;
	}
	else if (typeof (value) == 'number') {
		CxxEngineConfigHeader += `${'\t'.repeat(EngineConfigDepth)}#define ${path.replaceAll('.','_')}\n`;
		CxxEngineConfigHeader += `${'\t'.repeat(EngineConfigDepth)}constexpr long long ${key} = ${value};\n`;
	}
	else if (typeof (value) == 'boolean') {
		CxxEngineConfigHeader += `${'\t'.repeat(EngineConfigDepth)}#define ${path.replaceAll('.','_')}\n`;
		CxxEngineConfigHeader += `${'\t'.repeat(EngineConfigDepth)}constexpr bool ${key} = ${value};\n`;
	}
}

OnEngineConfigProperty('dmcre','dmcre', {
	config: config
});

console.log(`install config: ${JSON.stringify(config.install,null,'\t')}`);
console.log(`sdk config: ${JSON.stringify(config.sdk,null,'\t')}`);
fs.cpSync(`${process.cwd()}/Headers/C++`,`${config.install.headers.cxx}`,{recursive: true});

fs.writeFileSync(`${config.install.headers.cxx}/dmcre/config`, CxxEngineConfigHeader);

function setCompileCommandsEntry(path, __args) {
	const args = [...__args];
	Object.freeze(args);

	let found = false;
	compileCommandsJson.forEach(entry => {
		if (entry.file == path) {
			found = true;
			entry.arguments = args;
		}
	})
	if (!found) {
		compileCommandsJson.push({
			file: path,
			directory: `${process.cwd()}`,
			arguments: args
		})
	}
}

function SetCompileCommandForCppHeader(path) {
	const args = [];
	args.push(config.sdk.cxx.compiler);
	if(os.platform() == 'win32') {
		args.push('-target');
		args.push('x86_64-pc-windows-msvc');
		args.push('-fuse-ld=lld');
		args.push(`-D_CRT_SECURE_NO_WARNINGS`)
	}
	if(os.platform() == 'darwin') {
		for(let dir of config.sdk.cxx.frameworkDirectories) {
			args.push(`-F${dir}`)
		}
	}
	args.push(`-std=${config.sdk.cxx.standard}`);
	args.push(`-DDMCRE_MODULE="\\\"DMCRE Runtime\\\""`);
	args.push(`-Wno-vla-cxx-extension`);
	args.push(`-DDMCRE_BUILDING_RUNTIME`)
	config.sdk.cxx.include.forEach(i => {
		args.push(`-isystem${i}`);
	});
	args.push(`-I./llvm-project/clang/include`);
	args.push(`-I./llvm-project/build/tools/clang/include`);
	args.push(`-I./llvm-project/build/include`);
	args.push(`-I./llvm-project/llvm/include`);
	args.push(`-Wno-system-headers`);
	args.push(`-x`);
	args.push(`c++`);
	args.push(`-c`);
	args.push(`${path}`);
	args.push(`-I${process.cwd()}/Headers/C++`);

	setCompileCommandsEntry(path, args);

	args.pop();
	args.push(`-I${config.install.headers.cxx}`);
}

function BuildCppFile(path) {
	const path_base64 = Buffer.from(path).toString('base64');

	const object = `build/${path_base64}.o`;

	const args = [];
	args.push(config.sdk.cxx.compiler);
	if(os.platform() == 'win32') {
		args.push('-target');
		args.push('x86_64-pc-windows-msvc');
		args.push('-fuse-ld=lld');
		args.push(`-D_CRT_SECURE_NO_WARNINGS`)
	}
	if(os.platform() == 'darwin') {
		for(let dir of config.sdk.cxx.frameworkDirectories) {
			args.push(`-F${dir}`)
		}
	}
	args.push(`-std=${config.sdk.cxx.standard}`);
	args.push(`-DDMCRE_MODULE="\\\"DMCRE Runtime\\\""`);
	args.push(`-Wno-vla-cxx-extension`);
	args.push(`-DDMCRE_BUILDING_RUNTIME`);
	config.sdk.cxx.include.forEach(i => {
		args.push(`-isystem${i}`);
	});
	args.push(`-I./llvm-project/clang/include`);
	args.push(`-I./llvm-project/build/tools/clang/include`);
	args.push(`-I./llvm-project/build/include`);
	args.push(`-I./llvm-project/llvm/include`);
	args.push(`-Wno-system-headers`);
	args.push(`-x`);
	args.push(`c++`);
	args.push(`-c`);
	args.push(`${path}`);
	args.push(`-o`);
	args.push(object);

	args.push(`-I${process.cwd()}/Headers/C++`);

	setCompileCommandsEntry(path, args);

	args.pop();
	args.push(`-I${config.install.headers.cxx}`);

	console.log(`${path}`);

	child_process.execFileSync(config.sdk.cxx.compiler, args.slice(1));

	return object;
}

function BuildObjCppFile(path) {
	const path_base64 = Buffer.from(path).toString('base64');

	const object = `build/${path_base64}.o`;

	const args = [];
	args.push(config.sdk.cxx.compiler);
	if(os.platform() == 'win32') {
		args.push('-target');
		args.push('x86_64-pc-windows-msvc');
		args.push('-fuse-ld=lld');
		args.push(`-D_CRT_SECURE_NO_WARNINGS`);
	}
	if(os.platform() == 'darwin') {
		for(let dir of config.sdk.cxx.frameworkDirectories) {
			args.push(`-F${dir}`)
		}
	}
	args.push(`-std=${config.sdk.cxx.standard}`);
	args.push(`-DDMCRE_MODULE="\\\"DMCRE Runtime\\\""`);
	args.push(`-Wno-vla-cxx-extension`);
	args.push(`-Wno-deprecated-declarations`);
	args.push(`-Wno-unguarded-availability-new`);
	args.push(`-Wno-availability`);
	args.push(`-Wno-deprecated-anon-enum-enum-conversion`);
	args.push(`-DDMCRE_BUILDING_RUNTIME`);
	config.sdk.cxx.include.forEach(i => {
		args.push(`-isystem${i}`);
	});
	args.push(`-Wno-system-headers`);
	args.push(`-x`);
	args.push(`objective-c++`);
	args.push(`-c`);
	args.push(`${path}`);
	args.push(`-o`);
	args.push(object);

	args.push(`-I${process.cwd()}/Headers/C++`);

	setCompileCommandsEntry(path, args);

	args.pop();
	args.push(`-I${config.install.headers.cxx}`);

	console.log(`${path}`);

	child_process.execFileSync(config.sdk.cxx.compiler, args.slice(1));

	return object;
}

function BuildCFile(path) {
	const path_base64 = Buffer.from(path).toString('base64');

	const object = `build/${path_base64}.o`;

	const args = [];
	args.push(config.sdk.c.compiler);
	if(os.platform() == 'win32') {
		args.push('-target');
		args.push('x86_64-pc-windows-msvc');
		args.push('-fuse-ld=lld');
		args.push(`-D_CRT_SECURE_NO_WARNINGS`)
	}
	config.sdk.c.include.forEach(i => {
		args.push(`-isystem${i}`);
	});
	args.push(`-Wno-everything`)
	args.push(`-std=c23`);
	args.push(`-x`)
	args.push(`c`)
	args.push(`-c`);
	args.push(`${path}`);
	args.push(`-o`);
	args.push(object);

	setCompileCommandsEntry(path, args);

	console.log(`${path}`);

	child_process.execFileSync(config.sdk.cxx.compiler, args.slice(1));

	return object;
}

function BuildDir(path) {
	const objects = [];
	fs.readdirSync(path).forEach(entry => {
		const stat = fs.statSync(path + "/" + entry);
		if (stat.isFile()) {
			if (entry.endsWith('.cpp')) {
				objects.push(BuildCppFile(path + "/" + entry));
			}
			else if (entry.endsWith('.c')) {
				objects.push(BuildCFile(path + "/" + entry));
			}
			else if (entry.endsWith('.mm')) {
				objects.push(BuildObjCppFile(path + "/" + entry));
			}
		}
		else if (stat.isDirectory()) {
			objects.push(...BuildDir(path + "/" + entry));
		}
	})
	return objects;
}

fs.readdirSync('./Headers/C++',{"recursive": true}).forEach(entry => {
	const stat = fs.statSync("./Headers/C++/" + entry);
	if (stat.isFile()) {
		SetCompileCommandForCppHeader("./Headers/C++/" + entry);
	}
})

try {
	let runtimeObjects = BuildDir("./Runtime");
	runtimeObjects.push(BuildCppFile(`${config.install.headers.cxx}/dmcre/config`));
	runtimeObjects.push(BuildCppFile(`${config.install.headers.cxx}/dmcre/load`));

	const linkArgs = [];

	if(os.platform() == 'win32') {
		linkArgs.push(`-L${config.sdk.windows.lib.um}`);
		linkArgs.push('-lbcrypt');
		linkArgs.push('-target');
		linkArgs.push('x86_64-pc-windows-msvc');
		linkArgs.push('-fuse-ld=lld');
	}

	if(os.platform() == 'darwin') {
		for(let i of config.sdk.cxx.frameworkDirectories) {
			linkArgs.push(`-F${i}`)
		}
		linkArgs.push(`-framework`);
		linkArgs.push(`AppKit`);
		linkArgs.push(`-framework`);
		linkArgs.push(`Network`);
	}

	for(let dir of config.sdk.librarySearchPaths) {
		linkArgs.push(`-L${dir}`);
	}

	linkArgs.push(`-Wl,-rpath,./llvm-project/build/lib`);
	linkArgs.push(`-L./llvm-project/build/lib`);
	linkArgs.push(`-lclang-cpp`);
	linkArgs.push(`-lLLVM`);

	linkArgs.push('-shared');

	linkArgs.push(...runtimeObjects);

	linkArgs.push('-o');
	linkArgs.push(`${config.install.runtimeDll}`);

	child_process.execFileSync(config.sdk.cxx.compiler, linkArgs);
} catch (e) {
	console.error(e);
}

fs.writeFileSync('compile_commands.json', JSON.stringify(compileCommandsJson, null, '\t'));
