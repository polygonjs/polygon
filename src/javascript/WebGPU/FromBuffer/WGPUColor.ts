import { _num } from "../utils/WebGPUUtils";
import { WGPUColor } from "../utils/WGPUStructInfos";

export function WGPUColorFromBuffer(p: bigint): GPUColor {
	const m = WGPUColor.members;

	const r = _num(p, m.r);
	const g = _num(p, m.g);
	const b = _num(p, m.b);
	const a = _num(p, m.a);

	const color: GPUColor = { r, g, b, a };
	return color;
}

