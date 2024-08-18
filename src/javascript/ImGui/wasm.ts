import { EVENTS_DATA } from "../EventsController";
import { WGPU_SIZE } from "../WebGPU/utils/WebGPUOffset";

export function imguiGetWindowData(wPointer: bigint, hPointer: bigint) {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	// const u8 = new Uint8Array(buffer);
	const u32 = new Uint32Array(buffer);

	u32[Number(wPointer / WGPU_SIZE.u32)] = window.WebGPUCanvas.width;
	u32[Number(hPointer / WGPU_SIZE.u32)] = window.WebGPUCanvas.height;
}

export function imguiGetMouseData(
	mxPointer: bigint,
	myPointer: bigint,
	leftButtonPressedPointer: bigint
) {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u8 = new Uint8Array(buffer);
	const f32 = new Float32Array(buffer);
	// const u64 = new BigUint64Array(buffer);
	// const offset = WGPU_OFFSET.WGPUBindGroupDescriptor;

	//
	//
	// const layoutOffset = offset.layout;
	// const layoutSize = WGPU_SIZE.float;
	// const layoutStart = mxPointer / WGPU_SIZE.float;
	// console.log(mxPointer, layoutStart);
	// const layoutPointer = f32[Number(layoutStart)];

	f32[Number(mxPointer / WGPU_SIZE.float)] = EVENTS_DATA.cursor.x;
	f32[Number(myPointer / WGPU_SIZE.float)] = EVENTS_DATA.cursor.y;
	u8[Number(leftButtonPressedPointer / WGPU_SIZE.bool)] = EVENTS_DATA
		.mouseButton.left
		? 0xff
		: 0;
	// console.log(u8[Number(leftButtonPressedPointer / WGPU_SIZE.bool)]);
}

