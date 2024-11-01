// Vector3UIntType :: struct {}
Vector3UIntParam :: struct {
	#as using baseParam: BaseParam(Vector3UIntParam, Vector3UInt);
	// value: #run paramValueByType(TYPE);
	// initParam:ParamInitMethod: initParam;
};


#scope_file

// PARAM_TYPE :: ParamType.VECTOR3UINT;
TYPE :: Vector3UIntParam;

// initParam :: (_param: *TYPE, node: *$N) {
// 	// print("%\n", TYPE);
// 	// initParam(cast(*TYPE)_param);
// }

