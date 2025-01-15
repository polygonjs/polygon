import { _big, _label, createItemsByPointer } from "../../wasm/WasmUtils";
import {
	WGPURenderPassColorAttachment,
	WGPURenderPassDescriptor,
} from "../utils/WGPUStructInfos";
import { WGPURenderPassColorAttachmentFromBuffer } from "./WGPURenderPassColorAttachment";
import { WGPURenderPassDepthStencilAttachmentFromBuffer } from "./WGPURenderPassDepthStencilAttachment";

export function WGPURenderPassDescriptorFromBuffer(
	p: bigint
): GPURenderPassDescriptor {
	const m = WGPURenderPassDescriptor.members;
	//
	const label = _label(p, m);
	//
	const colorAttachmentCount = _big(p, m.colorAttachmentCount);
	const colorAttachments = createItemsByPointer<GPURenderPassColorAttachment>(
		{
			pointer: p,
			itemsCount: colorAttachmentCount,
			itemSize: WGPURenderPassColorAttachment.size,
			memberInfo: m.colorAttachments,
			callback: (itemPointer) => {
				return WGPURenderPassColorAttachmentFromBuffer(itemPointer);
			},
		}
	);
	//

	const depthStencilAttachment =
		WGPURenderPassDepthStencilAttachmentFromBuffer(
			_big(p, m.depthStencilAttachment)
		);

	const desc: GPURenderPassDescriptor = {
		label,
		colorAttachments,
		depthStencilAttachment,
	};
	return desc;
}

