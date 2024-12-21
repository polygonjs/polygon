paramRenderUI :: (param: *TYPE, paramName:string) {
	{
		assetPath := stringFixedToString(*param.value);
		// paramValueStr := to_c_string_temp(assetPath);
		#if USE_IMGUI ImGui.TextUnformatted(assetPath);
	}
	// tmpValue :s32= xx param.value;
	// initValue := tmpValue;
	// paramNameStr := to_c_string_temp(paramName);
	// ImGui.SliderInt(paramNameStr, *tmpValue, param.min, param.max);
	// if tmpValue != initValue {
	// 	paramSetValue(param, xx tmpValue);
	// }
}

#scope_file

TYPE :: StringParam;