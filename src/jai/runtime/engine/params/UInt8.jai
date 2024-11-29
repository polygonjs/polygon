UInt8Param :: struct {
	#as using baseParam: BaseParam(UInt8Param, VALUE_TYPE);
};

paramRegisterUInt8Param :: (){
	paramRegister(TYPE, VALUE_TYPE);
}

paramSetValue :: (param: *TYPE, value: VALUE_TYPE) {
	paramSetValueGeneric(param, value);
}

paramRenderUI :: (param: *TYPE, paramName:string) {
	tmpValue :s32= xx param.value;
	initValue := tmpValue;
	paramNameStr := to_c_string_temp(paramName);
	ImGui.SliderInt(paramNameStr, *tmpValue, 0, 256);
	if tmpValue != initValue {
		paramSetValue(param, xx tmpValue);
	}
}

#scope_file

TYPE :: UInt8Param;
VALUE_TYPE :: u8;
