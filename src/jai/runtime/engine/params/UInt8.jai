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


#scope_file

TYPE :: UInt8Param;
VALUE_TYPE :: u8;
