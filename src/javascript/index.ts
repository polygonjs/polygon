import "../css/style.css";
import { loadWasm } from "./WasmRuntime";
import { setupAndRenderWebGPU } from "./WebGPU";
// @ts-ignore
// import { debugMain } from "./debug";

document.addEventListener("DOMContentLoaded", async () => {
	await loadWasm();
	setupAndRenderWebGPU();
	// debugMain();
});
