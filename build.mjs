import * as fs from 'fs';
import * as child_process from 'child_process'
import * as os from 'os';
import * as path from 'path';

import * as __version from './version.mjs'
export const version = __version.version;
const isDevelopmentVersion = __version.isDevelopmentVersion;

var target = 'all';

for(let i of process.argv) {
	if(i.startsWith('target=')) {
		target = i.split('target=')[1];
	}
}

var rebuild = false;
for(let i of process.argv) {
	if(i == 'rebuild') {
		rebuild = true;
	}
}

var install = (() => {
	if(os.platform() == 'win32') {
		return `${process.env.USERPROFILE}/dmcre_${isDevelopmentVersion ? 'development' : version}`;
	}
	else {
		return `${process.env.HOME}/dmcre_${isDevelopmentVersion ? 'development' : version}`;
	}
})();

console.log(`target:`,target);
console.log(`install:`,install);

var CxxMacros = {};

var compileCommandsJson = JSON.parse(fs.readFileSync('compile_commands.json'));

var CxxIncludeDirectories = [];

function AddCxxIncludeDirectory(dir) {
	CxxIncludeDirectories.push(dir);
}

function RemoveCxxIncludeDirectory(dir) {
	CxxIncludeDirectories = CxxIncludeDirectories.filter((v) => v != dir);
}

var Libraries = [];

function AddLibrary(lib) {
	Libraries.push(lib);
}

function RemoveLibrary(lib) {
	Libraries = Libraries.filter((v) => v != lib);
}

var LibraryDirectories = [];

function AddLibraryDirectory(dir) {
	LibraryDirectories.push(dir);
}

function RemoveLibraryDirectory(dir) {
	LibraryDirectories = LibraryDirectories.filter((v) => v != dir);
}

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
	args.push(HostCxxCompiler);
	if(os.platform() == 'win32') {
		//args.push('-target');
		//args.push('x86_64-pc-windows-msvc');
		//args.push('-fuse-ld=lld');
		//args.push('-fms-runtime-lib=dll');
		args.push(`-D_CRT_SECURE_NO_WARNINGS`)
		args.push(`-D_DEBUG`)
		args.push(`-D_ITERATOR_DEBUG_LEVEL=2`)
	}
	args.push(`-std=${HostCxxStandard}`);
	args.push(`-DDMCRE_MODULE="\\\"DMCRE Runtime\\\""`);
	args.push(`-DWIN32_LEAN_AND_MEAN`);
	args.push(`-Wno-vla-cxx-extension`);
	args.push(`-DDMCRE_BUILDING_RUNTIME`);
	HostCxxSystemIncludes.forEach(i => {
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
}

function BuildCppFile(path) {
	console.log(`[C++] ${path}`);

	const path_base64 = Buffer.from(path).toString('base64');

	const object = `build/${path_base64}.o`;

	if(fs.existsSync(object)) {
		const path_stat = fs.statSync(path);
		const object_stat = fs.statSync(object);
		
		if((path_stat.mtime < object_stat.mtime) && (rebuild == false)) {
			return object;
		}
	}

	const args = [];
	args.push(`clang++`);
	args.push(`-DWIN32_LEAN_AND_MEAN`);
	args.push(`-DNOMINMAX`);
	args.push(`-std=c++23`);
	args.push(`-DDMCRE_MODULE="\\\"DMCRE dmcred\\\""`);
	args.push(`-D_FILE_OFFSET_BITS=64`);
	args.push(`-Wno-vla-cxx-extension`);
	for(let i of Object.entries(CxxMacros)) {
		args.push(`-D${i[0]}=${i[1]}`)
	}
	for(let i of CxxIncludeDirectories) {
		args.push(`-I${i}`);
	}
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
	args.push(`-I${install}/Headers/C++`);

	child_process.execFileSync('clang++', args.slice(1));

	return object;
}

function BuildDynamicLibrary(objects,library) {
	console.log(`[Dynamic Library] ${library}`);

	const args = [];

	args.push(...objects);
	
	if(os.platform() != 'win32') {
		args.push(`-Wl,-rpath,./llvm-project/build/lib`);
		args.push(`-L./llvm-project/build/lib`);
		args.push(`-lclang-cpp`);
		args.push(`-lLLVM`);
	} else {
		args.push(`-L./llvm-project/build/bin`);
		const files = fs.readdirSync('./llvm-project/build/bin');
		for(let file of files) {
			if(!file.endsWith('.dll')) continue;
			if(!(file.startsWith('libclang') || file.startsWith('libLLVM'))) continue;
			args.push(`-l${path.basename(file,'.dll').substring(3)}`);
		}
	}
	
	args.push('-shared');
	
	if(os.platform() == 'win32') {
		args.push('-lws2_32');
	}
	
	args.push('-o');
	args.push(`${install}/${library}.${(() => {
		if(os.platform() == 'win32') {
			return 'dll';
		}
		if(os.platform() == 'darwin') {
			return 'dylib';
		}
		return 'so';
	})()}`);
	
	child_process.execFileSync('clang++', args);
}

function BuildExecutable(objects,executable) {
	console.log(`[Executable] ${executable}`);

	const args = [];

	args.push('-fuse-ld=lld');
	
	if(os.platform() != 'win32') {
		args.push(`-Wl,-rpath,./llvm-project/build/lib`);
		args.push(`-L./llvm-project/build/lib`);
		args.push(`-lclang-cpp`);
		args.push(`-lLLVM`);
	} else {
		args.push(`-L./llvm-project/build/bin`);
		const files = fs.readdirSync('./llvm-project/build/bin');
		for(let file of files) {
			if(!file.endsWith('.dll')) continue;
			if(!(file.startsWith('libclang') || file.startsWith('libLLVM'))) continue;
			args.push(`-l${path.basename(file,'.dll')}`);
		}
	}
	
	args.push(...objects);

	for(let dir of LibraryDirectories) {
		args.push(`-L${dir}`);
	}

	for(let library of Libraries) {
		args.push(`-l${library}`);
	}
	
	args.push('-o');
	args.push(`${install}/${executable}${(() => {
		if(os.platform() == 'win32') {
			return '.exe';
		}
		return '';
	})()}`);
	
	child_process.execFileSync('clang++', args);
}

AddCxxIncludeDirectory(`./llvm-project/clang/include`);
AddCxxIncludeDirectory(`./llvm-project/build/tools/clang/include`);
AddCxxIncludeDirectory(`./llvm-project/build/include`);
AddCxxIncludeDirectory(`./llvm-project/llvm/include`);

if(target == 'all' || target == 'data') {
	fs.writeFileSync('build/dmcre_load.cpp',(() => {
		let code = '';

		code += '#include <string>\n';
		code += '#include <vector>\n';

		code += '#include <dmcre/foundation>\n';

		code += 'namespace dmcre::load {\n';

		let CxxSystemIncludeDirectories = [];
		if(os.platform() == 'win32') {
			CxxSystemIncludeDirectories.push('C:\\msys64\\ucrt64\\include\\c++\\16.2.0');
			CxxSystemIncludeDirectories.push('C:\\msys64\\ucrt64\\include\\c++\\16.2.0\\x86_64-w64-mingw32');
			CxxSystemIncludeDirectories.push('C:\\msys64\\ucrt64\\lib\\gcc\\x86_64-w64-mingw32\\16.2.0\\include');
			CxxSystemIncludeDirectories.push('C:\\msys64\\ucrt64\\include');
		}

		code += `\tDMCRE_PUBLIC_API extern const std::vector<std::string> CxxSystemIncludeDirectories = std::initializer_list<std::string>({\n`;
		CxxSystemIncludeDirectories.forEach((value,index,array) => {
			code += `\t\t"${value.replaceAll('\\', '\\\\')}"${index == (array.length-1) ? '' : ','}\n`;
		});
		code += '\t});\n';

		code += '}';

		return code;
	})());
}

if(target == 'all' || target == 'headers') {
	fs.cpSync(`${process.cwd()}/Headers`,`${install}/Headers`,{recursive: true});
}

if(target == 'all' || target == 'resources') {
	fs.cpSync(`${process.cwd()}/llvm-project/build/lib/clang/23`,`${install}/clang`,{recursive: true});
	fs.cpSync(`${process.cwd()}/llvm-project/clang/include`,`${install}/llvm-include`,{recursive: true});
	fs.cpSync(`${process.cwd()}/llvm-project/build/tools/clang/include`,`${install}/llvm-include`,{recursive: true});
	fs.cpSync(`${process.cwd()}/llvm-project/build/include`,`${install}/llvm-include`,{recursive: true});
	fs.cpSync(`${process.cwd()}/llvm-project/llvm/include`,`${install}/llvm-include`,{recursive: true});
}

CxxMacros.DMCRE_INSTALLATION_DIRECTORY = `"${install.replaceAll('\\','\\\\')}"`;

if(target == 'all' || target == 'runtime') {
	CxxMacros.DMCRE_BUILDING_RUNTIME = '1';

	const Objects = [];
	Objects.push(BuildCppFile('build/dmcre_load.cpp'))

	const SourceDirectory = fs.readdirSync('./Runtime',{recursive: true}).map((v) => './Runtime/'+v);
	for(let i of SourceDirectory) {
		const stat = fs.statSync(i);

		if(stat.isFile()) {
			if(i.endsWith('.cpp')) {
				Objects.push(BuildCppFile(i))
			}
		}
	}

	BuildDynamicLibrary(Objects,"dmcre_runtime");

	CxxMacros = Object.fromEntries(Object.entries(CxxMacros).filter((v) => v[0] != 'DMCRE_BUILDING_RUNTIME'));
}

if(target == 'all' || target == 'dmcred') {
	AddCxxIncludeDirectory(`./dmcred/clangd`);
	AddCxxIncludeDirectory(`./llvm-project/clang-tools-extra`);
	AddCxxIncludeDirectory(`./llvm-project/clang-tools-extra/include-cleaner/include`);
	AddCxxIncludeDirectory(`./llvm-project/build/tools/clang/tools/extra/clangd`);
	AddCxxIncludeDirectory(`./llvm-project/build/tools/clang/tools/extra/clang-tidy`);

	const Objects = [];
	const SourceDirectory = fs.readdirSync('./dmcred',{recursive: true}).map((v) => './dmcred/'+v);
	for(let i of SourceDirectory) {
		const stat = fs.statSync(i);

		if(stat.isFile()) {
			if(i.endsWith('.cpp')) {
				Objects.push(BuildCppFile(i))
			}
		}
	}

	RemoveCxxIncludeDirectory(`./dmcred/clangd`);
	RemoveCxxIncludeDirectory(`./llvm-project/clang-tools-extra`);
	RemoveCxxIncludeDirectory(`./llvm-project/clang-tools-extra/include-cleaner/include`);
	RemoveCxxIncludeDirectory(`./llvm-project/build/tools/clang/tools/extra/clangd`);
	RemoveCxxIncludeDirectory(`./llvm-project/build/tools/clang/tools/extra/clang-tidy`);

	AddLibraryDirectory(install);
	AddLibrary('dmcre_runtime');

	BuildExecutable(Objects,'dmcred');

	RemoveLibrary('dmcre_runtime');
	RemoveLibraryDirectory(install);
}

if(target == 'all' || target == 'cli') {
	const Objects = [];
	const SourceDirectory = fs.readdirSync('./CLI',{recursive: true}).map((v) => './CLI/'+v);
	for(let i of SourceDirectory) {
		const stat = fs.statSync(i);

		if(stat.isFile()) {
			if(i.endsWith('.cpp')) {
				Objects.push(BuildCppFile(i))
			}
		}
	}

	AddLibraryDirectory(install);
	AddLibrary('dmcre_runtime');

	BuildExecutable(Objects,'dmcre');

	RemoveLibrary('dmcre_runtime');
	RemoveLibraryDirectory(install);
}

fs.writeFileSync('compile_commands.json', JSON.stringify(compileCommandsJson, null, '\t'));
