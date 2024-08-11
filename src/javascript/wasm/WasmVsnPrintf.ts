import { jsStringFromJaiStringWithoutLength } from "./WasmString";

export function vsnprintf(
	strPointer: bigint,
	size: bigint,
	formatPointer: bigint,
	vaListPointer: bigint
) {
	// console.log("vsnprintf", {
	// 	strPointer,
	// 	size,
	// 	formatPointer,
	// 	vaListPointer,
	// });
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const memory = new Uint8Array(buffer);

	// Decode format string
	const format = jsStringFromJaiStringWithoutLength(formatPointer);
	if (!format) {
		throw new Error("vsnprintf: Format string is null");
	}

	// Decode the arguments from the vaListPointer
	const args = decodeArguments(memory, vaListPointer);

	// Perform the formatting
	const formattedString = formatString(format, args);
	// console.log("formattedString", formattedString);

	// Copy the formatted string into the target memory location
	const maxWriteSize = Math.min(formattedString.length, Number(size) - 1); // Leave room for null terminator
	for (let i = 0; i < maxWriteSize; i++) {
		memory[Number(strPointer) + i] = formattedString.charCodeAt(i);
	}
	memory[Number(strPointer) + maxWriteSize] = 0; // Null terminator

	// Return the number of characters that would have been written
	return formattedString.length;
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

// Helper function to decode the va_list arguments
function decodeArguments(memory: Uint8Array, vaListPointer: bigint) {
	const args = [];
	let currentPointer = Number(vaListPointer);

	// Assume arguments are passed as 64-bit values (bigint)
	while (true) {
		const arg = readBigInt(memory, currentPointer);
		if (arg === 0n) break; // Assume 0n marks the end of arguments
		args.push(arg);
		currentPointer += 8; // Move to the next 64-bit value
	}

	return args.map((arg) => arg.toString()); // Convert all arguments to strings for simplicity
}

// Helper function to read a 64-bit BigInt from memory
function readBigInt(memory: Uint8Array, pointer: number) {
	let value = 0n;
	for (let i = 0; i < 8; i++) {
		value |= BigInt(memory[pointer + i]) << BigInt(i * 8);
	}
	return value;
}

// Helper function to perform basic string formatting
function formatString(format: string, args: string[]) {
	let argIndex = 0;
	// console.log("formatString", { format, args });
	return format.replace(/%[sd]/g, (match) => {
		if (argIndex < args.length) {
			const arg = args[argIndex++];
			if (match === "%d") return `${parseInt(arg, 10)}`;
			if (match === "%s") return arg;
		}
		return match; // If no argument available, return the placeholder
	});
}
