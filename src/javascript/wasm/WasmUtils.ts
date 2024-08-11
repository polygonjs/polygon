import { jsStringFromJaiString } from "./WasmString";

export function memcmp(
	str1Pointer: bigint,
	str2Pointer: bigint,
	sizeBig: bigint
): number {
	// https://discord.com/channels/661732390355337246/1172463903943446548/1256763226847187127
	// https://www.tutorialspoint.com/c_standard_library/c_function_memcmp.htm
	const size = Number(sizeBig);
	const str1 = jsStringFromJaiString(str1Pointer, size);
	const str2 = jsStringFromJaiString(str2Pointer, size);
	if (str1 == str2) {
		return 0;
	}
	if (!(str1 && str2)) {
		return -1;
	}
	if (str1 < str2) {
		return -1;
	}
	if (str1 > str2) {
		return 1;
	}
	return -1;
}

export function memset(pointer: bigint, value: number, sizeBig: bigint) {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const size = Number(sizeBig);
	const memory = new Uint8Array(buffer); // Assume wasmMemory is the WebAssembly memory

	const start = Number(pointer);
	for (let i = 0; i < size; i++) {
		memory[start + i] = value;
	}
	return pointer;
}

export function memcpy(
	destPointer: bigint,
	srcPointer: bigint,
	sizeBig: bigint
): BigInt {
	const size = Number(sizeBig);
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const memory = new Uint8Array(buffer); // Assume wasmMemory is the WebAssembly memory

	const dest = Number(destPointer);
	const src = Number(srcPointer);

	for (let i = 0; i < size; i++) {
		memory[dest + i] = memory[src + i];
	}

	// Return the destination pointer as BigInt, often a convention in C-style memcpy
	return destPointer;
}

export function memmove(
	destPointer: bigint,
	srcPointer: bigint,
	sizeBig: bigint
): bigint {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const size = Number(sizeBig);
	const memory = new Uint8Array(buffer);

	const dest = Number(destPointer);
	const src = Number(srcPointer);

	// If the destination is higher in memory and overlaps with the source, copy backwards
	if (dest > src && dest < src + size) {
		for (let i = size - 1; i >= 0; i--) {
			memory[dest + i] = memory[src + i];
		}
	} else {
		// Otherwise, copy forwards
		for (let i = 0; i < size; i++) {
			memory[dest + i] = memory[src + i];
		}
	}

	// Return the destination pointer, similar to how C's memmove works
	return destPointer;
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
