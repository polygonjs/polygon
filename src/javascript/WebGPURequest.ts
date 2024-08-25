import { WebGPURequestResponse } from "./WebGPU/utils/WebGPUCommon";

export async function webGPURequest(): Promise<
	WebGPURequestResponse | undefined
> {
	const adapter = await navigator.gpu?.requestAdapter();
	const device = await adapter?.requestDevice();
	const presentationFormat = navigator.gpu.getPreferredCanvasFormat();
	if (!(device && adapter)) {
		alert("need a browser that supports WebGPU");
		return;
	}

	return { device, presentationFormat };
}

