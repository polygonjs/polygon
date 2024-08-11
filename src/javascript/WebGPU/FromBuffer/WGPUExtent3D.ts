import { WGPU_OFFSET } from "../utils/WebGPUOffset";
import { u32Create } from "../utils/WebGPUUtils";

export function WGPUExtent3DFromBuffer(pointer: bigint): GPUExtent3D {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const offset = WGPU_OFFSET.WGPUExtent3D;
	const u32 = new Uint32Array(buffer);

	const _u32 = u32Create(u32, pointer);
	//
	const width = _u32(offset.width);
	const height = _u32(offset.height);
	const depthOrArrayLayers = _u32(offset.depthOrArrayLayers);

	const desc: GPUExtent3D = {
		width,
		height,
		depthOrArrayLayers,
	};
	return desc;
}
