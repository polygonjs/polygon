StringParam :: struct {
	#as using baseParam: BaseParam(StringParam, VALUE_TYPE);
};

paramRegisterStringParam :: (){
	paramRegister(TYPE, VALUE_TYPE);
}

paramSetValue :: (param: *TYPE, value: VALUE_TYPE) {
	paramSetValueGeneric(param, value);
}
paramSetValue :: (param: *TYPE, value: string) {
	stringToStringFixed(*value, *param.value);
	paramPostSetValue(param);
}


#scope_file

TYPE :: StringParam;
VALUE_TYPE :: AssetPath;
