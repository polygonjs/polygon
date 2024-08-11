import { heapDelete, heapGet } from "../../WasmHeap";

export function wgpuSamplerRelease(samplerHeapIndex: bigint) {
	// console.log("wgpuSamplerRelease", samplerHeapIndex);
	const sampler = heapGet<GPUSampler>(samplerHeapIndex);
	if (sampler == null) {
		return;
	}
	if (sampler instanceof GPUSampler) {
		heapDelete(sampler);
	} else {
		console.error(
			`wgpuSamplerRelease: not a sampler view at index ${samplerHeapIndex}`
		);
		console.log(sampler);
	}
}
