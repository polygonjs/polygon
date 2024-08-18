const text_decoder = new TextDecoder();
export function jsStringFromJaiString(pointer: bigint, strlength: number) {
	// console.log({ pointer });
	// if(!allocated){
	// 	console.error("Memory not allocated")
	// 	return
	// }
	const u8 = new Uint8Array(
		window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer
	);
	if (Number(pointer) > u8.length) {
		console.error("Pointer out of bounds", Number(pointer), u8.length);
		return;
	}
	// console.log({ buffer: allocated!.buffer, u8, allocated });
	const bytes = u8.subarray(
		Number(pointer),
		Number(pointer) + Number(strlength)
	);
	// console.log("length", Number(pointer), Number(length), bytes);
	return text_decoder.decode(bytes);
}
export function jsStringFromJaiStringWithoutLength(
	pointer: bigint
): string | undefined {
	if (pointer == BigInt(0)) {
		return;
	}
	const u8 = new Uint8Array(
		window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer
	);
	const startIndex = Number(pointer);
	if (startIndex > u8.length) {
		console.error("Pointer out of bounds", startIndex, u8.length);
		return;
	}
	// console.log({ buffer: allocated!.buffer, u8, allocated });
	let charCode = u8[startIndex];
	let strLength = 0;
	for (let i = startIndex; i < u8.length; i++) {
		if (charCode == 0) {
			break;
		}
		charCode = u8[startIndex + strLength];
		strLength++;
	}

	const bytes = u8.subarray(startIndex, startIndex + strLength - 1);
	// console.log("length", Number(pointer), Number(length), bytes);
	return text_decoder.decode(bytes);
}

export function printf(formatPointer: bigint, ...args: any[]): number {
	// const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	// const memory = new Uint8Array(buffer);
	const format = jsStringFromJaiStringWithoutLength(formatPointer);
	if (!format) {
		throw new Error("printf: Format string is null");
	}
	const formattedString = formatString(format, args);

	console.log(formattedString);

	return formattedString.length; // Return the number of characters written
}

export function sprintf(
	bufferPointer: bigint,
	formatPointer: bigint,
	...args: any[]
): number {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const memory = new Uint8Array(buffer);
	const format = jsStringFromJaiStringWithoutLength(formatPointer);
	if (!format) {
		throw new Error("printf: Format string is null");
	}
	const formattedString = formatString(format, args);

	// Write the formatted string to the buffer in WebAssembly memory
	const bufferStart = Number(bufferPointer);
	for (let i = 0; i < formattedString.length; i++) {
		memory[bufferStart + i] = formattedString.charCodeAt(i);
	}
	memory[bufferStart + formattedString.length] = 0; // Null-terminate the string

	return formattedString.length; // Return the number of characters written
}

const FLOAT_FORMAT = "%.3f";
// Helper function to perform basic string formatting
export function formatString(format: string, args: string[]): string {
	let argIndex = 0;
	// console.log("formatString", { format, args });
	// format = format.replace(/%[sd]/g, (match) => {
	// 	if (argIndex < args.length) {
	// 		const arg = args[argIndex++];
	// 		if (match === "%d") return `${parseInt(arg, 10)}`;
	// 		if (match === "%s") return arg;
	// 	}
	// 	return match; // If no argument available, return the placeholder
	// });
	// argIndex = 0;

	if (format == FLOAT_FORMAT) {
		const firstArg = args[0];
		if (firstArg == null) {
			return format;
		}
		const floatValue = parseFloat(firstArg);
		console.log(floatValue);
		const value = floatValue.toFixed(3);
		return `${value}`;
	}

	format = format.replace(
		/%(\.\d+)?[dfs]/g,
		(match: string, precision: string) => {
			if (argIndex >= args.length) return match;
			const arg = args[argIndex++];

			if (match.includes("%d")) {
				const res = parseInt(arg, 10);
				return `${res}`;
			} else if (match.includes("%s")) {
				return arg.toString();
			} else if (match.includes("%f")) {
				const precisionValue = precision
					? parseInt(precision.substring(1))
					: 6; // Default to 6 decimal places if none specified
				const res = parseFloat(arg).toFixed(precisionValue);
				return `${res}`;
			}

			return match;
		}
	);
	return format;
}
// console.log(formatString("Hello %s %d %f", ["World", "42", "3.14159"]));
// console.log(formatString("%.3f", ["3.14159"]));
// console.log(formatString("test 1: %.3f", ["3.14159"]));
// console.log(formatString("test 2: %.3f x %.3f", ["3.14159", "7.12423"]));

export function strlen(pointer: bigint) {
	// console.warn("will be replaced");
	if (pointer == BigInt(0)) {
		return;
	}
	const u8 = new Uint8Array(
		window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer
	);
	const startIndex = Number(pointer);
	if (startIndex > u8.length) {
		console.error("Pointer out of bounds", startIndex, u8.length);
		return;
	}
	let charCode = u8[startIndex];
	let strLength = 0;
	for (let i = startIndex; i < u8.length; i++) {
		if (charCode == 0) {
			break;
		}
		charCode = u8[startIndex + strLength];
		strLength++;
	}

	// console.log({
	// 	pointer,
	// 	strLength,
	// 	data: jsStringFromJaiStringWithoutLength(pointer),
	// });
	return BigInt(strLength);
}

export function strcmp(str1Pointer: bigint, str2Pointer: bigint): number {
	const str1 = jsStringFromJaiStringWithoutLength(str1Pointer);
	const str2 = jsStringFromJaiStringWithoutLength(str2Pointer);
	if (str1 == null) {
		throw new Error("str1 is null");
	}
	if (str2 == null) {
		throw new Error("str2 is null");
	}

	for (let i = 0; i < str1.length && i < str2.length; i++) {
		if (str1[i] !== str2[i]) {
			return str1.charCodeAt(i) - str2.charCodeAt(i);
		}
	}
	return str1.length - str2.length;
}

export function atof(strPointer: bigint): number {
	// converts a string to a floating-point number
	// Assume wasmMemory is the WebAssembly memory object
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const memory = new Uint8Array(buffer);

	// Find the length of the string (until null terminator)
	let length = 0;
	let i = Number(strPointer);
	while (memory[i + length] !== 0) {
		length++;
	}

	// Use TextDecoder to decode the memory range into a string
	const decoder = new TextDecoder("utf-8");
	const str = decoder.decode(memory.subarray(i, i + length));

	// Use parseFloat to convert the string to a floating-point number
	return parseFloat(str);
}

// let usesCount = 0;
// export function vsnprintf(
// 	strPointer: bigint,
// 	size: bigint,
// 	formatPointer: bigint,
// 	vaListPointer: bigint
// ) {
// 	// console.log("vsnprintf", {
// 	// 	strPointer,
// 	// 	size,
// 	// 	formatPointer,
// 	// 	vaListPointer,
// 	// });
// 	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
// 	const memory = new Uint8Array(buffer);

// 	// Decode format string
// 	const format = jsStringFromJaiStringWithoutLength(formatPointer);
// 	if (!format) {
// 		throw new Error("vsnprintf: Format string is null");
// 	}

// 	// Decode the arguments from the vaListPointer
// 	const args = decodeArguments(memory, vaListPointer);
// 	// console.log(args);

// 	// Perform the formatting
// 	const formattedString = formatString(format, args);
// 	// console.log("formattedString", formattedString);

// 	// Copy the formatted string into the target memory location
// 	const maxWriteSize = Math.min(formattedString.length, Number(size) - 1); // Leave room for null terminator
// 	for (let i = 0; i < maxWriteSize; i++) {
// 		memory[Number(strPointer) + i] = formattedString.charCodeAt(i);
// 	}
// 	memory[Number(strPointer) + maxWriteSize] = 0; // Null terminator

// 	// Return the number of characters that would have been written
// 	console.log("> vsnprintf", { format, args, formattedString });
// 	// usesCount++;
// 	// if (usesCount > 2) throw new Error("vsnprintf CBB");
// 	return formattedString.length;
// }

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
// function decodeArguments(memory: Uint8Array, vaListPointer: bigint) {
// 	const args = [];
// 	let currentPointer = Number(vaListPointer);

// 	// Assume arguments are passed as 64-bit values (bigint)
// 	while (true) {
// 		const arg = readBigInt(memory, currentPointer);
// 		if (arg === 0n) break; // Assume 0n marks the end of arguments
// 		args.push(arg);
// 		currentPointer += 8; // Move to the next 64-bit value
// 	}

// 	return args.map((arg) => arg.toString()); // Convert all arguments to strings for simplicity
// }

// Helper function to read a 64-bit BigInt from memory
// function readBigInt(memory: Uint8Array, pointer: number) {
// 	let value = 0n;
// 	for (let i = 0; i < 8; i++) {
// 		value |= BigInt(memory[pointer + i]) << BigInt(i * 8);
// 	}
// 	return value;
// }

// formats a string and writes it to a buffer, but it will not write more than n characters, including the null terminator.
export function snprintf(
	bufferPointer: bigint,
	n: number,
	formatPointer: bigint,
	...args: any[]
): number {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const memory = new Uint8Array(buffer);
	const format = jsStringFromJaiStringWithoutLength(formatPointer);
	if (!format) {
		throw new Error("snprintf: Format string is null");
	}
	const formattedString = formatString(format, args);

	const length = Math.min(formattedString.length, n - 1); // Ensure null terminator fits

	// Write the formatted string to the buffer in WebAssembly memory
	for (let i = 0; i < length; i++) {
		memory[Number(bufferPointer) + i] = formattedString.charCodeAt(i);
	}
	memory[Number(bufferPointer) + length] = 0; // Null-terminate the string

	return length; // Return the number of characters that would have been written
}

// reads formatted input from a string, similar to scanf but from a string instead of standard input.
export function sscanf(
	strPointer: bigint,
	formatPointer: bigint,
	...args: any[]
): number {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const memory = new Uint8Array(buffer);
	const str = jsStringFromJaiStringWithoutLength(strPointer);
	if (!str) {
		throw new Error("sscanf: str string is null");
	}
	const format = jsStringFromJaiStringWithoutLength(formatPointer);
	if (!format) {
		throw new Error("sscanf: Format string is null");
	}

	let matchCount = 0;
	const regex = formatToRegex(format);
	const matches = str.match(regex);

	if (matches) {
		for (let i = 1; i < matches.length && i - 1 < args.length; i++) {
			const argPointer = Number(args[i - 1]);
			const value = matches[i];
			if (format.includes("%d")) {
				writeInt32ToMemory(parseInt(value, 10), argPointer, memory);
			} else if (format.includes("%s")) {
				writeStringToMemory(value, argPointer, memory);
			}
			matchCount++;
		}
	}

	return matchCount;
}

function formatToRegex(format: string) {
	// Convert sscanf format to regex, very simplified
	return new RegExp(format.replace(/%d/g, "(\\d+)").replace(/%s/g, "(\\S+)"));
}

function writeInt32ToMemory(
	value: number,
	pointer: number,
	memory: Uint8Array
) {
	new DataView(memory.buffer).setInt32(pointer, value, true);
}

function writeStringToMemory(
	value: string,
	pointer: number,
	memory: Uint8Array
) {
	for (let i = 0; i < value.length; i++) {
		memory[pointer + i] = value.charCodeAt(i);
	}
	memory[pointer + value.length] = 0; // Null-terminate
}

// locates the first occurrence of a character in a string.
export function strchr(strPointer: bigint, char: number): bigint {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const memory = new Uint8Array(buffer);
	const start = Number(strPointer);

	for (let i = start; memory[i] !== 0; i++) {
		if (memory[i] === char) {
			return BigInt(i);
		}
	}

	return 0n; // Return NULL if the character is not found
}

// compares two strings up to a specified number of characters.
export function strncmp(
	str1Pointer: bigint,
	str2Pointer: bigint,
	n: number
): number {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const memory = new Uint8Array(buffer);

	for (let i = 0; i < n; i++) {
		const char1 = memory[Number(str1Pointer) + i];
		const char2 = memory[Number(str2Pointer) + i];

		if (char1 !== char2) {
			return char1 - char2;
		}

		if (char1 === 0 || char2 === 0) {
			break; // Stop comparison if either string ends
		}
	}

	return 0;
}

// copies a specified number of characters from one string to another.
export function strncpy(
	destPointer: bigint,
	srcPointer: bigint,
	n: number
): bigint {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const memory = new Uint8Array(buffer);

	let i;
	for (i = 0; i < n && memory[Number(srcPointer) + i] !== 0; i++) {
		memory[Number(destPointer) + i] = memory[Number(srcPointer) + i];
	}

	// Fill the rest with null characters if necessary
	for (; i < n; i++) {
		memory[Number(destPointer) + i] = 0;
	}

	return destPointer;
}

// locates the first occurrence of a substring in a string.
export function strstr(haystackPointer: bigint, needlePointer: bigint): bigint {
	const haystack = jsStringFromJaiStringWithoutLength(haystackPointer);
	if (!haystack) throw new Error("strstr:haystack is null");
	const needle = jsStringFromJaiStringWithoutLength(needlePointer);
	if (!needle) throw new Error("strstr:needle is null");

	const index = haystack.indexOf(needle);
	if (index === -1) {
		return 0n; // Return NULL if the substring is not found
	}

	return BigInt(Number(haystackPointer) + index);
}

// converts a character to uppercase.
export function toupper(c: number): number {
	if (c >= 97 && c <= 122) {
		// 'a' to 'z'
		return c - 32; // Convert to 'A' to 'Z'
	}
	return c;
}
