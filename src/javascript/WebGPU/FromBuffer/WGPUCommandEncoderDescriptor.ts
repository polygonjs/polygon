import { WGPU_OFFSET } from "../utils/WebGPUOffset";
import { labelFromBuffer } from "../utils/WebGPUUtils";

export function WGPUCommandEncoderDescriptorFromBuffer(
	pointer: bigint,
	u64: BigUint64Array
): GPUCommandEncoderDescriptor {
	const offset = WGPU_OFFSET.WGPUCommandEncoderDescriptor;
	//
	const label = labelFromBuffer(pointer, offset, u64);
	//
	const desc: GPUCommandEncoderDescriptor = { label };
	return desc;
}
