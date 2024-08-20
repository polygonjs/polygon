import { heapGet } from "../../WasmHeap";

export function wgpuComputePassEncoderSetBindGroup(
	encoderHeapIndex: bigint,
	groupIndex: number,
	groupHeapIndex: bigint,
	dynamicOffsetCount: bigint,
	_dynamicOffsetsPointer: bigint
) {
	const encoder = heapGet<GPUComputePassEncoder>(encoderHeapIndex)!;
	const bindGroup = heapGet<GPUBindGroup>(groupHeapIndex)!;

	if (dynamicOffsetCount > 0) {
		console.warn(
			`dynamicOffsetCount>0 is not supported yet. dynamicOffsetCount=${dynamicOffsetCount}`
		);
	}

	return encoder.setBindGroup(groupIndex, bindGroup);
}

