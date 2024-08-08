import { jsStringFromJaiString } from "./StringUtils";

export function memcmp(
	str1Pointer: bigint,
	str2Pointer: bigint,
	sizeBig: bigint
): number {
	// https://discord.com/channels/661732390355337246/1172463903943446548/1256763226847187127
	// https://www.tutorialspoint.com/c_standard_library/c_function_memcmp.htm
	const size = Number(sizeBig);
	const str1 = jsStringFromJaiString(str1Pointer, size);
	const str2 = jsStringFromJaiString(str2Pointer, size);
	if (str1 == str2) {
		return 0;
	}
	if (!(str1 && str2)) {
		return -1;
	}
	if (str1 < str2) {
		return -1;
	}
	if (str1 > str2) {
		return 1;
	}
	return -1;
}
