import { jsStringFromJaiString } from "./WasmString";

export function memcmp(
	str1Pointer: bigint,
	str2Pointer: bigint,
	size: bigint
): number {
	// https://discord.com/channels/661732390355337246/1172463903943446548/1256763226847187127
	// https://www.tutorialspoint.com/c_standard_library/c_function_memcmp.htm
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

export function memchr(sPointer: bigint, c: number, n: bigint): bigint {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const memory = new Uint8Array(buffer);
	const start = Number(sPointer);
	const size = Number(n);
	const byteValue = c & 0xff; // Ensure the byte value is within 0-255

	for (let i = 0; i < size; i++) {
		if (memory[start + i] === byteValue) {
			return BigInt(start + i);
		}
	}

	return 0n; // Return 0 (NULL) if the byte is not found
}

