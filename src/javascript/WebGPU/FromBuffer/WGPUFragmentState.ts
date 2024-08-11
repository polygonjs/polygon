import { jsStringFromJaiStringWithoutLength } from "../../wasm/WasmString";
import { heapGet } from "../../WasmHeap";
import { WGPU_OFFSET, WGPU_SIZE } from "../utils/WebGPUOffset";
import {
	createWGPUItemsByPointer,
	numberFromBuffer,
} from "../utils/WebGPUUtils";
import { WGPUColorTargetStateFromBuffer } from "./WGPUColorTargetState";

export function WGPUFragmentStateFromBuffer(
	pointer: bigint,
	u32: Uint32Array,
	u64: BigUint64Array
): GPUFragmentState {
	const offset = WGPU_OFFSET.WGPUFragmentState;

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
	const targetCount = numberFromBuffer(u64, pointer, offset.targetCount);

	const targets: GPUColorTargetState[] = createWGPUItemsByPointer({
		u64,
		pointer,
		arrayOffset: offset.targets,
		itemsCount: targetCount,
		itemSize: WGPU_SIZE.WGPUColorTargetState,
		callback: (itemPointer) =>
			WGPUColorTargetStateFromBuffer(itemPointer, u32, u64),
	});
	// const targetArrayPointerIndex = (pointer + offset.targets) / WGPU_SIZE.u64;
	// const targetArrayPointer = u64[Number(targetArrayPointerIndex)];
	// for (let i = 0; i < targetCount; i++) {
	// 	const targetPointer =
	// 		targetArrayPointer + BigInt(i) * WGPU_SIZE.WGPUColorTargetState;
	// 	const target = WGPUColorTargetStateFromBuffer(targetPointer, u32, u64);
	// 	targets.push(target);
	// }

	//
	const fragment: GPUFragmentState = {
		module,
		entryPoint,
		targets,
	};
	return fragment;
}
