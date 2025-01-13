import {
	AllocatedMemory,
	RequestAllocationFunction,
	OnRequestAnimationFrameFunction,
	OnWebGPUReadyFunction,
	QSortFunction,
	USELESS_ARG0,
	OnAllocatedMemoryWrittenFunction,
	RequestReallocFunction,
	OnPopErrorScopeCompletedFunction,
} from "./Common";
import {
	jsStringFromJaiString,
	strcmp,
	strlen,
	atof,
	printf,
	sprintf,
	snprintf,
	// vsnprintf,
	sscanf,
	strchr,
	strncmp,
	strncpy,
	toupper,
	strstr,
} from "./wasm/WasmString";
import {
	memchr,
	memcmp,
	memcpy,
	memmove,
	memset,
	realloc,
	onReallocReady,
	calloc,
	ldexp,
	strtol,
} from "./wasm/WasmMem";
import { writeToConsoleLog } from "./wasm/PrintUtils";
import {
	js_wgpu_texture_get_height_surface,
	js_wgpu_texture_get_width_surface,
	wgpuSurfaceGetCurrentTexture,
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
import { wgpuTextureCreateView } from "./WebGPU/FromJs/wgpuTextureCreateView";
import { NOT_IMPLEMENTED } from "./wasm/WasmNotImplemented";
import { wgpuBindGroupLayoutRelease } from "./WebGPU/FromJs/wgpuBindGroupLayoutRelease";
import { wgpuBindGroupRelease } from "./WebGPU/FromJs/wgpuBindGroupRelease";
import { wgpuBufferDestroy } from "./WebGPU/FromJs/wgpuBufferDestroy";
// import { wgpuBufferRelease } from "./WebGPU/FromJs/wgpuBufferRelease";
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
import { wgpuCommandEncoderBeginComputePass } from "./WebGPU/FromJs/wgpuCommandEncoderBeginComputePass";
import { wgpuComputePassEncoderDispatchWorkgroups } from "./WebGPU/FromJs/wgpuComputePassEncoderDispatchWorkgroups";
import { wgpuComputePassEncoderEnd } from "./WebGPU/FromJs/wgpuComputePassEncoderEnd";
import { wgpuComputePassEncoderRelease } from "./WebGPU/FromJs/wgpuComputePassEncoderRelease";
import { wgpuComputePassEncoderSetBindGroup } from "./WebGPU/FromJs/wgpuComputePassEncoderSetBindGroup";
import { wgpuComputePassEncoderSetPipeline } from "./WebGPU/FromJs/wgpuComputePassEncoderSetPipeline";
import { wgpuComputePipelineGetBindGroupLayout } from "./WebGPU/FromJs/wgpuComputePipelineGetBindGroupLayout";
import { wgpuDeviceCreateComputePipeline } from "./WebGPU/FromJs/wgpuDeviceCreateComputePipeline";
import { wgpuDevicePopErrorScope } from "./WebGPU/FromJs/wgpuDevicePopErrorScope";
import { wgpuDevicePushErrorScope } from "./WebGPU/FromJs/wgpuDevicePushErrorScope";
import { WASM_MATH } from "./wasm/WasmMath";
import { __assert_fail } from "./wasm/WasmImgui";
import { mapFunctionName } from "./wasm/WasmFunctionMapper";
import {
	eventsDataUpdate,
	eventsSetCursor,
	performance_now,
	current_time_monotonic,
	to_float64_seconds,
	// onMemoryResize,
} from "./EventsController";
import { fetchUrl, onAllocateReady } from "./NodesSceneRequest";
import { wgpuCommandEncoderCopyBufferToBuffer } from "./WebGPU/FromJs/wgpuCommandEncoderCopyBufferToBuffer";
import { wgpuBufferGetMappedRange } from "./WebGPU/FromJs/wgpuBufferGetMappedRange";
import { wgpuBufferGetMapState } from "./WebGPU/FromJs/wgpuBufferGetMapState";
import { wgpuBufferMapAsync } from "./WebGPU/FromJs/wgpuBufferMapAsync";
import { wgpuBufferUnmap } from "./WebGPU/FromJs/wgpuBufferUnmap";
import { wgpuDevicePoll } from "./WebGPU/FromJs/wgpuDevicePoll";
import { wgpuCommandEncoderInsertDebugMarker } from "./WebGPU/FromJs/wgpuCommandEncoderInsertDebugMarker";
import { wgpuCommandEncoderCopyTextureToBuffer } from "./WebGPU/FromJs/wgpuCommandEncoderCopyTextureToBuffer";
import { loadImageDataPng } from "./wasm/WasmImage";
import { loadFontData } from "./AssetsController";

export function loadWasm(): Promise<void> {
	const EXPORTED_JS_FUNCTIONS: Record<string, Function> = {
		wasm_write_string: (
			s_count: bigint,
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
		},

		wasm_debug_break: () => {
			// debugger;
			// console.warn("NOT IMPLEMENTED wasm_debug_break");
		},
		memcmp,
		memset,
		realloc,
		onReallocReady,
		calloc,
		ldexp,
		strtol,
		memcpy,
		memmove,
		memchr,
		loadImageDataPng,
		loadFontData,
		strlen,
		strcmp,
		sscanf,
		strchr,
		strncmp,
		strncpy,
		atof,
		// vsnprintf,
		snprintf,
		printf,
		sprintf,
		strstr,
		toupper,
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
		wgpuCommandEncoderCopyBufferToBuffer,
		wgpuBufferGetMappedRange,
		wgpuBufferGetMapState,
		wgpuBufferMapAsync,
		wgpuBufferUnmap,
		wgpuDevicePoll,
		wgpuCommandEncoderInsertDebugMarker,
		wgpuCommandEncoderCopyTextureToBuffer,
		wgpuSurfaceGetCurrentTexture,
		wgpuDeviceCreateRenderPipeline,
		wgpuDeviceCreateBindGroup,
		wgpuRenderPipelineGetBindGroupLayout,
		wgpuDeviceCreateBuffer,
		wgpuDevicePopErrorScope,
		wgpuDevicePushErrorScope,
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
		wgpuTextureCreateView,
		wgpuBindGroupLayoutRelease,
		wgpuBindGroupRelease,
		wgpuBufferDestroy,
		// wgpuBufferRelease,
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
		// compute
		wgpuCommandEncoderBeginComputePass,
		wgpuComputePassEncoderDispatchWorkgroups,
		wgpuComputePassEncoderEnd,
		wgpuComputePassEncoderRelease,
		wgpuComputePassEncoderSetBindGroup,
		wgpuComputePassEncoderSetPipeline,
		wgpuComputePipelineGetBindGroupLayout,
		wgpuDeviceCreateComputePipeline,
		// events
		eventsDataUpdate,
		eventsSetCursor,
		performance_now,
		current_time_monotonic,
		to_float64_seconds,
		// onMemoryResize,
		fetchUrl,
		onAllocateReady,
	};
	const _dummy = (dummyName: string) => {
		return () => {
			console.log(dummyName);
		};
	};
	const _dummyWithReturn = (dummyName: string) => {
		return () => {
			console.log(dummyName);
			return BigInt(0);
		};
	};
	const dummyRequestAllocation = _dummy("requestAllocation");
	const dummyOnAllocatedMemoryWritten = _dummy("onAllocatedMemoryWritten");
	const dummyRequestRealloc = _dummyWithReturn("requestRealloc");
	const dummyOnPopErrorScopeCompleted = _dummyWithReturn(
		"onPopErrorScopeCompleted"
	);
	window.wasmFunctions = {
		onWebGPUReady: () => {},
		onRequestAnimationFrame: () => {},
		qsort: () => {},
		qsortWrapper: (a, b, c, d) => {
			window.wasmFunctions.qsort(
				USELESS_ARG0,
				a,
				Number(b),
				Number(c),
				d
			);
		},
		requestAllocation: dummyRequestAllocation,
		onAllocatedMemoryWritten: dummyOnAllocatedMemoryWritten,
		requestRealloc: dummyRequestRealloc,
		onPopErrorScopeCompleted: dummyOnPopErrorScopeCompleted,
	};
	const WRAPPERS_BY_NAMES: Record<string | symbol, Function> = {
		qsort: window.wasmFunctions.qsortWrapper,
	};
	window.ALLOCATED_MEMORY_CONTAINER = {
		dataView: new DataView(new ArrayBuffer(0)),
	};

	const unassignedFunctionNames: string[] = [];
	// Create the environment for the WASM file,
	// which includes the exported JS functions for the WASM:
	const imports = {
		env: new Proxy(EXPORTED_JS_FUNCTIONS, {
			get(target, prop) {
				const wrapper = WRAPPERS_BY_NAMES[prop];
				if (wrapper) {
					return wrapper;
				}
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
	return new Promise((resolve) => {
		// console.log("wasm load START");
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

			const container = window.ALLOCATED_MEMORY_CONTAINER;

			const memory = obj.instance.exports[
				"memory"
			] as any as AllocatedMemory;
			// function _log(prefix: string) {
			// 	console.log(
			// 		prefix,
			// 		memory,
			// 		(memory as any).type(),
			// 		"new:",
			// 		(memory.buffer as any).byteLength,
			// 		"new size:",
			// 		new Uint8Array(memory.buffer).byteLength,
			// 		"old:",
			// 		(container.allocatedMemory?.buffer as any)?.byteLength
			// 	);
			// }
			// for (let i = 0; i < 10; i++) {
			// 	const j = i;
			// 	setTimeout(() => {
			// 		console.log(
			// 			"memory " + j,
			// 			memory,
			// 			(memory.buffer as any).byteLength,
			// 			(memory.buffer as any).maxByteLength
			// 		);
			// 	}, 10 * i);
			// }
			// _log("> 1");
			// setTimeout(() => {
			// 	_log("> 2");
			// }, 100);
			container.allocatedMemory = memory;

			// const u64 = new BigUint64Array(memory.buffer);
			// console.log(u64.length);
			// u64.fill(BigInt(0));
			// console.log(container.u32, container.u64);
			// console.log(
			// 	"WASM loaded",
			// 	allocatedMemoryContainer.allocatedMemory
			// );

			//
			// we still call main, as it assigns call_from_wasm_context,
			// which seems necessary at times (but really may not be, I'm not sure yet)
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
				// console.log(`export has ${methodNames.length} functions`);
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
							window.wasmFunctions.onWebGPUReady =
								method as OnWebGPUReadyFunction;
						}
						if (
							methodName.startsWith("on_request_animation_frame")
						) {
							window.wasmFunctions.onRequestAnimationFrame =
								method as OnRequestAnimationFrameFunction;
						}
						if (methodName.startsWith("qsort")) {
							window.wasmFunctions.qsort =
								method as QSortFunction;
						}
						if (methodName.startsWith("requestAllocation")) {
							if (
								window.wasmFunctions.requestAllocation ==
								dummyRequestAllocation
							) {
								window.wasmFunctions.requestAllocation =
									method as RequestAllocationFunction;
							} else {
								console.warn(
									"requestAllocation already linked"
								);
							}
						}
						if (methodName.startsWith("onAllocatedMemoryWritten")) {
							if (
								window.wasmFunctions.onAllocatedMemoryWritten ==
								dummyOnAllocatedMemoryWritten
							) {
								window.wasmFunctions.onAllocatedMemoryWritten =
									method as OnAllocatedMemoryWrittenFunction;
							} else {
								console.warn(
									"onAllocatedMemoryWritten already linked"
								);
							}
						}
						if (methodName.startsWith("requestRealloc")) {
							if (
								window.wasmFunctions.requestRealloc ==
								dummyRequestRealloc
							) {
								window.wasmFunctions.requestRealloc =
									method as RequestReallocFunction;
							} else {
								console.warn("requestRealloc already linked");
							}
						}
						if (methodName.startsWith("onPopErrorScopeCompleted")) {
							if (
								window.wasmFunctions.onPopErrorScopeCompleted ==
								dummyOnPopErrorScopeCompleted
							) {
								window.wasmFunctions.onPopErrorScopeCompleted =
									method as OnPopErrorScopeCompletedFunction;
							} else {
								console.warn(
									"onPopErrorScopeCompleted already linked"
								);
							}
						}
					}
				}
			};
			linkWasmFunctions();
			if (
				window.wasmFunctions.onWebGPUReady == null ||
				window.wasmFunctions.onRequestAnimationFrame == null
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

