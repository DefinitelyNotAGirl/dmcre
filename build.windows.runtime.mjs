import * as fs from 'fs';
import * as child_process from 'child_process';
import * as process from 'process';

import * as defaultConfig from './config.windows.default.mjs'
import * as localConfig from './config.windows.mjs'

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

var CppIncludeDirectories = [];

var compileCommandsJson = JSON.parse(fs.readFileSync('compile_commands.json'));

var EngineConfigDepth = 0;
var CxxEngineConfigHeader = `#pragma once\n#include <string>\n#include <vector>\n#include "foundation"\n\n`;

function OnEngineConfigProperty(key, value) {
	if (typeof (value) == 'object') {
		if (Object.prototype.toString.call(value) === '[object Array]') {
			CxxEngineConfigHeader += `${'\t'.repeat(EngineConfigDepth)}DMCRE_IF_INCLUDE_LEVEL_NOT_0(extern) DMCRE_PUBLIC_API const std::vector<std::string> ${key} DMCRE_IF_INCLUDE_LEVEL_0(= std::initializer_list<std::string>({\n`;
			EngineConfigDepth++;
			Object.entries(value).forEach(([key, value],index,array) => {
				CxxEngineConfigHeader += `${'\t'.repeat(EngineConfigDepth)}"${value.replaceAll('\\', '\\\\')}"${index == (array.length-1) ? '' : ','}\n`;
			});
			EngineConfigDepth--;
			CxxEngineConfigHeader += `${'\t'.repeat(EngineConfigDepth)}}));\n`;
		}
		else {
			CxxEngineConfigHeader += `${'\t'.repeat(EngineConfigDepth)}namespace ${key} {\n`;
			EngineConfigDepth++;
			Object.entries(value).forEach(([key, value]) => {
				OnEngineConfigProperty(key, value);
			});
			EngineConfigDepth--;
			CxxEngineConfigHeader += `${'\t'.repeat(EngineConfigDepth)}}\n`;
		}
	}
	else if (typeof (value) == 'string') {
		CxxEngineConfigHeader += `${'\t'.repeat(EngineConfigDepth)}DMCRE_IF_INCLUDE_LEVEL_NOT_0(extern) DMCRE_PUBLIC_API const std::string ${key} DMCRE_IF_INCLUDE_LEVEL_0(= "${value.replaceAll('\\', '\\\\')}");\n`;
	}
	else if (typeof (value) == 'number') {
		CxxEngineConfigHeader += `${'\t'.repeat(EngineConfigDepth)}constexpr long long ${key} = ${value};\n`;
	}
	else if (typeof (value) == 'boolean') {
		CxxEngineConfigHeader += `${'\t'.repeat(EngineConfigDepth)}constexpr bool ${key} = ${value};\n`;
	}
}

OnEngineConfigProperty('dmcre', {
	config: config
});


console.log(`install config: ${JSON.stringify(config.install,null,'\t')}`);
fs.cpSync(`${process.cwd()}\\Headers\\C++`,`${config.install.headers.cxx}`,{recursive: true});

fs.writeFileSync(`${config.install.headers.cxx}\\dmcre\\config`, CxxEngineConfigHeader);

function setCompileCommandsEntry(path, args) {
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

function BuildCppFile(path) {
	const path_base64 = Buffer.from(path).toString('base64');

	const object = `build/windows/amd64/${path_base64}.o`;

	const args = [];
	args.push(config.sdk.cxx.compiler);
	args.push(`-target`);
	args.push(`x86_64-pc-windows-msvc`);
	args.push(`-std=${config.sdk.cxx.standard}`);
	args.push(`-DDMCRE_MODULE="\\\"DMCRE Runtime\\\""`);
	args.push(`-Wno-vla-cxx-extension`);
	args.push(`-D_CRT_SECURE_NO_WARNINGS`)
	args.push(`-DDMCRE_BUILDING_RUNTIME`)
	config.sdk.cxx.include.forEach(i => {
		args.push(`-isystem${i}`);
	});
	CppIncludeDirectories.forEach(i => {
		args.push(`-I${i}`);
	});
	args.push(`-Wno-system-headers`);
	args.push(`-x`);
	args.push(`c++`);
	args.push(`-c`);
	args.push(`${path}`);
	args.push(`-o`);
	args.push(object);

	setCompileCommandsEntry(path, args);

	console.log(`${path}`);

	child_process.execFileSync(config.sdk.cxx.compiler, args.slice(1));

	return object;
}

function BuildCFile(path) {
	const path_base64 = Buffer.from(path).toString('base64');

	const object = `build/windows/amd64/${path_base64}.o`;

	const args = [];
	args.push(config.sdk.cxx.compiler);
	args.push(`-target`);
	args.push(`x86_64-pc-windows-msvc`);
	args.push(`-std=c23`);
	args.push(`-x`)
	args.push(`c`)
	args.push(`-D_CRT_SECURE_NO_WARNINGS`)
	CppIncludeDirectories.forEach(i => {
		args.push(`-I${i}`);
	});
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
		}
		else if (stat.isDirectory()) {
			BuildDir(path + "/" + entry);
		}
	})
	return objects;
}

try {
	CppIncludeDirectories.push(`${config.install.headers.cxx}`);

	let runtimeObjects = BuildDir("./Runtime");
	runtimeObjects.push(BuildCppFile(`${config.install.headers.cxx}\\dmcre\\config`));
	runtimeObjects.push(BuildCppFile(`${config.install.headers.cxx}\\dmcre\\load`));

	const linkArgs = [
		`-L${config.sdk.windows.lib.um}`,
		'-lbcrypt',
		'-target',
		'x86_64-pc-windows-msvc',
		'-fuse-ld=lld',
		'-shared',
		...runtimeObjects,
		'-o',
		`${config.install.runtimeDll}`
	];
	child_process.execFileSync(config.sdk.cxx.compiler, linkArgs);
} catch (e) {
	console.error(e);
}

fs.writeFileSync('compile_commands.json', JSON.stringify(compileCommandsJson, null, '\t'));
