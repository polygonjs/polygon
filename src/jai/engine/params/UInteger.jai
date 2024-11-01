// IntegerType :: struct {}
UIntegerParam :: struct {
	#as using baseParam: BaseParam(UIntegerParam, u32);
	// value: #run paramValueByType(TYPE);
	// initParam:ParamInitMethod: initParam;
};


#scope_file

// PARAM_TYPE :: ParamType.UINTEGER;
TYPE :: UIntegerParam;

// initParam :: (_param: *TYPE, node: *$N) {
// 	// print("%\n", TYPE);
// 	// initParam(cast(*TYPE)_param);
// }
