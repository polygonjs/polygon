import { WebGPURequestResponse } from "./WebGPU/utils/WebGPUCommon";

export async function webGPURequest(): Promise<
	WebGPURequestResponse | undefined
> {
	if (!navigator.gpu) {
		return;
	}
	const adapter = await navigator.gpu.requestAdapter();
	if (!adapter) {
		return;
	}
	const device = await adapter.requestDevice();
	const presentationFormat = navigator.gpu.getPreferredCanvasFormat();
	// const presentationFormat = "bgra8unorm-srgb";
	if (!(device && adapter)) {
		alert("need a browser that supports WebGPU");
		return;
	}

	// console.log("Adapter info:", adapter.info);
	// console.log("Presentation format:", presentationFormat);
	// console.log("Device limits:", device.limits);
	// console.log("Device features:", device.features);

	return { device, presentationFormat };
}

