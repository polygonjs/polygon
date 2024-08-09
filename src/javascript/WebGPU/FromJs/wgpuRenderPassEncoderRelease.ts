import { heapDelete } from "../../WasmHeap";

export function wgpuRenderPassEncoderRelease(pointer: bigint) {
	// const renderPassEncoder = heapGet<GPURenderPassEncoder>(pointer);
	// console.log("wgpuRenderPassEncoderRelease", pointer, renderPassEncoder);
	heapDelete(pointer);
}
