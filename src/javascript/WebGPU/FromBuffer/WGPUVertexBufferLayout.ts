import { stepModeIntToGPUVertexStepMode } from "../utils/WebGPUMap";
import { WGPU_OFFSET, WGPU_SIZE } from "../utils/WebGPUOffset";
import { createWGPUItemsByPointer, u64Create } from "../utils/WebGPUUtils";
import { WGPUVertexAttributeFromBuffer } from "./WGPUVertexAttribute";

export function WGPUVertexBufferLayoutFromBuffer(
	pointer: bigint
): GPUVertexBufferLayout {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u64 = new BigUint64Array(buffer);
	const _u64 = u64Create(u64, pointer);
	//
	const offset = WGPU_OFFSET.WGPUVertexBufferLayout;
	//
	const arrayStrideb = _u64(offset.arrayStride);
	const arrayStride = Number(arrayStrideb);
	//
	const stepModeb = _u64(offset.stepMode);
	const stepMode: GPUVertexStepMode = stepModeIntToGPUVertexStepMode(
		Number(stepModeb)
	);
	//
	const attributesCount = _u64(offset.attributeCount);
	//
	const attributes: GPUVertexAttribute[] = createWGPUItemsByPointer({
		u64,
		pointer,
		arrayOffset: offset.attributes,
		itemsCount: attributesCount,
		itemSize: WGPU_SIZE.WGPUVertexAttribute,
		callback: (itemPointer) => WGPUVertexAttributeFromBuffer(itemPointer),
	});

	const vertexBufferLayout: GPUVertexBufferLayout = {
		arrayStride,
		stepMode,
		attributes,
	};
	return vertexBufferLayout;
}

