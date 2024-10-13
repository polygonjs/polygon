import { WebGPURequestResponse } from "./WebGPU/utils/WebGPUCommon";

const COLOR_SPACE_LINEAR = true; // needs to manually match same variable in main.jai (although it is not yet working when set to false)
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
	const presentationFormat = getPresentationFormat(device);
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

function getPresentationFormat(device: GPUDevice): GPUTextureFormat {
	if (COLOR_SPACE_LINEAR) {
		return navigator.gpu.getPreferredCanvasFormat();
	} else {
		const srgbFormat = "bgra8unorm-srgb";
		console.log(navigator.gpu.getPreferredCanvasFormat(), srgbFormat);
		if (isFormatSupported(device, srgbFormat)) {
			return srgbFormat;
		} else {
			return navigator.gpu.getPreferredCanvasFormat();
		}
	}
}

function isFormatSupported(
	device: GPUDevice,
	format: GPUTextureFormat
): boolean {
	try {
		const descriptor: GPUTextureDescriptor = {
			size: [1, 1],
			format: format as GPUTextureFormat,
			usage: GPUTextureUsage.TEXTURE_BINDING,
		};
		device.createTexture(descriptor);
		return true;
	} catch {
		return false;
	}
}

