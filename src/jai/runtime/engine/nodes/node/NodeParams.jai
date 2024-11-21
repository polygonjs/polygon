nodeParamsInit :: (node: *$N) {
	// print("nodeInitParams:%\n", type_of(node), <<node);
	// node := cast(*nodeType)_node;

	// node_info := type_info(type_of(<<node));
	// node_tis := cast(*Type_Info_Struct)node_info;
	// paramsField := get_field(node_tis, "p");
	// params_info := type_info(type_of(node.p));
	// if params_info.type != .STRUCT {
	// 	print("*** handle_params: not a struct\n");
	// 	return;
	// }

	// params_tis := cast(*Type_Info_Struct)params_info;
	// for member: params_tis.members {
	// 	paramField := get_field(params_info, member.name);
	// 	// print("paramField: % % % %\n", member.name, paramField, <<paramField.type);
	// 	member_tis := cast(*Type_Info_Struct)paramField.type;
	// 	paramPtr := (cast(*u8)node) + paramsField.offset_in_bytes + paramField.offset_in_bytes;
	// 	param := cast(*BaseParamAny)paramPtr;
	// 	if cast(*void)param.type == null {
	// 		param.type = paramType(member_tis.name);
	// 	}
	// 	initParamByType(param, node);
	// 	// nodeInitParam(node, paramPtr);
	// }

	for :params param: node {
		if cast(*void)param.type == null {
			assert(false, "*** handle_params: param.type is null\n");
			// param.type = type;
		}
		initParamByType(param, node);
	}
}

params :: (node: *$T, body: Code, flags: For_Flags) #expand {
	node_info := type_info(type_of(<<node));
	node_tis := cast(*Type_Info_Struct)node_info;
	paramsField := get_field(node_tis, "p");
	params_info := type_info(type_of(node.p));
	assert(params_info.type == .STRUCT, "*** handle_params: not a struct (%, type=%)\n", params_info.type, type_of(<<node));

	params_tis := cast(*Type_Info_Struct)params_info;

	for member, i: params_tis.members {
		paramField := get_field(params_tis, member.name);
		// print("paramField: % (%/%)\n", member.name, i, params_tis.members.count);
		member_tis := cast(*Type_Info_Struct)paramField.type;
		paramPtr := (cast(*u8)node) + paramsField.offset_in_bytes + paramField.offset_in_bytes;
		`it := cast(*BaseParamAny)paramPtr;
		`it_index := i;
		`type := paramType(member_tis.name);
		#insert body;
	}
}
paramsCount :: (node: *$T) -> u8 {
	count :u8= 0;
	for param: node.params {
		count += 1;
	}
	return count;
}


nodeResetParams :: (node: *$T) {
	for :params param: node { paramsResetValue(param); }
}