import "../css/style.css";
import type { WebGPURequestResponse } from "./WebGPU/utils/WebGPUCommon";
import { logBlueBg, logGreenBg } from "./Logger";
import { loadWasm, LoadWasmOptions } from "./WasmRuntime";
import { webGPURequest } from "./WebGPURequest";
import {
	WebGPURenderController,
	webGPURenderControllerCreate,
} from "./WebGPUController";
import { ViteHotReloadEvent } from "./config/ViteHotReloadEvent";

const wasmLoadOptions: LoadWasmOptions = { url: "/polygon-next.wasm" };

let webGPURequestResponse: WebGPURequestResponse | undefined;
let webGPUController: WebGPURenderController | undefined;

document.addEventListener("DOMContentLoaded", async () => {
	const wasmPromise = loadWasm(wasmLoadOptions);
	const webGPURequestPromise = webGPURequest();
	const results = await Promise.all([wasmPromise, webGPURequestPromise]);
	webGPURequestResponse = results[1];
	if (!webGPURequestResponse) {
		return;
	}
	webGPUController = webGPURenderControllerCreate({
		webGPURequestResponse,
		createCanvas: true,
	});
	webGPUController?.start();
});

if (import.meta.hot) {
	let wasmRebuildCount = 0;
	let buildStartAt = 0;
	import.meta.hot.on(ViteHotReloadEvent.BUILD_START, async () => {
		buildStartAt = performance.now();
		logBlueBg("building start...");
		webGPUController?.stop();

		webGPUController = undefined;
	});
	import.meta.hot.on(ViteHotReloadEvent.BUILD_SUCCESS, async () => {
		const buildTime = (performance.now() - buildStartAt).toFixed(0);
		logGreenBg(
			`------------ WASM HOT RELOAD ------------ #${wasmRebuildCount++} in ${buildTime}ms`
		);
		webGPUController?.stop();
		await loadWasm(wasmLoadOptions);
		if (!webGPURequestResponse) {
			return;
		}
		webGPUController = webGPURenderControllerCreate({
			webGPURequestResponse,
			createCanvas: false,
		});
		webGPUController?.start();
	});
	import.meta.hot.on(ViteHotReloadEvent.BUILD_ERROR, (d) => {
		console.error("Jai WASM error", d);
		console.log(d["message"]);
	});
}

