// Method 1: Using Canvas (recommended for raw bytes)
// function displayPngWithCanvas(pngBytes: Uint8Array) {
// 	// Create a blob from the byte array
// 	const blob = new Blob([pngBytes], { type: "image/png" });

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

function displayPngWithImage(pngBytes: Uint8Array) {
	// Create blob and URL as before
	const blob = new Blob([pngBytes], { type: "image/png" });
	const url = URL.createObjectURL(blob);

	// Create and append image element
	const img = document.createElement("img");
	img.onload = () => {
		// Clean up object URL after image loads
		URL.revokeObjectURL(url);
	};
	img.src = url;
	img.style.position = "absolute";
	img.style.top = "0";
	img.style.left = "0";
	document.body.appendChild(img);
}

export function debugImageDataPng(dataPointer: BigInt, dataSize: BigInt) {
	// const dataSize = Number(width) * Number(height) * 4;
	console.log("debugPngData", { dataPointer, dataSize });

	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const data = new Uint8Array(buffer).subarray(
		Number(dataPointer),
		Number(dataPointer) + Number(dataSize)
	);

	displayPngWithImage(data);
}

