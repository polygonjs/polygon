StringParam :: struct {
	#as using baseParam: BaseParam(StringParam, VALUE_TYPE);
};

paramRegisterStringParam :: (){
	paramRegister(TYPE, VALUE_TYPE);
}

paramSetValue :: (param: *TYPE, value: VALUE_TYPE) {
	paramSetValueGeneric(param, value);
}

paramRenderUI :: (param: *TYPE, paramName:string) {
	{
		paramValueStr := to_c_string_temp(param.value);
		ImGui.Text_CFormat(paramValueStr);
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
VALUE_TYPE :: string;
