import "../css/style.css";
import { logBlueBg, logGreenBg } from "./Logger";
import { loadWasm, LoadWasmOptions } from "./WasmRuntime";
import { ViteHotReloadEvent } from "./config/ViteHotReloadEvent";
import {
	ThreeController,
	threeControllerCreate,
} from "./three/threeController";

const wasmLoadOptions: LoadWasmOptions = { url: "/polygon-next.32.wasm" };
let threeController: ThreeController | null = null;

document.addEventListener("DOMContentLoaded", async () => {
	await loadWasm(wasmLoadOptions);
	threeController = threeControllerCreate();
	threeController.start();
});

if (import.meta.hot) {
	let wasmRebuildCount = 0;
	let buildStartAt = 0;
	import.meta.hot.on(ViteHotReloadEvent.BUILD_START, async () => {
		buildStartAt = performance.now();
		logBlueBg("building start...");
	});
	import.meta.hot.on(ViteHotReloadEvent.BUILD_SUCCESS, async () => {
		const buildTime = (performance.now() - buildStartAt).toFixed(0);
		logGreenBg(
			`------------ WASM HOT RELOAD ------------ #${wasmRebuildCount++} in ${buildTime}ms`
		);
		await loadWasm(wasmLoadOptions);
	});
	import.meta.hot.on(ViteHotReloadEvent.BUILD_ERROR, (d) => {
		console.error("Jai WASM error", d);
		console.log(d["message"]);
	});
}

