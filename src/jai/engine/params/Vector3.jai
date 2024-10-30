// Vector3Type :: struct {}
Vector3Param :: struct {
	#as using baseParam: BaseParam(ParamType.VECTOR3, Vector3);
	initParam:BaseTypedParamInitMethod: initVector3Param;
};

#scope_file

initVector3Param :: (_param: *$P, node: *$N) {
	param := cast(*Vector3Param)_param;
	// print("initVector3Param\n");
}

