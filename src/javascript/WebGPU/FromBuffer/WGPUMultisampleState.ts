import { WGPU_OFFSET } from "../utils/WebGPUOffset";
import { u32Create } from "../utils/WebGPUUtils";

export function WGPUMultisampleStateFromBuffer(
	pointer: bigint
): GPUMultisampleState {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u32 = new Uint32Array(buffer);
	const _u32 = u32Create(u32, pointer);
	//
	const offset = WGPU_OFFSET.WGPUMultisampleState;
	//

	const count = _u32(offset.count);
	const mask = _u32(offset.mask);
	const alphaToCoverageEnabled = Boolean(_u32(offset.alphaToCoverageEnabled));

	//
	const multisampleState: GPUMultisampleState = {
		count,
		mask,
		alphaToCoverageEnabled,
	};
	return multisampleState;
}

