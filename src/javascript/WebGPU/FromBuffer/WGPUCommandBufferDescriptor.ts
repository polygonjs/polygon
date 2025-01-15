import { _label } from "../../wasm/WasmUtils";
import { WGPUCommandBufferDescriptor } from "../utils/WGPUStructInfos";

export function WGPUCommandBufferDescriptorFromBuffer(
	p: bigint
): GPUCommandBufferDescriptor {
	const m = WGPUCommandBufferDescriptor.members;

	const label = _label(p, m);

	const desc: GPUCommandBufferDescriptor = { label };
	return desc;
}

