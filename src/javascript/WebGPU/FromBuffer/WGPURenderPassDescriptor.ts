import { WGPU_OFFSET, WGPU_SIZE } from "../utils/WebGPUOffset";
import {
	createWGPUItemsByPointer,
	labelFromBuffer,
	numberFromBuffer,
} from "../utils/WebGPUUtils";
import { WGPURenderPassColorAttachmentFromBuffer } from "./WGPURenderPassColorAttachment";

export function WGPURenderPassDescriptorFromBuffer(
	pointer: bigint,
	u64: BigUint64Array,
	u32: Uint32Array,
	context: GPUCanvasContext
): GPURenderPassDescriptor {
	const offset = WGPU_OFFSET.WGPURenderPassDescriptor;
	//
	const label = labelFromBuffer(pointer, offset, u64);
	//
	const colorAttachmentCount = numberFromBuffer(
		u64,
		pointer,
		offset.colorAttachmentCount
	);
	const colorAttachments =
		createWGPUItemsByPointer<GPURenderPassColorAttachment>({
			u64,
			pointer,
			arrayOffset: offset.colorAttachments,
			itemsCount: colorAttachmentCount,
			itemSize: WGPU_SIZE.WGPURenderPassColorAttachment,
			callback: (itemPointer) => {
				return WGPURenderPassColorAttachmentFromBuffer(
					itemPointer,
					u32,
					context
				);
			},
		});
	//
	const desc: GPURenderPassDescriptor = { label, colorAttachments };
	return desc;
}
