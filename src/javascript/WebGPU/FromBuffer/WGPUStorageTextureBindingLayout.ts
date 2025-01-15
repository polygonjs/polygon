import {
	storageTextureAccessIntToGPUStorageTextureAccess,
	textureFormatIntToGPUTextureFormat,
	textureViewDimentionIntToGPUTextureViewDimension,
} from "../utils/WebGPUMap";
import { _num } from "../../wasm/WasmUtils";
import { WGPUStorageTextureBindingLayout } from "../utils/WGPUStructInfos";

export function WGPUStorageTextureBindingLayoutFromBuffer(
	p: bigint
): GPUStorageTextureBindingLayout | undefined {
	const m = WGPUStorageTextureBindingLayout.members;
	//
	const access = storageTextureAccessIntToGPUStorageTextureAccess(
		_num(p, m.access)
	);
	if (access == null) {
		return;
	}
	const format = textureFormatIntToGPUTextureFormat(_num(p, m.format));
	const viewDimension = textureViewDimentionIntToGPUTextureViewDimension(
		_num(p, m.viewDimension)
	);

	const layout: GPUStorageTextureBindingLayout = {
		access,
		format,
		viewDimension,
	};
	return layout;
}

