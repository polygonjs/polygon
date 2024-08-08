import { jsStringFromJaiStringWithoutLength } from "../../wasm/StringUtils";
import { heapGet } from "../../WasmHeap";
import { WGPU_OFFSET, WGPU_SIZE } from "../utils/WebGPUOffset";
import {
	createWGPUItemsByPointer,
	numberFromBuffer,
} from "../utils/WebGPUUtils";
import { WGPUVertexBufferLayoutFromBuffer } from "./WGPUVertexBufferLayout";

export function WGPUVertexStateFromBuffer(
	pointer: bigint,
	u32: Uint32Array,
	u64: BigUint64Array
): GPUVertexState {
	const offset = WGPU_OFFSET.WGPUVertexState;
	//
	const modulePointer = (pointer + offset.module) / WGPU_SIZE.u64;
	const moduleHeapIndex = u64[Number(modulePointer)];
	const module = heapGet<GPUShaderModule>(moduleHeapIndex);
	if (!module) {
		throw new Error("module is null");
	}
	//
	const entryPointOffset = offset.entryPoint;
	const entryPointSize = WGPU_SIZE.u64;
	const entryPointStart = (pointer + entryPointOffset) / entryPointSize;
	const entryPointPointer = u64[Number(entryPointStart)];
	const entryPoint = jsStringFromJaiStringWithoutLength(
		BigInt(entryPointPointer)
	);
	//
	// const constantCountOffset = offset.constantCount;
	// const constantCountSize = SIZE.u64;
	// const constantCountStart = (pointer + constantCountOffset) / constantCountSize;
	// const constantCountb = u64[Number(constantCountStart)];
	//
	const bufferCount = numberFromBuffer(u64, pointer, offset.bufferCount);

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
			WGPUVertexBufferLayoutFromBuffer(itemPointer, u32, u64),
	});
	// const bufferLayoutArrayPointerIndex =
	// 	(pointer + offset.buffers) / WGPU_SIZE.u64;
	// const bufferLayoutArrayPointer = u64[Number(bufferLayoutArrayPointerIndex)];
	// for (let i = 0; i < bufferCount; i++) {
	// 	const bufferLayoutPointer =
	// 		bufferLayoutArrayPointer +
	// 		BigInt(i) * WGPU_SIZE.WGPUVertexBufferLayout;

	// 	const bufferLayout = WGPUVertexBufferLayoutFromBuffer(
	// 		bufferLayoutPointer,
	// 		u32,
	// 		u64
	// 	);
	// 	buffers.push(bufferLayout);
	// }

	// console.log({ module, entryPoint });
	const vertexState: GPUVertexState = {
		module,
		entryPoint,
		buffers,
	};
	return vertexState;
}
