import { EVENTS_DATA, markEventsDataDirty } from "../../EventsController";
import { heapGet } from "../../WasmHeap";

export function wgpuBufferGetMappedRange(
	bufferHeapIndex: bigint,
	offset: bigint,
	size: bigint
) {
	const buffer = heapGet<GPUBuffer>(bufferHeapIndex)!;
	const result = buffer.getMappedRange(Number(offset), Number(size));
	const uint8 = new Uint8Array(result);
	EVENTS_DATA.readPixelValue[0] = uint8[0];
	EVENTS_DATA.readPixelValue[1] = uint8[1];
	EVENTS_DATA.readPixelValue[2] = uint8[2];
	EVENTS_DATA.readPixelValue[3] = uint8[3];
	markEventsDataDirty();
	return BigInt(0);
}

