import { heapDeleteByIndex } from "../../WasmHeap";

export function wgpuSamplerRelease(samplerHeapIndex: bigint) {
	// console.log("wgpuSamplerRelease", samplerHeapIndex);
	heapDeleteByIndex(samplerHeapIndex);
	// const sampler = heapGet<GPUSampler>(samplerHeapIndex);
	// if (sampler == null) {
	// 	return;
	// }
	// if (sampler instanceof GPUSampler) {
	// 	heapDelete(sampler);
	// } else {
	// 	console.error(
	// 		`wgpuSamplerRelease: not a sampler view at index ${samplerHeapIndex}`
	// 	);
	// 	console.log(sampler);
	// }
}

