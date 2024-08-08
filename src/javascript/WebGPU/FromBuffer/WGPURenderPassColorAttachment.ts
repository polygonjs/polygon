import {
	loadOpIntToGPULoadOp,
	storeOpIntToGPUStoreOp,
} from "../utils/WebGPUMap";
import { WGPU_OFFSET, WGPU_SIZE } from "../utils/WebGPUOffset";

export function WGPURenderPassColorAttachmentFromBuffer(
	pointer: bigint,
	u32: Uint32Array,
	context: GPUCanvasContext
): GPURenderPassColorAttachment {
	const offset = WGPU_OFFSET.WGPURenderPassColorAttachment;
	//
	// const viewOffset = offset.view;
	// const viewSize = WGPU_SIZE.u64;
	// const viewStart = (pointer + viewOffset) / viewSize;
	// const viewPointer = u64[Number(viewStart)];
	const view = context.getCurrentTexture().createView(); //heapGet<GPUTextureView>(viewPointer);
	//
	const clearValueOffset = offset.clearValue;
	const clearValueSize = WGPU_SIZE.float64;
	const clearValueStart = (pointer + clearValueOffset) / clearValueSize;
	const start = Number(clearValueStart);
	const sizeN = Number(4);
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const f64 = new Float64Array(buffer).subarray(start, start + sizeN);
	const clearValue: GPUColor = [
		Number(f64[0]),
		Number(f64[1]),
		Number(f64[2]),
		Number(f64[3]),
	];
	console.log("clearValue:", clearValue);
	//
	const loadOpOffset = offset.loadOp;
	const loadOpSize = WGPU_SIZE.u32;
	const loadOpStart = (pointer + loadOpOffset) / loadOpSize;
	const loadOpb = u32[Number(loadOpStart)];
	const loadOp = loadOpIntToGPULoadOp(loadOpb);
	//
	const storeOpOffset = offset.storeOp;
	const storeOpSize = WGPU_SIZE.u32;
	const storeOpStart = (pointer + storeOpOffset) / storeOpSize;
	const storeOpb = u32[Number(storeOpStart)];
	const storeOp = storeOpIntToGPUStoreOp(storeOpb);
	//

	//
	const colorAttachment: GPURenderPassColorAttachment = {
		view,
		clearValue,
		loadOp,
		storeOp,
	};
	return colorAttachment;
}
