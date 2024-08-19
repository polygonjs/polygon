import { jsStringFromJaiStringWithoutLength } from "../../wasm/WasmString";
import { heapGet } from "../../WasmHeap";
import { WGPU_SIZE } from "./WebGPUOffset";

interface LabelOffsetContainer {
	label: bigint;
}
export function labelFromBuffer(
	pointer: bigint,
	offset: LabelOffsetContainer,
	u64: BigUint64Array
) {
	return stringFromBuffer(pointer, offset.label, u64);
	// const labelOffset = offset.label;
	// const labelSize = WGPU_SIZE.u64;
	// const labelStart = (pointer + labelOffset) / labelSize;
	// const labelPointer = u64[Number(labelStart)];
	// const label = jsStringFromJaiStringWithoutLength(BigInt(labelPointer));
	// return label;
}
export function stringFromBuffer(
	pointer: bigint,
	stringOffset: bigint,
	u64: BigUint64Array
) {
	const labelOffset = stringOffset;
	const labelSize = WGPU_SIZE.u64;
	const labelStart = (pointer + labelOffset) / labelSize;
	const labelPointer = u64[Number(labelStart)];
	const label = jsStringFromJaiStringWithoutLength(BigInt(labelPointer));
	return label;
}

export function u64Create(
	u64: BigUint64Array,
	pointer: bigint
): (i: bigint) => bigint {
	function _u64(elementOffset: bigint) {
		const elementSize = WGPU_SIZE.u64;
		const elementStart = (pointer + elementOffset) / elementSize;
		const elementb = u64[Number(elementStart)];
		return elementb;
	}
	return _u64;
}
export function f64Create(
	u64: Float64Array,
	pointer: bigint
): (i: bigint) => number {
	function _f64(elementOffset: bigint) {
		const elementSize = WGPU_SIZE.u64;
		const elementStart = (pointer + elementOffset) / elementSize;
		const elementb = u64[Number(elementStart)];
		return elementb;
	}
	return _f64;
}
export function f32Create(
	u64: Float32Array,
	pointer: bigint
): (i: bigint) => number {
	function _f32(elementOffset: bigint) {
		const elementSize = WGPU_SIZE.float;
		const elementStart = (pointer + elementOffset) / elementSize;
		const elementb = u64[Number(elementStart)];
		return elementb;
	}
	return _f32;
}
export function u32Create(
	u32: Uint32Array,
	pointer: bigint
): (i: bigint) => number {
	function _u32(elementOffset: bigint) {
		const elementSize = WGPU_SIZE.u32;
		const elementStart = (pointer + elementOffset) / elementSize;
		const elementb = u32[Number(elementStart)];
		return Number(elementb);
	}
	return _u32;
}
export function u16Create(
	u16: Uint16Array,
	pointer: bigint
): (i: bigint) => number {
	function _u16(elementOffset: bigint) {
		const elementSize = WGPU_SIZE.u16;
		const elementStart = (pointer + elementOffset) / elementSize;
		const elementb = u16[Number(elementStart)];
		return Number(elementb);
	}
	return _u16;
}

export function heapGetItemFromOffset<T>(
	u64: BigUint64Array,
	pointer: bigint,
	elementOffset: bigint
): T | undefined {
	//
	const elementPointer = (pointer + elementOffset) / WGPU_SIZE.u64;
	const elementHeapIndex = u64[Number(elementPointer)];
	const element = heapGet<T>(elementHeapIndex);
	return element;
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

