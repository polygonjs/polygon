import { vertexFormatIntToGPUVertexFormat } from "../utils/WebGPUMap";
import { WGPU_OFFSET } from "../utils/WebGPUOffset";
import { u32Create, u64Create } from "../utils/WebGPUUtils";

export function WGPUVertexAttributeFromBuffer(
	pointer: bigint
): GPUVertexAttribute {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u32 = new Uint32Array(buffer);
	const u64 = new BigUint64Array(buffer);
	const _u32 = u32Create(u32, pointer);
	const _u64 = u64Create(u64, pointer);
	//
	const offset = WGPU_OFFSET.WGPUVertexAttribute;
	//
	const formatb = _u32(offset.format);
	const format = vertexFormatIntToGPUVertexFormat(Number(formatb));
	if (format == null) {
		throw new Error("format is null, memory is most likely corrupted");
	}
	//
	const offsetb = _u64(offset.offset);

	//
	const shaderLocationb = _u32(offset.shaderLocation);
	const shaderLocation = Number(shaderLocationb);

	const attribute: GPUVertexAttribute = {
		format,
		offset: Number(offsetb),
		shaderLocation: shaderLocation,
	};

	return attribute;
}

