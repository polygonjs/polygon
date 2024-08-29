import { textureAspectIntToGPUTextureAspect } from "../utils/WebGPUMap";
import { _num, heapGetItemFromOffset } from "../utils/WebGPUUtils";
import { WGPUImageCopyTexture } from "../utils/WGPUStructInfos";
import { WGPUOrigin3DFromBuffer } from "./WGPUOrigin3D";

export function WGPUImageCopyTextureFromBuffer(p: bigint): GPUImageCopyTexture {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const m = WGPUImageCopyTexture.members;
	const u64 = new BigUint64Array(buffer);

	const texture = heapGetItemFromOffset<GPUTexture>(u64, p, m.texture.offset);
	if (!texture) {
		throw new Error("texture is null");
	}
	const mipLevel = _num(p, m.mipLevel);
	const origin = WGPUOrigin3DFromBuffer(p + m.origin.offset);

	const aspectb = _num(p, m.aspect);
	const aspect = textureAspectIntToGPUTextureAspect(aspectb);

	const desc: GPUImageCopyTexture = {
		texture,
		mipLevel,
		origin,
		aspect,
	};
	return desc;
}

