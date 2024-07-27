import "../css/style.css";
// import { computeTest } from "./ComputeTest";
import { loadWasm } from "./WasmRuntimeDebug";
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
