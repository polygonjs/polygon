// IntegerType :: struct {}
IntegerParam :: struct {
	#as using baseParam: BaseParam(ParamType.INTEGER, s32);
	initParam:BaseTypedParamInitMethod: initIntegerParam;
};

#scope_file

initIntegerParam :: (_param: *$P, node: *$N) {
	param := cast(*IntegerParam)_param;
	// print("initIntegerParam\n");
}

