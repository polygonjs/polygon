import "../css/style.css";
import { loadWasm } from "./WasmRuntime";
import { setupAndRenderWebGPU } from "./Webgpu";

document.addEventListener("DOMContentLoaded", async () => {
	await loadWasm();
	setupAndRenderWebGPU();
});
