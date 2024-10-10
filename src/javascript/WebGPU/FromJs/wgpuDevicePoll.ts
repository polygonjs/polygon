import { heapGet } from "../../WasmHeap";

export async function wgpuDevicePoll(deviceHeadIndex: bigint): Promise<void> {
	// this promise is a little useless, as we cannot current wait for the promise to be resolved,
	// when calling this from wasm
	return new Promise((resolve) => {
		const device = heapGet<GPUDevice>(deviceHeadIndex)!;
		device.queue.onSubmittedWorkDone().then(resolve);
	});
}

