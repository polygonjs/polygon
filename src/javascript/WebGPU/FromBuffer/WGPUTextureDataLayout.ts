import { WGPU_OFFSET } from "../utils/WebGPUOffset";
import { u32Create, u64Create } from "../utils/WebGPUUtils";

export function WGPUTextureDataLayout(pointer: bigint): GPUImageDataLayout {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const offset = WGPU_OFFSET.WGPUTextureDataLayout;
	const u32 = new Uint32Array(buffer);
	const u64 = new BigUint64Array(buffer);

	const _u32 = u32Create(u32, pointer);
	const _u64 = u64Create(u64, pointer);
	//
	const layoutOffset = _u64(offset.offset);
	const bytesPerRow = _u32(offset.bytesPerRow);
	const rowsPerImage = _u32(offset.rowsPerImage);

	const desc: GPUImageDataLayout = {
		offset: Number(layoutOffset),
		bytesPerRow,
		rowsPerImage,
	};
	return desc;
}
