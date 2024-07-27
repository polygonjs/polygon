import { AllocatedMemory } from "./Common";

const text_decoder = new TextDecoder();
export function jsStringFromJaiString(
	pointer: BigInt,
	length: number,
	allocatedMemory: AllocatedMemory
) {
	// console.log({ pointer });
	// if(!allocated){
	// 	console.error("Memory not allocated")
	// 	return
	// }
	const u8 = new Uint8Array(allocatedMemory.buffer);
	if (Number(pointer) > u8.length) {
		console.error("Pointer out of bounds", Number(pointer), u8.length);
		return;
	}
	// console.log({ buffer: allocated!.buffer, u8, allocated });
	const bytes = u8.subarray(
		Number(pointer),
		Number(pointer) + Number(length)
	);
	// console.log("length", Number(pointer), Number(length), bytes);
	return text_decoder.decode(bytes);
}

// console.log and console.error always add newlines so we need to buffer the output from write_string
// to simulate a more basic I/O behavior. We’ll flush it after a certain time so that you still
// see the last line if you forget to terminate it with a newline for some reason.
let console_buffer = "";
let console_buffer_is_standard_error: boolean = false;
let console_timeout: number = -1;
const FLUSH_CONSOLE_AFTER_MS = 3;

export function writeToConsoleLog(str: string, to_standard_error: boolean) {
	if (
		console_buffer &&
		console_buffer_is_standard_error != to_standard_error
	) {
		flush_buffer();
	}

	console_buffer_is_standard_error = to_standard_error;
	const lines = str.split("\n");
	for (let i = 0; i < lines.length - 1; i++) {
		console_buffer += lines[i];
		flush_buffer();
	}

	console_buffer += lines[lines.length - 1];

	clearTimeout(console_timeout);
	if (console_buffer) {
		console_timeout = setTimeout(() => {
			flush_buffer();
		}, FLUSH_CONSOLE_AFTER_MS);
	}

	function flush_buffer() {
		if (!console_buffer) return;

		if (console_buffer_is_standard_error) {
			console.error(console_buffer);
		} else {
			console.log(console_buffer);
		}

		console_buffer = "";
	}
}
