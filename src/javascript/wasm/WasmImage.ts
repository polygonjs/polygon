// Method 1: Using Canvas (recommended for raw bytes)
// function displayPngWithCanvas(pngBytes: Uint8Array) {
// 	// Create a blob from the byte array
// 	const blob = new Blob([pngBytes], { type: "image/png" });

import { updateMemoryArrayViewsIfNeeded } from "../Common";

// 	// Create object URL from the blob
// 	const url = URL.createObjectURL(blob);

// 	// Create canvas element
// 	const canvas = document.createElement("canvas");
// 	document.body.appendChild(canvas);

// 	// Create image and wait for it to load
// 	const img = new Image();
// 	img.onload = () => {
// 		// Set canvas size to match image
// 		canvas.width = img.width;
// 		canvas.height = img.height;

// 		// Draw image to canvas
// 		const ctx = canvas.getContext("2d");
// 		ctx?.drawImage(img, 0, 0);

// 		// Clean up object URL
// 		URL.revokeObjectURL(url);
// 	};

// 	// Set image source to trigger loading
// 	img.src = url;
// }

// function displayPngWithImage(pngBytes: Uint8Array) {
// 	// Create blob and URL as before
// 	const blob = new Blob([pngBytes], { type: "image/png" });
// 	const url = URL.createObjectURL(blob);

// 	// Create and append image element
// 	const img = document.createElement("img");
// 	img.onload = () => {
// 		// Clean up object URL after image loads
// 		URL.revokeObjectURL(url);
// 	};
// 	img.src = url;
// 	img.style.position = "absolute";
// 	img.style.top = "0";
// 	img.style.left = "0";
// 	document.body.appendChild(img);
// }

function loadPngData(pngBytes: Uint8Array): Promise<ImageData> {
	return new Promise((resolve, reject) => {
		const canvas = document.createElement("canvas");
		const ctx = canvas.getContext("2d");
		if (!ctx) {
			reject(new Error("Could not get canvas context"));
			return;
		}

		const blob = new Blob([pngBytes], { type: "image/png" });
		const url = URL.createObjectURL(blob);

		// Create and append image element
		const img = document.createElement("img");
		img.onload = () => {
			// Set canvas size to match image
			canvas.width = img.width;
			canvas.height = img.height;

			// Draw image to canvas
			ctx.drawImage(img, 0, 0);

			// Get raw RGBA pixel data
			const imageData = ctx.getImageData(0, 0, img.width, img.height);

			// Create view into WASM memory

			canvas.remove();

			// Clean up object URL after image loads
			URL.revokeObjectURL(url);

			resolve(imageData);
		};
		img.src = url;
	});
}

// function debugImageDataPng(pngDataPointer: BigInt, dataSize: BigInt) {
// 	// const dataSize = Number(width) * Number(height) * 4;
// 	console.log("debugPngData", { pngDataPointer, dataSize });

// 	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
// 	const data = new Uint8Array(buffer).subarray(
// 		Number(pngDataPointer),
// 		Number(pngDataPointer) + Number(dataSize)
// 	);

// 	displayPngWithImage(data);
// }
export async function loadImageDataPng(
	pngDataPointer: BigInt,
	dataSize: BigInt,
	rawDataDest: BigInt,
	assetName?: string
) {
	function writeImageData(imageData: ImageData) {
		updateMemoryArrayViewsIfNeeded();
		const wasmView = new Uint8Array(
			window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer,
			Number(rawDataDest),
			imageData.data.length
		);
		wasmView.set(imageData.data);
	}
	if (assetName != null) {
		const cachedImageData = IMAGE_DATA_BY_ASSET_NAME.get(assetName);
		if (cachedImageData != null) {
			writeImageData(cachedImageData);
			return;
		}
	}
	// const dataSize = Number(width) * Number(height) * 4;
	// console.log("loadImageDataPng", { pngDataPointer, dataSize, rawDataDest });

	updateMemoryArrayViewsIfNeeded();
	const pngData = new Uint8Array(
		window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer
	).subarray(
		Number(pngDataPointer),
		Number(pngDataPointer) + Number(dataSize)
	);

	const imageData = await loadPngData(pngData);
	if (assetName != null) {
		IMAGE_DATA_BY_ASSET_NAME.set(assetName, imageData);
	}
	writeImageData(imageData);
	// console.log("png image ready");
}

const IMAGE_DATA_BY_ASSET_NAME: Map<string, ImageData> = new Map();

