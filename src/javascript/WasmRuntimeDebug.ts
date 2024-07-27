import {
	AllocatedMemory,
	AllocatedMemoryContainer,
	UpdateWasmFunction,
} from "./Common";
import { logGreenBg } from "./Logger";
import { jsStringFromJaiString, writeToConsoleLog } from "./WasmRuntimeUtils";

const allocatedMemoryContainer: AllocatedMemoryContainer = {}; // A global reference of the WASM’s memory area so that we can look up pointers

const exported_js_functions = {
	wasm_write_string: (
		s_count: number,
		s_data: BigInt,
		to_standard_error: boolean
	) => {
		const string = jsStringFromJaiString(
			s_data,
			s_count,
			allocatedMemoryContainer.allocatedMemory!
		);
		if (!string) {
			return;
		}
		writeToConsoleLog(string, to_standard_error);
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
			} else {
				console.warn("updateWasmFunc is null");
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
