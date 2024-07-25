import "../css/style.css";
import { computeTest } from "./ComputeTest";
import { loadWasm } from "./WasmRuntime";
import { requestWebGPU, setupAndRenderWebGPU } from "./WebGPU";
// @ts-ignore
// import { debugMain } from "./debug";

document.addEventListener("DOMContentLoaded", async () => {
	const wasmPromise = loadWasm();
	const webGPUPromise = requestWebGPU();
	const results = await Promise.all([wasmPromise, webGPUPromise]);
	const device = results[1];
	if (!device) {
		return;
	}
	setupAndRenderWebGPU(device);
	computeTest({ device });
});
