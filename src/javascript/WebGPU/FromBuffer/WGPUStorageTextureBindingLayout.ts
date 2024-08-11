import {
	storageTextureAccessIntToGPUStorageTextureAccess,
	textureFormatIntToGPUTextureFormat,
	textureViewDimentionIntToGPUTextureViewDimension,
} from "../utils/WebGPUMap";
import { WGPU_OFFSET } from "../utils/WebGPUOffset";
import { u32Create } from "../utils/WebGPUUtils";

export function WGPUStorageTextureBindingLayoutFromBuffer(
	pointer: bigint
): GPUStorageTextureBindingLayout | undefined {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u32 = new Uint32Array(buffer);
	const offset = WGPU_OFFSET.WGPUStorageTextureBindingLayout;
	const _u32 = u32Create(u32, pointer);
	//
	const access = storageTextureAccessIntToGPUStorageTextureAccess(
		_u32(offset.access)
	);
	if (access == null) {
		return;
	}
	const format = textureFormatIntToGPUTextureFormat(_u32(offset.format));
	const viewDimension = textureViewDimentionIntToGPUTextureViewDimension(
		_u32(offset.viewDimension)
	);

	const layout: GPUStorageTextureBindingLayout = {
		access,
		format,
		viewDimension,
	};
	return layout;
}
