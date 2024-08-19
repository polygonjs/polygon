import { WGPU_OFFSET } from "../utils/WebGPUOffset";
import { u32Create } from "../utils/WebGPUUtils";
import { WGPUBufferBindingLayout } from "./WGPUBufferBindingLayout";
import { WGPUSamplerBindingLayoutFromBuffer } from "./WGPUSamplerBindingLayout";
import { WGPUStorageTextureBindingLayoutFromBuffer } from "./WGPUStorageTextureBindingLayout";
import { WGPUTextureBindingLayoutFromBuffer } from "./WGPUTextureBindingLayout";

export function WGPUBindGroupLayoutEntryFromBuffer(
	pointer: bigint
): GPUBindGroupLayoutEntry {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u32 = new Uint32Array(buffer);
	const _u32 = u32Create(u32, pointer);
	//
	const offset = WGPU_OFFSET.WGPUBindGroupLayoutEntry;
	//
	const binding = _u32(offset.binding);
	const visibility = _u32(offset.visibility);
	//
	const layoutBuffer = WGPUBufferBindingLayout(pointer + offset.buffer);
	const sampler = WGPUSamplerBindingLayoutFromBuffer(
		pointer + offset.sampler
	);
	const texture = WGPUTextureBindingLayoutFromBuffer(
		pointer + offset.texture
	);
	const storageTexture = WGPUStorageTextureBindingLayoutFromBuffer(
		pointer + offset.storageTexture
	);

	const entry: GPUBindGroupLayoutEntry = {
		binding,
		visibility,
		buffer: layoutBuffer, //: { type: bufferType },
		sampler,
		texture,
		storageTexture,
		externalTexture: undefined, // there is not externalTexture in native for now
	};
	return entry;
}

