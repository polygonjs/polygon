export function mapFunctionName(
	functionName: string,
	prefix: string,
	targetName: string,
	exportedMethod: Function,
	exportedJsFunctions: Record<string, Function>
) {
	if (functionName.startsWith(prefix)) {
		exportedJsFunctions[targetName] = exportedMethod;
		// console.log(">>>> map", functionName, targetName);
	}
}
