// FloatType :: struct {}
FloatParam :: struct {
	#as using baseParam: BaseParam(FloatParam, float32);
	// value: #run paramValueByType(TYPE);
	// initParam:ParamInitMethod: initParam;
};


#scope_file

// PARAM_TYPE :: ParamType.FLOAT;
TYPE :: FloatParam;

// initParam :: (_param: *TYPE, node: *$N) {
// 	// print("%\n", TYPE);
// 	// initParam(cast(*TYPE)_param);
// }

