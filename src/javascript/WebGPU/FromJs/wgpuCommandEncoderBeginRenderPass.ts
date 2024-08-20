import { heapAdd, heapGet } from "../../WasmHeap";
import { WGPURenderPassDescriptorFromBuffer } from "../FromBuffer/WGPURenderPassDescriptor";

export function wgpuCommandEncoderBeginRenderPass(
	commandEncoderHeadIndex: bigint,
	descriptorPointer: bigint
) {
	const commandEncoder = heapGet<GPUCommandEncoder>(commandEncoderHeadIndex)!;
	const descriptor = WGPURenderPassDescriptorFromBuffer(descriptorPointer);
	const renderPassEncoder = commandEncoder.beginRenderPass(descriptor);
	return heapAdd(renderPassEncoder);
}

