import { heapGet } from "../../WasmHeap";
import { WGPU_OFFSET } from "../utils/WebGPUOffset";
import { u32Create, u64Create } from "../utils/WebGPUUtils";

export function WGPUBindGroupEntryFromBuffer(
	pointer: bigint
	// u32: Uint32Array,
	// u64: BigUint64Array
): GPUBindGroupEntry {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u32 = new Uint32Array(buffer);
	const u64 = new BigUint64Array(buffer);
	const _u32 = u32Create(u32, pointer);
	const _u64 = u64Create(u64, pointer);
	//
	const offset = WGPU_OFFSET.WGPUBindGroupEntry;
	//
	const binding = _u32(offset.binding);
	//
	const bufferPointer = _u64(offset.buffer);
	const bufferValue = heapGet<GPUBuffer>(bufferPointer)!;
	const offsetValue = Number(_u64(offset.offset)!);

	const size = Number(_u64(offset.size));
	const samplerPointer = _u64(offset.sampler);
	const sampler = heapGet<GPUSampler>(samplerPointer);
	const textureViewPointer = _u64(offset.textureView);
	const textureView = heapGet<GPUTextureView>(textureViewPointer);

	if (!(bufferValue || sampler || textureView)) {
		throw new Error("buffer,sampler,textureView is null");
	}
	if (bufferValue) {
		const entry: GPUBindGroupEntry = {
			binding,
			resource: {
				buffer: bufferValue,
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

