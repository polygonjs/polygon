import { heapGet } from "../../WasmHeap";
import { WGPU_OFFSET } from "../utils/WebGPUOffset";
import {
	createWGPUItemsByHeapIndex,
	labelFromBuffer,
	u64Create,
} from "../utils/WebGPUUtils";

export function WGPUPipelineLayoutDescriptorFromBuffer(
	pointer: bigint
): GPUPipelineLayoutDescriptor {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u64 = new BigUint64Array(buffer);
	const _u64 = u64Create(u64, pointer);
	//
	const offset = WGPU_OFFSET.WGPUPipelineLayoutDescriptor;

	//

	const label = labelFromBuffer(pointer, offset, u64);
	//
	const groupLayoutCount = _u64(offset.bindGroupLayoutCount);
	//
	const bindGroupLayouts: GPUBindGroupLayout[] = createWGPUItemsByHeapIndex({
		u64,
		pointer,
		arrayOffset: offset.bindGroupLayouts,
		itemsCount: groupLayoutCount,
		callback: (itemHeapIndex) => {
			const bindGroupLayout = heapGet<GPUBindGroupLayout>(itemHeapIndex);
			if (!bindGroupLayout) {
				console.error("bindGroupLayout is null");
				throw new Error("bindGroupLayout is null");
			}
			return bindGroupLayout;
		},
	});

	//
	const pipelineDescriptor: GPUPipelineLayoutDescriptor = {
		label,
		bindGroupLayouts,
	};
	// const pipelineLayout = device.createPipelineLayout(pipelineDescriptor);
	for (let i = 0; i < groupLayoutCount; i++) {
		// heapDeleteByItem(bindGroupLayouts[i]);
	}
	// TODO: run heapDelete for each bindGroupLayout ?
	return pipelineDescriptor;
}

