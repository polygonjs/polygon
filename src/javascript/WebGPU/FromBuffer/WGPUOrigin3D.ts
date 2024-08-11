import { WGPU_OFFSET } from "../utils/WebGPUOffset";
import { u32Create } from "../utils/WebGPUUtils";

export function WGPUOrigin3DFromBuffer(pointer: bigint): GPUOrigin3D {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const offset = WGPU_OFFSET.WGPUOrigin3D;
	const u32 = new Uint32Array(buffer);

	const _u32 = u32Create(u32, pointer);
	//
	const x = _u32(offset.x);
	const y = _u32(offset.y);
	const z = _u32(offset.z);

	const desc: GPUOrigin3D = {
		x,
		y,
		z,
	};
	return desc;
}
