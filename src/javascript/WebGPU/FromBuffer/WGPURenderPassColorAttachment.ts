import { heapGet } from "../../WasmHeap";
import {
	loadOpIntToGPULoadOp,
	storeOpIntToGPUStoreOp,
} from "../utils/WebGPUMap";
import { WGPU_SIZE } from "../utils/WebGPUOffset";
import { _big, _num } from "../utils/WebGPUUtils";
import { WGPURenderPassColorAttachment } from "../utils/WGPUStructInfos";

export function WGPURenderPassColorAttachmentFromBuffer(
	p: bigint
): GPURenderPassColorAttachment {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	//
	// const offset = WGPU_OFFSET.WGPURenderPassColorAttachment;
	const m = WGPURenderPassColorAttachment.members;
	//
	const viewPointer = _big(p, m.view);
	const view = heapGet<GPUTextureView>(viewPointer)!;
	const resolveTargetPointer = _big(p, m.resolveTarget);
	const resolveTarget = heapGet<GPUTextureView>(resolveTargetPointer);
	//
	const clearValueOffset = m.clearValue.offset;
	const clearValueSize = WGPU_SIZE.float64;
	const clearValueStart = (p + clearValueOffset) / clearValueSize;
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
	const loadOp = loadOpIntToGPULoadOp(_num(p, m.loadOp));
	const storeOp = storeOpIntToGPUStoreOp(_num(p, m.storeOp));
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

