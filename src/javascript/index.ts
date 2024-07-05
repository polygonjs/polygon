import "../css/style.css";
import { loadWasm } from "./WasmRuntime";
import { setupAndRenderWebGPU } from "./WebGPU";

document.addEventListener("DOMContentLoaded", async () => {
	await loadWasm();
	setupAndRenderWebGPU();
});
