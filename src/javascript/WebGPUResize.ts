export function webGPUListenToResize(
	device: GPUDevice,
	domElement: HTMLElement,
	canvas: HTMLCanvasElement,
	callback: () => void
) {
	const observer = new ResizeObserver((entries) => {
		let entriesCount = entries.length;
		for (let i = 0; i < entriesCount; i++) {
			const entry = entries[i];
			if (domElement != entry.target) continue;
			const width = entry.contentBoxSize[0].inlineSize;
			const height = entry.contentBoxSize[0].blockSize;
			canvasSetSize(canvas, device, width, height);
		}
		callback();
	});
	observer.observe(domElement);
}

export function canvasSetSize(
	canvas: HTMLCanvasElement,
	device: GPUDevice,
	width: number,
	height: number
) {
	canvas.width = Math.floor(
		Math.max(1, Math.min(width, device.limits.maxTextureDimension2D))
	);
	canvas.height = Math.floor(
		Math.max(1, Math.min(height, device.limits.maxTextureDimension2D))
	);
	canvas.style.width = `${canvas.width}px`;
	canvas.style.height = `${canvas.height}px`;
}

