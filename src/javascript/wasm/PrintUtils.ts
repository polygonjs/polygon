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
