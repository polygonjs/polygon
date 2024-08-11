import { jsStringFromJaiStringWithoutLength } from "./WasmString";

export function __assert_fail(
	exprPointer: bigint,
	filePointer: bigint,
	line: number,
	funcPointer: bigint
) {
	// Decode the expression string
	const expr = jsStringFromJaiStringWithoutLength(exprPointer);

	// Decode the file name string
	const file = jsStringFromJaiStringWithoutLength(filePointer);

	// Decode the function name string
	const func = jsStringFromJaiStringWithoutLength(funcPointer);

	// Log the assertion failure information
	console.error(
		`Assertion failed: ${expr}, function ${func}, file ${file}, line ${line}`
	);

	// Optionally throw an error to halt execution or handle it as needed
	throw new Error(
		`Assertion failed: ${expr}, function ${func}, file ${file}, line ${line}`
	);
}

// Helper function to decode null-terminated C strings from memory
// function decodeCString(memory, pointer, decoder) {
//     let length = 0;
//     let start = Number(pointer);

//     // Find the length of the string (until null terminator)
//     while (memory[start + length] !== 0) {
//         length++;
//     }

//     // Decode the memory range into a string
//     return decoder.decode(memory.subarray(start, start + length));
// }
