import { bufferTypeIntToGPUBufferBindingType } from "../utils/WebGPUMap";
import { WGPU_OFFSET } from "../utils/WebGPUOffset";
import { u32Create, u64Create } from "../utils/WebGPUUtils";

export function WGPUBufferBindingLayout(
	pointer: bigint
): GPUBufferBindingLayout | undefined {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u32 = new Uint32Array(buffer);
	const u64 = new BigUint64Array(buffer);
	const offset = WGPU_OFFSET.WGPUBufferBindingLayout;
	const _u32 = u32Create(u32, pointer);
	const _u64 = u64Create(u64, pointer);
	//
	const type = bufferTypeIntToGPUBufferBindingType(_u32(offset.type));
	if (type == null) {
		return;
	}
	const hasDynamicOffset = _u32(offset.hasDynamicOffset) > 0;
	const minBindingSize = Number(_u64(offset.minBindingSize));

	const layout: GPUBufferBindingLayout = {
		type,
		hasDynamicOffset,
		minBindingSize,
	};
	return layout;
}
