INDENT_CHAR :: #char "\t";
indent :: inline (level: u8) -> string {
	builder:String_Builder;
	for 0..level append(*builder, INDENT_CHAR);
	word := builder_to_string(*builder);
	reset(*builder);
	return word;
}