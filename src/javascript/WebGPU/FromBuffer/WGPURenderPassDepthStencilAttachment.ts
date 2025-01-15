import { heapGet } from "../../WasmHeap";
import {
	loadOpIntToGPULoadOp,
	storeOpIntToGPUStoreOp,
} from "../utils/WebGPUMap";
import { _big, _num } from "../../wasm/WasmUtils";
import { WGPURenderPassDepthStencilAttachment } from "../utils/WGPUStructInfos";
export function WGPURenderPassDepthStencilAttachmentFromBuffer(
	p: bigint
): GPURenderPassDepthStencilAttachment | undefined {
	const m = WGPURenderPassDepthStencilAttachment.members;

	//
	const viewHeapIndex = _big(p, m.view);
	const view = heapGet<GPUTextureView>(viewHeapIndex);
	if (view == null) {
		return;
	}
	//

	const depthLoadOp = loadOpIntToGPULoadOp(_num(p, m.depthLoadOp));
	const depthStoreOp = storeOpIntToGPUStoreOp(_num(p, m.depthStoreOp));
	const depthClearValue = _num(p, m.depthClearValue);
	const depthReadOnly = _num(p, m.depthReadOnly) > 0.5 ? true : false;
	//
	const stencilLoadOp = loadOpIntToGPULoadOp(_num(p, m.stencilLoadOp));
	const stencilStoreOp = storeOpIntToGPUStoreOp(_num(p, m.stencilStoreOp));
	const stencilClearValue = _num(p, m.stencilClearValue);
	const stencilReadOnly = _num(p, m.stencilReadOnly) > 0.5 ? true : false;

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

