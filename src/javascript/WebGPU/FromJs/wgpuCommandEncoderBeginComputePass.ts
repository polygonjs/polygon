import { heapAdd, heapGet } from "../../WasmHeap";
import { WGPUComputePassDescriptorFromBuffer } from "../FromBuffer/WGPUComputePassDescriptor";

export function wgpuCommandEncoderBeginComputePass(
	commandEncoderHeadIndex: bigint,
	descriptorPointer: bigint
) {
	const commandEncoder = heapGet<GPUCommandEncoder>(commandEncoderHeadIndex)!;
	const descriptor = WGPUComputePassDescriptorFromBuffer(descriptorPointer);
	const computePassEncoder = commandEncoder.beginComputePass(descriptor);
	return heapAdd(computePassEncoder);
}

