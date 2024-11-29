Vector3UIntParam :: struct {
	#as using baseParam: BaseParam(Vector3UIntParam, VALUE_TYPE);
};

paramRegisterVector3UIntParam :: (){
	paramRegister(TYPE, VALUE_TYPE);
}

paramSetValue :: (param: *TYPE, value: VALUE_TYPE) {
	paramSetValueGeneric(param, value);
}

paramRenderUI :: (param: *TYPE, paramName:string) {
	initValue :VALUE_TYPE = param.value;
	tmpValue :[3] s32;
	tmpValue[0] = xx initValue.x;
	tmpValue[1] = xx initValue.y;
	tmpValue[2] = xx initValue.z;
	paramNameStr := to_c_string_temp(paramName);
	ImGui.SliderInt3(paramNameStr, *tmpValue, 0, 10);
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

valueEquals :: (tmpValue: [3] s32, vector3: VALUE_TYPE) -> bool #expand {
	return tmpValue[0] == xx vector3.x && tmpValue[1] == xx vector3.y && tmpValue[2] == xx vector3.z;
}