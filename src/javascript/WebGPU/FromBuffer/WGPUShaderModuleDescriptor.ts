import { _big, _label } from "../utils/WebGPUUtils";
import { WGPUShaderModuleDescriptor } from "../utils/WGPUStructInfos";
import { WGPUShaderModuleWGSLDescriptorFromBuffer } from "./WGPUShaderModuleWGSLDescriptor";

export function WGPUShaderModuleDescriptorFromBuffer(
	p: bigint
): GPUShaderModuleDescriptor {
	const m = WGPUShaderModuleDescriptor.members;
	//
	const label = _label(p, m);
	//
	// const nextInChainPointerIndex =
	// (p + m.nextInChain.offset) / WGPU_SIZE.u64;
	const nextInChainPointer = _big(p, m.nextInChain); //u64[Number(nextInChainPointerIndex)];
	const wgslDescriptor =
		WGPUShaderModuleWGSLDescriptorFromBuffer(nextInChainPointer);

	const descriptor: GPUShaderModuleDescriptor = {
		label,
		code: wgslDescriptor.code,
	};
	return descriptor;
}

