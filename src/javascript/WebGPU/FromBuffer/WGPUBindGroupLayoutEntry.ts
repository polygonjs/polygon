import { WGPU_OFFSET } from "../utils/WebGPUOffset";
import { u32Create } from "../utils/WebGPUUtils";
import { WGPUBufferBindingLayout } from "./WGPUBufferBindingLayout";
import { WGPUSamplerBindingLayoutFromBuffer } from "./WGPUSamplerBindingLayout";
import { WGPUStorageTextureBindingLayoutFromBuffer } from "./WGPUStorageTextureBindingLayout";
import { WGPUTextureBindingLayoutFromBuffer } from "./WGPUTextureBindingLayout";

export function WGPUBindGroupLayoutEntryFromBuffer(
	pointer: bigint
): GPUBindGroupLayoutEntry {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u32 = new Uint32Array(buffer); //window.ALLOCATED_MEMORY_CONTAINER.u32;
	// const pointer = Number(pointerb);
	const offset = WGPU_OFFSET.WGPUBindGroupLayoutEntry;
	const _u32 = u32Create(u32, pointer);
	//
	// const bindingOffset = offset.binding;
	// const bindingSize = WGPU_SIZE.u32;
	// const bindingStart = (pointer + bindingOffset) / bindingSize;
	const binding = _u32(offset.binding); //u32[Number(bindingStart)];

	// console.log({
	// 	u32,
	// 	pointer,
	// 	bindingOffset,
	// 	bindingSize,
	// 	bindingStart,
	// 	binding,
	// });
	//
	// const visibilityOffset = offset.visibility;
	// const visibilitySize = WGPU_SIZE.u32;
	// const visibilityStart = (pointer + visibilityOffset) / visibilitySize;
	const visibility = _u32(offset.visibility); //u32[Number(visibilityStart)];
	//
	// const bufferOffset = offset.buffer;
	// const bufferSize = offset.sampler - bufferOffset;
	const layoutBuffer = WGPUBufferBindingLayout(pointer + offset.buffer);
	const sampler = WGPUSamplerBindingLayoutFromBuffer(
		pointer + offset.sampler
	);
	const texture = WGPUTextureBindingLayoutFromBuffer(
		pointer + offset.texture
	);
	const storageTexture = WGPUStorageTextureBindingLayoutFromBuffer(
		pointer + offset.storageTexture
	);
	//
	// console.log("WGPUBindGroupLayoutFromBuffer", {
	// 	binding,
	// 	visibility,
	// 	bufferType,
	// });
	// let definedElementsCount = 0;
	// if (buffer) definedElementsCount++;
	// if (sampler) definedElementsCount++;
	// if (texture) definedElementsCount++;
	// if (storageTexture) definedElementsCount++;
	// if (definedElementsCount > 1) {
	// 	console.log({ buffer, sampler, texture, storageTexture });
	// 	// throw new Error(
	// 	// 	"Multiple defined elements in WGPUBindGroupLayoutEntryFromBuffer"
	// 	// );
	// }

	const entry: GPUBindGroupLayoutEntry = {
		binding,
		visibility,
		buffer: layoutBuffer, //: { type: bufferType },
		sampler,
		texture,
		storageTexture,
		externalTexture: undefined, // there is not externalTexture in native for now
	};
	// console.log({ entry });
	return entry;
	// const bindGroupLayout = device.createBindGroupLayout({ entries });
	// console.log(entries, bindGroupLayout);
	// return bindGroupLayout;
	// const heapIndex= heapAdd(bindGroupLayout);
	// console.log(entries,bindGroupLayout,heapIndex)
	// heapIndex
}
