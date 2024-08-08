export enum TypeArrayType {
	Uint8Array = "Uint8Array",
	Int16Array = "Int16Array",
	Uint16Array = "Uint16Array",
	Int32Array = "Int32Array",
	Uint32Array = "Uint32Array",
	Float32Array = "Float32Array",
	Float64Array = "Float64Array",
}
type TypedArray =
	| Uint8Array
	| Int16Array
	| Uint16Array
	| Int32Array
	| Uint32Array
	| Float32Array
	| Float64Array;
type TypedArrayClass =
	| typeof Uint8Array
	| typeof Int16Array
	| typeof Uint16Array
	| typeof Int32Array
	| typeof Uint32Array
	| typeof Float32Array
	| typeof Float64Array;
type TypeArrayByTypedArrayGeneric = { [key in TypeArrayType]: TypedArray };
type TypeArrayClassByTypedArrayGeneric = {
	[key in TypeArrayType]: TypedArrayClass;
};
interface TypeArrayByType extends TypeArrayByTypedArrayGeneric {
	Uint8Array: Uint8Array;
	Int16Array: Int16Array;
	Uint16Array: Uint16Array;
	Int32Array: Int32Array;
	Uint32Array: Uint32Array;
	Float32Array: Float32Array;
	Float64Array: Float64Array;
}
interface TypeArrayClassByType extends TypeArrayClassByTypedArrayGeneric {
	Uint8Array: typeof Uint8Array;
	Int16Array: typeof Int16Array;
	Uint16Array: typeof Uint16Array;
	Int32Array: typeof Int32Array;
	Uint32Array: typeof Uint32Array;
	Float32Array: typeof Float32Array;
	Float64Array: typeof Float64Array;
}

export function typedArrayFromBuffer<T extends TypeArrayType>(
	pointer: BigInt,
	length: number,
	elementSize: number,
	arrayClass: TypeArrayClassByType[T]
): TypeArrayByType[T] | undefined {
	const fullBuffer = new arrayClass(
		window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer
	);
	const start = Number(pointer) / elementSize;
	if (start > fullBuffer.length) {
		console.error(
			"Pointer out of bounds",
			Number(pointer),
			fullBuffer.length
		);
		return;
	}
	// console.log({ pointer, elementSize, start, end: start + Number(length) });
	const slice = fullBuffer.subarray(start, start + Number(length));
	return slice as TypeArrayByType[T];
}
