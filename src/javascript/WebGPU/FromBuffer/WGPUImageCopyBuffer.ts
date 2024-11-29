import { heapGet } from "../../WasmHeap";
import { _num, _pointerValue } from "../utils/WebGPUUtils";
import { WGPUImageCopyBuffer } from "../utils/WGPUStructInfos";
// import { WGPUTextureDataLayoutFromBuffer } from "./WGPUTextureDataLayout";

export function WGPUImageCopyBufferFromBuffer(p: bigint): GPUImageCopyBuffer {
	const m = WGPUImageCopyBuffer.members;

	const buffer = heapGet<GPUBuffer>(_pointerValue(p + m.buffer.offset));

	if (!buffer) {
		throw new Error("buffer is null");
	}
	// const layout = WGPUTextureDataLayoutFromBuffer(p + m.layout.offset);
	// const mipLevel = _num(p, m.mipLevel);
	// const origin = WGPUOrigin3DFromBuffer(p + m.origin.offset);

	// const aspect = textureAspectIntToGPUTextureAspect(aspectb);

	const imageCopyBuffer: GPUImageCopyBuffer = {
		buffer,
		// layout,
	};
	return imageCopyBuffer;
}

