UInt8Param :: struct {
	#as using baseParam: BaseParam(UInt8Param, VALUE_TYPE);
};

paramSetValue :: (param: *TYPE, value: VALUE_TYPE) {
	paramSetValueGeneric(param, value);
}

#scope_file

TYPE :: UInt8Param;
VALUE_TYPE :: u8;
