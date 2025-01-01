import { loadImageDataPng } from "./wasm/WasmImage";

interface AssetsLoadStatus {
	fontImage: boolean;
}
const _assetsLoadStatus: AssetsLoadStatus = {
	fontImage: false,
};

export function assetsLoaded(): boolean {
	return _assetsLoadStatus.fontImage;
}

export async function loadFontData(
	pngDataPointer: BigInt,
	dataSize: BigInt,
	rawDataDest: BigInt
) {
	await loadImageDataPng(pngDataPointer, dataSize, rawDataDest, "font");
	_assetsLoadStatus.fontImage = true;
}

