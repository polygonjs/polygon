Vector2UIntParam :: struct {
	#as using baseParam: BaseParam(#run nextParamTypeId(), VALUE_TYPE);
};

paramRegisterVector2UIntParam :: () #compile_time {
	paramRegister(TYPE, VALUE_TYPE);
}

paramSetValue :: (param: *TYPE, value: VALUE_TYPE) {
	paramSetValueGeneric(param, value);
}


#scope_file

TYPE :: Vector2UIntParam;
VALUE_TYPE :: Vector2UInt;

