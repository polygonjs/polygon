import { jsStringFromJaiStringWithoutLength } from "../../wasm/StringUtils";
import { WGPU_SIZE } from "./WebGPUOffset";

interface LabelOffsetContainer {
	label: bigint;
}
export function labelFromBuffer(
	pointer: bigint,
	offset: LabelOffsetContainer,
	u64: BigUint64Array
) {
	const labelOffset = offset.label;
	const labelSize = WGPU_SIZE.u64;
	const labelStart = (pointer + labelOffset) / labelSize;
	const labelPointer = u64[Number(labelStart)];
	const label = jsStringFromJaiStringWithoutLength(BigInt(labelPointer));
	return label;
}

export function numberFromBuffer(
	u64: BigUint64Array,
	pointer: bigint,
	offset: bigint
): bigint {
	//
	const countOffset = offset;
	const countSize = WGPU_SIZE.u64;
	const countStart = (pointer + countOffset) / countSize;
	return u64[Number(countStart)];
}

// export function arrayItemHeapIndex(
// 	u64: BigUint64Array,
// 	pointer: bigint,
// 	arrayOffset: bigint,
// 	i: number
// ) {
// 	const itemPointer = (pointer + arrayOffset) / WGPU_SIZE.u64;
// 	const itemHeapIndex = u64[Number(itemPointer)];
// 	// we only add i, and not size_of(a-struct)*i
// 	// since WGPUBindGroupLayout is just a pointer, therefore NewArray(X, WGPUBindGroupLayout)
// 	// is an array of pointers
// 	const heapIndex = u64[Number(itemHeapIndex / WGPU_SIZE.u64) + i];
// 	return heapIndex;
// }
// interface CreateWGPUItemsByPointerOptionsCallbackOptions {
// 	itemPointer: bigint;
// }
// interface CreateWGPUItemsByHeapIndexOptionsCallbackOptions {
// 	itemHeapIndex: bigint;
// }
interface CreateWGPUItemsByPointerOptions<T> {
	u64: BigUint64Array;
	pointer: bigint;
	arrayOffset: bigint;
	itemsCount: bigint;
	itemSize: bigint;
	callback: (itemPointer: bigint) => T;
}
interface CreateWGPUItemsByHeapIndexOptions<T> {
	u64: BigUint64Array;
	pointer: bigint;
	arrayOffset: bigint;
	itemsCount: bigint;
	// itemSize: bigint;
	callback: (itemHeapIndex: bigint) => T;
}
export function createWGPUItemsByPointer<T>(
	options: CreateWGPUItemsByPointerOptions<T>
) {
	const { u64, pointer, arrayOffset, itemsCount, itemSize, callback } =
		options;
	// const items: T[] = [];
	const arrayPointerIndex = (pointer + arrayOffset) / WGPU_SIZE.u64;
	const arrayPointer = u64[Number(arrayPointerIndex)];
	return new Array(Number(itemsCount)).fill(1).map((_, i) => {
		const itemPointer = arrayPointer + BigInt(i) * itemSize;
		// const itemHeapIndex = u64[Number(arrayPointer / WGPU_SIZE.u64) + i];
		return callback(itemPointer);

		// const attribute = WGPUVertexAttributeFromBuffer(
		// 	attributePointer,
		// 	u32,
		// 	u64
		// );
		// return attribute
	});
	// for (let i = 0; i < itemsCount; i++) {

	// 	// console.log(i, attribute);
	// 	items.push(attribute);
	// }
	// return items;
}
export function createWGPUItemsByHeapIndex<T>(
	options: CreateWGPUItemsByHeapIndexOptions<T>
) {
	const { u64, pointer, arrayOffset, itemsCount, callback } = options;
	// const items: T[] = [];
	const arrayPointerIndex = (pointer + arrayOffset) / WGPU_SIZE.u64;
	const arrayPointer = u64[Number(arrayPointerIndex)];
	return new Array(Number(itemsCount)).fill(1).map((_, i) => {
		const itemHeapIndex = u64[Number(arrayPointer / WGPU_SIZE.u64) + i];
		return callback(itemHeapIndex);

		// const attribute = WGPUVertexAttributeFromBuffer(
		// 	attributePointer,
		// 	u32,
		// 	u64
		// );
		// return attribute
	});
	// for (let i = 0; i < itemsCount; i++) {

	// 	// console.log(i, attribute);
	// 	items.push(attribute);
	// }
	// return items;
}
