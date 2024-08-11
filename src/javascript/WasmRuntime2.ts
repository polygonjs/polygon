import {
	AllocatedMemory,
	InitDrawDataFunction,
	OnRequestAnimationFrameFunction,
	OnWebGPUReadyFunction,
} from "./Common";
import { jsStringFromJaiString, strlen } from "./wasm/WasmString";
import { atof, memcmp, memcpy, memmove, memset } from "./wasm/WasmUtils";
// import { TypeArrayType, typedArrayFromBuffer } from "./wasm/ArrayUtils";
import { writeToConsoleLog } from "./wasm/PrintUtils";
import {
	// js_wgpu_create_shader_module,
	js_wgpu_texture_get_height_surface,
	js_wgpu_texture_get_width_surface,
} from "./WebGPU/utils/WebGPUCommon";
import { wgpuCommandEncoderBeginRenderPass } from "./WebGPU/FromJs/wgpuCommandEncoderBeginRenderPass";
import { wgpuDeviceCreateCommandEncoder } from "./WebGPU/FromJs/wgpuDeviceCreateCommandEncoder";
import { wgpuDeviceCreatePipelineLayout } from "./WebGPU/FromJs/wgpuDeviceCreatePipelineLayout";
import { wgpuDeviceCreateTexture } from "./WebGPU/FromJs/wgpuDeviceCreateTexture";
import { wgpuTextureGetHeight } from "./WebGPU/FromJs/wgpuTextureGetHeight";
import { wgpuTextureGetWidth } from "./WebGPU/FromJs/wgpuTextureGetWidth";
import { wgpuTextureRelease } from "./WebGPU/FromJs/wgpuTextureRelease";
import { wgpuTextureViewRelease } from "./WebGPU/FromJs/wgpuTextureViewRelease";
import { wgpuQueueWriteBuffer } from "./WebGPU/FromJs/wgpuQueueWriteBuffer";
import { wgpuDeviceCreateBindGroupLayout } from "./WebGPU/FromJs/wgpuDeviceCreateBindGroupLayout";
import { wgpuDeviceCreateBindGroup } from "./WebGPU/FromJs/wgpuDeviceCreateBindGroup";
import { wgpuRenderPipelineGetBindGroupLayout } from "./WebGPU/FromJs/wgpuRenderPipelineGetBindGroupLayout";
import { wgpuDeviceCreateBuffer } from "./WebGPU/FromJs/wgpuDeviceCreateBuffer";
import { wgpuDeviceCreateRenderPipeline } from "./WebGPU/FromJs/wgpuDeviceCreateRenderPipeline";
import { wgpuRenderPassEncoderSetPipeline } from "./WebGPU/FromJs/wgpuRenderPassEncoderSetPipeline";
import { wgpuRenderPassEncoderSetBindGroup } from "./WebGPU/FromJs/wgpuRenderPassEncoderSetBindGroup";
import { wgpuRenderPassEncoderSetVertexBuffer } from "./WebGPU/FromJs/wgpuRenderPassEncoderSetVertexBuffer";
import { wgpuRenderPassEncoderSetIndexBuffer } from "./WebGPU/FromJs/wgpuRenderPassEncoderSetIndexBuffer";
import { wgpuRenderPassEncoderDrawIndexed } from "./WebGPU/FromJs/wgpuRenderPassEncoderDrawIndexed";
import { wgpuRenderPassEncoderEnd } from "./WebGPU/FromJs/wgpuRenderPassEncoderEnd";
import { wgpuCommandEncoderFinish } from "./WebGPU/FromJs/wgpuCommandEncoderFinish";
import { wgpuQueueSubmit } from "./WebGPU/FromJs/wgpuQueueSubmit";
import { wgpuCommandBufferRelease } from "./WebGPU/FromJs/wgpuCommandBufferRelease";
import { wgpuCommandEncoderRelease } from "./WebGPU/FromJs/wgpuCommandEncoderRelease";
import { wgpuRenderPassEncoderRelease } from "./WebGPU/FromJs/wgpuRenderPassEncoderRelease";
// import { wgpuSurfaceGetCurrentTexture } from "./WebGPU/FromJs/wgpuSurfaceGetCurrentTexture";
import { wgpuTextureCreateView } from "./WebGPU/FromJs/wgpuTextureCreateView";
import { update_render_pass_descriptor_multisample } from "./WebGPU/utils/WebGPUMultisample";
import { NOT_IMPLEMENTED } from "./wasm/WasmNotImplemented";
import { wgpuBindGroupLayoutRelease } from "./WebGPU/FromJs/wgpuBindGroupLayoutRelease";
import { wgpuBindGroupRelease } from "./WebGPU/FromJs/wgpuBindGroupRelease";
import { wgpuBufferDestroy } from "./WebGPU/FromJs/wgpuBufferDestroy";
import { wgpuBufferRelease } from "./WebGPU/FromJs/wgpuBufferRelease";
import { wgpuDeviceCreateSampler } from "./WebGPU/FromJs/wgpuDeviceCreateSampler";
import { wgpuDeviceCreateShaderModule } from "./WebGPU/FromJs/wgpuDeviceCreateShaderModule";
import { wgpuDeviceGetQueue } from "./WebGPU/FromJs/wgpuDeviceGetQueue";
import { wgpuQueueRelease } from "./WebGPU/FromJs/wgpuQueueRelease";
import { wgpuQueueWriteTexture } from "./WebGPU/FromJs/wgpuQueueWriteTexture";
import { wgpuRenderPassEncoderSetBlendConstant } from "./WebGPU/FromJs/wgpuRenderPassEncoderSetBlendConstant";
import { wgpuRenderPassEncoderSetScissorRect } from "./WebGPU/FromJs/wgpuRenderPassEncoderSetScissorRect";
import { wgpuRenderPassEncoderSetViewport } from "./WebGPU/FromJs/wgpuRenderPassEncoderSetViewport";
import { wgpuRenderPipelineRelease } from "./WebGPU/FromJs/wgpuRenderPipelineRelease";
import { wgpuSamplerRelease } from "./WebGPU/FromJs/wgpuSamplerRelease";
import { wgpuShaderModuleRelease } from "./WebGPU/FromJs/wgpuShaderModuleRelease";
import { WASM_MATH } from "./wasm/WasmMath";
import { __assert_fail } from "./wasm/WasmImgui";
import { vsnprintf } from "./wasm/WasmVsnPrintf";
import { mapFunctionName } from "./wasm/WasmFunctionMapper";
import { qsort } from "./wasm/WasmQSort";

// A global reference of the WASM’s memory area so that we can look up pointers
// let PRINT_STRING_BUFFER: Uint8Array = new Uint8Array(0);

const EXPORTED_JS_FUNCTIONS: Record<string, Function> = {
	// wasm_log_dom: (s_count: number, s_data: BigInt, is_error: boolean) => {
	// 	const string = jsStringFromJaiString(
	// 		s_data,
	// 		s_count,
	// 		ALLOCATED_MEMORY_CONTAINER.allocatedMemory!
	// 	);
	// 	if (!string) {
	// 		console.warn("No string");
	// 		return;
	// 	}
	// 	console.log(string);
	// 	// const log = document.getElementById("log");
	// 	// if (!log) {
	// 	// 	console.error("No log element found");
	// 	// 	return;
	// 	// }
	// 	// const lines = string.split("\n");
	// 	// for (let i = 0; i < lines.length; i++) {
	// 	// 	const line = lines[i];
	// 	// 	if (!line && i == lines.length - 1) continue; // Don’t create an extra empty line after the last newline

	// 	// 	const element = document.createElement("div");
	// 	// 	if (is_error) element.style.color = "#d33";
	// 	// 	element.innerText = line;
	// 	// 	log.appendChild(element);
	// 	// }
	// },
	wasm_write_string: (
		s_count: number,
		s_data: bigint,
		to_standard_error: boolean
	) => {
		// console.log("-- do not use this,but still display to debug --");
		const string = jsStringFromJaiString(s_data, s_count);
		if (!string) {
			console.warn("No string");
			return;
		}
		writeToConsoleLog(string, to_standard_error);
		// console.log("-- end --");
	},
	// js_set_print_string_buffer: (
	// 	s_count: number,
	// 	s_data: bigint,
	// 	elementSize: number
	// ) => {
	// 	const buffer = typedArrayFromBuffer<TypeArrayType.Uint8Array>(
	// 		s_data,
	// 		s_count,
	// 		elementSize,
	// 		Uint8Array
	// 	);
	// 	// console.log("js_set_print_string_buffer", buffer);
	// 	if (buffer) {
	// 		PRINT_STRING_BUFFER = buffer;
	// 	} else {
	// 		console.error("js_set_print_string_buffer failed");
	// 	}
	// },
	// js_read_print_buffer: (s_count: BigInt) => {
	// 	const count = Number(s_count);
	// 	// console.log({
	// 	// 	detached: (PRINT_STRING_BUFFER.buffer as any).detached,
	// 	// 	PRINT_STRING_BUFFER,
	// 	// });
	// 	const buffer = PRINT_STRING_BUFFER.slice(0, count);
	// 	const textDecoder = new TextDecoder();
	// 	const string = textDecoder.decode(buffer);
	// 	console.log(string);
	// },
	wasm_debug_break: () => {
		console.warn("NOT IMPLEMENTED wasm_debug_break");
	},
	memcmp,
	memset,
	memcpy,
	memmove,
	strlen,
	atof,
	vsnprintf,
	qsort,
	__assert_fail,
	...WASM_MATH,
	...NOT_IMPLEMENTED,
	wgpuCommandEncoderBeginRenderPass,
	wgpuDeviceCreateCommandEncoder,
	wgpuDeviceCreatePipelineLayout,
	wgpuDeviceCreateTexture,
	wgpuTextureGetHeight,
	wgpuTextureGetWidth,
	wgpuTextureRelease,
	wgpuTextureViewRelease,
	wgpuQueueWriteBuffer,
	wgpuDeviceCreateBindGroupLayout,
	// js_wgpu_create_shader_module,
	js_wgpu_texture_get_width_surface,
	js_wgpu_texture_get_height_surface,
	wgpuDeviceCreateRenderPipeline,
	wgpuDeviceCreateBindGroup,
	wgpuRenderPipelineGetBindGroupLayout,
	wgpuDeviceCreateBuffer,
	wgpuRenderPassEncoderSetPipeline,
	wgpuRenderPassEncoderSetBindGroup,
	wgpuRenderPassEncoderSetVertexBuffer,
	wgpuRenderPassEncoderSetIndexBuffer,
	wgpuRenderPassEncoderDrawIndexed,
	wgpuRenderPassEncoderEnd,
	wgpuCommandEncoderFinish,
	wgpuQueueSubmit,
	wgpuCommandBufferRelease,
	wgpuCommandEncoderRelease,
	wgpuRenderPassEncoderRelease,
	// wgpuSurfaceGetCurrentTexture,
	wgpuTextureCreateView,
	update_render_pass_descriptor_multisample,
	wgpuBindGroupLayoutRelease,
	wgpuBindGroupRelease,
	wgpuBufferDestroy,
	wgpuBufferRelease,
	wgpuDeviceCreateSampler,
	wgpuDeviceCreateShaderModule,
	wgpuDeviceGetQueue,
	wgpuQueueRelease,
	wgpuQueueWriteTexture,
	wgpuRenderPassEncoderSetBlendConstant,
	wgpuRenderPassEncoderSetScissorRect,
	wgpuRenderPassEncoderSetViewport,
	wgpuRenderPipelineRelease,
	wgpuSamplerRelease,
	wgpuShaderModuleRelease,
};

// Create the environment for the WASM file,
// which includes the exported JS functions for the WASM:
const unassignedFunctionNames: string[] = [];
const imports = {
	env: new Proxy(EXPORTED_JS_FUNCTIONS, {
		get(target, prop) {
			if (target.hasOwnProperty(prop)) {
				return (target as any)[prop];
			}
			unassignedFunctionNames.push(String(prop));

			return () => {
				console.warn(`NOT IMPLEMENTED: ${String(prop)}`);
			};
		},
	}),
};

export function loadWasm(): Promise<void> {
	return new Promise((resolve) => {
		WebAssembly.instantiateStreaming(
			fetch("/polygon-next.wasm"),
			imports
		).then((obj) => {
			if (unassignedFunctionNames.length > 0) {
				unassignedFunctionNames.sort();
				console.error("unassignedFunctionNames:");
				unassignedFunctionNames.forEach((name) => console.log(name));
				console.log("----------------");
				// throw new Error("Some functions are not assigned");
			}
			const memory = obj.instance.exports[
				"memory"
			] as any as AllocatedMemory;
			const container = window.ALLOCATED_MEMORY_CONTAINER;
			container.allocatedMemory = memory;
			// container.u32 = new Uint32Array(memory.buffer);
			// container.u64 = new BigUint64Array(memory.buffer);
			// console.log(container.u32, container.u64);
			// console.log(
			// 	"WASM loaded",
			// 	allocatedMemoryContainer.allocatedMemory
			// );
			const mainFunc: Function = obj.instance.exports["main"] as Function;
			mainFunc(0, BigInt(0));

			function mapFunction(
				functionName: string,
				prefix: string,
				targetName: string,
				method: Function
			) {
				mapFunctionName(
					functionName,
					prefix,
					targetName,
					method,
					EXPORTED_JS_FUNCTIONS
				);
			}

			const linkWasmFunctions = () => {
				const methodNames = Object.keys(obj.instance.exports);
				for (const methodName of methodNames) {
					const method = obj.instance.exports[methodName];
					if (typeof method == "function") {
						function mapFunc(prefix: string, targetName: string) {
							mapFunction(
								methodName,
								prefix,
								targetName,
								method as Function
							);
						}
						mapFunc("c_style_strlen", "strlen");
						if (methodName.startsWith("on_wgpu_device_ready")) {
							window.onWebGPUReady =
								method as OnWebGPUReadyFunction;
						}
						if (methodName.startsWith("init_draw_data")) {
							window.initDrawData =
								method as InitDrawDataFunction;
						}
						if (
							methodName.startsWith("on_request_animation_frame")
						) {
							window.onRequestAnimationFrame =
								method as OnRequestAnimationFrameFunction;
						}
					}
				}
			};
			linkWasmFunctions();
			if (
				window.onWebGPUReady == null ||
				window.onRequestAnimationFrame == null
			) {
				console.error("functions not assigned");
			}
			// console.log("onWebGPUReady calling...");
			// onWebGPUReady(BigInt(0), BigInt(0));
			// console.log("onWebGPUReady called");
			resolve();
		});
	});
}

export function onWasmAndWebGPUReady() {}
