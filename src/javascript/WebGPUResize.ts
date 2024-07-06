export function webGPUListenToResize(
	device: GPUDevice,
	canvas: HTMLCanvasElement
) {
	const observer = new ResizeObserver((entries) => {
		for (const entry of entries) {
			if (canvas != entry.target) continue;
			const width = (entry.contentBoxSize[0].inlineSize / 64) | 0;
			const height = (entry.contentBoxSize[0].blockSize / 64) | 0;
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
	observer.observe(canvas);
}
