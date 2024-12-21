UIntegerParam :: struct {
	#as using baseParam: BaseParam(UIntegerParam, VALUE_TYPE);
};

paramRegisterUIntegerParam :: (){
	paramRegister(TYPE, VALUE_TYPE);
}

paramSetValue :: (param: *TYPE, value: VALUE_TYPE) {
	paramSetValueGeneric(param, value);
}



#scope_file

TYPE :: UIntegerParam;
VALUE_TYPE :: u32;
