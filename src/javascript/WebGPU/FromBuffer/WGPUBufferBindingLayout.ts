import { bufferTypeIntToGPUBufferBindingType } from "../utils/WebGPUMap";
import { _big, _num } from "../../wasm/WasmUtils";
import { WGPUBufferBindingLayout } from "../utils/WGPUStructInfos";

export function WGPUBufferBindingLayoutFromBuffer(
	p: bigint
): GPUBufferBindingLayout | undefined {
	const m = WGPUBufferBindingLayout.members;
	//
	const type = bufferTypeIntToGPUBufferBindingType(_num(p, m.type));
	if (type == null) {
		return;
	}
	const hasDynamicOffset = _num(p, m.hasDynamicOffset) > 0;
	const minBindingSize = Number(_big(p, m.minBindingSize));

	const layout: GPUBufferBindingLayout = {
		type,
		hasDynamicOffset,
		minBindingSize,
	};
	return layout;
}

