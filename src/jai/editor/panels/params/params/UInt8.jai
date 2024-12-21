paramRenderUI :: (param: *TYPE, paramName:string) {
	tmpValue :s32= xx param.value;
	initValue := tmpValue;
	paramNameStr := to_c_string_temp(paramName);
	#if USE_IMGUI ImGui.SliderInt(paramNameStr, *tmpValue, param.min, param.max);
	if tmpValue != initValue {
		paramSetValue(param, xx tmpValue);
	}
}

#scope_file

TYPE :: UInt8Param;