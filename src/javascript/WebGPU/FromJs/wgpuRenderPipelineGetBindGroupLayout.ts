import { heapAdd, heapGet } from "../../WasmHeap";

export function wgpuRenderPipelineGetBindGroupLayout(
	pipelineHeapIndex: bigint,
	bind_group_index: number // u32
) {
	const pipeline = heapGet<GPURenderPipeline>(pipelineHeapIndex)!;
	const bindGroupLayout = pipeline.getBindGroupLayout(bind_group_index);
	return heapAdd(bindGroupLayout);
}
