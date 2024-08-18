// import { clockInit, clockTick } from "./Clock";
// import { SHADERS } from "./Common";
// import { orbitControlsAddEvents } from "./OrbitControls";
// import {
// 	indexArrayToBuffer,
// 	SCENE_DATA,
// 	vertexArrayToBuffer,
// } from "./SceneData";
import { WGPURequestResponse } from "./WebGPU/utils/WebGPUCommon";
// import {
// 	createDepthTextureIfNeeded,
// 	depthInitRenderPassDescriptor,
// 	DepthTextureContainer,
// 	updatePipelineDescriptorDepth,
// 	updateRenderPassDescriptorDepth,
// } from "./WebGPUDepth";
// import {
// 	createMultiSampleTextureIfNeeded,
// 	MultiSampleTextureContainer,
// 	updatePipelineDescriptorMultisample,
// 	updateRenderPassDescriptorMultisample,
// } from "./WebGPUMultisample";
// import { webGPUListenToResize } from "./WebGPUResize";

// const MSAA: boolean = true;

export async function requestWebGPU(): Promise<
	WGPURequestResponse | undefined
> {
	const adapter = await navigator.gpu?.requestAdapter();
	const device = await adapter?.requestDevice();
	const presentationFormat = navigator.gpu.getPreferredCanvasFormat();
	if (!(device && adapter)) {
		alert("need a browser that supports WebGPU");
		return;
	}
	// console.log("features", adapter.features.size);
	// adapter.features.forEach((value, key) => {
	// 	console.log(key, value);
	// });
	// const keys = Object.keys(device.limits);
	// console.log("limits", device.limits, device.limits.__brand, keys);
	// keys.forEach((key) => {
	// 	console.log(key, (device.limits as any)[key]);
	// });
	return { device, presentationFormat };
}

// export async function WebGPUSetupOld(
// 	options: WGPURequestResponse
// 	// vertexBufferRead: Float32Array,
// 	// verticesBufferResult: VertexArrayToBufferResult
// ) {
// 	const { device, presentationFormat } = options;
// 	const domElement = document.getElementById("app") as HTMLElement;
// 	if (!domElement) {
// 		alert("no dom element found with id app");
// 		return;
// 	}

// 	orbitControlsAddEvents(domElement, SCENE_DATA);
// 	const canvas = document.createElement("canvas");
// 	const rect = domElement.getBoundingClientRect();
// 	canvas.width = rect.width;
// 	canvas.height = rect.height;
// 	domElement.appendChild(canvas);
// 	const context = canvas.getContext("webgpu");
// 	if (!context) {
// 		alert("failed to create a context");
// 		return;
// 	}

// 	context.configure({
// 		device,
// 		format: presentationFormat,
// 	});

// 	const module = device.createShaderModule({
// 		code: SHADERS.basic,
// 	});
// 	// console.log("Compare:", vertexBufferRead, SCENE_DATA.vertexBuffer);
// 	const vertexArrayBufferResult = vertexArrayToBuffer(
// 		device,
// 		SCENE_DATA.vertexBuffer //[vertexBufferRead, SCENE_DATA.vertexBuffer][0]
// 	);
// 	// const vertexArrayBufferResult = verticesBufferResult;
// 	const indexArrayToBufferResult = indexArrayToBuffer(
// 		device,
// 		SCENE_DATA.indexBuffer
// 	);
// 	if (!(vertexArrayBufferResult && indexArrayToBufferResult)) {
// 		alert("failed to create vertex buffer");
// 		return;
// 	}

// 	const pipelineDescriptor: GPURenderPipelineDescriptor = {
// 		label: "our hardcoded red triangle pipeline",
// 		layout: "auto",
// 		vertex: {
// 			entryPoint: "vertex",
// 			module,
// 			buffers: [SCENE_DATA.vertexLayout],
// 		},
// 		fragment: {
// 			entryPoint: "fragment",
// 			module,
// 			targets: [{ format: presentationFormat }],
// 		},
// 		primitive: {
// 			cullMode: "back",
// 		},
// 	};
// 	updatePipelineDescriptorMultisample(pipelineDescriptor, MSAA);
// 	updatePipelineDescriptorDepth(pipelineDescriptor);
// 	console.log(pipelineDescriptor);
// 	const pipeline = device.createRenderPipeline(pipelineDescriptor);
// 	if (1 + 1) return;

// 	const colorAttachment: GPURenderPassColorAttachment = {
// 		view: context.getCurrentTexture().createView(), //null as any, //<- to be filled out when we render
// 		clearValue: [0.0, 0.0, 0.0, 1],
// 		loadOp: "clear",
// 		storeOp: "store",
// 	};
// 	// colorAttachment.view = context.getCurrentTexture().createView();
// 	const renderPassDescriptor: GPURenderPassDescriptor = {
// 		label: "our basic canvas renderPass",
// 		colorAttachments: [colorAttachment],
// 	};
// 	depthInitRenderPassDescriptor(renderPassDescriptor);

// 	// TODO: why min size of 16?
// 	const objectUniformBufferSize = Math.max(
// 		16,
// 		SCENE_DATA.objectUniformBuffer.length
// 	);
// 	const cameraUniformBufferSize = Math.max(
// 		16,
// 		SCENE_DATA.cameraUniformBuffer.length
// 	);
// 	const SDFUniformBufferSize = Math.max(
// 		16,
// 		SCENE_DATA.SDFUniformBuffer.length
// 	);
// 	//Math.max(SCENE_DATA.objectUniformBuffer.length, 16);
// 	// 4 * 4 + // color is 4 32bit floats (4bytes each)
// 	// 2 * 4 + // scale is 2 32bit floats (4bytes each)
// 	// 2 * 4;  // offset is 2 32bit floats (4bytes each)
// 	const objectUniformBuffer = device.createBuffer({
// 		size: objectUniformBufferSize * 4,
// 		usage: GPUBufferUsage.UNIFORM | GPUBufferUsage.COPY_DST,
// 	});
// 	const cameraUniformBuffer = device.createBuffer({
// 		size: cameraUniformBufferSize * 4,
// 		usage: GPUBufferUsage.UNIFORM | GPUBufferUsage.COPY_DST,
// 	});
// 	const SDFUniformBuffer = device.createBuffer({
// 		size: SDFUniformBufferSize * 4,
// 		usage: GPUBufferUsage.UNIFORM | GPUBufferUsage.COPY_DST,
// 	});

// 	//   const kColorOffset = 0;
// 	//   const kScaleOffset = 4;
// 	//   const kOffsetOffset = 6;
// 	// const offsetOffset = 0;

// 	//   uniformValues.set([0, 1, 0, 1], kColorOffset);        // set the color
// 	// uniformValues.set([0.5], offsetOffset); // set the offset
// 	const objectBindGroup = device.createBindGroup({
// 		layout: pipeline.getBindGroupLayout(0),
// 		entries: [{ binding: 0, resource: { buffer: objectUniformBuffer } }],
// 	});
// 	const cameraBindGroup = device.createBindGroup({
// 		layout: pipeline.getBindGroupLayout(1),
// 		entries: [{ binding: 0, resource: { buffer: cameraUniformBuffer } }],
// 	});
// 	const SDFBindGroup = device.createBindGroup({
// 		layout: pipeline.getBindGroupLayout(2),
// 		entries: [{ binding: 0, resource: { buffer: SDFUniformBuffer } }],
// 	});

// 	let multisampleTextureContainer: MultiSampleTextureContainer = {
// 		texture: null,
// 	};
// 	let depthTextureContainer: DepthTextureContainer = {
// 		texture: null,
// 	};

// 	// window.offset = 0;
// 	const clockData = clockInit();
// 	// const getCurrentTime = () => Math.floor(performance.now());
// 	// let previousTime = getCurrentTime();
// 	function render() {
// 		if (
// 			!(
// 				device &&
// 				context &&
// 				vertexArrayBufferResult &&
// 				indexArrayToBufferResult
// 			)
// 		) {
// 			return;
// 		}
// 		clockTick(clockData);
// 		// const aspect = canvas.width / canvas.height;
// 		// window.update_wasm(
// 		// 	BigInt(0),
// 		// 	BigInt(clockData.time),
// 		// 	BigInt(Math.round(aspect * 1000))
// 		// );

// 		// updateVertexArrayToBuffer(device, vertexArrayBufferResult);
// 		device.queue.writeBuffer(
// 			objectUniformBuffer,
// 			0,
// 			SCENE_DATA.objectUniformBuffer
// 		);
// 		device.queue.writeBuffer(
// 			cameraUniformBuffer,
// 			0,
// 			SCENE_DATA.cameraUniformBuffer
// 		);
// 		device.queue.writeBuffer(
// 			SDFUniformBuffer,
// 			0,
// 			SCENE_DATA.SDFUniformBuffer
// 		);

// 		createMultiSampleTextureIfNeeded(
// 			device,
// 			context,
// 			multisampleTextureContainer
// 		);
// 		createDepthTextureIfNeeded(
// 			device,
// 			context,
// 			depthTextureContainer,
// 			multisampleTextureContainer
// 		);
// 		// Get the current texture from the canvas context and
// 		// set it as the texture to render to.
// 		// const colorAttachment:GPURenderPassColorAttachment = renderPassDescriptor.colorAttachments[0];
// 		// colorAttachment.view = context.getCurrentTexture().createView();
// 		updateRenderPassDescriptorMultisample(
// 			colorAttachment,
// 			context,
// 			multisampleTextureContainer,
// 			MSAA
// 		);
// 		updateRenderPassDescriptorDepth(
// 			renderPassDescriptor,
// 			depthTextureContainer
// 		);

// 		// make a command encoder to start encoding commands
// 		const encoder = device.createCommandEncoder({ label: "our encoder" });

// 		// make a render pass encoder to encode render specific commands
// 		const pass = encoder.beginRenderPass(renderPassDescriptor);
// 		pass.setPipeline(pipeline);
// 		pass.setBindGroup(0, objectBindGroup);
// 		pass.setBindGroup(1, cameraBindGroup);
// 		pass.setBindGroup(2, SDFBindGroup);
// 		pass.setVertexBuffer(0, vertexArrayBufferResult.buffer);
// 		pass.setIndexBuffer(indexArrayToBufferResult.buffer, "uint32");
// 		pass.drawIndexed(indexArrayToBufferResult.data.length);
// 		pass.end();

// 		const commandBuffer = encoder.finish();
// 		device.queue.submit([commandBuffer]);

// 		// requestAnimationFrame(render);
// 	}

// 	render();

// 	webGPUListenToResize(device, domElement, canvas, render);
// }

