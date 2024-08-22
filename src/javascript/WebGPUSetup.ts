import { clockInit, clockTick } from "./Clock";
import { USELESS_ARG0 } from "./Common";
import { addEvents } from "./EventsController";
import {
	heapAdd,
	// Heap,
	// heapCopy,
	// heapCreate,
	// heapDelta,
	// heapStatus,
} from "./WasmHeap";
import { WGPURequestResponse } from "./WebGPU/utils/WebGPUCommon";
import { textureFormatIndex } from "./WebGPU/utils/WebGPUMap";
import { canvasSetSize, webGPUListenToResize } from "./WebGPUResize";

export function webgpuSetup(wgpuRequestResponse: WGPURequestResponse) {
	const domElement = document.getElementById("app") as HTMLElement;
	if (!domElement) {
		alert("no dom element found with id app");
		return;
	}

	const clockData = clockInit();
	const canvas = document.createElement("canvas");
	window.WebGPUCanvas = canvas;
	const rect = domElement.getBoundingClientRect();
	canvasSetSize(canvas, wgpuRequestResponse.device, rect.width, rect.height);
	domElement.appendChild(canvas);
	addEvents(canvas);
	const context = canvas.getContext("webgpu");
	if (!context) {
		alert("failed to create a context");
		return;
	}
	context.configure({
		device: wgpuRequestResponse.device,
		format: wgpuRequestResponse.presentationFormat,
	});
	window.webGPUContext = context;

	const canvasIndex = heapAdd(canvas);
	// const contextIndex = heapAdd(context);
	// const currentTexture = context.getCurrentTexture();
	// const currentTextureView = currentTexture.createView();
	// heapAdd(currentTexture);
	// heapAdd(currentTextureView);
	const deviceHeapIndex = heapAdd(wgpuRequestResponse.device);
	const queueHeapIndex = heapAdd(wgpuRequestResponse.device.queue);
	const formatNative = textureFormatIndex(
		wgpuRequestResponse.presentationFormat
	);
	let _onRequestAnimationFrameInProgress: boolean = false;
	let framesCount = 0;

	// const resizeObserver = new ResizeObserver((entries) => {
	// 	const firstEntry = entries[0];
	// 	if (firstEntry == null) return;
	// 	canvas.width = firstEntry.contentRect.width;
	// 	canvas.height = firstEntry.contentRect.height;
	// 	render();
	// });
	// resizeObserver.observe(domElement);

	// console.log("webgpuSetup", wgpuRequestResponse, formatNative);
	// wgpuRequestResponse.presentationFormat == "bgra8unorm" ? textureFormatIndex()/*23*/ : null;
	// if (formatNative == null) {
	// 	console.error(
	// 		'formatNative is null, make sure to convert the enum start with "WGPUTextureFormat :: enum u32 {" so that it can be converted from typescript'
	// 	);
	// }
	// console.log({
	// 	canvasIndex,
	// 	// contextIndex,
	// 	deviceHeapIndex,
	// 	queueHeapIndex,
	// 	formatNative,
	// });
	// console.log(window.onWebGPUReady);
	window.onWebGPUReady(
		USELESS_ARG0,
		canvasIndex,
		deviceHeapIndex,
		queueHeapIndex,
		formatNative
	);
	window.initDrawData(USELESS_ARG0);

	webGPUListenToResize(
		wgpuRequestResponse.device,
		domElement,
		canvas,
		render
	);

	// let previousHeap: Heap = heapCreate();
	// let deltaHeap: Heap = heapCreate();
	function render() {
		if (_onRequestAnimationFrameInProgress) {
			return;
		}
		if (framesCount % 100 === 0) {
			console.log(framesCount);
			// console.log(heapStatus());
		}
		_onRequestAnimationFrameInProgress = true;

		// heapCopy(previousHeap);
		// const currentTexture = wgpuSurfaceGetCurrentTexture();
		window.onRequestAnimationFrame(
			USELESS_ARG0,
			BigInt(clockData.time),
			BigInt(canvas.width),
			BigInt(canvas.height)
		);
		framesCount++;
		// if (currentTexture) {
		// 	heapDeleteByItem(currentTexture);
		// }
		_onRequestAnimationFrameInProgress = false;
	}
	function animate() {
		clockTick(clockData);
		for (let i = 0; i < 1; i++) {
			render();
		}
		// if (framesCount < 10) {
		requestAnimationFrame(animate);
		// } else {
		// 	requestAnimationFrame(() => {
		// 		heapDelta(previousHeap, deltaHeap);
		// 		console.log(deltaHeap);
		// 		console.log(`${framesCount} frames rendered, stopping for now`);
		// 	});
		// }
	}
	animate();
}

