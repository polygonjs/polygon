// Vector3Type :: struct {}
Vector3Param :: struct {
	#as using baseParam: BaseParam(Vector3Param, Vector3);
	// value: #run paramValueByType(TYPE);
	// initParam:ParamInitMethod: initParam;
};


#scope_file

// PARAM_TYPE :: ParamType.VECTOR3;
TYPE :: Vector3Param;

// initParam :: (_param: *TYPE, node: *$N) {
// 	// print("%\n", TYPE);
// 	// initParam(cast(*TYPE)_param);
// }

