import { _num } from "../../wasm/WasmUtils";
import { WGPUExtent3D } from "../utils/WGPUStructInfos";

export function WGPUExtent3DFromBuffer(p: bigint): GPUExtent3D {
	const m = WGPUExtent3D.members;

	const width = _num(p, m.width);
	const height = _num(p, m.height);
	const depthOrArrayLayers = _num(p, m.depthOrArrayLayers);

	const desc: GPUExtent3D = {
		width,
		height,
		depthOrArrayLayers,
	};
	return desc;
}

