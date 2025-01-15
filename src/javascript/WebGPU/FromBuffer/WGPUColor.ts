import { _num } from "../../wasm/WasmUtils";
import { WGPUColor } from "../utils/WGPUStructInfos";

export function WGPUColorFromBuffer(p: bigint): GPUColorDict /*GPUColor*/ {
	const m = WGPUColor.members;

	const r = _num(p, m.r);
	const g = _num(p, m.g);
	const b = _num(p, m.b);
	const a = _num(p, m.a);

	const color: GPUColorDict = { r, g, b, a };
	return color;
}

