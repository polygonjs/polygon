import { _big, _label, _num } from "../utils/WebGPUUtils";
import { WGPUBufferDescriptor } from "../utils/WGPUStructInfos";

export function WGPUBufferDescriptorFromBuffer(p: bigint): GPUBufferDescriptor {
	const m = WGPUBufferDescriptor.members;
	//
	const label = _label(p, m);
	const usage = _num(p, m.usage);
	const size = Number(_big(p, m.size));
	const mappedAtCreation = Boolean(_num(p, m.mappedAtCreation));
	//
	const desc: GPUBufferDescriptor = {
		label,
		usage,
		size,
		mappedAtCreation,
	};
	return desc;
}

