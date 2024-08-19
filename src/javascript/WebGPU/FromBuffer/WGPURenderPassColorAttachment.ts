import { heapGet } from "../../WasmHeap";
import {
	loadOpIntToGPULoadOp,
	storeOpIntToGPUStoreOp,
} from "../utils/WebGPUMap";
import { WGPU_OFFSET, WGPU_SIZE } from "../utils/WebGPUOffset";
import { u32Create, u64Create } from "../utils/WebGPUUtils";

export function WGPURenderPassColorAttachmentFromBuffer(
	pointer: bigint
): GPURenderPassColorAttachment {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u32 = new Uint32Array(buffer);
	const u64 = new BigUint64Array(buffer);
	const _u32 = u32Create(u32, pointer);
	const _u64 = u64Create(u64, pointer);
	//
	const offset = WGPU_OFFSET.WGPURenderPassColorAttachment;
	//
	const viewPointer = _u64(offset.view);
	const view = heapGet<GPUTextureView>(viewPointer)!;
	const resolveTargetPointer = _u64(offset.resolveTarget);
	const resolveTarget = heapGet<GPUTextureView>(resolveTargetPointer);
	//
	const clearValueOffset = offset.clearValue;
	const clearValueSize = WGPU_SIZE.float64;
	const clearValueStart = (pointer + clearValueOffset) / clearValueSize;
	const start = Number(clearValueStart);
	const sizeN = Number(4);
	const f64 = new Float64Array(buffer).subarray(start, start + sizeN);
	const clearValue: GPUColor = [
		Number(f64[0]),
		Number(f64[1]),
		Number(f64[2]),
		Number(f64[3]),
	];
	//
	const loadOp = loadOpIntToGPULoadOp(_u32(offset.loadOp));
	const storeOp = storeOpIntToGPUStoreOp(_u32(offset.storeOp));
	//

	//
	const colorAttachment: GPURenderPassColorAttachment = {
		view,
		resolveTarget,
		clearValue,
		loadOp,
		storeOp,
	};
	return colorAttachment;
}

