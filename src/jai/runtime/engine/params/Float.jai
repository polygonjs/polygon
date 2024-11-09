FloatParam :: struct {
	#as using baseParam: BaseParam(FloatParam, VALUE_TYPE);
};

paramSetValue :: (param: *TYPE, value: VALUE_TYPE) {
	paramSetValueGeneric(param, value);
}

#scope_file

TYPE :: FloatParam;
VALUE_TYPE :: float32;

