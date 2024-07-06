import { Allocated, SetTimeFunction } from "./Common";
import { logGreenBg } from "./Logger";

let allocated: Allocated | undefined; // A global reference of the WASM’s memory area so that we can look up pointers

window.set_time = (time) => console.log(`default set_time:${time}`);

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
		write_to_console_log(string, to_standard_error);
	},

	wasm_debug_break: () => {
		// debugger;
	},
	wasm_log_dom: (s_count: number, s_data: BigInt, is_error: boolean) => {
		const log = document.getElementById("log");
		if (!log) {
			console.error("No log element found");
			return;
		}
		const string = js_string_from_jai_string(s_data, s_count);
		const lines = string.split("\n");
		for (let i = 0; i < lines.length; i++) {
			const line = lines[i];
			if (!line && i == lines.length - 1) continue; // Don’t create an extra empty line after the last newline

			const element = document.createElement("div");
			if (is_error) element.style.color = "#d33";
			element.innerText = line;
			log.appendChild(element);
		}
	},
	set_webgpu_shader_js: (_s_count: number, _s_data: number) => {
		// const content = js_string_from_jai_string(s_data, s_count);
		// console.log({ content });
		// setupAndRenderWebGPU(content);
	},
	// main_call_completed: () => {
	// 	console.log("___main_call_completed___");
	// },
	set_webgpu_data: (offset: number) => {
		// console.log("set_webgpu_data", offset);
		window.offset = Number(offset);
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
			allocated = memory as any as Allocated;
			const mainFunc: Function = obj.instance.exports["main"] as Function;
			mainFunc(0, BigInt(0));

			const getSetTimeFunction = () => {
				const methodNames = Object.keys(obj.instance.exports);
				for (const methodName of methodNames) {
					if (methodName.startsWith("set_time")) {
						return obj.instance.exports[
							methodName
						] as SetTimeFunction;
					}
				}
			};
			const setTimeFunc = getSetTimeFunction();
			if (setTimeFunc) {
				window.set_time = setTimeFunc;
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
	const u8 = new Uint8Array(allocated!.buffer);
	// console.log({ buffer: allocated!.buffer, u8, allocated });
	const bytes = u8.subarray(
		Number(pointer),
		Number(pointer) + Number(length)
	);
	return text_decoder.decode(bytes);
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
