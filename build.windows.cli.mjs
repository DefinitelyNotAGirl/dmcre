import * as fs from 'fs';
import * as child_process from 'child_process';
import * as process from 'process';

var CppIncludeDirectories = [];

var compileCommandsJson = JSON.parse(fs.readFileSync('compile_commands.json'));

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

console.log(`install config: ${JSON.stringify(config.install,null,'\t')}`);

function setCompileCommandsEntry(path,args) {
	let found = false;
	compileCommandsJson.forEach(entry => {
		if(entry.file == path) {
			found = true;
			entry.arguments = args;
		}
	})
	if(!found) {
		compileCommandsJson.push({
			file: path,
			directory: PROJECT_ROOT,
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
	args.push(`-std=c++23`);
	args.push(`-DDMCRE_MODULE="\\\"DMCRE Runtime\\\""`);
	args.push(`-Wno-vla-cxx-extension`);
	args.push(`-D_CRT_SECURE_NO_WARNINGS`)
	args.push(`-DBUNDLE_ID="dmcre"`)
    config.sdk.cxx.include.forEach(i => {
		args.push(`-I${i}`);
	});
	CppIncludeDirectories.forEach(i => {
		args.push(`-I${i}`);
	});
	args.push(`-c`);
	args.push(`${path}`);
	args.push(`-o`);
	args.push(object);

	setCompileCommandsEntry(path,args);

	console.log(`${path}`);
	
	child_process.execFileSync(config.sdk.cxx.compiler, args.slice(1));

	return object;
}

function BuildDir(path) {
	const objects = [];
	fs.readdirSync(path).forEach(entry => {
		const stat = fs.statSync(path+"/"+entry);
		if(stat.isFile()) {
			if(entry.endsWith('.cpp')) {
				objects.push(BuildCppFile(path+"/"+entry));
			}
			else if(entry.endsWith('.c')) {
				objects.push(BuildCFile(path+"/"+entry));
			}
		}
		else if(stat.isDirectory()) {
			BuildDir(path + "/" + entry);
		}
	})
	return objects;
}

CppIncludeDirectories.push(`${config.install.headers.cxx}`);

const cliObjects = BuildDir('./CLI');

console.log('Linking dmcre.exe');
const linkArgs = [
	`-L${config.sdk.windows.lib.um}`,
	'-lbcrypt',
	'-target',
	'x86_64-pc-windows-msvc',
	'-fuse-ld=lld',
	`${config.install.runtimeDylib}`,
	...cliObjects,
	'-o',
	`${config.install.cliExe}`
];
child_process.execFileSync(config.sdk.cxx.compiler, linkArgs, { stdio: 'inherit' });

fs.writeFileSync('compile_commands.json',JSON.stringify(compileCommandsJson,null,'\t'));
