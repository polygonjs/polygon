paramRenderUI :: (param: *TYPE, paramName:string) {
	tmpValue := param.value;
	initValue := tmpValue;
	paramNameStr := to_c_string_temp(paramName);
	#if USE_IMGUI ImGui.SliderFloat(paramNameStr, *tmpValue, 0., 10.);
	if tmpValue != initValue {
		paramSetValue(param, tmpValue);
	}
}

#scope_file

TYPE :: FloatParam;