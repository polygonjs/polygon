import { stepModeIntToGPUVertexStepMode } from "../utils/WebGPUMap";
import { WGPU_OFFSET, WGPU_SIZE } from "../utils/WebGPUOffset";
import {
	createWGPUItemsByPointer,
	numberFromBuffer,
} from "../utils/WebGPUUtils";
import { WGPUVertexAttributeFromBuffer } from "./WGPUVertexAttribute";

export function WGPUVertexBufferLayoutFromBuffer(
	pointer: bigint,
	u32: Uint32Array,
	u64: BigUint64Array
): GPUVertexBufferLayout {
	const offset = WGPU_OFFSET.WGPUVertexBufferLayout;
	//
	const arrayStrideOffset = offset.arrayStride;
	const arrayStrideSize = WGPU_SIZE.u64;
	const arrayStrideStart = (pointer + arrayStrideOffset) / arrayStrideSize;
	const arrayStrideb = u64[Number(arrayStrideStart)];
	const arrayStride = Number(arrayStrideb);
	//
	const stepModeOffset = offset.stepMode;
	const stepModeSize = WGPU_SIZE.u64;
	const stepModeStart = (pointer + stepModeOffset) / stepModeSize;
	const stepModeb = u64[Number(stepModeStart)];
	const stepMode: GPUVertexStepMode = stepModeIntToGPUVertexStepMode(
		Number(stepModeb)
	);
	//
	const attributesCount = numberFromBuffer(
		u64,
		pointer,
		offset.attributeCount
	); //u64[Number(attributesCountStart)];
	//
	const attributes: GPUVertexAttribute[] = createWGPUItemsByPointer({
		u64,
		pointer,
		arrayOffset: offset.attributes,
		itemsCount: attributesCount,
		itemSize: WGPU_SIZE.WGPUVertexAttribute,
		callback: (itemPointer) =>
			WGPUVertexAttributeFromBuffer(itemPointer, u32, u64),
	});
	// const attributeArrayPointerIndex =
	// 	(pointer + offset.attributes) / WGPU_SIZE.u64;
	// const attributeArrayPointer = u64[Number(attributeArrayPointerIndex)];
	// for (let i = 0; i < attributesCountb; i++) {
	// 	const attributePointer =
	// 		attributeArrayPointer + BigInt(i) * WGPU_SIZE.WGPUVertexAttribute;

	// 	const attribute = WGPUVertexAttributeFromBuffer(
	// 		attributePointer,
	// 		u32,
	// 		u64
	// 	);
	// 	// console.log(i, attribute);
	// 	attributes.push(attribute);
	// }
	//
	const vertexBufferLayout: GPUVertexBufferLayout = {
		arrayStride,
		stepMode,
		attributes,
	};
	return vertexBufferLayout;
}
