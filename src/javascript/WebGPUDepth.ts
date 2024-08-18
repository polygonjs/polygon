// import {
// 	MULTISAMPLE_SAMPLES_COUNT,
// 	MultiSampleTextureContainer,
// } from "./WebGPUMultisample";

// export interface DepthTextureContainer {
// 	texture: GPUTexture | null;
// 	// textureView: GPUTextureView | null;
// 	// canvasTextureView: GPUTextureView | null;
// }

// export function updatePipelineDescriptorDepth(
// 	pipelineDescriptor: GPURenderPipelineDescriptor
// ) {
// 	pipelineDescriptor.depthStencil = {
// 		depthWriteEnabled: true,
// 		depthCompare: "less",
// 		format: "depth24plus",
// 	};
// }

// export function createDepthTextureIfNeeded(
// 	device: GPUDevice,
// 	context: GPUCanvasContext,
// 	textureContainer: DepthTextureContainer,
// 	multiSampleTextureContainer: MultiSampleTextureContainer
// ) {
// 	const canvasTexture = context.getCurrentTexture();
// 	if (
// 		!textureContainer.texture ||
// 		textureContainer.texture.width !== canvasTexture.width ||
// 		textureContainer.texture.height !== canvasTexture.height
// 	) {
// 		if (textureContainer.texture) {
// 			textureContainer.texture.destroy();
// 		}
// 		textureContainer.texture = device.createTexture({
// 			size: [canvasTexture.width, canvasTexture.height],
// 			format: "depth24plus",
// 			usage: GPUTextureUsage.RENDER_ATTACHMENT,
// 			sampleCount: multiSampleTextureContainer.texture
// 				? MULTISAMPLE_SAMPLES_COUNT
// 				: 1,
// 		});
// 	}
// }
// export function depthInitRenderPassDescriptor(
// 	renderPassDescriptor: GPURenderPassDescriptor
// ) {
// 	renderPassDescriptor.depthStencilAttachment = {
// 		view: null as any, //context.getCurrentTexture().createView(), //<- to be filled out when we render
// 		depthClearValue: 1.0,
// 		depthLoadOp: "clear",
// 		depthStoreOp: "store",
// 	};
// }
// export function updateRenderPassDescriptorDepth(
// 	renderPassDescriptor: GPURenderPassDescriptor,
// 	textureContainer: DepthTextureContainer
// ) {
// 	if (
// 		!(
// 			renderPassDescriptor.depthStencilAttachment &&
// 			textureContainer.texture
// 		)
// 	) {
// 		return;
// 	}
// 	renderPassDescriptor.depthStencilAttachment.view =
// 		textureContainer.texture.createView();
// }

