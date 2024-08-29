import { heapGet } from "../../WasmHeap";
import { _big, _label, _pointerValue } from "../utils/WebGPUUtils";
import { WGPUComputePipelineDescriptor } from "../utils/WGPUStructInfos";
import { WGPUProgrammableStageDescriptorFromBuffer } from "./WGPUProgrammableStageDescriptor";

export function WGPUComputePipelineDescriptorFromBuffer(
	p: bigint
): GPUComputePipelineDescriptor {
	const m = WGPUComputePipelineDescriptor.members;
	//
	const label = _label(p, m);
	const layoutPointer = _big(p, m.layout);
	const layout = heapGet<GPUPipelineLayout>(layoutPointer) || "auto";
	const compute = WGPUProgrammableStageDescriptorFromBuffer(
		p + m.compute.offset
	);
	//

	const desc: GPUComputePipelineDescriptor = {
		label,
		layout,
		compute,
	};
	return desc;
}

