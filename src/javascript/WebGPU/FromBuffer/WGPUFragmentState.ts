import { jsStringFromJaiStringWithoutLength } from "../../wasm/WasmString";
import { heapGet } from "../../WasmHeap";
import { WGPU_OFFSET, WGPU_SIZE } from "../utils/WebGPUOffset";
import { createWGPUItemsByPointer, u64Create } from "../utils/WebGPUUtils";
import { WGPUColorTargetStateFromBuffer } from "./WGPUColorTargetState";

export function WGPUFragmentStateFromBuffer(pointer: bigint): GPUFragmentState {
	const offset = WGPU_OFFSET.WGPUFragmentState;
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u64 = new BigUint64Array(buffer);
	const _u64 = u64Create(u64, pointer);
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
	const targetCount = _u64(offset.targetCount);

	const targets: GPUColorTargetState[] = createWGPUItemsByPointer({
		u64,
		pointer,
		arrayOffset: offset.targets,
		itemsCount: targetCount,
		itemSize: WGPU_SIZE.WGPUColorTargetState,
		callback: (itemPointer) => WGPUColorTargetStateFromBuffer(itemPointer),
	});

	//
	const fragment: GPUFragmentState = {
		module,
		entryPoint,
		targets,
	};
	return fragment;
}

