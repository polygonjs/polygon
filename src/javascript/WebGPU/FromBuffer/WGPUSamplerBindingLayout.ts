import { samplerBindingTypeIntToGPUSamplerBindingType } from "../utils/WebGPUMap";
import { WGPU_OFFSET } from "../utils/WebGPUOffset";
import { u32Create } from "../utils/WebGPUUtils";

export function WGPUSamplerBindingLayoutFromBuffer(
	pointer: bigint
): GPUSamplerBindingLayout | undefined {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u32 = new Uint32Array(buffer);
	const _u32 = u32Create(u32, pointer);
	//
	const offset = WGPU_OFFSET.WGPUSamplerBindingLayout;
	//
	const type = samplerBindingTypeIntToGPUSamplerBindingType(
		_u32(offset.type)
	);
	if (type == null) {
		return;
	}

	const layout: GPUSamplerBindingLayout = {
		type,
	};
	return layout;
}

