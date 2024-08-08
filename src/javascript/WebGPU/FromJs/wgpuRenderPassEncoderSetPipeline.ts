import { heapGet } from "../../WasmHeap";

export function wgpuRenderPassEncoderSetPipeline(
	renderPassEncoderHeapIndex: bigint,
	pipelineHeapIndex: bigint
) {
	const renderPassEncoder = heapGet<GPURenderPassEncoder>(
		renderPassEncoderHeapIndex
	)!;
	const pipeline = heapGet<GPURenderPipeline>(pipelineHeapIndex)!;
	return renderPassEncoder.setPipeline(pipeline);
}
