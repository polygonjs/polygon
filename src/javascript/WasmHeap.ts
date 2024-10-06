// import { WGPU_SIZE } from "./WebGPU/utils/WebGPUOffset";

type HeapObject = any;
export interface HeapContent {
	itemByIndex: Map<BigInt, HeapObject>;
	indexByItem: Map<HeapObject, bigint>;
}
export interface Heap extends HeapContent {
	nextValue: bigint;
}
export function heapCreate(): Heap {
	return {
		itemByIndex: new Map(),
		indexByItem: new Map(),
		// we start with a number > 0, so that failed pointer values of 0 do not resolve to anything
		nextValue: BigInt(3),
	};
}
const HEAP: Heap = heapCreate();
function _heapCopy(src: Heap, target: Heap) {
	target.itemByIndex = new Map(src.itemByIndex);
	target.indexByItem = new Map(src.indexByItem);
	target.nextValue = src.nextValue;
}
export function heapCopy(target: Heap) {
	_heapCopy(HEAP, target);
}
function _heapDelta(heap0: Heap, heap1: Heap, delta: HeapContent) {
	delta.itemByIndex.clear();
	delta.indexByItem.clear();
	for (const [key, value] of heap0.itemByIndex) {
		if (!heap1.itemByIndex.has(key)) {
			delta.itemByIndex.set(key, value);
		}
	}
	for (const [key, value] of heap0.indexByItem) {
		if (!heap1.indexByItem.has(key)) {
			delta.indexByItem.set(key, value);
		}
	}
}
export function heapDelta(heap1: Heap, delta: HeapContent) {
	_heapDelta(HEAP, heap1, delta);
}

export function heapAdd(item: HeapObject): bigint {
	const currentIndex = HEAP.indexByItem.get(item);
	if (currentIndex != null) {
		// console.log("item already in heap", item);
		return currentIndex;
	}

	const index = HEAP.nextValue;
	HEAP.itemByIndex.set(index, item);
	HEAP.indexByItem.set(item, index);

	HEAP.nextValue++;
	while (HEAP.itemByIndex.has(HEAP.nextValue)) {
		HEAP.nextValue++;
	}
	// console.log("+ heapAdd", { index, item });
	return index;
}
export function heapStatus() {
	return {
		itemByIndex: HEAP.itemByIndex.size,
		indexByItem: HEAP.indexByItem.size,
		nextValue: HEAP.nextValue,
	};
}
export function heapDeleteByItem(item: HeapObject) {
	const index = HEAP.indexByItem.get(item);
	if (index == null) {
		console.warn("heapDelete: item not in heap", item);
		return;
	}
	_heapDelete(index, item);
	// console.log("- heapDeleteByItem", { index, item });
}
export function heapDeleteByIndex(index: bigint) {
	const item = HEAP.itemByIndex.get(index);
	if (item == null) {
		console.warn("heapDelete: item not in heap", index);
		return;
	}
	_heapDelete(index, item);
	// console.log("- heapDeleteByIndex", { index, item });
}

// export function heapDeleteByPointer(pointer: bigint) {
// 	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
// 	const u64 = new BigUint64Array(buffer);

// 	//
// 	const size = WGPU_SIZE.u64;
// 	const start = pointer / size;
// 	const index = u64[Number(start)];
// 	heapDeleteByIndex(index);
// }
function _heapDelete(index: bigint, item: HeapObject) {
	HEAP.itemByIndex.delete(index);
	HEAP.indexByItem.delete(item);
	if (index < HEAP.nextValue) {
		HEAP.nextValue = index;
	}
}
export function heapGet<T>(index: bigint): T | undefined {
	return HEAP.itemByIndex.get(index);
}

