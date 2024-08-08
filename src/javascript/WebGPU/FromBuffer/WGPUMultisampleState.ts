import { WGPU_OFFSET, WGPU_SIZE } from "../utils/WebGPUOffset";

export function WGPUMultisampleStateFromBuffer(
	pointer: bigint,
	u32: Uint32Array
): GPUMultisampleState {
	const offset = WGPU_OFFSET.WGPUMultisampleState;
	//
	function getu32(pointerOffset: bigint) {
		const countSize = WGPU_SIZE.u32;
		const countStart = (pointer + pointerOffset) / countSize;
		return u32[Number(countStart)];
	}
	//
	const count = getu32(offset.count);
	const mask = getu32(offset.mask);
	const alphaToCoverageEnabled = Boolean(
		getu32(offset.alphaToCoverageEnabled)
	);

	//
	const multisampleState: GPUMultisampleState = {
		count,
		mask,
		alphaToCoverageEnabled,
	};
	return multisampleState;
}
