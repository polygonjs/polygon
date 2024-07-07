export function webGPUListenToResize(
	device: GPUDevice,
	domElement: HTMLElement,
	canvas: HTMLCanvasElement
	// callback: () => void
) {
	const observer = new ResizeObserver((entries) => {
		let entriesCount = entries.length;
		for (let i = 0; i < entriesCount; i++) {
			const entry = entries[i];
			if (domElement != entry.target) continue;
			const width = entry.contentBoxSize[0].inlineSize;
			const height = entry.contentBoxSize[0].blockSize;
			canvas.width = Math.max(
				1,
				Math.min(width, device.limits.maxTextureDimension2D)
			);
			canvas.height = Math.max(
				1,
				Math.min(height, device.limits.maxTextureDimension2D)
			);
		}
	});
	observer.observe(domElement);
}
