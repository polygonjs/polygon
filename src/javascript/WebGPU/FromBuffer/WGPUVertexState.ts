import { jsStringFromJaiStringWithoutLength } from "../../wasm/WasmString";
import { heapGet } from "../../WasmHeap";
import { WGPU_OFFSET, WGPU_SIZE } from "../utils/WebGPUOffset";
import { createWGPUItemsByPointer, u64Create } from "../utils/WebGPUUtils";
import { WGPUVertexBufferLayoutFromBuffer } from "./WGPUVertexBufferLayout";

export function WGPUVertexStateFromBuffer(pointer: bigint): GPUVertexState {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u64 = new BigUint64Array(buffer);
	const _u64 = u64Create(u64, pointer);
	//
	const offset = WGPU_OFFSET.WGPUVertexState;
	//
	const moduleHeapIndex = _u64(offset.module);
	const module = heapGet<GPUShaderModule>(moduleHeapIndex);
	if (!module) {
		throw new Error("module is null");
	}
	//
	const entryPointPointer = _u64(offset.entryPoint);
	const entryPoint = jsStringFromJaiStringWithoutLength(
		BigInt(entryPointPointer)
	);
	//
	const constantsCount = _u64(offset.constantCount);
	if (constantsCount > 0) {
		console.warn(
			"WGPUVertexStateFromBuffer: constantsCount is greater than 0, but not implemented"
		);
	}
	//
	const bufferCount = _u64(offset.bufferCount);
	if (bufferCount >= 2) {
		console.warn(
			"WGPUVertexStateFromBuffer: bufferCountb is greater than 1, the pointer lookup with +BigInt(i) may not work. But it works in WGPUVertexBufferLayoutFromBuffer"
		);
	}
	const buffers: GPUVertexBufferLayout[] = createWGPUItemsByPointer({
		u64,
		pointer,
		arrayOffset: offset.buffers,
		itemsCount: bufferCount,
		itemSize: WGPU_SIZE.WGPUVertexBufferLayout,
		callback: (itemPointer) =>
			WGPUVertexBufferLayoutFromBuffer(itemPointer),
	});

	const vertexState: GPUVertexState = {
		module,
		entryPoint,
		buffers,
	};
	return vertexState;
}

