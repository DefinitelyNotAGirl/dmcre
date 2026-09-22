import * as fs from 'fs';
import * as child_process from 'child_process';
import * as process from 'process';
import * as os from 'os';

var compileCommandsJson = JSON.parse(fs.readFileSync('compile_commands.json'));

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
			directory: process.cwd(),
			arguments: args
		})
	}
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

const cliObjects = BuildDir('./CLI');

console.log('Linking cli executable');

const linkArgs = [];

if(os.platform() == 'win32') {
	linkArgs.push(`-L${config.sdk.windows.lib.um}`);
	linkArgs.push('-lbcrypt');
	linkArgs.push('-target');
	linkArgs.push('x86_64-pc-windows-msvc');
	linkArgs.push('-fuse-ld=lld');
}

for(let dir of config.sdk.librarySearchPaths) {
	linkArgs.push(`-L${dir}`);
}

linkArgs.push(`${config.install.runtimeDll}`)
linkArgs.push(...cliObjects);

linkArgs.push(`-Wl,-rpath,./llvm-project/build/lib`);
linkArgs.push(`-L./llvm-project/build/lib`);
linkArgs.push(`-lLLVM`);

linkArgs.push('-o');
linkArgs.push(`${config.install.cliExe}`);

child_process.execFileSync(config.sdk.cxx.compiler, linkArgs);

fs.writeFileSync('compile_commands.json',JSON.stringify(compileCommandsJson,null,'\t'));
