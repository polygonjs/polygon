import { _label } from "../../wasm/WasmUtils";
import { WGPUComputePassDescriptor } from "../utils/WGPUStructInfos";

export function WGPUComputePassDescriptorFromBuffer(
	p: bigint
): GPUComputePassDescriptor {
	const m = WGPUComputePassDescriptor.members;
	//
	const label = _label(p, m);
	//

	const desc: GPUComputePassDescriptor = {
		label,
	};
	return desc;
}

