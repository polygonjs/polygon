import { _num } from "../../wasm/WasmUtils";
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
	const buffer = WGPUBufferBindingLayoutFromBuffer(p + m.buffer.offset);

	const entry: GPUBindGroupLayoutEntry = {
		binding,
		visibility,
		// buffer,
		// texture,
		// storageTexture,
		// sampler,
		externalTexture: undefined, // there is not externalTexture in native for now
	};
	if (buffer) {
		entry.buffer = buffer;
		return entry;
	}
	const texture = WGPUTextureBindingLayoutFromBuffer(p + m.texture.offset);
	if (texture) {
		entry.texture = texture;
		return entry;
	}
	const storageTexture = WGPUStorageTextureBindingLayoutFromBuffer(
		p + m.storageTexture.offset
	);
	if (storageTexture) {
		entry.storageTexture = storageTexture;
		return entry;
	}
	const sampler = WGPUSamplerBindingLayoutFromBuffer(p + m.sampler.offset);
	if (sampler) {
		// we use the sampler last,
		// since it's currently hard to tell if the sample is null or not, since its type can be null,
		// and we therefore always return something. Maybe that should be done differently.
		// the same thing is done in WGPUBindGroupEntry.ts
		entry.sampler = sampler;
		return entry;
	}
	return entry;
}

