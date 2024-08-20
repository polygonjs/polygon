import { heapGet } from "../../WasmHeap";

export function wgpuComputePassEncoderSetPipeline(
	encoderHeapIndex: bigint,
	pipelineHeapIndex: bigint
) {
	const renderPassEncoder = heapGet<GPUComputePassEncoder>(encoderHeapIndex)!;
	const pipeline = heapGet<GPUComputePipeline>(pipelineHeapIndex)!;
	return renderPassEncoder.setPipeline(pipeline);
}

