import { _big, createItemsByPointer, _label } from "../../wasm/WasmUtils";
import {
	WGPUBindGroupLayoutDescriptor,
	WGPUBindGroupLayoutEntry,
} from "../utils/WGPUStructInfos";
import { WGPUBindGroupLayoutEntryFromBuffer } from "./WGPUBindGroupLayoutEntry";

export function WGPUBindGroupLayoutDescriptorFromBuffer(
	p: bigint
): GPUBindGroupLayoutDescriptor {
	const m = WGPUBindGroupLayoutDescriptor.members;
	//
	const label = _label(p, m);
	const entriesCount = _big(p, m.entryCount);
	const entries = createItemsByPointer<GPUBindGroupLayoutEntry>({
		pointer: p,
		itemsCount: entriesCount,
		itemSize: WGPUBindGroupLayoutEntry.size,
		memberInfo: m.entries,
		callback: (itemPointer) =>
			WGPUBindGroupLayoutEntryFromBuffer(itemPointer),
	});

	const desc: GPUBindGroupLayoutDescriptor = {
		label,
		entries,
	};
	return desc;
}

