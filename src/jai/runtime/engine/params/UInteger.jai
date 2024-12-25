UIntegerParam :: struct {
	#as using baseParam: BaseParam(#run nextParamTypeId(), VALUE_TYPE);
};

paramRegisterUIntegerParam :: () #compile_time {
	paramRegister(TYPE, VALUE_TYPE);
}

paramSetValue :: (param: *TYPE, value: VALUE_TYPE) {
	paramSetValueGeneric(param, value);
}



#scope_file

TYPE :: UIntegerParam;
VALUE_TYPE :: u32;
