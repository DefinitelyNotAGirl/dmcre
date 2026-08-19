const now = new Date(Date.now());

export const version = (() => {
	let res = 0;
	res += now.getDate() * 100;
	res += (now.getMonth() + 1) * 10000;
	res += now.getFullYear() * 1000000;

	return res;
})();

const installRoot = `${process.env.USERPROFILE}\\dmcre_${version}`;

export const install = {
	root: installRoot,
	headers: {
		cxx: `${installRoot}\\Headers\\C++`
	},
	runtimeDylib: `${installRoot}\\runtime.lib`,
    runtimeDll: `${installRoot}\\runtime.dll`,
	cliExe: `${installRoot}\\dmcre.exe`
}

export const target = {
	platform: `Microsoft Windows 11`,
}

export const sdk = {
	cxx: {
		compiler: ``,
		standard: `c++23`,
		include: [
		]
	},
	windows: {
		lib: {
			um: ``
		}
	}
}
