Vector2Param :: struct {
	#as using baseParam: BaseParam(#run nextParamTypeId(), VALUE_TYPE);
};

paramRegisterVector2Param :: () #compile_time {
	paramRegister(TYPE, VALUE_TYPE);
}

paramSetValue :: (param: *TYPE, value: VALUE_TYPE) {
	paramSetValueGeneric(param, value);
}


#scope_file

TYPE :: Vector2Param;
VALUE_TYPE :: Vector2;


