import "../css/style.css";
import { WebGPURequestResponse } from "./WebGPU/utils/WebGPUCommon";
import { logBlueBg, logGreenBg } from "./Logger";
// import { computeTest } from "./ComputeTest";
import { loadWasm } from "./WasmRuntime2";
import { webGPURequest } from "./WebGPURequest";
import {
	WebGPURenderController,
	webGPURenderControllerCreate,
} from "./WebGPUController";
import { ViteHotReloadEvent } from "./config/ViteHotReloadEvent";
// import { WebGPUSetupOld } from "./WebGPU";
// @ts-ignore
// import { debugMain } from "./debug";

let webGPURequestResponse: WebGPURequestResponse | undefined;
let webGPUController: WebGPURenderController | undefined;

document.addEventListener("DOMContentLoaded", async () => {
	const wasmPromise = loadWasm();
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
	// WebGPUSetupOld(wgpuRequestResponse);
	// const computeResult = await computeTest({ device });
	// if (!computeResult) {
	// 	console.error("computeResult is null");
	// 	return;
	// }
	// setupAndRenderWebGPU(
	// 	device
	// 	// computeResult.verticesBufferRead,
	// 	// computeResult.verticesBufferResult
	// );
});

if (import.meta.hot) {
	let wamsRebuildCount = 0;
	import.meta.hot.on(ViteHotReloadEvent.BUILD_START, async () => {
		logBlueBg("building start...");
		webGPUController?.stop();

		webGPUController = undefined;
	});
	import.meta.hot.on(ViteHotReloadEvent.BUILD_SUCCESS, async () => {
		// logGreenBg("-----------------------------------------");
		// logGreenBg("-----------------------------------------");
		logGreenBg(
			`------------ WASM HOT RELOAD ------------ ${wamsRebuildCount++}`
		);
		// logGreenBg("-----------------------------------------");
		// logGreenBg("-----------------------------------------");
		webGPUController?.stop();
		await loadWasm();
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

