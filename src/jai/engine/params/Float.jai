// FloatType :: struct {}
FloatParam :: struct {
	#as using baseParam: BaseParam(ParamType.FLOAT, float32);
	initParam:BaseTypedParamInitMethod: initFloatParam;
};

#scope_file

initFloatParam :: (_param: *$P, node: *$N) {
	param := cast(*FloatParam)_param;
	// print("initFloatParam\n");
}

