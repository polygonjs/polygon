// FloatType :: struct {}
FloatParam :: struct {
	#as using baseParam: BaseParam(FloatParam, PARAM_TYPE);
	value: #run paramValueByType(PARAM_TYPE);
	// initParam:ParamInitMethod: initParam;
};


#scope_file

PARAM_TYPE :: ParamType.FLOAT;
TYPE :: FloatParam;

// initParam :: (_param: *TYPE, node: *$N) {
// 	// print("%\n", TYPE);
// 	// initParam(cast(*TYPE)_param);
// }

