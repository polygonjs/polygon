export interface MultiSampleTextureContainer {
	texture: GPUTexture | null;
	// textureView: GPUTextureView | null;
	// canvasTextureView: GPUTextureView | null;
}
// const MULTISAMPLE_TEXTURE_CONTAINER:MultiSampleTextureContainer = {
// 	texture:null
// }
const MULTISAMPLE_SAMPLES_COUNT = 4;

export function updatePipelineDescriptor(
	pipelineDescriptor: GPURenderPipelineDescriptor,
	multisample: boolean
) {
	if (multisample) {
		pipelineDescriptor.multisample = {
			count: MULTISAMPLE_SAMPLES_COUNT,
		};
	} else {
		delete pipelineDescriptor.multisample;
	}
}

export function createMultiSampleTextureIfNeeded(
	device: GPUDevice,
	context: GPUCanvasContext,
	textureContainer: MultiSampleTextureContainer
) {
	// Get the current texture from the canvas context
	const canvasTexture = context.getCurrentTexture();

	// If the multisample texture doesn't exist or
	// is the wrong size then make a new one.
	if (
		!textureContainer.texture ||
		textureContainer.texture.width !== canvasTexture.width ||
		textureContainer.texture.height !== canvasTexture.height
	) {
		// If we have an existing multisample texture destroy it.
		if (textureContainer.texture) {
			textureContainer.texture.destroy();
		}

		// Create a new multisample texture that matches our
		// canvas's size
		textureContainer.texture = device.createTexture({
			format: canvasTexture.format,
			usage: GPUTextureUsage.RENDER_ATTACHMENT,
			size: [canvasTexture.width, canvasTexture.height],
			sampleCount: MULTISAMPLE_SAMPLES_COUNT,
		});
		// textureContainer.textureView = textureContainer.texture.createView();
		// textureContainer.canvasTextureView = canvasTexture.createView();
	}
}

export function updateRenderPassDescription(
	colorAttachment: GPURenderPassColorAttachment,
	context: GPUCanvasContext,
	textureContainer: MultiSampleTextureContainer,
	multisample: boolean
) {
	if (
		multisample &&
		textureContainer.texture //&&
		// textureContainer.textureView &&
		// textureContainer.canvasTextureView
	) {
		const canvasTexture = context.getCurrentTexture();

		// Set the multisample texture as the texture to render to
		colorAttachment.view = textureContainer.texture.createView();
		// Set the canvas texture as the texture to "resolve"
		// the multisample texture to.
		colorAttachment.resolveTarget = canvasTexture.createView();
	} else {
		// Get the current texture from the canvas context and
		// set it as the texture to render to.
		colorAttachment.view = context.getCurrentTexture().createView();
	}
}
