import { USELESS_ARG0 } from "./Common";
import { jsStringFromJaiString } from "./wasm/WasmString";

let fetchedData: ArrayBuffer | null = null;
export function fetchUrl(
	nodeId: bigint,
	stringPtr: bigint,
	stringSize: bigint
) {
	// console.log("TODO: use more than a global fetchedData");
	// console.log("fetchUrl", nodeId, stringPtr, stringSize);
	const url = jsStringFromJaiString(stringPtr, Number(stringSize));
	// console.log("fetchUrl", url);
	if (url) {
		fetch(url).then(async (response) => {
			// console.log("response", response);
			fetchedData = await response.arrayBuffer();
			// console.log(
			// 	"data",
			// 	fetchedData.byteLength,
			// 	fetchedData,
			// 	window.wasmFunctions.requestAllocation
			// );
			// console.log("A");
			// console.log("requestAllocation A", nodeId);
			// console.log("requestAllocation A", nodeId, url);
			window.wasmFunctions.requestAllocation(
				USELESS_ARG0,
				nodeId,
				BigInt(fetchedData.byteLength)
			);
			// console.log("requestAllocation B");
			// console.log("requestAllocation B", nodeId, result);
		});
	}
}
export function onAllocateReady(
	nodeId: bigint,
	destPointer: bigint,
	size: number
) {
	// when using this function,
	// there was a lot of crashes in jai/wasm.
	// Those crashes sometimes disappeared when having a print statement in jai, which really should not happen.
	// So I've tried putting this inside a setTimeout,
	// so that we would not have js calling jai, calling js, calling jai, etc. in such direct successions.
	setTimeout(() => {
		// console.log(
		// 	"onAllocateReady A",
		// 	nodeId,
		// 	destPointer,
		// 	size,
		// 	fetchedData
		// );

		if (!fetchedData) {
			console.error("onAllocateReady: fetchedData is null");
			return;
		}

		const buffer =
			window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
		const targetMemory = new Uint8Array(buffer); // Assume wasmMemory is the WebAssembly memory
		const srcMemory = new Uint8Array(fetchedData);

		const dest = Number(destPointer);
		for (let i = 0; i < size; i++) {
			targetMemory[dest + i] = srcMemory[i];
		}
		// console.log(
		// 	"onAllocateReady B",
		// 	nodeId,
		// 	destPointer,
		// 	size,
		// 	fetchedData
		// );
		window.wasmFunctions.onAllocatedMemoryWritten(USELESS_ARG0, nodeId);

		// console.log(
		// 	"onAllocateReady C",
		// 	nodeId,
		// 	destPointer,
		// 	size,
		// 	fetchedData
		// );
	}, 10);
}

