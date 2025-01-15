import { heapGet } from "../../WasmHeap";
import { _big, _label, createItemsByPointer } from "../../wasm/WasmUtils";
import {
	WGPUBindGroupDescriptor,
	WGPUBindGroupEntry,
} from "../utils/WGPUStructInfos";
import { WGPUBindGroupEntryFromBuffer } from "./WGPUBindGroupEntry";

export function WGPUBindGroupDescriptorFromBuffer(
	p: bigint
): GPUBindGroupDescriptor {
	const m = WGPUBindGroupDescriptor.members;

	//
	const label = _label(p, m);
	//
	const layoutPointer = _big(p, m.layout);
	const layout = heapGet<GPUBindGroupLayout>(layoutPointer);
	if (!layout) {
		throw new Error("layout is null");
	}
	//
	const entriesCount = _big(p, m.entryCount);
	//
	const entries: GPUBindGroupEntry[] = createItemsByPointer({
		pointer: p,
		itemsCount: entriesCount,
		itemSize: WGPUBindGroupEntry.size,
		memberInfo: m.entries,
		callback: (itemPointer) => WGPUBindGroupEntryFromBuffer(itemPointer),
	});

	const desc: GPUBindGroupDescriptor = {
		label,
		layout,
		entries,
	};
	return desc;
}

