import { heapGet } from "../../WasmHeap";
import { WGPU_OFFSET } from "../utils/WebGPUOffset";
import { stringFromBuffer, u64Create } from "../utils/WebGPUUtils";

export function WGPUProgrammableStageDescriptorFromBuffer(
	pointer: bigint
): GPUProgrammableStage {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u64 = new BigUint64Array(buffer);
	const _u64 = u64Create(u64, pointer);
	//
	const offset = WGPU_OFFSET.WGPUProgrammableStageDescriptor;
	//
	const entryPoint = stringFromBuffer(pointer, offset.entryPoint, u64);
	const modulePointer = _u64(offset.module);
	const module = heapGet<GPUShaderModule>(modulePointer);
	if (!module) {
		throw new Error("module is null");
	}

	const desc: GPUProgrammableStage = {
		entryPoint,
		module,
	};
	return desc;
}

