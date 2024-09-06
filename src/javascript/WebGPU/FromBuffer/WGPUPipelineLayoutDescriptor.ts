import { heapGet } from "../../WasmHeap";
import { _big, _label, createWGPUItemsByHeapIndex } from "../utils/WebGPUUtils";
import { WGPUPipelineLayoutDescriptor } from "../utils/WGPUStructInfos";

export function WGPUPipelineLayoutDescriptorFromBuffer(
	p: bigint
): GPUPipelineLayoutDescriptor {
	const m = WGPUPipelineLayoutDescriptor.members;
	//

	const label = _label(p, m);
	const bindGroupLayoutCount = _big(p, m.bindGroupLayoutCount);
	//
	const bindGroupLayouts: GPUBindGroupLayout[] = createWGPUItemsByHeapIndex({
		pointer: p,
		itemsCount: bindGroupLayoutCount,
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

	return pipelineDescriptor;
}

