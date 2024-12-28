export type MainFunction = (uselessArg0: number, uselessArg1: BigInt) => void;
export const USELESS_ARG0 = BigInt(10);
export type UpdateWasmFunction = (
	uselessArg0: bigint,
	time: bigint,
	aspect: bigint
) => void;
export type OnWebGPUReadyFunction = (
	uselessArg0: bigint,
	canvasHeapIndex: bigint,
	deviceHeapIndex: bigint,
	queueHeapIndex: bigint,
	preferredFormat: number,
	width: bigint,
	height: bigint
) => void;
// export type InitDrawDataFunction = (uselessArg0: bigint) => void;
export type OnRequestAnimationFrameFunction = (
	uselessArg0: bigint,
	time: bigint,
	width: bigint,
	height: bigint
) => void;
export type QSortFunction = (
	uselessArg0: bigint,
	basePointer: bigint,
	nitems: number,
	size: number,
	comparePointer: bigint
) => void;
export type QSortFunctionWrapper = (
	basePointer: bigint,
	nitems: number,
	size: number,
	comparePointer: bigint
) => void;
export type RequestAllocationFunction = (
	uselessArg0: bigint,
	nodeId: bigint,
	size: bigint
) => void;
export type OnAllocatedMemoryWrittenFunction = (
	uselessArg0: bigint,
	nodeId: bigint
) => void;

export interface Vector2 {
	x: number;
	y: number;
}
export interface Vector3 {
	x: number;
	y: number;
	z: number;
}

interface WasmFunctions {
	onWebGPUReady: OnWebGPUReadyFunction;
	onRequestAnimationFrame: OnRequestAnimationFrameFunction;
	qsort: QSortFunction;
	qsortWrapper: QSortFunctionWrapper;
	requestAllocation: RequestAllocationFunction;
	onAllocatedMemoryWritten: OnAllocatedMemoryWrittenFunction;
}
declare global {
	interface Window {
		WebGPUCanvas: HTMLCanvasElement;
		wasmFunctions: WasmFunctions;
		ALLOCATED_MEMORY_CONTAINER: AllocatedMemoryContainer;
		webGPUContext: GPUCanvasContext;
	}
}

export interface AllocatedMemory {
	buffer: ArrayBufferLike;
}

export type GetArrayFunction = (i: number) => number | bigint;
export interface AllocatedMemoryContainer {
	allocatedMemory?: AllocatedMemory;
	dataView: DataView;
}

export function updateMemoryArrayViews() {
	const container = window.ALLOCATED_MEMORY_CONTAINER;
	container.dataView = new DataView(container.allocatedMemory!.buffer);
}
export function updateMemoryArrayViewsIfNeeded() {
	if (
		(window.ALLOCATED_MEMORY_CONTAINER.dataView.buffer as any).detached ==
		true
	) {
		updateMemoryArrayViews();
	}
}
const LITTLE_ENDIAN = true;
export function setBoolean(i: number, value: boolean) {
	updateMemoryArrayViewsIfNeeded();
	return window.ALLOCATED_MEMORY_CONTAINER.dataView.setUint8(
		i,
		value ? 1 : 0
	);
}
export const getU8 = (i: number) => {
	updateMemoryArrayViewsIfNeeded();
	return window.ALLOCATED_MEMORY_CONTAINER.dataView.getUint8(i);
};
export const setU8 = (i: number, value: number) => {
	updateMemoryArrayViewsIfNeeded();
	return window.ALLOCATED_MEMORY_CONTAINER.dataView.setUint8(i, value);
};
export const getU16 = (i: number) => {
	updateMemoryArrayViewsIfNeeded();
	return window.ALLOCATED_MEMORY_CONTAINER.dataView.getUint16(
		i,
		LITTLE_ENDIAN
	);
};
export const getU32 = (i: number) => {
	updateMemoryArrayViewsIfNeeded();

	return window.ALLOCATED_MEMORY_CONTAINER.dataView.getUint32(
		i,
		LITTLE_ENDIAN
	);
};
export const setU32 = (i: number, value: number) => {
	updateMemoryArrayViewsIfNeeded();

	return window.ALLOCATED_MEMORY_CONTAINER.dataView.setUint32(
		i,
		value,
		LITTLE_ENDIAN
	);
};
export const getU64 = (i: number) => {
	updateMemoryArrayViewsIfNeeded();
	return window.ALLOCATED_MEMORY_CONTAINER.dataView.getBigUint64(
		i,
		LITTLE_ENDIAN
	);
};
export const getS32 = (i: number) =>
	window.ALLOCATED_MEMORY_CONTAINER.dataView.getInt32(i, LITTLE_ENDIAN);
export const getFLOAT32 = (i: number) => {
	return window.ALLOCATED_MEMORY_CONTAINER.dataView.getFloat32(
		i,
		LITTLE_ENDIAN
	);
};
export const setFLOAT32 = (i: number, value: number) => {
	updateMemoryArrayViewsIfNeeded();
	return window.ALLOCATED_MEMORY_CONTAINER.dataView.setFloat32(
		i,
		value,
		LITTLE_ENDIAN
	);
};
export const getFLOAT64 = (i: number) => {
	updateMemoryArrayViewsIfNeeded();
	return window.ALLOCATED_MEMORY_CONTAINER.dataView.getFloat64(
		i,
		LITTLE_ENDIAN
	);
};

