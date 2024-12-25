StringFixed :: struct ($N: s64) {
	array: [N]u8;
	count: u8;
}

NODE_NAME_MAX_LENGTH :: 128;
NodeName :: StringFixed(NODE_NAME_MAX_LENGTH);
ASSET_PATH_MAX_LENGTH :: 256;
AssetPath :: StringFixed(ASSET_PATH_MAX_LENGTH);

StringFixedTypes :: Type.[NodeName, AssetPath];

INDENT_CHAR :: #char "\t";

stringFixedToString :: (stringFixed: StringFixed)->string {
	view := array_view(stringFixed.array, 0, stringFixed.count);
	str := cast(string)view;
	return str;
}
stringToStringFixed :: (src: string, stringFixed:*$T/StringFixedTypes) {
	stringFixed.count = xx src.count;
	memcpy(stringFixed.array.data, src.data, min(stringFixed.array.count, src.count));
}
// stringToStringFixed :: (src: string, stringFixed:*$T/StringFixedTypes) {
// 	stringToStringFixed(*src, stringFixed);
// }

indent :: inline (level: u8) -> string {
	builder:String_Builder;
	for 0..level append(*builder, INDENT_CHAR);
	word := builder_to_string(*builder);
	reset(*builder);
	return word;
}

to_c_string_temp :: (str: string) -> *u8 {
	push_allocator(temp);
	return to_c_string(str);
}
