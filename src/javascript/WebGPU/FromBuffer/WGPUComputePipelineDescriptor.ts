import { heapGet } from "../../WasmHeap";
import { WGPU_OFFSET } from "../utils/WebGPUOffset";
import { labelFromBuffer, u64Create } from "../utils/WebGPUUtils";
import { WGPUProgrammableStageDescriptorFromBuffer } from "./WGPUProgrammableStageDescriptor";

export function WGPUComputePipelineDescriptorFromBuffer(
	pointer: bigint
): GPUComputePipelineDescriptor {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u64 = new BigUint64Array(buffer);
	const _u64 = u64Create(u64, pointer);
	//
	const offset = WGPU_OFFSET.WGPUComputePipelineDescriptor;
	//
	const label = labelFromBuffer(pointer, offset, u64);
	const layoutPointer = _u64(offset.layout);
	const layout = heapGet<GPUPipelineLayout>(layoutPointer) || "auto";
	const compute = WGPUProgrammableStageDescriptorFromBuffer(
		pointer + offset.compute
	);
	//

	const desc: GPUComputePipelineDescriptor = {
		label,
		layout,
		compute,
	};
	return desc;
}

