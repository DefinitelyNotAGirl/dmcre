const modules = {};
const moduleCache = {};

function require(id) {
	const cachedModule = moduleCache[id];
	if(cachedModule !== undefined) {
		return cachedModule.exports;
	}

	const moduleFactory = modules[id];

	if(moduleFactory === undefined) {
		throw new Error(`required module not present: ${id}`);
	}

	const exports = {};
	const module = {
		exports: exports
	};
	moduleCache[id] = module;

	moduleFactory(exports,module);

	return module.exports;
}

const process = {
	env: {
		NODE_ENV: "development"
	}
}
