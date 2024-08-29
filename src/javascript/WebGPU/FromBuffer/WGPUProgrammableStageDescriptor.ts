import { heapGet } from "../../WasmHeap";
import { _big, _str } from "../utils/WebGPUUtils";
import { WGPUProgrammableStageDescriptor } from "../utils/WGPUStructInfos";

export function WGPUProgrammableStageDescriptorFromBuffer(
	p: bigint
): GPUProgrammableStage {
	const m = WGPUProgrammableStageDescriptor.members;
	//
	const entryPoint = _str(p, m.entryPoint);
	const modulePointer = _big(p, m.module);
	const module = heapGet<GPUShaderModule>(modulePointer);
	if (!module) {
		throw new Error("module is null");
	}

	const desc: GPUProgrammableStage = {
		entryPoint,
		module,
	};
	return desc;
}

