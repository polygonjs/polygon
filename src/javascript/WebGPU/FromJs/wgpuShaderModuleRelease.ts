import { heapDeleteByIndex } from "../../WasmHeap";

export function wgpuShaderModuleRelease(heapIndex: bigint) {
	heapDeleteByIndex(heapIndex);
	// const shaderModule = heapGet<GPUShaderModule>(heapIndex);
	// if (shaderModule == null) {
	// 	return;
	// }
	// if (shaderModule instanceof GPUShaderModule) {

	// } else {
	// 	console.warn(
	// 		`wgpuShaderModuleRelease: not a shader module at index ${heapIndex}`
	// 	);
	// }
}

