// wgpuCommandEncoderFinish :: (commandEncoder: WGPUCommandEncoder, descriptor: *WGPUCommandBufferDescriptor) -> WGPUCommandBuffer #foreign;

import { heapAdd, heapGet } from "../../WasmHeap";
import { WGPUCommandBufferDescriptorFromBuffer } from "../FromBuffer/WGPUCommandBufferDescriptor";

export function wgpuCommandEncoderFinish(
	commandEncoderHeadIndex: bigint,
	descriptorPointer: bigint
) {
	const commandEncoder = heapGet<GPUCommandEncoder>(commandEncoderHeadIndex)!;
	const desc = WGPUCommandBufferDescriptorFromBuffer(descriptorPointer);
	const commandBuffer = commandEncoder.finish(desc);
	const cmdBufferHeapIndex = heapAdd(commandBuffer);
	return cmdBufferHeapIndex;
}
