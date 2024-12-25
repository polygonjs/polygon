nodeParamsInit :: (node: *BaseNodeAny) {
	generatedParamsInit(node);
	// iterateParams(node, #code {
	// 	if param.paramTypeId == 0 {
	// 		assert(false, "*** nodeParamsInit: param.paramTypeId is 0\n");
	// 		// param.type = type;
	// 	}
	// 	generatedParamInit(param, node);
	// });
}

// params :: (node: *$T, body: Code, flags: For_Flags) #expand {
// 	node_info := type_info(type_of(<<node));
// 	node_tis := cast(*Type_Info_Struct)node_info;
// 	paramsField := get_field(node_tis, "p");
// 	params_info := type_info(type_of(node.p));
// 	assert(params_info.type == .STRUCT, "*** handle_params: not a struct (%, type=%)\n", params_info.type, type_of(<<node));

// 	params_tis := cast(*Type_Info_Struct)params_info;

// 	for member, i: params_tis.members {
// 		paramField := get_field(params_tis, member.name);
// 		// print("paramField: % (%/%)\n", member.name, i, params_tis.members.count);
// 		member_tis := cast(*Type_Info_Struct)paramField.type;
// 		paramPtr := (cast(*u8)node) + paramsField.offset_in_bytes + paramField.offset_in_bytes;
// 		// `it := cast(*BaseParamAny)paramPtr;
// 		generatedParamMacroCast(cast(*BaseParamAny)paramPtr, i, member, body);
// 	}
// }


// iterateParams :: (node: *$T, $body: Code) {
// 	iterateParamsFromNodeType(type_of(<<node), body);
// 	// node_info := type_info(type_of(<<node));
// 	// node_tis := cast(*Type_Info_Struct)node_info;
// 	// paramsField := get_field(node_tis, "p");
// 	// params_info := type_info(type_of(node.p));
// 	// assert(params_info.type == .STRUCT, "*** handle_params: not a struct (%, type=%)\n", params_info.type, type_of(<<node));

// 	// params_tis := cast(*Type_Info_Struct)params_info;

// 	// for member, i: params_tis.members {
// 	// 	paramField := get_field(params_tis, member.name);
// 	// 	// print("paramField: % (%/%)\n", member.name, i, params_tis.members.count);
// 	// 	member_tis := cast(*Type_Info_Struct)paramField.type;
// 	// 	paramPtr := (cast(*u8)node) + paramsField.offset_in_bytes + paramField.offset_in_bytes;
// 	// 	// `it := cast(*BaseParamAny)paramPtr;
// 	// 	generatedParamMacroCast(cast(*BaseParamAny)paramPtr, i, member, body);
// 	// }
// }
// iterateParamsFromNodeType :: ($nodeType: Type, $body: Code) {
// 	node_info := type_info(nodeType);
// 	node_tis := cast(*Type_Info_Struct)node_info;
// 	paramsField := get_field(node_tis, "p");
// 	// params_info := type_info(type_of(node.p));
// 	// assert(params_info.type == .STRUCT, "*** handle_params: not a struct (%, type=%)\n", params_info.type, type_of(<<node));

// 	params_tis := cast(*Type_Info_Struct)paramsField;

// 	for member, i: params_tis.members {
// 		paramField := get_field(params_tis, member.name);
// 		// print("paramField: % (%/%)\n", member.name, i, params_tis.members.count);
// 		member_tis := cast(*Type_Info_Struct)paramField.type;
// 		offset := paramsField.offset_in_bytes + paramField.offset_in_bytes;
// 		paramPtr := (cast(*u8)node) + offset;
// 		// `it := cast(*BaseParamAny)paramPtr;
// 		generatedParamMacroCast(cast(*BaseParamAny)paramPtr, i, member, body);
// 	}
// }
paramsCount :: (node: *$T) -> u8 {
	node_info := type_info(type_of(<<node));
	node_tis := cast(*Type_Info_Struct)node_info;
	// paramsField := get_field(node_tis, "p");
	params_info := type_info(type_of(node.p));
	// assert(params_info.type == .STRUCT, "*** handle_params: not a struct (%, type=%)\n", params_info.type, type_of(<<node));

	params_tis := cast(*Type_Info_Struct)params_info;

	return xx params_tis.members.count;

	// count :u8= 0;
	// for :params param: node {
	// 	count += 1;
	// }
	// return count;
}


nodeResetParams :: (node: *BaseNodeAny) {
	generatedParamsReset(node);
	// print("nodeResetParams NOT IMPLEMENTED\n");
	// for :params param: node { paramsResetValue(param); }
	// iterateParams(node, #code {
	// 	paramsResetValue(param);
	// });
}

// paramsMetaDatas :: ($T: Type) -> [..]NodeParamMetaData {
// 	paramMetaDatas: [..]NodeParamMetaData;
// 	{
// 		node_info := type_info(T);
// 		print("node_info: %\n", <<node_info);
// 		node_tis := cast(*Type_Info_Struct)node_info;
// 		paramsField := get_field(node_tis, "p");
// 		print("paramsField type: %\n", <<paramsField.type.type);
// 		params_tis := cast(*Type_Info_Struct)paramsField;

// 		print("params_tis.members: % -> %, %\n", T, params_tis.name, params_tis.members);

// 		for member, i: params_tis.members {
// 			paramField := get_field(params_tis, member.name);
// 			member_tis := cast(*Type_Info_Struct)paramField.type;
// 			offset := paramsField.offset_in_bytes + paramField.offset_in_bytes;
// 			paramMetaData:NodeParamMetaData = .{
// 				type = paramField.name,
// 				name = member.name,
// 				offset = xx offset
// 			};
// 			array_add(*paramMetaDatas, paramMetaData);
// 		}
// 	}
// 	return paramMetaDatas;
// }

// paramsMetaDatas :: (node: *$T) -> *[..]NodeParamMetaData {
// 	paramMetaDatas: *[..]NodeParamMetaData = New([..]NodeParamMetaData);
// 	node_info :: type_info(type_of(<<node));
// 	node_tis := cast(*Type_Info_Struct)node_info;
// 	paramsField := get_field(node_tis, "p");
// 	params_info := type_info(type_of(node.p));
// 	assert(params_info.type == .STRUCT, "*** handle_params: not a struct (%, type=%)\n", params_info.type, type_of(<<node));

// 	params_tis := cast(*Type_Info_Struct)params_info;

// 	for member, i: params_tis.members {
// 		paramField := get_field(params_tis, member.name);
// 		// print("paramField: % (%/%)\n", member.name, i, params_tis.members.count);
// 		member_tis := cast(*Type_Info_Struct)paramField.type;
// 		offset := paramsField.offset_in_bytes + paramField.offset_in_bytes;
// 		// paramPtr := (cast(*u8)node) + paramsField.offset_in_bytes + paramField.offset_in_bytes;
// 		// `it := cast(*BaseParamAny)paramPtr;
// 		// print("paramField:%\n", <<paramField);
// 		// generatedParamMacroCast(cast(*BaseParamAny)paramPtr, i, member, body);
// 		paramMetaData:NodeParamMetaData = .{
// 			type = member_tis.name,
// 			name = member.name,
// 			offset = xx offset
// 		};
// 		array_add(paramMetaDatas, paramMetaData);
// 	}
// 	return paramMetaDatas;
// }



paramsMetaDataFixed :: (node: *$T) -> FixedParamMetaData {

	data: FixedParamMetaData;
	data.count = 0;
	
	node_info :: type_info(type_of(<<node));
	node_tis := cast(*Type_Info_Struct)node_info;
	paramsField := get_field(node_tis, "p");
	params_info := type_info(type_of(node.p));
	assert(params_info.type == .STRUCT, "*** handle_params: not a struct (%, type=%)\n", params_info.type, type_of(<<node));

	params_tis := cast(*Type_Info_Struct)params_info;

	for member, i: params_tis.members {
		paramField := get_field(params_tis, member.name);
		member_tis := cast(*Type_Info_Struct)paramField.type;
		offset := paramsField.offset_in_bytes + paramField.offset_in_bytes;
		paramMetaData:NodeParamMetaData = .{
			type = member_tis.name,
			name = member.name,
			offset = xx offset
		};
		data.metaDatas[i] = paramMetaData;
		data.count += 1;
	}

	return data;
}

// paramsMetaDataString :: (node: *$T) -> ParamMetaDataString {
	
// 	node_info :: type_info(type_of(<<node));
// 	node_tis := cast(*Type_Info_Struct)node_info;
// 	paramsField := get_field(node_tis, "p");
// 	params_info := type_info(type_of(node.p));
// 	assert(params_info.type == .STRUCT, "*** handle_params: not a struct (%, type=%)\n", params_info.type, type_of(<<node));

// 	params_tis := cast(*Type_Info_Struct)params_info;

// 	strings:[..]string;

// 	for member, i: params_tis.members {
// 		paramField := get_field(params_tis, member.name);
// 		// print("paramField: % (%/%)\n", member.name, i, params_tis.members.count);
// 		member_tis := cast(*Type_Info_Struct)paramField.type;
// 		offset := paramsField.offset_in_bytes + paramField.offset_in_bytes;
// 		// paramPtr := (cast(*u8)node) + paramsField.offset_in_bytes + paramField.offset_in_bytes;
// 		// `it := cast(*BaseParamAny)paramPtr;
// 		// print("paramField:%\n", <<paramField);
// 		// generatedParamMacroCast(cast(*BaseParamAny)paramPtr, i, member, body);
// 		paramMetaData:NodeParamMetaData = .{
// 			type = member_tis.name,
// 			name = member.name,
// 			offset = xx offset
// 		};
// 		metaDataString := sprint("%,%,%", paramMetaData.type, paramMetaData.name, paramMetaData.offset);
// 		array_add(*strings, metaDataString);
// 		// print_to_builder(*builder, );
// 	}
// 	// builder: String_Builder;
// 	full :string= join(..strings, ":");
// 	print("full: %\n", full);
// 	data: ParamMetaDataString;
// 	stringToStringFixed(full, *data);
// 	strings2 := split(stringFixedToString(*data), ":");
// 	return data;
// }

// paramsMetaDataFromString :: (data: ParamMetaDataString) -> [..]NodeParamMetaData {
// 	strings := split(stringFixedToString(*data), ":");
// 	print("strings 2: %\n", strings);
// 	metaDatas:[..]NodeParamMetaData;
// 	for item: strings {
// 		print("item:%\n", item);
// 		metaData: NodeParamMetaData;
// 		// scan2(item, "%,%,%", *metaData.type, *metaData.name, *metaData.offset);
// 		success, values := scan("%%,%%,%i", item);
// 		print("success: %, values: %\n", success, values);
// 		print("metaData: _%_: %, %, %\n", item, metaData.type, metaData.name, metaData.offset);
// 		// elements := split(string, ",");
// 		// paramMetaData:NodeParamMetaData = .{
// 		// 	type = elements[0],
// 		// 	name = elements[1],
// 		// 	offset = elements[2]
// 		// };
// 		array_add(*metaDatas, metaData);
// 	}
// 	return metaDatas;
// }
