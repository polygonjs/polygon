import { heapAdd, heapGet } from "../../WasmHeap";

export function wgpuComputePipelineGetBindGroupLayout(
	pipelineHeapIndex: bigint,
	bind_group_index: number
) {
	const pipeline = heapGet<GPUComputePipeline>(pipelineHeapIndex)!;
	const bindGroupLayout = pipeline.getBindGroupLayout(bind_group_index);
	return heapAdd(bindGroupLayout);
}

