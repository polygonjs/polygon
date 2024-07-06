import { clockInit, clockTick } from "./Clock";
import { SHADERS } from "./Common";
import {
	SCENE_DATA,
	// updateVertexArrayToBuffer,
	vertexArrayToBuffer,
	// VERTICES,
} from "./VertexBuffer";

export async function setupAndRenderWebGPU() {
	const adapter = await navigator.gpu?.requestAdapter();
	const device = await adapter?.requestDevice();
	if (!device) {
		alert("need a browser that supports WebGPU");
		return;
	}

	const domElement = document.getElementById("app") as HTMLElement;
	if (!domElement) {
		alert("no dom element found with id app");
		return;
	}
	const canvas = document.createElement("canvas");
	const rect = domElement.getBoundingClientRect();
	canvas.width = rect.width;
	canvas.height = rect.height;
	domElement.appendChild(canvas);
	const context = canvas.getContext("webgpu");
	if (!context) {
		alert("failed to create a context");
		return;
	}
	const presentationFormat = navigator.gpu.getPreferredCanvasFormat();

	context.configure({
		device,
		format: presentationFormat,
	});

	//
	// 	const shader1 = `
	// struct OurStruct {
	// 	offset: f32,
	// };

	// @group(0) @binding(0) var<uniform> ourStruct: OurStruct;

	// @vertex
	// fn vs( @builtin(vertex_index) vertexIndex : u32) -> @builtin(position) vec4f {
	// 	let pos = array(
	// 		vec2f( 0.0,  0.5+ourStruct.offset),  // top center
	// 		vec2f(-0.5, -0.5),  // bottom left
	// 		vec2f( 0.5, -0.5)   // bottom right
	// 	);

	// 	return vec4f(pos[vertexIndex], 0.0, 1.0);
	// }

	// @fragment
	// fn fs() -> @location(0) vec4f {
	// 	return vec4f(1.0, 1.0, 0.0, 1.0);
	// }`;
	// 	const shader = `
	// struct VertexInput {
	// 	@location(0) position: vec3<f32>,
	// 	@location(1) color: vec3<f32>,
	// };

	// struct VertexOutput {
	// 	@builtin(position) clip_position: vec4<f32>,
	// 	@location(0) color: vec3<f32>,
	// };

	// @vertex
	// fn vertex(model: VertexInput) -> VertexOutput {
	// 	var out: VertexOutput;
	// 	out.clip_position = vec4<f32>(model.position, 1.0);
	// 	out.color = model.color;
	// 	return out;
	// }

	// @fragment
	// fn fragment(in: VertexOutput) -> @location(0) vec4<f32> {
	// 	return vec4<f32>(in.color, 1.0);
	// }
	// 	`;
	const module = device.createShaderModule({
		code: SHADERS.basic,
	});

	const vertexArrayBufferResult = vertexArrayToBuffer(
		device,
		SCENE_DATA.vertexBuffer
	);
	if (vertexArrayBufferResult == null) {
		alert("failed to create vertex buffer");
		return;
	}

	const pipeline = device.createRenderPipeline({
		label: "our hardcoded red triangle pipeline",
		layout: "auto",
		vertex: {
			//   entryPoint: 'vs',
			module,
			buffers: [
				{
					arrayStride: 2 * 3 * 4, // 2 floats, 4 bytes each
					attributes: [
						{ shaderLocation: 0, offset: 0, format: "float32x3" }, // position
						{ shaderLocation: 1, offset: 12, format: "float32x3" }, // color
					],
				},
			],
		},
		fragment: {
			//   entryPoint: 'fs',
			module,
			targets: [{ format: presentationFormat }],
		},
	});

	const colorAttachment: GPURenderPassColorAttachment = {
		view: context.getCurrentTexture().createView(), //null as any, //<- to be filled out when we render
		clearValue: [0.3, 0.3, 0.3, 1],
		loadOp: "clear",
		storeOp: "store",
	};
	// colorAttachment.view = context.getCurrentTexture().createView();
	const renderPassDescriptor: GPURenderPassDescriptor = {
		label: "our basic canvas renderPass",
		colorAttachments: [colorAttachment],
	};

	// const uniformBufferSize = 1 * 4;
	// 4 * 4 + // color is 4 32bit floats (4bytes each)
	// 2 * 4 + // scale is 2 32bit floats (4bytes each)
	// 2 * 4;  // offset is 2 32bit floats (4bytes each)
	// const uniformBuffer = device.createBuffer({
	// 	size: uniformBufferSize,
	// 	usage: GPUBufferUsage.UNIFORM | GPUBufferUsage.COPY_DST,
	// });
	// const uniformValues = new Float32Array(uniformBufferSize / 4);

	//   const kColorOffset = 0;
	//   const kScaleOffset = 4;
	//   const kOffsetOffset = 6;
	// const offsetOffset = 0;

	//   uniformValues.set([0, 1, 0, 1], kColorOffset);        // set the color
	// uniformValues.set([0.5], offsetOffset); // set the offset
	// const bindGroup = device.createBindGroup({
	// 	layout: pipeline.getBindGroupLayout(0),
	// 	entries: [{ binding: 0, resource: { buffer: uniformBuffer } }],
	// });

	// window.offset = 0;
	const clockData = clockInit();
	// const getCurrentTime = () => Math.floor(performance.now());
	// let previousTime = getCurrentTime();
	function render() {
		if (!(device && context && vertexArrayBufferResult)) {
			return;
		}
		clockTick(clockData);
		window.set_wasm_time(BigInt(0), BigInt(clockData.time));

		// VERTICES[0].position.y = Math.sin((4 * clockData.time) / 1000) / 2.0;
		// updateVertexArrayToBuffer(device, VERTICES, vertexArrayBufferResult);
		// uniformValues.set([window.offset], offsetOffset); // set the scale
		// uniformValues[offsetOffset] = window.offset;
		// device.queue.writeBuffer(uniformBuffer, 0, uniformValues);
		// Get the current texture from the canvas context and
		// set it as the texture to render to.
		// const colorAttachment:GPURenderPassColorAttachment = renderPassDescriptor.colorAttachments[0];
		colorAttachment.view = context.getCurrentTexture().createView();

		// make a command encoder to start encoding commands
		const encoder = device.createCommandEncoder({ label: "our encoder" });

		// make a render pass encoder to encode render specific commands
		const pass = encoder.beginRenderPass(renderPassDescriptor);
		pass.setPipeline(pipeline);
		pass.setVertexBuffer(0, vertexArrayBufferResult.buffer);
		// pass.setBindGroup(0, bindGroup);
		pass.draw(3); // call our vertex shader 3 times
		pass.end();

		const commandBuffer = encoder.finish();
		device.queue.submit([commandBuffer]);

		// requestAnimationFrame(render);
	}

	requestAnimationFrame(render);
	// render();
}
