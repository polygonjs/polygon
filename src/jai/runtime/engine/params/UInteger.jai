UIntegerParam :: struct {
	#as using baseParam: BaseParam(UIntegerParam, VALUE_TYPE);
};

paramRegisterUIntegerParam :: (){
	paramRegister(TYPE, VALUE_TYPE);
}

paramSetValue :: (param: *TYPE, value: VALUE_TYPE) {
	paramSetValueGeneric(param, value);
}

paramRenderUI :: (param: *TYPE, paramName:string) {
	initValue := param.value;
	tmpValue :s32= xx param.value;
	paramNameStr := to_c_string_temp(paramName);
	ImGui.SliderInt(paramNameStr, *tmpValue, 0, 10);
	if tmpValue != xx initValue {
		paramSetValue(param, xx tmpValue);
	}
}

#scope_file

TYPE :: UIntegerParam;
VALUE_TYPE :: u32;
