import { _str } from "../../wasm/WasmUtils";
import { WGPUShaderModuleWGSLDescriptor } from "../utils/WGPUStructInfos";

interface Mock_GPUShaderModuleWGSLDescriptor {
	code: string;
}
export function WGPUShaderModuleWGSLDescriptorFromBuffer(
	p: bigint
): Mock_GPUShaderModuleWGSLDescriptor {
	const m = WGPUShaderModuleWGSLDescriptor.members;

	const code = _str(p, m.code);
	if (!code) {
		throw new Error(
			"WGPUShaderModuleWGSLDescriptorFromBuffer:code is null"
		);
	}

	const descriptor: Mock_GPUShaderModuleWGSLDescriptor = {
		code,
	};
	return descriptor;
}

