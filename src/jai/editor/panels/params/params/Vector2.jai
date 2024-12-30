paramRenderUI :: (param: *TYPE, paramName:string) {
	initValue :VALUE_TYPE = param.value;
	tmpValue :[2] float;
	tmpValue[0] = initValue.x;
	tmpValue[1] = initValue.y;
	paramNameStr := to_c_string_temp(paramName);
	#if USE_IMGUI ImGui.SliderFloat2(paramNameStr, *tmpValue, 0., 10.);
	if valueEquals(tmpValue, initValue)==false {
		initValue.x = tmpValue[0];
		initValue.y = tmpValue[1];
		paramSetValue(param, initValue);
	}
}

#scope_file

TYPE :: Vector2Param;
VALUE_TYPE :: Vector2;
