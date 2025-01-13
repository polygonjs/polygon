import { USELESS_ARG0 } from "../../Common";
import { heapGet } from "../../WasmHeap";

export async function wgpuDevicePopErrorScope(deviceHeapIndex: bigint) {
	const device = heapGet<GPUDevice>(deviceHeapIndex)!;
	const error = await device.popErrorScope();
	const errorSize = error ? BigInt(error.message.length) : 0n;
	window.wasmFunctions.onPopErrorScopeCompleted(USELESS_ARG0, errorSize);
}

