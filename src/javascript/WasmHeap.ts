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
export function heapDelete(slot: HeapObject) {
	const index = HEAP.indexByItem.get(slot);
	if (index == null) {
		return;
	}
	HEAP.itemByIndex.delete(index);
	HEAP.indexByItem.delete(slot);
	if (index < HEAP.nextValue) {
		HEAP.nextValue = index;
	}
}
export function heapGet<T>(slot: bigint): T | undefined {
	return HEAP.itemByIndex.get(slot);
}
