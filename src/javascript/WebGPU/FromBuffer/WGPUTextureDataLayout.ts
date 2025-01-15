import { _big, _num } from "../../wasm/WasmUtils";
import { WGPUTextureDataLayout } from "../utils/WGPUStructInfos";

export function WGPUTextureDataLayoutFromBuffer(p: bigint): GPUImageDataLayout {
	const m = WGPUTextureDataLayout.members;
	//
	const layoutOffset = _big(p, m.offset);
	const bytesPerRow = _num(p, m.bytesPerRow);
	const rowsPerImage = _num(p, m.rowsPerImage);

	const desc: GPUImageDataLayout = {
		offset: Number(layoutOffset),
		bytesPerRow,
		rowsPerImage,
	};
	return desc;
}

