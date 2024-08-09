import { clockInit, clockTick } from "./Clock";
import { USELESS_ARG0 } from "./Common";
import { heapAdd } from "./WasmHeap";
import { WGPURequestResponse } from "./WebGPU/utils/WebGPUCommon";
import { textureFormatIndex } from "./WebGPU/utils/WebGPUMap";
import { webGPUListenToResize } from "./WebGPUResize";

export function webgpuSetup(wgpuRequestResponse: WGPURequestResponse) {
	const domElement = document.getElementById("app") as HTMLElement;
	if (!domElement) {
		alert("no dom element found with id app");
		return;
	}

	const canvas = document.createElement("canvas");
	const rect = domElement.getBoundingClientRect();
	canvas.width = rect.width;
	canvas.height = rect.height;
	domElement.appendChild(canvas);
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
	const currentTexture = context.getCurrentTexture();
	const currentTextureView = currentTexture.createView();
	heapAdd(currentTexture);
	heapAdd(currentTextureView);
	const deviceHeapIndex = heapAdd(wgpuRequestResponse.device);
	const queueHeapIndex = heapAdd(wgpuRequestResponse.device.queue);
	const formatNative = textureFormatIndex(
		wgpuRequestResponse.presentationFormat
	);

	// const resizeObserver = new ResizeObserver((entries) => {
	// 	const firstEntry = entries[0];
	// 	if (firstEntry == null) return;
	// 	canvas.width = firstEntry.contentRect.width;
	// 	canvas.height = firstEntry.contentRect.height;
	// 	render();
	// });
	// resizeObserver.observe(domElement);
	webGPUListenToResize(
		wgpuRequestResponse.device,
		domElement,
		canvas,
		render
	);

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

	const clockData = clockInit();
	function render() {
		window.onRequestAnimationFrame(
			USELESS_ARG0,
			BigInt(clockData.time),
			BigInt(canvas.width),
			BigInt(canvas.height)
		);
	}
	function animate() {
		clockTick(clockData);
		render();
		requestAnimationFrame(animate);
	}
	animate();
}
