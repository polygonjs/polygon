import { getU64, updateMemoryArrayViewsIfNeeded } from "../Common";
import { jsStringFromJaiStringWithoutLength } from "./WasmString";
import { WASM_DATA_SIZE } from "./WasmDataSize";
import { MemberInfo } from "../WebGPU/utils/WGPUStructInfos";

interface LabelOffsetContainer {
	label: bigint;
}
export function labelFromBuffer(
	pointer: bigint,
	offset: LabelOffsetContainer,
	u64: BigUint64Array
) {
	return stringFromBuffer(pointer, offset.label, u64);
}
export function stringFromBuffer(
	pointer: bigint,
	stringOffset: bigint,
	u64: BigUint64Array
) {
	const labelOffset = stringOffset;
	const labelSize = WASM_DATA_SIZE.u64;
	const labelStart = (pointer + labelOffset) / labelSize;
	const labelPointer = u64[Number(labelStart)];
	const label = jsStringFromJaiStringWithoutLength(BigInt(labelPointer));
	return label;
}

// export function u64Create(
// 	u64: BigUint64Array,
// 	pointer: bigint
// ): (i: bigint) => bigint {
// 	function _u64(elementOffset: bigint) {
// 		const elementSize = WGPU_SIZE.u64;
// 		const elementStart = (pointer + elementOffset) / elementSize;
// 		const elementb = u64[Number(elementStart)];
// 		return elementb;
// 	}
// 	return _u64;
// }
// export function f64Create(
// 	u64: Float64Array,
// 	pointer: bigint
// ): (i: bigint) => number {
// 	function _f64(elementOffset: bigint) {
// 		const elementSize = WGPU_SIZE.u64;
// 		const elementStart = (pointer + elementOffset) / elementSize;
// 		const elementb = u64[Number(elementStart)];
// 		return elementb;
// 	}
// 	return _f64;
// }
// export function f32Create(
// 	u64: Float32Array,
// 	pointer: bigint
// ): (i: bigint) => number {
// 	function _f32(elementOffset: bigint) {
// 		const elementSize = WGPU_SIZE.float;
// 		const elementStart = (pointer + elementOffset) / elementSize;
// 		const elementb = u64[Number(elementStart)];
// 		return elementb;
// 	}
// 	return _f32;
// }
// export function u32Create(
// 	u32: Uint32Array,
// 	pointer: bigint
// ): (i: bigint) => number {
// 	function _u32(elementOffset: bigint) {
// 		const elementSize = WGPU_SIZE.u32;
// 		const elementStart = (pointer + elementOffset) / elementSize;
// 		const elementb = u32[Number(elementStart)];
// 		return Number(elementb);
// 	}
// 	return _u32;
// }
// export function s32Create(
// 	s32: Int32Array,
// 	pointer: bigint
// ): (i: bigint) => number {
// 	function _s32(elementOffset: bigint) {
// 		const elementSize = WGPU_SIZE.s32;
// 		const elementStart = (pointer + elementOffset) / elementSize;
// 		const elementb = s32[Number(elementStart)];
// 		return Number(elementb);
// 	}
// 	return _s32;
// }
// export function u16Create(
// 	u16: Uint16Array,
// 	pointer: bigint
// ): (i: bigint) => number {
// 	function _u16(elementOffset: bigint) {
// 		const elementSize = WGPU_SIZE.u16;
// 		const elementStart = (pointer + elementOffset) / elementSize;
// 		const elementb = u16[Number(elementStart)];
// 		return Number(elementb);
// 	}
// 	return _u16;
// }

export function _num(structPointer: bigint, memberInfo: MemberInfo): number {
	return memberInfo.arrayView(
		Number(structPointer + memberInfo.offset)
	) as number;
}
export function _big(structPointer: bigint, memberInfo: MemberInfo): bigint {
	updateMemoryArrayViewsIfNeeded();

	return memberInfo.arrayView(
		Number(structPointer + memberInfo.offset)
	) as bigint;
}
export function _pointerValue(pointer: bigint) {
	return getU64(Number(pointer));
}
export function _str(structPointer: bigint, memberInfo: MemberInfo) {
	return jsStringFromJaiStringWithoutLength(_big(structPointer, memberInfo));
}
export function _label(
	structPointer: bigint,
	members: Record<"label", MemberInfo>
) {
	return jsStringFromJaiStringWithoutLength(
		_big(structPointer, members.label)
	);
}

interface CreateItemsByPointerOptions<T> {
	pointer: bigint;
	itemsCount: bigint;
	itemSize: bigint;
	memberInfo: MemberInfo;
	callback: (itemPointer: bigint) => T;
}
interface CreateItemsByHeapIndexOptions<T> {
	pointer: bigint;
	itemsCount: bigint;
	memberInfo: MemberInfo;
	callback: (itemHeapIndex: bigint) => T;
}
export function createItemsByPointer<T>(
	options: CreateItemsByPointerOptions<T>
) {
	const { pointer, itemsCount, memberInfo, itemSize, callback } = options;
	const arrayPointer = _big(pointer, memberInfo);
	return new Array(Number(itemsCount)).fill(1).map((_, i) => {
		const itemPointer = arrayPointer + itemSize * BigInt(i);
		return callback(itemPointer);
	});
}
export function createItemsByHeapIndex<T>(
	options: CreateItemsByHeapIndexOptions<T>
) {
	const { pointer, itemsCount, memberInfo, callback } = options;
	const arrayPointer = _pointerValue(pointer + memberInfo.offset);
	return new Array(Number(itemsCount)).fill(1).map((_, i) => {
		const itemHeapIndex = _pointerValue(
			arrayPointer + memberInfo.size * BigInt(i)
		);
		return callback(itemHeapIndex);
	});
}

