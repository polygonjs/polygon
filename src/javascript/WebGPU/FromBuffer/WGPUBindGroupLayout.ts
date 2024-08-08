// import { heapAdd } from "../../WasmHeap";
// import { bufferTypeIntToGPUBufferBindingType } from "../utils/WebGPUMap";
// import { WGPU_OFFSET, WGPU_SIZE } from "../utils/WebGPUOffset";

// export function WGPUBindGroupLayoutFromBuffer(
// 	device: GPUDevice,
// 	pointer: bigint
// ): GPUBindGroupLayout {
// 	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
// 	const u32 = new Uint32Array(buffer); //window.ALLOCATED_MEMORY_CONTAINER.u32;
// 	// const pointer = Number(pointerb);
// 	const offset = WGPU_OFFSET.WGPUBindGroupLayoutEntry;
// 	//
// 	const bindingOffset = offset.binding;
// 	const bindingSize = WGPU_SIZE.u32;
// 	const bindingStart = (pointer + bindingOffset) / bindingSize;
// 	const binding = u32[Number(bindingStart)];
// 	// console.log({
// 	// 	u32,
// 	// 	pointer,
// 	// 	bindingOffset,
// 	// 	bindingSize,
// 	// 	bindingStart,
// 	// 	binding,
// 	// });
// 	//
// 	const visibilityOffset = offset.visibility;
// 	const visibilitySize = WGPU_SIZE.u32;
// 	const visibilityStart = (pointer + visibilityOffset) / visibilitySize;
// 	const visibility = u32[Number(visibilityStart)];
// 	//
// 	// const bufferOffset = offset.buffer;
// 	// const bufferSize = offset.sampler - bufferOffset;
// 	const bufferTypeOffset =
// 		offset.buffer + WGPU_OFFSET.WGPUBufferBindingLayout.type;
// 	const bufferSize = WGPU_SIZE.u32;
// 	const bufferStart = (pointer + bufferTypeOffset) / bufferSize;
// 	const bufferTypeInt = u32[Number(bufferStart)];
// 	const bufferType = bufferTypeIntToGPUBufferBindingType(bufferTypeInt);
// 	//
// 	// console.log("WGPUBindGroupLayoutFromBuffer", {
// 	// 	binding,
// 	// 	visibility,
// 	// 	bufferType,
// 	// });
// 	const entries: GPUBindGroupLayoutEntry[] = [
// 		{
// 			binding,
// 			visibility,
// 			buffer: { type: bufferType },
// 		},
// 	];
// 	// const desc:GPUBindGroupLayoutDescriptor = {
// 	// 	entries,
// 	// }
// 	const bindGroupLayout = device.createBindGroupLayout({ entries });
// 	console.log(entries, bindGroupLayout);
// 	return bindGroupLayout;
// 	// const heapIndex= heapAdd(bindGroupLayout);
// 	// console.log(entries,bindGroupLayout,heapIndex)
// 	// heapIndex
// }
