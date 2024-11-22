call_from_wasm_context :Context;
wasm_debug_break :: ()  #foreign;
wasm_write_string :: (count: s64, data: *u8, is_error: bool)  #foreign;