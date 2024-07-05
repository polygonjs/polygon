import "./style.css";
import { loadWasm } from "./wasmRuntime";
import { setupAndRenderWebGPU } from "./webgpu";

document.addEventListener("DOMContentLoaded", async () => {
	await loadWasm();
	setupAndRenderWebGPU();
});
