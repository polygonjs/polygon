import {
	textureDimensionIntToGPUTextureDimension,
	textureFormatIntToGPUTextureFormat,
} from "../utils/WebGPUMap";
import { WGPU_SIZE } from "../utils/WebGPUOffset";
import {
	_big,
	_label,
	_num,
	_pointerValue,
	createWGPUItemsByPointer,
} from "../utils/WebGPUUtils";
import { WGPUTextureDescriptor } from "../utils/WGPUStructInfos";
import { WGPUExtent3DFromBuffer } from "./WGPUExtent3D";

export function WGPUTextureDescriptorFromBuffer(
	p: bigint
): GPUTextureDescriptor {
	const m = WGPUTextureDescriptor.members;

	const label = _label(p, m);
	const usage = _num(p, m.usage);
	//
	const dimensionb = _num(p, m.dimension);
	const dimension = textureDimensionIntToGPUTextureDimension(
		Number(dimensionb)
	);
	//
	const size = WGPUExtent3DFromBuffer(p + m.size.offset);
	//
	const formatb = _num(p, m.format);
	const format = textureFormatIntToGPUTextureFormat(formatb);
	//
	const mipLevelCount = _num(p, m.mipLevelCount);
	const sampleCount = _num(p, m.sampleCount);
	const viewFormatCount = _big(p, m.viewFormatCount);

	const viewFormats = createWGPUItemsByPointer<GPUTextureFormat>({
		pointer: p,
		itemsCount: viewFormatCount,
		itemSize: WGPU_SIZE.u32,
		memberInfo: m.viewFormats,
		callback: (itemPointer) => {
			const itemFormatb = _pointerValue(itemPointer);
			const itemFormat = textureFormatIntToGPUTextureFormat(
				Number(itemFormatb)
			);
			return itemFormat;
		},
	});

	const desc: GPUTextureDescriptor = {
		label,
		usage,
		dimension,
		size,
		format,
		mipLevelCount,
		sampleCount,
		viewFormats,
	};
	return desc;
}

