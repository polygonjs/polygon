import { assetsLoaded } from "./AssetsController";
import { clockInit, clockTick } from "./Clock";
import {
	updateMemoryArrayViews,
	updateMemoryArrayViewsIfNeeded,
	USELESS_ARG0,
} from "./Common";
import {
	addEvents,
	eventsDataReset,
	markEventsDataDirty,
} from "./EventsController";
import { waitForCondition } from "./waitFor";
import {
	Heap,
	heapAdd,
	heapCopy,
	heapCreate,
	heapDelta,
	heapStatus,
} from "./WasmHeap";
import { WebGPURequestResponse } from "./WebGPU/utils/WebGPUCommon";
import { textureFormatIndex } from "./WebGPU/utils/WebGPUMap";
import { canvasSetSize, webGPUListenToResize } from "./WebGPUResize";

const DEBUG_HEAP: boolean = false;
interface WebGPURenderControllerOptions {
	webGPURequestResponse: WebGPURequestResponse;
	createCanvas: boolean;
}
export interface WebGPURenderController {
	start: () => void;
	stop: () => void;
}
export function webGPURenderControllerCreate(
	options: WebGPURenderControllerOptions
): WebGPURenderController | undefined {
	const { webGPURequestResponse, createCanvas } = options;
	const domElement = document.getElementById("app") as HTMLElement;
	if (!domElement) {
		alert("no dom element found with id app");
		return;
	}

	const clockData = clockInit();
	const canvas = createCanvas
		? document.createElement("canvas")
		: window.WebGPUCanvas;
	if (createCanvas == true) {
		canvas.oncontextmenu = () => false;
		canvas.tabIndex = 1;
		window.WebGPUCanvas = canvas;
		const rect = domElement.getBoundingClientRect();
		canvasSetSize(
			canvas,
			webGPURequestResponse.device,
			rect.width,
			rect.height
		);
		domElement.appendChild(canvas);
		addEvents(canvas);
		const context = canvas.getContext("webgpu");
		if (!context) {
			alert("failed to create a context");
			return;
		}
		const contextConfigurationOptions: GPUCanvasConfiguration = {
			device: webGPURequestResponse.device,
			format: webGPURequestResponse.presentationFormat,
			usage: GPUTextureUsage.RENDER_ATTACHMENT | GPUTextureUsage.COPY_SRC,
			// viewFormats: ["bgra8unorm-srgb"],
			// colorSpace: "srgb", //"display-p3",
			alphaMode: "opaque", //"premultiplied",
		};
		context.configure(contextConfigurationOptions);
		window.webGPUContext = context;
	}
	const canvasIndex = heapAdd(canvas);
	const deviceHeapIndex = heapAdd(webGPURequestResponse.device);
	const queueHeapIndex = heapAdd(webGPURequestResponse.device.queue);

	const formatNative = textureFormatIndex(
		webGPURequestResponse.presentationFormat
	);
	let _onRequestAnimationFrameInProgress: boolean = false;
	let framesCount = 0;
	let animateAllowed: boolean = false;

	webGPURequestResponse.device.addEventListener(
		"uncapturederror",
		(event) => {
			console.log("uncaptured error:", (event as any).error.message);
			animateAllowed = false;
		}
	);

	updateMemoryArrayViews();
	// (window.wasmFunctions as any).requestRealloc(
	// 	BigInt(101),
	// 	BigInt(102),
	// 	BigInt(103),
	// 	BigInt(104),
	// 	BigInt(105)
	// );
	window.wasmFunctions.onWebGPUReady(
		USELESS_ARG0,
		canvasIndex,
		deviceHeapIndex,
		queueHeapIndex,
		formatNative,
		BigInt(canvas.width),
		BigInt(canvas.height)
	);
	updateMemoryArrayViews();

	const resizeObserver = webGPUListenToResize(
		webGPURequestResponse.device,
		domElement,
		canvas,
		() => {
			if (animateAllowed == false) {
				return;
			}
			markEventsDataDirty();
			render();
		}
	);

	let previousHeap: Heap = heapCreate();
	let deltaHeap: Heap = heapCreate();
	function render() {
		if (animateAllowed == false) {
			return;
		}
		if (_onRequestAnimationFrameInProgress) {
			return;
		}
		if (DEBUG_HEAP && framesCount % 1 === 0) {
			console.log(framesCount);
			console.log(heapStatus());
			heapDelta(previousHeap, deltaHeap);
			console.log("deltaHeap:", deltaHeap);
		}
		_onRequestAnimationFrameInProgress = true;

		if (DEBUG_HEAP) heapCopy(previousHeap);
		// const currentTexture = wgpuSurfaceGetCurrentTexture();
		updateMemoryArrayViewsIfNeeded();
		window.wasmFunctions.onRequestAnimationFrame(
			USELESS_ARG0,
			BigInt(clockData.time),
			BigInt(canvas.width),
			BigInt(canvas.height)
		);
		eventsDataReset();
		framesCount++;
		// if (framesCount > 2) animateAllowed = false;
		// if (currentTexture) {
		// 	heapDeleteByItem(currentTexture);
		// }
		_onRequestAnimationFrameInProgress = false;
	}
	function animate() {
		if (animateAllowed == false) {
			return;
		}
		clockTick(clockData);
		render();
		// if (framesCount > 1) {
		// 	animateAllowed = false;
		// 	console.log("stop render to debug");
		// }
		if (animateAllowed) {
			requestAnimationFrame(animate);
		}
		// } else {
		// 	requestAnimationFrame(() => {
		// 		heapDelta(previousHeap, deltaHeap);
		// 		console.log(deltaHeap);
		// 		console.log(`${framesCount} frames rendered, stopping for now`);
		// 	});
		// }
	}
	async function start() {
		await waitForCondition(() => assetsLoaded() == true);
		animateAllowed = true;
		markEventsDataDirty();
		animate();
	}
	function stop() {
		animateAllowed = false;
		resizeObserver.disconnect();

		if (window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory) {
			const u8 = new Uint8Array(
				window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory.buffer
			);
			u8.fill(0);
		}
		window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory = undefined;
	}
	const controller: WebGPURenderController = {
		start,
		stop,
	};
	return controller;
}

