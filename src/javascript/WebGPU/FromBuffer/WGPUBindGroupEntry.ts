import { heapGet } from "../../WasmHeap";
import { WGPU_OFFSET, WGPU_SIZE } from "../utils/WebGPUOffset";

export function WGPUBindGroupEntryFromBuffer(
	pointer: bigint,
	u32: Uint32Array,
	u64: BigUint64Array
): GPUBindGroupEntry {
	const offset = WGPU_OFFSET.WGPUBindGroupEntry;
	//
	const bindingOffset = offset.binding;
	const bindingSize = WGPU_SIZE.u32;
	const bindingStart = (pointer + bindingOffset) / bindingSize;
	const binding = u32[Number(bindingStart)];
	//
	const bufferOffset = offset.buffer;
	const bufferSize = WGPU_SIZE.u64;
	const bufferStart = (pointer + bufferOffset) / bufferSize;
	const bufferPointer = u64[Number(bufferStart)];
	const buffer = heapGet<GPUBuffer>(bufferPointer);
	//
	const offsetOffset = offset.offset;
	const offsetSize = WGPU_SIZE.u64;
	const offsetStart = (pointer + offsetOffset) / offsetSize;
	const offsetValue = Number(u64[Number(offsetStart)]);
	//
	const sizeOffset = offset.size;
	const sizeSize = WGPU_SIZE.u64;
	const sizeStart = (pointer + sizeOffset) / sizeSize;
	const size = Number(u64[Number(sizeStart)]);
	//
	const samplerOffset = offset.sampler;
	const samplerSize = WGPU_SIZE.u64;
	const samplerStart = (pointer + samplerOffset) / samplerSize;
	const samplerPointer = u64[Number(samplerStart)];
	const sampler = heapGet<GPUSampler>(samplerPointer);
	//
	const textureViewOffset = offset.textureView;
	const textureViewSize = WGPU_SIZE.u64;
	const textureViewStart = (pointer + textureViewOffset) / textureViewSize;
	const textureViewPointer = u64[Number(textureViewStart)];
	const textureView = heapGet<GPUTextureView>(textureViewPointer);

	if (!(buffer || sampler || textureView)) {
		throw new Error("buffer,sampler,textureView is null");
	}
	if (buffer) {
		const entry: GPUBindGroupEntry = {
			binding,
			resource: {
				buffer,
				offset: offsetValue,
				size,
			},
			// offset:offsetValue,
			// size,
			// sampler,
			// textureView,
		};
		return entry;
	} else if (sampler) {
		const entry: GPUBindGroupEntry = {
			binding,
			resource: sampler,
		};
		return entry;
	} else if (textureView) {
		const entry: GPUBindGroupEntry = {
			binding,
			resource: textureView,
		};
		return entry;
	}
	throw new Error("WGPUBindGroupEntryFromBuffer: fail");
}
