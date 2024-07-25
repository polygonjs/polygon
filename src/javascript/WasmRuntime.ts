import {
	AllocatedMemory,
	AllocatedMemoryContainer,
	UpdateWasmFunction,
	SHADERS,
} from "./Common";
import { logGreenBg } from "./Logger";
import { orbitControlsFromBuffer } from "./OrbitControls";
import { bufferToGPUVertexBufferLayout, SCENE_DATA } from "./SceneData";

const allocatedMemoryContainer: AllocatedMemoryContainer = {}; // A global reference of the WASM’s memory area so that we can look up pointers

// These are all the functions that we declared as "#foreign" in our Jai code.
// They let you interact with the JS and DOM world from within Jai.
// If you forget to implement one, the Proxy below will log a nice error.
const exported_js_functions = {
	wasm_write_string: (
		s_count: number,
		s_data: BigInt,
		to_standard_error: boolean
	) => {
		const string = js_string_from_jai_string(s_data, s_count);
		if (!string) {
			return;
		}
		write_to_console_log(string, to_standard_error);
	},

	wasm_debug_break: () => {
		// debugger;
	},
	wasm_log_dom: (s_count: number, s_data: BigInt, is_error: boolean) => {
		const string = js_string_from_jai_string(s_data, s_count);
		if (!string) {
			console.warn("No string");
			return;
		}
		console.log(string);
		// const log = document.getElementById("log");
		// if (!log) {
		// 	console.error("No log element found");
		// 	return;
		// }
		// const lines = string.split("\n");
		// for (let i = 0; i < lines.length; i++) {
		// 	const line = lines[i];
		// 	if (!line && i == lines.length - 1) continue; // Don’t create an extra empty line after the last newline

		// 	const element = document.createElement("div");
		// 	if (is_error) element.style.color = "#d33";
		// 	element.innerText = line;
		// 	log.appendChild(element);
		// }
	},
	set_webgpu_shader_js: (s_count: number, s_data: BigInt) => {
		const shader = js_string_from_jai_string(s_data, s_count);
		if (!shader) {
			return;
		}
		SHADERS.basic = shader;
		// setupAndRenderWebGPU(content);
	},
	set_webgpu_vertex_data_js: (
		s_count: number,
		s_data: BigInt,
		elementSize: number
	) => {
		const buffer = typedArrayFromJaiBuffer<TypeArrayType.Float32Array>(
			s_data,
			s_count,
			elementSize,
			Float32Array
		); //float32_from_jai_buffer(s_data, s_count, elementSize);
		if (!buffer) {
			return;
		}
		SCENE_DATA.vertexBuffer = buffer;
	},
	set_webgpu_index_data_js: (
		s_count: number,
		s_data: BigInt,
		elementSize: number
	) => {
		const buffer = typedArrayFromJaiBuffer<TypeArrayType.Uint32Array>(
			s_data,
			s_count,
			elementSize,
			Uint32Array
		);
		if (!buffer) {
			return;
		}

		SCENE_DATA.indexBuffer = buffer;
	},
	set_webgpu_vertex_layout_js: (
		s_count: number,
		s_data: BigInt,
		elementSize: number
	) => {
		const buffer = typedArrayFromJaiBuffer<TypeArrayType.Uint8Array>(
			s_data,
			s_count,
			elementSize,
			Uint8Array
		);
		if (!buffer) {
			console.error("set_webgpu_vertex_layout_js: No buffer");
			return;
		}
		const layout = bufferToGPUVertexBufferLayout(buffer);
		SCENE_DATA.vertexLayout = layout;
	},
	set_webgpu_object_uniforms_js: (
		s_count: number,
		s_data: BigInt,
		elementSize: number
	) => {
		const buffer = typedArrayFromJaiBuffer<TypeArrayType.Float32Array>(
			s_data,
			s_count,
			elementSize,
			Float32Array
		);
		if (!buffer) {
			console.error("set_webgpu_object_uniforms_js: No buffer");
			return;
		}
		SCENE_DATA.objectUniformBuffer = buffer;
	},
	set_webgpu_camera_uniforms_js: (
		s_count: number,
		s_data: BigInt,
		elementSize: number
	) => {
		const buffer = typedArrayFromJaiBuffer<TypeArrayType.Float32Array>(
			s_data,
			s_count,
			elementSize,
			Float32Array
		);
		if (!buffer) {
			console.error("set_webgpu_object_uniforms_js: No buffer");
			return;
		}
		SCENE_DATA.cameraUniformBuffer = buffer;
	},
	set_webgpu_sdf_data_js: (
		s_count: number,
		s_data: BigInt,
		elementSize: number
	) => {
		const buffer = typedArrayFromJaiBuffer<TypeArrayType.Float32Array>(
			s_data,
			s_count,
			elementSize,
			Float32Array
		);
		if (!buffer) {
			console.error("set_webgpu_object_uniforms_js: No buffer");
			return;
		}
		SCENE_DATA.SDFData = buffer;
		if ((window as any).input == null) {
			const input = document.createElement("input");
			(window as any).input = input;
			input.style.position = "fixed";
			input.style.top = "0";
			input.style.left = "0";
			document.body.appendChild(input);
			input.setAttribute("type", "range");
			input.setAttribute("min", "-1");
			input.setAttribute("max", "1");
			input.setAttribute("step", "0.01");
			input.addEventListener("input", () => {
				SCENE_DATA.SDFData[0] = parseFloat(input.value);
			});
		} else {
			console.error("this should only be run once");
		}
	},
	set_webgpu_sdf_uniforms_js: (
		s_count: number,
		s_data: BigInt,
		elementSize: number
	) => {
		const buffer = typedArrayFromJaiBuffer<TypeArrayType.Float32Array>(
			s_data,
			s_count,
			elementSize,
			Float32Array
		);
		if (!buffer) {
			console.error("set_webgpu_sdf_uniforms_js: No buffer");
			return;
		}
		SCENE_DATA.SDFUniformBuffer = buffer;
	},
	set_webgpu_orbit_controls_js: (
		s_count: number,
		s_data: BigInt,
		elementSize: number
	) => {
		const buffer = typedArrayFromJaiBuffer<TypeArrayType.Float32Array>(
			s_data,
			s_count,
			elementSize,
			Float32Array
		);
		if (!buffer) {
			console.error("set_webgpu_object_uniforms_js: No buffer");
			return;
		}
		SCENE_DATA.orbitControlsBuffer = buffer;
		orbitControlsFromBuffer(SCENE_DATA);
	},
	memcmp: (
		str1Pointer: BigInt,
		str2Pointer: BigInt,
		sizeBig: BigInt
	): number => {
		// https://discord.com/channels/661732390355337246/1172463903943446548/1256763226847187127
		// https://www.tutorialspoint.com/c_standard_library/c_function_memcmp.htm
		const size = Number(sizeBig);
		const str1 = js_string_from_jai_string(str1Pointer, size);
		const str2 = js_string_from_jai_string(str2Pointer, size);
		if (str1 == str2) {
			return 0;
		}
		if (!(str1 && str2)) {
			return -1;
		}
		if (str1 < str2) {
			return -1;
		}
		if (str1 > str2) {
			return 1;
		}
		return -1;
	},
};

// Create the environment for the WASM file,
// which includes the exported JS functions for the WASM:
const imports = {
	env: new Proxy(exported_js_functions, {
		get(target, prop) {
			// console.log("get", prop);
			if (target.hasOwnProperty(prop)) {
				return (target as any)[prop];
			}

			return () => {
				throw new Error(`Missing function: ${String(prop)}`);
			};
		},
	}),
};

// Load the WASM file we compiled and run its main.
export function loadWasm(): Promise<void> {
	return new Promise((resolve) => {
		WebAssembly.instantiateStreaming(
			fetch("/polygon-next.wasm"),
			imports
		).then((obj) => {
			const memory = obj.instance.exports["memory"];
			allocatedMemoryContainer.allocatedMemory =
				memory as any as AllocatedMemory;
			// console.log(
			// 	"WASM loaded",
			// 	allocatedMemoryContainer.allocatedMemory
			// );
			const mainFunc: Function = obj.instance.exports["main"] as Function;
			mainFunc(0, BigInt(0));

			const getUpdateWasmFunction = () => {
				const methodNames = Object.keys(obj.instance.exports);
				for (const methodName of methodNames) {
					if (methodName.startsWith("update_wasm")) {
						return obj.instance.exports[
							methodName
						] as UpdateWasmFunction;
					}
				}
			};
			const updateWasmFunc = getUpdateWasmFunction();
			if (updateWasmFunc) {
				window.update_wasm = updateWasmFunc;
			}
			resolve();
		});
	});
}
if (import.meta.hot) {
	let wamsRebuildCount = 0;
	import.meta.hot.on("jai-wasm-update", () => {
		// logGreenBg("-----------------------------------------");
		// logGreenBg("-----------------------------------------");
		logGreenBg(
			`------------ WASM HOT RELOAD ------------ ${wamsRebuildCount++}`
		);
		// logGreenBg("-----------------------------------------");
		// logGreenBg("-----------------------------------------");
		loadWasm();
	});
	import.meta.hot.on("jai-wasm-error", (d) => {
		console.error("Jai WASM error", d);
		console.log(d["message"]);
	});
}

const text_decoder = new TextDecoder();
function js_string_from_jai_string(pointer: BigInt, length: number) {
	// console.log({ pointer });
	// if(!allocated){
	// 	console.error("Memory not allocated")
	// 	return
	// }
	const u8 = new Uint8Array(allocatedMemoryContainer.allocatedMemory!.buffer);
	if (Number(pointer) > u8.length) {
		console.error("Pointer out of bounds", Number(pointer), u8.length);
		return;
	}
	// console.log({ buffer: allocated!.buffer, u8, allocated });
	const bytes = u8.subarray(
		Number(pointer),
		Number(pointer) + Number(length)
	);
	// console.log("length", Number(pointer), Number(length), bytes);
	return text_decoder.decode(bytes);
}
// function float32_from_jai_buffer(
// 	pointer: BigInt,
// 	length: number,
// 	elementSize: number
// ) {
// 	const f32 = new Float32Array(
// 		allocatedMemoryContainer.allocatedMemory!.buffer
// 	);
// 	const start = Number(pointer) / elementSize;
// 	if (start > f32.length) {
// 		console.error("Pointer out of bounds", Number(pointer), f32.length);
// 		return;
// 	}
// 	const bytes = f32.subarray(start, start + Number(length));
// 	return bytes;
// }
// function u32_from_jai_buffer(
// 	pointer: BigInt,
// 	length: number,
// 	elementSize: number
// ) {
// 	// const u32 = new Uint32Array(
// 	// 	allocatedMemoryContainer.allocatedMemory!.buffer
// 	// );
// 	// const start = Number(pointer) / elementSize;
// 	// if (start > u32.length) {
// 	// 	console.error("Pointer out of bounds", Number(pointer), u32.length);
// 	// 	return;
// 	// }
// 	// const bytes = u32.subarray(start, start + Number(length));
// 	// return bytes;
// }
export enum TypeArrayType {
	Uint8Array = "Uint8Array",
	Int16Array = "Int16Array",
	Uint16Array = "Uint16Array",
	Int32Array = "Int32Array",
	Uint32Array = "Uint32Array",
	Float32Array = "Float32Array",
	Float64Array = "Float64Array",
}
type TypedArray =
	| Uint8Array
	| Int16Array
	| Uint16Array
	| Int32Array
	| Uint32Array
	| Float32Array
	| Float64Array;
type TypedArrayClass =
	| typeof Uint8Array
	| typeof Int16Array
	| typeof Uint16Array
	| typeof Int32Array
	| typeof Uint32Array
	| typeof Float32Array
	| typeof Float64Array;
type TypeArrayByTypedArrayGeneric = { [key in TypeArrayType]: TypedArray };
type TypeArrayClassByTypedArrayGeneric = {
	[key in TypeArrayType]: TypedArrayClass;
};
interface TypeArrayByType extends TypeArrayByTypedArrayGeneric {
	Uint8Array: Uint8Array;
	Int16Array: Int16Array;
	Uint16Array: Uint16Array;
	Int32Array: Int32Array;
	Uint32Array: Uint32Array;
	Float32Array: Float32Array;
	Float64Array: Float64Array;
}
interface TypeArrayClassByType extends TypeArrayClassByTypedArrayGeneric {
	Uint8Array: typeof Uint8Array;
	Int16Array: typeof Int16Array;
	Uint16Array: typeof Uint16Array;
	Int32Array: typeof Int32Array;
	Uint32Array: typeof Uint32Array;
	Float32Array: typeof Float32Array;
	Float64Array: typeof Float64Array;
}

function typedArrayFromJaiBuffer<T extends TypeArrayType>(
	pointer: BigInt,
	length: number,
	elementSize: number,
	arrayClass: TypeArrayClassByType[T]
): TypeArrayByType[T] | undefined {
	const fullBuffer = new arrayClass(
		allocatedMemoryContainer.allocatedMemory!.buffer
	);
	const start = Number(pointer) / elementSize;
	if (start > fullBuffer.length) {
		console.error(
			"Pointer out of bounds",
			Number(pointer),
			fullBuffer.length
		);
		return;
	}
	const slice = fullBuffer.subarray(start, start + Number(length));
	return slice as TypeArrayByType[T];
}

// console.log and console.error always add newlines so we need to buffer the output from write_string
// to simulate a more basic I/O behavior. We’ll flush it after a certain time so that you still
// see the last line if you forget to terminate it with a newline for some reason.
let console_buffer = "";
let console_buffer_is_standard_error: boolean = false;
let console_timeout: number = -1;
const FLUSH_CONSOLE_AFTER_MS = 3;

function write_to_console_log(str: string, to_standard_error: boolean) {
	if (
		console_buffer &&
		console_buffer_is_standard_error != to_standard_error
	) {
		flush_buffer();
	}

	console_buffer_is_standard_error = to_standard_error;
	const lines = str.split("\n");
	for (let i = 0; i < lines.length - 1; i++) {
		console_buffer += lines[i];
		flush_buffer();
	}

	console_buffer += lines[lines.length - 1];

	clearTimeout(console_timeout);
	if (console_buffer) {
		console_timeout = setTimeout(() => {
			flush_buffer();
		}, FLUSH_CONSOLE_AFTER_MS);
	}

	function flush_buffer() {
		if (!console_buffer) return;

		if (console_buffer_is_standard_error) {
			console.error(console_buffer);
		} else {
			console.log(console_buffer);
		}

		console_buffer = "";
	}
}
