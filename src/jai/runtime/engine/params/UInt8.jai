UInt8Param :: struct {
	#as using baseParam: BaseParam(#run nextParamTypeId(), VALUE_TYPE);
	min:u8=0;
	max:u8=16;
};

paramRegisterUInt8Param :: () #compile_time {
	paramRegister(TYPE, VALUE_TYPE);
}

paramSetValue :: (param: *TYPE, value: VALUE_TYPE) {
	paramSetValueGeneric(param, value);
}


#scope_file

TYPE :: UInt8Param;
VALUE_TYPE :: u8;
