Vector3Param :: struct {
	#as using baseParam: BaseParam(Vector3Param, VALUE_TYPE);
};

paramRegisterVector3Param :: (){
	paramRegister(TYPE, VALUE_TYPE);
}

paramSetValue :: (param: *TYPE, value: VALUE_TYPE) {
	paramSetValueGeneric(param, value);
}

paramRenderUI :: (param: *TYPE, paramName:string) {
	initValue :VALUE_TYPE = param.value;
	tmpValue :[3] float;
	tmpValue[0] = initValue.x;
	tmpValue[1] = initValue.y;
	tmpValue[2] = initValue.z;
	paramNameStr := to_c_string_temp(paramName);
	ImGui.SliderFloat3(paramNameStr, *tmpValue, 0., 10.);
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

valueEquals :: (tmpValue: [3] float, vector3: VALUE_TYPE) -> bool #expand {
	return tmpValue[0] == vector3.x && tmpValue[1] == vector3.y && tmpValue[2] == vector3.z;
}
