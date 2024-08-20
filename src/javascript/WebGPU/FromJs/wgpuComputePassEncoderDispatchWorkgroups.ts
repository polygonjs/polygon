// wgpuComputePassEncoderDispatchWorkgroups :: (computePassEncoder: WGPUComputePassEncoder, workgroupCountX: u32, workgroupCountY: u32, workgroupCountZ: u32) -> void #foreign;

import { heapGet } from "../../WasmHeap";

export function wgpuComputePassEncoderDispatchWorkgroups(
	encoderHeadIndex: bigint,
	workgroupCountX: number,
	workgroupCountY: number,
	workgroupCountZ: number
) {
	const encoder = heapGet<GPUComputePassEncoder>(encoderHeadIndex)!;
	encoder.dispatchWorkgroups(
		workgroupCountX,
		workgroupCountY,
		workgroupCountZ
	);
}

