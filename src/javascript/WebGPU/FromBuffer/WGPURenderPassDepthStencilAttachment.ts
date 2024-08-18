import { heapGet } from "../../WasmHeap";
import {
	loadOpIntToGPULoadOp,
	storeOpIntToGPUStoreOp,
} from "../utils/WebGPUMap";
import { f32Create, u32Create, u64Create } from "../utils/WebGPUUtils";
import { WGPU_OFFSET } from "./../utils/WebGPUOffset";
export function WGPURenderPassDepthStencilAttachmentFromBuffer(
	pointer: bigint
): GPURenderPassDepthStencilAttachment {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u64 = new BigUint64Array(buffer);
	const u32 = new Uint32Array(buffer);
	const f32 = new Float32Array(buffer);
	const _u32 = u32Create(u32, pointer);
	const _u64 = u64Create(u64, pointer);
	const _f32 = f32Create(f32, pointer);

	const offset = WGPU_OFFSET.WGPURenderPassDepthStencilAttachment;

	//
	const viewHeapIndex = _u64(offset.view);
	const view: GPUTextureView = heapGet<GPUTextureView>(viewHeapIndex)!;
	//

	const depthLoadOp = loadOpIntToGPULoadOp(_u32(offset.depthLoadOp));
	const depthStoreOp = storeOpIntToGPUStoreOp(_u32(offset.depthStoreOp));
	const depthClearValue = _f32(offset.depthClearValue);
	const depthReadOnly = _u32(offset.depthReadOnly) > 0.5 ? true : false;
	//
	const stencilLoadOp = loadOpIntToGPULoadOp(_u32(offset.stencilLoadOp));
	const stencilStoreOp = storeOpIntToGPUStoreOp(_u32(offset.stencilStoreOp));
	const stencilClearValue = _f32(offset.stencilClearValue);
	const stencilReadOnly = _u32(offset.stencilReadOnly) > 0.5 ? true : false;

	const desc: GPURenderPassDepthStencilAttachment = {
		view,
		depthLoadOp,
		depthStoreOp,
		depthClearValue,
		depthReadOnly,
		stencilLoadOp,
		stencilStoreOp,
		stencilClearValue,
		stencilReadOnly,
	};
	return desc;
}

