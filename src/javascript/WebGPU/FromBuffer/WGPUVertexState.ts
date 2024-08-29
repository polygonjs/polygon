import { jsStringFromJaiStringWithoutLength } from "../../wasm/WasmString";
import { heapGet } from "../../WasmHeap";
import { _big, createWGPUItemsByPointer } from "../utils/WebGPUUtils";
import {
	WGPUVertexBufferLayout,
	WGPUVertexState,
} from "../utils/WGPUStructInfos";
import { WGPUVertexBufferLayoutFromBuffer } from "./WGPUVertexBufferLayout";

export function WGPUVertexStateFromBuffer(p: bigint): GPUVertexState {
	const m = WGPUVertexState.members;
	//
	const moduleHeapIndex = _big(p, m.module);
	const module = heapGet<GPUShaderModule>(moduleHeapIndex);
	if (!module) {
		throw new Error("module is null");
	}
	//
	const entryPointPointer = _big(p, m.entryPoint);
	const entryPoint = jsStringFromJaiStringWithoutLength(
		BigInt(entryPointPointer)
	);
	//
	const constantsCount = _big(p, m.constantCount);
	if (constantsCount > 0) {
		console.warn(
			"WGPUVertexStateFromBuffer: constantsCount is greater than 0, but not implemented"
		);
	}
	//
	const bufferCount = _big(p, m.bufferCount);
	if (bufferCount >= 2) {
		console.warn(
			"WGPUVertexStateFromBuffer: bufferCountb is greater than 1, the pointer lookup with +BigInt(i) may not work. But it works in WGPUVertexBufferLayoutFromBuffer"
		);
	}
	const buffers: GPUVertexBufferLayout[] = createWGPUItemsByPointer({
		pointer: p,
		itemsCount: bufferCount,
		itemSize: WGPUVertexBufferLayout.size,
		memberInfo: m.buffers,
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

