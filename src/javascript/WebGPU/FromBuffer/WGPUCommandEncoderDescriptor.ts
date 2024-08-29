import { _label } from "../utils/WebGPUUtils";
import { WGPUCommandEncoderDescriptor } from "../utils/WGPUStructInfos";

export function WGPUCommandEncoderDescriptorFromBuffer(
	p: bigint
): GPUCommandEncoderDescriptor {
	const m = WGPUCommandEncoderDescriptor.members;
	//
	const label = _label(p, m);
	//
	const desc: GPUCommandEncoderDescriptor = { label };
	return desc;
}

