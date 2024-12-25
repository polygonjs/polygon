
generatedParamValueTypeByParamType :: (paramType: Type) -> Type {
	#insert GENERATED_CODE_PARAM_VALUE_TYPE_BY_PARAM_TYPE;
	assert(false, tprint("generatedParamValueTypeByParamType: paramType '%' is not implemented", paramType));
	return u8;
}
// generatedParamInit :: (param: *BaseParamAny, node:*$N) {
// 	#insert GENERATED_CODE_PARAM_INIT;
// 	assert(false, tprint("generatedParamInit: param paramTypeId '%' is not implemented", param.paramTypeId));
// }
// generatedParamRenderUI :: (param: *BaseParamAny, paramName:string) {
// 	#insert GENERATED_CODE_PARAM_RENDER_UI;
// 	assert(false, tprint("generatedParamRenderUI: param paramTypeId '%' is not implemented", param.paramTypeId));
// }
// generatedParamMacroCast :: (paramAny: *BaseParamAny, i:s64, member: Type_Info_Struct_Member, $body: Code) #expand {
// 	#insert GENERATED_CODE_PARAM_MACRO_CAST;
// 	assert(false, tprint("generatedParamMacroCast: param paramTypeId '%' is not implemented", paramAny.paramTypeId));
// }


registerParams :: () {

	NEXT_PARAM_TYPE_ID = 0;
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
	paramValueTypeByParamType:string
	// paramInit:string,
	// paramRenderUI:string,
	// paramMacroCast:string
) {

	registerParams();

	paramValueTypeByParamType := generateParamValueTypeByParamType();
	// paramInit := generateParamInit();
	// paramsRenderUI := generateParamRenderUI();
	// paramsMacroCast := generateParamMacroCast();
	return
		paramValueTypeByParamType;
		// paramInit,
		// paramsRenderUI,
		// paramsMacroCast;
}
paramType::(paramTypeId: ParamTypeId)->Type {
	for metaData: PARAM_METADATAS {
		if metaData.paramTypeId == paramTypeId {
			return metaData.type;
		}
	}
	assert(false, tprint("paramType: paramTypeId '%' not found", paramTypeId));
	return u8;
}
// paramTypeId :: (T:Type)->ParamTypeId {
// 	for metaData: PARAM_METADATAS {
// 		if metaData.type == T {
// 			return metaData.paramTypeId;
// 		}
// 	}
// 	assert(false, tprint("paramTypeId: type '%' not found", T));
// 	return 0;
// }
nextParamTypeId :: ()->ParamTypeId {
	paramTypeId := NEXT_PARAM_TYPE_ID;
	NEXT_PARAM_TYPE_ID += 1;
	return paramTypeId;
}


paramRegister :: (
	$T:Type,
	$ValueType:Type
	) {

	p:T;

	array_add(*TMP_METADATAS, .{
		paramTypeId=p.paramTypeId,
		type = T,
		valueType = ValueType
	});
}


ParamMetaData :: struct {
	paramTypeId: ParamTypeId;
	type: Type;
	valueType: Type;
}

#no_reset PARAM_METADATAS_COUNT :u64: #run paramsMetaDatasCount();
#no_reset PARAM_METADATAS :[PARAM_METADATAS_COUNT]ParamMetaData: #run paramsMetaDatas();

#scope_file

TMP_METADATAS: [..]ParamMetaData;
NEXT_PARAM_TYPE_ID: ParamTypeId = 0;

GENERATED_CODE_PARAM_VALUE_TYPE_BY_PARAM_TYPE
// GENERATED_CODE_PARAM_INIT,
// GENERATED_CODE_PARAM_RENDER_UI,
// GENERATED_CODE_PARAM_MACRO_CAST 
:: #run registerParamsAndGenerateCode();



generateParamValueTypeByParamType :: ()->string {
	builder: String_Builder;
	print_to_builder(*builder, "if paramType == {\n");
	for metaData: PARAM_METADATAS {
		paramType := metaData.type;
		valueType := metaData.valueType;
		print_to_builder(*builder, tprint("\tcase %; return %;\n", paramType, valueType));
	}
	print_to_builder(*builder, "}");

	result := builder_to_string(*builder);
	reset(*builder);
	return result;
}
// generateParamInit :: ()->string {
// 	builder: String_Builder;
// 	print_to_builder(*builder, "if param.paramTypeId == {\n");
// 	for paramMetaData: PARAM_METADATAS {
// 		paramTypeId := paramMetaData.paramTypeId;
// 		paramType := paramMetaData.type;
// 		print_to_builder(*builder, tprint("\tcase %; {paramInit(cast(*%) param, node); return;}\n", paramTypeId, paramType));
// 	}
// 	print_to_builder(*builder, "}");

// 	result := builder_to_string(*builder);
// 	reset(*builder);
// 	return result;
// }
// generateParamRenderUI :: ()->string {
// 	builder: String_Builder;
// 	print_to_builder(*builder, "if param.paramTypeId == {\n");
// 	for paramMetaData: PARAM_METADATAS {
// 		paramTypeId := paramMetaData.paramTypeId;
// 		paramType := paramMetaData.type;
// 		print_to_builder(*builder, tprint("\tcase %; {paramRenderUI(cast(*%) param, paramName); return;}\n", paramTypeId, paramType));
// 	}
// 	print_to_builder(*builder, "}");

// 	result := builder_to_string(*builder);
// 	reset(*builder);
// 	return result;
// }

// generateParamMacroCast :: ()->string {
// 	builder: String_Builder;
// 	print_to_builder(*builder, "if paramAny.paramTypeId == {\n");
// 	for paramMetaData: PARAM_METADATAS {
// 		paramTypeId := paramMetaData.paramTypeId;
// 		paramType := paramMetaData.type;
// 		print_to_builder(*builder, tprint("\tcase %; {param := cast(*%) paramAny; it_index := i; paramName := member.name; #insert body;}\n", paramTypeId, paramType));
// 	}
// 	print_to_builder(*builder, "}");

// 	result := builder_to_string(*builder);
// 	reset(*builder);
// 	return result;
// }


