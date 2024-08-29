import { _big, createWGPUItemsByPointer, _label } from "../utils/WebGPUUtils";
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
	const entries = createWGPUItemsByPointer<GPUBindGroupLayoutEntry>({
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

