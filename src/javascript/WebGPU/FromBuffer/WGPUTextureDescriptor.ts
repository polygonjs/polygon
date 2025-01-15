import { getU32 } from "../../Common";
import {
	textureDimensionIntToGPUTextureDimension,
	textureFormatIntToGPUTextureFormat,
} from "../utils/WebGPUMap";
import { WASM_DATA_SIZE } from "../../wasm/WasmDataSize";
import {
	_big,
	_label,
	_num,
	_pointerValue,
	createItemsByPointer,
} from "../../wasm/WasmUtils";
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

	const viewFormats = createItemsByPointer<GPUTextureFormat>({
		pointer: p,
		itemsCount: viewFormatCount,
		itemSize: WASM_DATA_SIZE.u32,
		memberInfo: m.viewFormats,
		callback: (itemPointer) => {
			const itemFormatb = getU32(Number(itemPointer));
			const itemFormat = textureFormatIntToGPUTextureFormat(itemFormatb);
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

