import { heapGet } from "../../WasmHeap";

// wgpuRenderPassEncoderSetBindGroup :: (renderPassEncoder: WGPURenderPassEncoder, groupIndex: u32, group: WGPUBindGroup, dynamicOffsetCount: u64, dynamicOffsets: *u32) -> void #foreign;

export function wgpuRenderPassEncoderSetBindGroup(
	renderPassEncoderHeapIndex: bigint,
	groupIndex: number,
	groupHeapIndex: bigint,
	dynamicOffsetCount: bigint,
	_dynamicOffsetsPointer: bigint
): void {
	const renderPassEncoder = heapGet<GPURenderPassEncoder>(
		renderPassEncoderHeapIndex
	)!;
	const bindGroup = heapGet<GPUBindGroup>(groupHeapIndex)!;

	if (dynamicOffsetCount > 0) {
		console.warn(
			`dynamicOffsetCount>0 is not supported yet. dynamicOffsetCount=${dynamicOffsetCount}`
		);
	}

	return renderPassEncoder.setBindGroup(groupIndex, bindGroup);
}
