
paramRenderUI :: (param: *TYPE, paramName:string) {
	initValue :VALUE_TYPE = param.value;
	tmpValue :[2] s32;
	tmpValue[0] = xx initValue.x;
	tmpValue[1] = xx initValue.y;
	paramNameStr := to_c_string_temp(paramName);
	#if USE_IMGUI ImGui.SliderInt2(paramNameStr, *tmpValue, 0, 128);
	if valueEquals(tmpValue, initValue)==false {
		initValue.x = xx tmpValue[0];
		initValue.y = xx tmpValue[1];
		paramSetValue(param, initValue);
	}
}

#scope_file

TYPE :: Vector2UIntParam;
VALUE_TYPE :: Vector2UInt;