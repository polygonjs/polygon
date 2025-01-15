import { jsStringFromJaiStringWithoutLength } from "../../wasm/WasmString";
import { heapGet } from "../../WasmHeap";
import { _big, createItemsByPointer } from "../../wasm/WasmUtils";
import {
	WGPUColorTargetState,
	WGPUFragmentState,
} from "../utils/WGPUStructInfos";
import { WGPUColorTargetStateFromBuffer } from "./WGPUColorTargetState";

export function WGPUFragmentStateFromBuffer(p: bigint): GPUFragmentState {
	const m = WGPUFragmentState.members;
	//
	const moduleHeapIndex = _big(p, m.module); //u64[Number(modulePointer)];
	const module = heapGet<GPUShaderModule>(moduleHeapIndex);
	if (!module) {
		throw new Error("module is null");
	}
	//
	// const entryPointOffset = offset.entryPoint;
	// const entryPointSize = WGPU_SIZE.u64;
	// const entryPointStart = (pointer + entryPointOffset) / entryPointSize;
	const entryPointPointer = _big(p, m.entryPoint); //u64[Number(entryPointStart)];
	const entryPoint = jsStringFromJaiStringWithoutLength(
		BigInt(entryPointPointer)
	);
	//
	const targetCount = _big(p, m.targetCount);

	const targets: GPUColorTargetState[] =
		createItemsByPointer<GPUColorTargetState>({
			pointer: p,
			itemsCount: targetCount,
			itemSize: WGPUColorTargetState.size,
			memberInfo: m.targets,
			callback: (itemPointer) =>
				WGPUColorTargetStateFromBuffer(itemPointer),
		});

	//
	const fragment: GPUFragmentState = {
		module,
		entryPoint,
		targets,
	};
	return fragment;
}

