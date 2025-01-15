import { heapGet } from "../../WasmHeap";
import { _big, _num } from "../../wasm/WasmUtils";
import { WGPUBindGroupEntry } from "../utils/WGPUStructInfos";

export function WGPUBindGroupEntryFromBuffer(p: bigint): GPUBindGroupEntry {
	const m = WGPUBindGroupEntry.members;
	//
	const binding = _num(p, m.binding);
	//
	const bufferPointer = _big(p, m.buffer);
	const bufferValue = heapGet<GPUBuffer>(bufferPointer)!;
	const offsetValue = Number(_big(p, m.offset)!);

	const size = Number(_big(p, m.size));
	const samplerPointer = _big(p, m.sampler);
	const sampler = heapGet<GPUSampler>(samplerPointer);
	const textureViewPointer = _big(p, m.textureView);
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
	} else if (textureView) {
		const entry: GPUBindGroupEntry = {
			binding,
			resource: textureView,
		};
		// console.log("textureView:", { entry });
		return entry;
	} else if (sampler) {
		// see comment in WGPUBindGroupLayoutEntry.ts for explanation about the order of buffer/texture/sampler
		const entry: GPUBindGroupEntry = {
			binding,
			resource: sampler,
		};
		return entry;
	}
	throw new Error("WGPUBindGroupEntryFromBuffer: fail");
}

