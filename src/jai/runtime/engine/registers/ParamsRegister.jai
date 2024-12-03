
generatedParamValueTypeByParamType :: (paramType: Type) -> Type {
	#insert GENERATED_CODE_PARAM_VALUE_TYPE_BY_PARAM_TYPE;
	assert(false, tprint("generatedParamRenderUI: paramType '%' is not implemented", paramType));
	return u8;
}
generatedParamInit :: (param: *$P, node:*$N) {
	#insert GENERATED_CODE_PARAM_INIT;
	assert(false, tprint("generatedParamInit: param type '%' is not implemented", param.type));
}
generatedParamRenderUI :: (param: *$P, paramName:string) {
	#insert GENERATED_CODE_PARAM_RENDER_UI;
	assert(false, tprint("generatedParamRenderUI: param type '%' is not implemented", param.type));
}

registerParams :: () {

	array_reset(*TMP_METADATAS);

	paramRegisterFloatParam();
	paramRegisterStringParam();
	paramRegisterUInt8Param();
	paramRegisterUIntegerParam();
	paramRegisterVector3Param();
	paramRegisterVector3UIntParam();

}
paramsMetaDatasCount :: ()->u64{
	registerParams();
	return xx TMP_METADATAS.count;
}
paramsMetaDatas :: ()->[PARAM_METADATAS_COUNT]ParamMetaData {
	registerParams();

	list:[PARAM_METADATAS_COUNT]ParamMetaData;

	for paramMetaData, i: TMP_METADATAS {
		list[i] = paramMetaData;
	}
	return list;
}

registerParamsAndGenerateCode :: () -> (
	paramValueTypeByParamType:string,
	paramInit:string,
	paramRenderUI:string
) {

	registerParams();

	paramValueTypeByParamType := generateParamValueTypeByParamType();
	paramInit := generateParamInit();
	paramsRenderUI := generateParamRenderUI();

	return paramValueTypeByParamType,
	paramInit,
	paramsRenderUI;
}

paramRegister :: (
	$T:Type,
	$ValueType:Type
	) {
	array_add(*TMP_METADATAS, .{
		type = T,
		valueType = ValueType
	});
}


ParamMetaData :: struct {
	type: Type;
	valueType: Type;
}

#no_reset PARAM_METADATAS_COUNT :u64: #run paramsMetaDatasCount();
#no_reset PARAM_METADATAS :[PARAM_METADATAS_COUNT]ParamMetaData: #run paramsMetaDatas();

#scope_file

TMP_METADATAS: [..]ParamMetaData;


GENERATED_CODE_PARAM_VALUE_TYPE_BY_PARAM_TYPE,
GENERATED_CODE_PARAM_INIT,
GENERATED_CODE_PARAM_RENDER_UI :: #run registerParamsAndGenerateCode();


generateParamValueTypeByParamType :: ()->string {
	builder: String_Builder;
	print_to_builder(*builder, "if paramType == {\n");
	for paramMetaData: PARAM_METADATAS {
		paramType := paramMetaData.type;
		valueType := paramMetaData.valueType;
		print_to_builder(*builder, tprint("\tcase %; return %;\n", paramType, valueType));
	}
	print_to_builder(*builder, "}");

	result := builder_to_string(*builder);
	reset(*builder);
	return result;
}
generateParamInit :: ()->string {
	builder: String_Builder;
	print_to_builder(*builder, "if param.type == {\n");
	for paramMetaData: PARAM_METADATAS {
		paramType := paramMetaData.type;
		valueType := paramMetaData.valueType;
		print_to_builder(*builder, tprint("\tcase %; {paramInit(cast(*%) param, node); return;}\n", paramType, paramType));
	}
	print_to_builder(*builder, "}");

	result := builder_to_string(*builder);
	reset(*builder);
	return result;
}
generateParamRenderUI :: ()->string {
	builder: String_Builder;
	print_to_builder(*builder, "if param.type == {\n");
	for paramMetaData: PARAM_METADATAS {
		paramType := paramMetaData.type;
		print_to_builder(*builder, tprint("\tcase %; {paramRenderUI(cast(*%) param, paramName); return;}\n", paramType, paramType));
	}
	print_to_builder(*builder, "}");

	result := builder_to_string(*builder);
	reset(*builder);
	return result;
}