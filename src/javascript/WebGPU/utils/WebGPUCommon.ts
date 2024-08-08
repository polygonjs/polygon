import { jsStringFromJaiString } from "../../wasm/StringUtils";
import { heapAdd, heapGet } from "../../WasmHeap";

// import { WGPUBindGroupDescriptorFromBuffer } from "./WebGPU/FromBuffer/WGPUBindGroupDescriptor";
// import { WGPUBindGroupEntryFromBuffer } from "./WGPUBindGroupEntry";
// import { WGPUBindGroupLayoutEntryFromBuffer } from "./WGPUBindGroupLayoutEntry";
// import { WGPUBindGroupLayoutDescriptorFromBuffer } from "./WGPUBindGroupLayoutDescriptor";
// import { WGPUBlendComponentFromBuffer } from "./WGPUBlendComponent";
// import { WGPUBlendStateFromBuffer } from "./WGPUBlendState";
// import { WGPUBufferDescriptorFromBuffer } from "./WGPUBufferDescriptor";
// import { WGPUColorTargetStateFromBuffer } from "./WGPUColorTargetState";
// import { WGPUCommandEncoderDescriptorFromBuffer } from "./WGPUCommandEncoderDescriptor";
// import { WGPUDepthStencilStateFromBuffer } from "./WGPUDepthStencilState";
// import { WGPUFragmentStateFromBuffer } from "./WGPUFragmentState";
// import { WGPUMultisampleStateFromBuffer } from "./WGPUMultisampleState";
// import { WGPUPipelineLayoutDescriptorFromBuffer } from "./WGPUPipelineLayoutDescriptor";
// import { WGPUPrimitiveStateFromBuffer } from "./WGPUPrimitiveState";
// import { WGPURenderPassColorAttachmentFromBuffer } from "./WGPURenderPassColorAttachment";
// import { WGPURenderPassDescriptorFromBuffer } from "./WGPURenderPassDescriptor";
// import { WGPUStencilFaceStateFromBuffer } from "./WGPUStencilFaceState";
// import { WGPUVertexAttributeFromBuffer } from "./WGPUVertexAttribute";
// import { WGPUVertexBufferLayoutFromBuffer } from "./WGPUVertexBufferLayout";
// import { WGPUVertexStateFromBuffer } from "./WGPUVertexState";
// import { WGPURenderPipelineFromBuffer } from "../FromBuffer/WGPURenderPipelineDescriptor";

export interface WGPURequestResponse {
	device: GPUDevice;
	presentationFormat: GPUTextureFormat;
}

// function wgpu_create_shader_module(
// 	device: GPUDevice,
// 	code: string,
// 	label: string
// ): GPUShaderModule {
// 	const module = device.createShaderModule({
// 		label,
// 		code,
// 	});
// 	// console.log("wgpu_create_shader_module", {
// 	// 	device,
// 	// 	code,
// 	// 	label,
// 	// 	module,
// 	// 	valid: module,
// 	// });
// 	return module;
// }
export function js_wgpu_create_shader_module(
	deviceHeapIndex: bigint,
	code_s_count: number,
	code_s_data: bigint,
	label_s_count: number,
	label_s_data: bigint
) {
	const device = heapGet<GPUDevice>(deviceHeapIndex)!;
	const code = jsStringFromJaiString(code_s_data, code_s_count);
	const label = jsStringFromJaiString(label_s_data, label_s_count);
	if (code == null || label == null) {
		console.error("js_wgpu_create_shader_module: No code or label");
		throw new Error("js_wgpu_create_shader_module: No code or label");
	}
	const shaderModule = device.createShaderModule({
		label,
		code,
	});
	return heapAdd(shaderModule);
}

// export function js_wgpu_create_pipeline_layout(
// 	deviceHeapIndex: bigint,
// 	data: bigint
// ) {
// 	const device = heapGet<GPUDevice>(deviceHeapIndex)!;
// 	const bindGroupLayout = WGPU_FUNCTIONS_FROM_BUFFER.WGPUPipelineLayoutFromBuffer(device, data);
// 	return heapAdd(bindGroupLayout);
// }

export function js_wgpu_texture_get_width_surface(
	canvasHeapIndex: bigint
): number {
	const canvas = heapGet<HTMLCanvasElement>(canvasHeapIndex)!;
	return canvas.width;
}
export function js_wgpu_texture_get_height_surface(
	canvasHeapIndex: bigint
): number {
	const canvas = heapGet<HTMLCanvasElement>(canvasHeapIndex)!;
	return canvas.height;
}
