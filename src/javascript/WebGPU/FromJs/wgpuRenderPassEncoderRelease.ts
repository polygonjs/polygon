import { heapDeleteByIndex } from "../../WasmHeap";

export function wgpuRenderPassEncoderRelease(index: bigint) {
	// const renderPassEncoder = heapGet<GPURenderPassEncoder>(pointer);
	// console.log("wgpuRenderPassEncoderRelease", pointer, renderPassEncoder);
	heapDeleteByIndex(index);
}

