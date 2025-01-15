import { heapGet } from "../../WasmHeap";
import { textureAspectIntToGPUTextureAspect } from "../utils/WebGPUMap";
import { _num, _pointerValue } from "../../wasm/WasmUtils";
import { WGPUImageCopyTexture } from "../utils/WGPUStructInfos";
import { WGPUOrigin3DFromBuffer } from "./WGPUOrigin3D";

export function WGPUImageCopyTextureFromBuffer(p: bigint): GPUImageCopyTexture {
	const m = WGPUImageCopyTexture.members;

	const texture = heapGet<GPUTexture>(_pointerValue(p + m.texture.offset));

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

