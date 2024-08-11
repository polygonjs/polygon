const text_decoder = new TextDecoder();
export function jsStringFromJaiString(pointer: bigint, strlength: number) {
	// console.log({ pointer });
	// if(!allocated){
	// 	console.error("Memory not allocated")
	// 	return
	// }
	const u8 = new Uint8Array(
		window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer
	);
	if (Number(pointer) > u8.length) {
		console.error("Pointer out of bounds", Number(pointer), u8.length);
		return;
	}
	// console.log({ buffer: allocated!.buffer, u8, allocated });
	const bytes = u8.subarray(
		Number(pointer),
		Number(pointer) + Number(strlength)
	);
	// console.log("length", Number(pointer), Number(length), bytes);
	return text_decoder.decode(bytes);
}
export function jsStringFromJaiStringWithoutLength(
	pointer: bigint
): string | undefined {
	if (pointer == BigInt(0)) {
		return;
	}
	const u8 = new Uint8Array(
		window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer
	);
	const startIndex = Number(pointer);
	if (startIndex > u8.length) {
		console.error("Pointer out of bounds", startIndex, u8.length);
		return;
	}
	// console.log({ buffer: allocated!.buffer, u8, allocated });
	let charCode = u8[startIndex];
	let strLength = 0;
	for (let i = startIndex; i < u8.length; i++) {
		if (charCode == 0) {
			break;
		}
		charCode = u8[startIndex + strLength];
		strLength++;
	}

	const bytes = u8.subarray(startIndex, startIndex + strLength - 1);
	// console.log("length", Number(pointer), Number(length), bytes);
	return text_decoder.decode(bytes);
}

export function strlen(pointer: bigint) {
	// console.warn("will be replaced");
	if (pointer == BigInt(0)) {
		return;
	}
	const u8 = new Uint8Array(
		window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer
	);
	const startIndex = Number(pointer);
	if (startIndex > u8.length) {
		console.error("Pointer out of bounds", startIndex, u8.length);
		return;
	}
	let charCode = u8[startIndex];
	let strLength = 0;
	for (let i = startIndex; i < u8.length; i++) {
		if (charCode == 0) {
			break;
		}
		charCode = u8[startIndex + strLength];
		strLength++;
	}

	// console.log({
	// 	pointer,
	// 	strLength,
	// 	data: jsStringFromJaiStringWithoutLength(pointer),
	// });
	return BigInt(strLength);
}
