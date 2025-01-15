import { vertexFormatIntToGPUVertexFormat } from "../utils/WebGPUMap";
import { _big, _num } from "../../wasm/WasmUtils";
import { WGPUVertexAttribute } from "../utils/WGPUStructInfos";

export function WGPUVertexAttributeFromBuffer(p: bigint): GPUVertexAttribute {
	const m = WGPUVertexAttribute.members;
	//
	const formatb = _num(p, m.format);
	const format = vertexFormatIntToGPUVertexFormat(Number(formatb));
	if (format == null) {
		throw new Error("format is null, memory is most likely corrupted");
	}
	//
	const offsetb = _big(p, m.offset);
	const shaderLocation = _num(p, m.shaderLocation);

	const attribute: GPUVertexAttribute = {
		format,
		offset: Number(offsetb),
		shaderLocation: shaderLocation,
	};

	return attribute;
}

