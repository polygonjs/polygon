import { _num } from "../utils/WebGPUUtils";
import { WGPUOrigin3D } from "../utils/WGPUStructInfos";

export function WGPUOrigin3DFromBuffer(p: bigint): GPUOrigin3D {
	const m = WGPUOrigin3D.members;
	//
	const x = _num(p, m.x);
	const y = _num(p, m.y);
	const z = _num(p, m.z);

	const desc: GPUOrigin3D = {
		x,
		y,
		z,
	};
	return desc;
}

