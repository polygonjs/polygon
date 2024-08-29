import { heapGet } from "../../WasmHeap";
import { _pointerValue } from "../utils/WebGPUUtils";

export function WGPUCommandBufferFromBuffer(pointer: bigint): GPUCommandBuffer {
	const pointerValue = _pointerValue(pointer); //u64[Number(pointer / WGPU_SIZE.u64)];
	const commandBuffer = heapGet<GPUCommandBuffer>(pointerValue)!;
	return commandBuffer;
}

