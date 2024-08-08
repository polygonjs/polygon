import { heapAdd, heapGet } from "../../WasmHeap";
import { WGPURenderPassDescriptorFromBuffer } from "../FromBuffer/WGPURenderPassDescriptor";

export function wgpuCommandEncoderBeginRenderPass(
	commandEncoderHeadIndex: bigint,
	// commandEncoder: GPUCommandEncoder,
	descriptorPointer: bigint
) {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u64 = new BigUint64Array(buffer);
	const u32 = new Uint32Array(buffer);
	const commandEncoder = heapGet<GPUCommandEncoder>(commandEncoderHeadIndex)!;
	const descriptor = WGPURenderPassDescriptorFromBuffer(
		descriptorPointer,
		u64,
		u32,
		window.webGPUContext
	);
	const renderPassEncoder = commandEncoder.beginRenderPass(descriptor);
	return heapAdd(renderPassEncoder);
}
