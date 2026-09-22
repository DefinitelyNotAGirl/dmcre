const now = new Date(Date.now());

export const version = (() => {
	let res = 0;
	res += now.getDate() * 100;
	res += (now.getMonth() + 1) * 10000;
	res += now.getFullYear() * 1000000;

	return res;
})();