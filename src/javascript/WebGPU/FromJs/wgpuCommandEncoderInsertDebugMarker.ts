import { jsStringFromJaiStringWithoutLength } from "../../wasm/WasmString";
import { heapGet } from "../../WasmHeap";

export function wgpuCommandEncoderInsertDebugMarker(
	commandEncoderHeapIndex: bigint,
	markerLabelPointer: bigint
) {
	const encoder = heapGet<GPUCommandEncoder>(commandEncoderHeapIndex)!;
	const label = jsStringFromJaiStringWithoutLength(markerLabelPointer);
	return encoder.insertDebugMarker(label || "no label");
}

