StringParam :: struct {
	#as using baseParam: BaseParam(#run nextParamTypeId(), VALUE_TYPE);
};

paramRegisterStringParam :: () #compile_time {
	paramRegister(TYPE, VALUE_TYPE);
}

paramSetValue :: (param: *TYPE, value: VALUE_TYPE) {
	paramSetValueGeneric(param, value);
}
paramSetValue :: (param: *TYPE, value: string) {
	stringToStringFixed(value, *param.value);
	paramPostSetValue(param);
}


#scope_file

TYPE :: StringParam;
VALUE_TYPE :: AssetPath;
