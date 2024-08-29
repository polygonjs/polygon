import { _num } from "../utils/WebGPUUtils";
import { WGPUBindGroupLayoutEntry } from "../utils/WGPUStructInfos";
import { WGPUBufferBindingLayoutFromBuffer } from "./WGPUBufferBindingLayout";
import { WGPUSamplerBindingLayoutFromBuffer } from "./WGPUSamplerBindingLayout";
import { WGPUStorageTextureBindingLayoutFromBuffer } from "./WGPUStorageTextureBindingLayout";
import { WGPUTextureBindingLayoutFromBuffer } from "./WGPUTextureBindingLayout";

export function WGPUBindGroupLayoutEntryFromBuffer(
	p: bigint
): GPUBindGroupLayoutEntry {
	const m = WGPUBindGroupLayoutEntry.members;
	//
	const binding = _num(p, m.binding);
	const visibility = _num(p, m.visibility);
	//
	const layoutBuffer = WGPUBufferBindingLayoutFromBuffer(p + m.buffer.offset);
	const sampler = WGPUSamplerBindingLayoutFromBuffer(p + m.sampler.offset);
	const texture = WGPUTextureBindingLayoutFromBuffer(p + m.texture.offset);
	const storageTexture = WGPUStorageTextureBindingLayoutFromBuffer(
		p + m.storageTexture.offset
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

