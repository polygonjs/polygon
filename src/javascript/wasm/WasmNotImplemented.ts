function generateNotImplementedFunction(name: string) {
	return function notImplemented() {
		throw new Error(`${name} is not implemented`);
	};
}
// function notImplemented() {}
const functionNames: string[] = [
	// "fclose",
	// "fflush",
	// "fopen",
	// "fread",
	// "fseek",
	// "ftell",
	// "fwrite",
	// "log",
	// "logf",
	// "memchr",
	// "printf",
	// "strncmp",
	// "strncpy",
	// "sscanf", // imgui
	// "strstr", // imgui
];
function createDict() {
	const dict: any = {};
	functionNames.forEach((name) => {
		dict[name] = generateNotImplementedFunction(name);
	});
	return dict;
}
export const NOT_IMPLEMENTED = createDict();
