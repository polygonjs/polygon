import { heapGet } from "../../WasmHeap";
import { _big, _label, createWGPUItemsByHeapIndex } from "../utils/WebGPUUtils";
import { WGPUPipelineLayoutDescriptor } from "../utils/WGPUStructInfos";

export function WGPUPipelineLayoutDescriptorFromBuffer(
	p: bigint
): GPUPipelineLayoutDescriptor {
	const m = WGPUPipelineLayoutDescriptor.members;
	//

	const label = _label(p, m);
	const groupLayoutCount = _big(p, m.bindGroupLayoutCount);
	//
	const bindGroupLayouts: GPUBindGroupLayout[] = createWGPUItemsByHeapIndex({
		pointer: p,
		itemsCount: groupLayoutCount,
		memberInfo: m.bindGroupLayouts,
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

