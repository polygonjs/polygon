import { WGPU_OFFSET } from "../utils/WebGPUOffset";
import { f64Create } from "../utils/WebGPUUtils";

export function WGPUColorFromBuffer(pointer: bigint): GPUColor {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const offset = WGPU_OFFSET.WGPUColor;
	const u64 = new Float64Array(buffer);

	const _f64 = f64Create(u64, pointer);

	const r = _f64(offset.r);
	const g = _f64(offset.g);
	const b = _f64(offset.b);
	const a = _f64(offset.a);

	const color: GPUColor = { r, g, b, a };
	return color;
}
