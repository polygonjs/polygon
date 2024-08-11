import { heapDelete, heapGet } from "../../WasmHeap";

export function wgpuShaderModuleRelease(heapIndex: bigint) {
	const shaderModule = heapGet<GPUShaderModule>(heapIndex);
	if (shaderModule == null) {
		return;
	}
	if (shaderModule instanceof GPUShaderModule) {
		heapDelete(heapIndex);
	} else {
		console.warn(
			`wgpuShaderModuleRelease: not a shader module at index ${heapIndex}`
		);
	}
}
