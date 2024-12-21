Vector3UIntParam :: struct {
	#as using baseParam: BaseParam(Vector3UIntParam, VALUE_TYPE);
};

paramRegisterVector3UIntParam :: (){
	paramRegister(TYPE, VALUE_TYPE);
}

paramSetValue :: (param: *TYPE, value: VALUE_TYPE) {
	paramSetValueGeneric(param, value);
}


#scope_file

TYPE :: Vector3UIntParam;
VALUE_TYPE :: Vector3UInt;

