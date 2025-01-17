import "../css/style.css";
import { logBlueBg, logGreenBg } from "./Logger";
import { loadWasm, LoadWasmOptions } from "./WasmRuntime";
import { ViteHotReloadEvent } from "./config/ViteHotReloadEvent";
import {
	ThreeController,
	threeControllerCreate,
} from "./three/threeController";

const WASM32 = true;
const WASM_URL = WASM32 ? "/polygon-next.32.wasm" : "/polygon-next.wasm";
const wasmLoadOptions: LoadWasmOptions = { url: WASM_URL };
let threeController: ThreeController | null = null;

async function _start() {
	await loadWasm(wasmLoadOptions);
	threeController = threeControllerCreate();
	threeController.start();
}
document.addEventListener("DOMContentLoaded", async () => {
	_start();
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
		threeController?.stop();
		_start();
	});
	import.meta.hot.on(ViteHotReloadEvent.BUILD_ERROR, (d) => {
		console.error("Jai WASM error", d);
		console.log(d["message"]);
	});
}

