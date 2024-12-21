
paramRenderUI :: (param: *TYPE, paramName:string) {
	initValue :VALUE_TYPE = param.value;
	tmpValue :[3] s32;
	tmpValue[0] = xx initValue.x;
	tmpValue[1] = xx initValue.y;
	tmpValue[2] = xx initValue.z;
	paramNameStr := to_c_string_temp(paramName);
	#if USE_IMGUI ImGui.SliderInt3(paramNameStr, *tmpValue, 0, 128);
	if valueEquals(tmpValue, initValue)==false {
		initValue.x = xx tmpValue[0];
		initValue.y = xx tmpValue[1];
		initValue.z = xx tmpValue[2];
		paramSetValue(param, initValue);
	}
}

#scope_file

TYPE :: Vector3UIntParam;
VALUE_TYPE :: Vector3UInt;