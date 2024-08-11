import { textureAspectIntToGPUTextureAspect } from "../utils/WebGPUMap";
import { WGPU_OFFSET } from "../utils/WebGPUOffset";
import { heapGetItemFromOffset, u32Create } from "../utils/WebGPUUtils";
import { WGPUOrigin3DFromBuffer } from "./WGPUOrigin3D";

export function WGPUImageCopyTextureFromBuffer(
	pointer: bigint
): GPUImageCopyTexture {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const offset = WGPU_OFFSET.WGPUImageCopyTexture;
	const u32 = new Uint32Array(buffer);
	const u64 = new BigUint64Array(buffer);
	const _u32 = u32Create(u32, pointer);

	const texture = heapGetItemFromOffset<GPUTexture>(
		u64,
		pointer,
		offset.texture
	);
	if (!texture) {
		throw new Error("texture is null");
	}
	const mipLevel = _u32(offset.mipLevel);
	const origin = WGPUOrigin3DFromBuffer(pointer + offset.origin);

	const aspectb = _u32(offset.aspect);
	const aspect = textureAspectIntToGPUTextureAspect(aspectb);

	const desc: GPUImageCopyTexture = {
		texture,
		mipLevel,
		origin,
		aspect,
	};
	return desc;
}
