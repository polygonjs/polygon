// import { WGPU_SIZE } from "./WebGPU/utils/WebGPUOffset";

type HeapObject = any;
interface Heap {
	itemByIndex: Map<BigInt, HeapObject>;
	indexByItem: Map<HeapObject, bigint>;
	nextValue: bigint;
}
const HEAP: Heap = {
	itemByIndex: new Map(),
	indexByItem: new Map(),
	// we start with a number > 0, so that failed pointer values of 0 do not resolve to anything
	nextValue: BigInt(3),
};

export function heapAdd(item: HeapObject): bigint {
	const currentIndex = HEAP.indexByItem.get(item);
	if (currentIndex != null) {
		console.log("item already in heap", item);
		return currentIndex;
	}

	// const slot = HEAP.availableSlots.values().next().value;
	const index = HEAP.nextValue;
	HEAP.itemByIndex.set(index, item);
	HEAP.indexByItem.set(item, index);
	// HEAP.availableSlots.delete(index);

	HEAP.nextValue++;
	while (HEAP.itemByIndex.has(HEAP.nextValue)) {
		HEAP.nextValue++;
	}
	// console.log("+ heapAdd", { index, item });
	return index;
}
export function heapDeleteByItem(item: HeapObject) {
	const index = HEAP.indexByItem.get(item);
	if (index == null) {
		console.log("heapDelete: item not in heap", item);
		return;
	}
	_heapDelete(index, item);
	// console.log("- heapDeleteByItem", { index, item });
}
export function heapDeleteByIndex(index: bigint) {
	const item = HEAP.itemByIndex.get(index);
	if (item == null) {
		console.log("heapDelete: item not in heap", index, item);
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
export function heapGet<T>(slot: bigint): T | undefined {
	return HEAP.itemByIndex.get(slot);
}

