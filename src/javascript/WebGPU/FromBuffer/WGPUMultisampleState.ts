import { _num } from "../../wasm/WasmUtils";
import { WGPUMultisampleState } from "../utils/WGPUStructInfos";

export function WGPUMultisampleStateFromBuffer(p: bigint): GPUMultisampleState {
	const m = WGPUMultisampleState.members;
	//
	const count = _num(p, m.count);
	const mask = _num(p, m.mask);
	const alphaToCoverageEnabled = Boolean(_num(p, m.alphaToCoverageEnabled));

	//
	const multisampleState: GPUMultisampleState = {
		count,
		mask,
		alphaToCoverageEnabled,
	};
	return multisampleState;
}

