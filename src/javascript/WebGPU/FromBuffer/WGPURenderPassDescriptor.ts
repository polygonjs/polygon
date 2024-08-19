import { WGPU_OFFSET, WGPU_SIZE } from "../utils/WebGPUOffset";
import {
	createWGPUItemsByPointer,
	labelFromBuffer,
	u64Create,
} from "../utils/WebGPUUtils";
import { WGPURenderPassColorAttachmentFromBuffer } from "./WGPURenderPassColorAttachment";
import { WGPURenderPassDepthStencilAttachmentFromBuffer } from "./WGPURenderPassDepthStencilAttachment";

export function WGPURenderPassDescriptorFromBuffer(
	pointer: bigint
): GPURenderPassDescriptor {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u64 = new BigUint64Array(buffer);
	const _u64 = u64Create(u64, pointer);
	//
	const offset = WGPU_OFFSET.WGPURenderPassDescriptor;
	//
	const label = labelFromBuffer(pointer, offset, u64);
	//
	const colorAttachmentCount = _u64(offset.colorAttachmentCount);
	const colorAttachments =
		createWGPUItemsByPointer<GPURenderPassColorAttachment>({
			u64,
			pointer,
			arrayOffset: offset.colorAttachments,
			itemsCount: colorAttachmentCount,
			itemSize: WGPU_SIZE.WGPURenderPassColorAttachment,
			callback: (itemPointer) => {
				return WGPURenderPassColorAttachmentFromBuffer(itemPointer);
			},
		});
	//

	const depthStencilAttachment =
		WGPURenderPassDepthStencilAttachmentFromBuffer(
			_u64(offset.depthStencilAttachment)
		);

	const desc: GPURenderPassDescriptor = {
		label,
		colorAttachments,
		depthStencilAttachment,
	};
	return desc;
}

