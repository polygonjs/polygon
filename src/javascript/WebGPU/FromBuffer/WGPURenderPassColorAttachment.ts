import { heapGet } from "../../WasmHeap";
import {
	loadOpIntToGPULoadOp,
	storeOpIntToGPUStoreOp,
} from "../utils/WebGPUMap";
import { _big, _num, _pointerValue } from "../../wasm/WasmUtils";
import { WGPURenderPassColorAttachment } from "../utils/WGPUStructInfos";
import { WGPUColorFromBuffer } from "./WGPUColor";

export function WGPURenderPassColorAttachmentFromBuffer(
	p: bigint
): GPURenderPassColorAttachment {
	//
	const m = WGPURenderPassColorAttachment.members;
	//
	const viewPointer = _big(p, m.view);
	const view = heapGet<GPUTextureView>(viewPointer)!;
	const resolveTargetPointer = _big(p, m.resolveTarget);
	const resolveTarget = heapGet<GPUTextureView>(resolveTargetPointer);
	//
	const clearValue = WGPUColorFromBuffer(p + m.clearValue.offset);
	// const clearValue: GPUColorDict = { r: 0, g: 0, b: 0, a: 1 };
	// srgbToLinear(clearValueSRGB, clearValue);
	// console.log(clearValueSRGB, clearValue);
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

// function srgbToLinearNum(color: number) {
// 	return color <= 0.04045
// 		? color / 12.92
// 		: Math.pow((color + 0.055) / 1.055, 2.4);
// }
// function srgbToLinear(color: GPUColorDict, target: GPUColorDict) {
// 	target.r = srgbToLinearNum(color.r);
// 	target.g = srgbToLinearNum(color.g);
// 	target.b = srgbToLinearNum(color.b);
// }

