import "../css/style.css";
import { logGreenBg } from "./Logger";
// import { computeTest } from "./ComputeTest";
import { loadWasm } from "./WasmRuntime2";
import { requestWebGPU } from "./WebGPU";
import { webgpuSetup } from "./WebGPUSetup";
// import { WebGPUSetupOld } from "./WebGPU";
// @ts-ignore
// import { debugMain } from "./debug";

let wgpuRequestResponse: WGPURequestResponse | undefined;

document.addEventListener("DOMContentLoaded", async () => {
	const wasmPromise = loadWasm();
	const webGPUPromise = requestWebGPU();
	const results = await Promise.all([wasmPromise, webGPUPromise]);
	wgpuRequestResponse = results[1];
	if (!wgpuRequestResponse) {
		return;
	}
	webgpuSetup(wgpuRequestResponse);
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
	import.meta.hot.on("jai-wasm-update", async () => {
		// logGreenBg("-----------------------------------------");
		// logGreenBg("-----------------------------------------");
		logGreenBg(
			`------------ WASM HOT RELOAD ------------ ${wamsRebuildCount++}`
		);
		// logGreenBg("-----------------------------------------");
		// logGreenBg("-----------------------------------------");
		await loadWasm();
		if (!wgpuRequestResponse) {
			return;
		}
		webgpuSetup(wgpuRequestResponse);
	});
	import.meta.hot.on("jai-wasm-error", (d) => {
		console.error("Jai WASM error", d);
		console.log(d["message"]);
	});
}
