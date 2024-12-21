paramRenderUI :: (param: *TYPE, paramName:string) {
	initValue :VALUE_TYPE = param.value;
	tmpValue :[3] float;
	tmpValue[0] = initValue.x;
	tmpValue[1] = initValue.y;
	tmpValue[2] = initValue.z;
	paramNameStr := to_c_string_temp(paramName);
	#if USE_IMGUI ImGui.SliderFloat3(paramNameStr, *tmpValue, 0., 10.);
	if valueEquals(tmpValue, initValue)==false {
		initValue.x = tmpValue[0];
		initValue.y = tmpValue[1];
		initValue.z = tmpValue[2];
		paramSetValue(param, initValue);
	}
}

#scope_file

TYPE :: Vector3Param;
VALUE_TYPE :: Vector3;
