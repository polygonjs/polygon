export function qsort(
	basePointer: bigint,
	nitems: number,
	size: number,
	comparPointer: bigint
) {
	console.log("qsort: NOT SORTING YET", {
		basePointer,
		nitems,
		size,
		comparPointer,
	});
	// const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer
	// const memory = new Uint8Array(buffer);

	// // Decode the elements from WebAssembly memory into a JavaScript array
	// const array = [];
	// for (let i = 0; i < nitems; i++) {
	//     const elementPointer = Number(basePointer) + i * size;
	//     array.push(memory.slice(elementPointer, elementPointer + size));
	// }

	// // Sort the array using the provided comparison function
	// array.sort((a, b) => {
	//     return callComparFunction(a, b, comparPointer, memory);
	// });

	// // Write the sorted array back into WebAssembly memory
	// for (let i = 0; i < nitems; i++) {
	//     const elementPointer = Number(basePointer) + i * size;
	//     memory.set(array[i], elementPointer);
	// }
}

// Function to call the comparison function provided by the C code
// function callComparFunction(a, b, comparPointer:bigint, memory:Uint8Array) {
//     // Assume the comparison function returns an int and receives two pointers
//     const aPointer = allocateInWasmMemory(a, memory);
//     const bPointer = allocateInWasmMemory(b, memory);

//     // Call the comparison function via WebAssembly instance
//     const result = wasmInstance.exports.__indirect_function_table.get(Number(comparPointer))(aPointer, bPointer);

//     // Free the allocated memory
//     freeInWasmMemory(aPointer, memory);
//     freeInWasmMemory(bPointer, memory);

//     return result;
// }

// // Function to allocate memory in WebAssembly for a given JavaScript array (Uint8Array)
// function allocateInWasmMemory(data, memory) {
//     const pointer = wasmInstance.exports.malloc(data.length); // Assume a malloc function is available
//     memory.set(data, pointer);
//     return pointer;
// }

// // Function to free memory in WebAssembly
// function freeInWasmMemory(pointer, memory) {
//     wasmInstance.exports.free(pointer); // Assume a free function is available
// }
