paramRenderUI :: (param: *TYPE, paramName:string) {
	initValue := param.value;
	tmpValue :s32= xx param.value;
	paramNameStr := to_c_string_temp(paramName);
	#if USE_IMGUI ImGui.SliderInt(paramNameStr, *tmpValue, 0, 100);
	if tmpValue != xx initValue {
		paramSetValue(param, xx tmpValue);
	}
}

#scope_file

TYPE :: UIntegerParam;