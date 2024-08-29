import { stepModeIntToGPUVertexStepMode } from "../utils/WebGPUMap";
import { _big, _num, createWGPUItemsByPointer } from "../utils/WebGPUUtils";
import {
	WGPUVertexAttribute,
	WGPUVertexBufferLayout,
} from "../utils/WGPUStructInfos";
import { WGPUVertexAttributeFromBuffer } from "./WGPUVertexAttribute";

export function WGPUVertexBufferLayoutFromBuffer(
	p: bigint
): GPUVertexBufferLayout {
	const m = WGPUVertexBufferLayout.members;
	//
	const arrayStrideb = _big(p, m.arrayStride);
	const arrayStride = Number(arrayStrideb);
	//
	const stepModeb = _num(p, m.stepMode);
	const stepMode: GPUVertexStepMode =
		stepModeIntToGPUVertexStepMode(stepModeb);
	//
	const attributesCount = _big(p, m.attributeCount);
	//
	const attributes: GPUVertexAttribute[] = createWGPUItemsByPointer({
		pointer: p,
		itemsCount: attributesCount,
		itemSize: WGPUVertexAttribute.size,
		memberInfo: m.attributes,
		callback: (itemPointer) => WGPUVertexAttributeFromBuffer(itemPointer),
	});

	const vertexBufferLayout: GPUVertexBufferLayout = {
		arrayStride,
		stepMode,
		attributes,
	};
	return vertexBufferLayout;
}

