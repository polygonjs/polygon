UInt8Param :: struct {
	#as using baseParam: BaseParam(UInt8Param, VALUE_TYPE);
	min:u8=0;
	max:u8=16;
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
	#if USE_IMGUI ImGui.SliderInt(paramNameStr, *tmpValue, param.min, param.max);
	if tmpValue != initValue {
		paramSetValue(param, xx tmpValue);
	}
}

#scope_file

TYPE :: UInt8Param;
VALUE_TYPE :: u8;
