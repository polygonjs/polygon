import { heapGet } from "../../WasmHeap";

export function wgpuRenderPassEncoderSetPipeline(
	encoderHeapIndex: bigint,
	pipelineHeapIndex: bigint
) {
	const encoder = heapGet<GPURenderPassEncoder>(encoderHeapIndex)!;
	const pipeline = heapGet<GPURenderPipeline>(pipelineHeapIndex)!;
	return encoder.setPipeline(pipeline);
}

