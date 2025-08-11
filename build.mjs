#!/usr/bin/env node

import * as fs from 'fs';
import * as path from 'path';
import * as crypto from 'crypto';
import * as child_process from 'child_process';

/**
 * @brief gathers files of a given extension, returned paths are either absolute or relative depending on whether or not basedir is absolute
 * @param basedir base directory to search in, may be absolute or relative
 * @param extension extension e.g. ".cxx",".h",".js"
 * @param recursive if true gather files all the way down the file system tree, if false only gather direct children of basedir
 */
export function GetAllFilesOfExtension(basedir, extension, recursive = true) {
	const result = [];
	const isAbsolute = path.isAbsolute(basedir);
	function walk(currentDir) {
		for (const entry of fs.readdirSync(currentDir, { withFileTypes: true })) {
			const fullPath = path.join(currentDir, entry.name);
			if (entry.isDirectory()) {
				if (recursive) walk(fullPath);
			} else if (entry.isFile() && path.extname(entry.name) === extension) {
				const outputPath = isAbsolute ? fullPath : path.relative(path.resolve(basedir+"/../"), fullPath);
				result.push(outputPath);
			}
		}
	}
	walk(basedir);
	return result;
}

var BuildScript = "";

function spawnSync(command,args,options) {
	BuildScript += `${command} ${args.join(' ')}\n`;

	return child_process.spawnSync(command,args,options);
}

function expandEnv(str) {
	return str.replace(/\$(\w+)|%([^%]+)%/g, (_, unixVar, winVar) => {
		const envVar = unixVar || winVar;
		return process.env[envVar] ?? "";
	});
}

function EnsureDirectoryExists(dir) {
	if(!fs.existsSync(dir)) {
		fs.mkdirSync(expandEnv(dir),{recursive: true});
	}
	if(process.platform == 'win32') {
		BuildScript += `if not exist "${dir}" mkdir "${dir}"\n`;
	} else {
		BuildScript += `mkdir -p "${dir}"\n`;
	}
}

function FsCopy(src,dst) {
	if(process.platform == 'win32') {
		BuildScript += `robocopy "${src} ${dst} /E"\n`;
	} else {
		BuildScript += `cp -r "${src}" "${dst}"\n`;
	}
	return fs.cpSync(expandEnv(src),expandEnv(dst),{recursive: true});
}

(() => {
	const sources_cpp = [
		...GetAllFilesOfExtension('src','.cpp'),
		...GetAllFilesOfExtension('src','.cxx'),
		...GetAllFilesOfExtension('src','.c++'),
	].map((file) => file.replace(/\\/g,'/'));

	const sources_c = [
		...GetAllFilesOfExtension('src','.c'),
	].map((file) => file.replace(/\\/g,'/'));

	const objects = [
	];

	EnsureDirectoryExists(`build/objects`);
	EnsureDirectoryExists(`bin`);
	const HOME = process.platform == 'win32' ? `%USERPROFILE%` : `$HOME`;
	EnsureDirectoryExists(`${HOME}/.dmcre`);
	EnsureDirectoryExists(`${HOME}/.dmcre/global`);
	EnsureDirectoryExists(`${HOME}/.dmcre/bin`);

	sources_cpp.forEach((source) => {
		const objname = crypto.hash('sha256',source)+'.obj';
		console.log(`[C++] ${source} ${objname}`);
		const compiler = spawnSync(
			'clang++',[
				(source == 'src/data.cpp' ? `-Wno-null-conversion` : ``),
				'-c',
				'-Wno-vla-cxx-extension',
				'-Wno-deprecated-declarations',
				'-g',
				'-std=c++20',
				'-I','inc',
				`${source}`,
				`-o`,`build/objects/${objname}`
			],
			{stdio:'inherit'}
		);
		if(compiler.status != 0) {
			process.exit(1);
		}
		objects.push(`build/objects/${objname}`);
	});

	sources_c.forEach((source) => {
		const objname = crypto.hash('sha256',source)+'.obj';
		console.log(`[C] ${source} ${objname}`);
		const compiler = spawnSync(
			'clang',[
				(source.startsWith('src/crypto/b-con/') ? `-Wno-pointer-sign` : ``),
				(source.startsWith('src/crypto/b-con/') ? `-Wno-return-type` : ``),
				(source.startsWith('src/crypto/b-con/') ? `-Wno-header-guard` : ``),
				'-c',
				'-g',
				'-std=c17',
				'-I','inc',
				`${source}`,
				`-o`,`build/objects/${objname}`
			],
			{stdio:'inherit'}
		);
		if(compiler.status != 0) {
			process.exit(1);
		}
		objects.push(`build/objects/${objname}`);
	});

	const linker = spawnSync(
		'clang++',[
			...objects,
			`-g`,
			`-o`,`bin/dmcre`,
			process.platform != 'win32' ? `-rdynamic` : '',
			process.platform != 'win32' ? `-ldl` : '',
		],
		{stdio:'inherit'}
	);
	if(linker.status != 0) {
		process.exit(2);
	}

	FsCopy(`inc/dmcre`,`${HOME}/.dmcre/global`);
	FsCopy(`bin/dmcre`,`${HOME}/.dmcre/bin/dmcre.exe`);

	fs.writeFileSync(`BuildScript.temp`,BuildScript);
})()
