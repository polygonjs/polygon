import { vertexFormatIntToGPUVertexFormat } from "../utils/WebGPUMap";
import { WGPU_OFFSET, WGPU_SIZE } from "../utils/WebGPUOffset";

export function WGPUVertexAttributeFromBuffer(
	pointer: bigint,
	u32: Uint32Array,
	u64: BigUint64Array
): GPUVertexAttribute {
	const offset = WGPU_OFFSET.WGPUVertexAttribute;
	//
	const formatOffset = offset.format;
	const formatSize = WGPU_SIZE.u32;
	const formatStart = (pointer + formatOffset) / formatSize;
	const formatb = u32[Number(formatStart)];
	const format = vertexFormatIntToGPUVertexFormat(Number(formatb));
	if (format == null) {
		throw new Error("format is null, memory is most likely corrupted");
	}
	//
	const offsetOffset = offset.offset;
	const offsetSize = WGPU_SIZE.u64;
	const offsetStart = (pointer + offsetOffset) / offsetSize;
	const offsetb = u64[Number(offsetStart)];

	//
	const shaderLocationOffset = offset.shaderLocation;
	const shaderLocationSize = WGPU_SIZE.u32;
	const shaderLocationStart =
		(pointer + shaderLocationOffset) / shaderLocationSize;
	const shaderLocationb = u32[Number(shaderLocationStart)];

	const attribute: GPUVertexAttribute = {
		format,
		offset: Number(offsetb),
		shaderLocation: Number(shaderLocationb),
	};

	return attribute;
}
