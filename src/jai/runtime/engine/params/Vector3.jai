Vector3Param :: struct {
	#as using baseParam: BaseParam(Vector3Param, VALUE_TYPE);
};

paramRegisterVector3Param :: (){
	paramRegister(TYPE, VALUE_TYPE);
}

paramSetValue :: (param: *TYPE, value: VALUE_TYPE) {
	paramSetValueGeneric(param, value);
}


#scope_file

TYPE :: Vector3Param;
VALUE_TYPE :: Vector3;


