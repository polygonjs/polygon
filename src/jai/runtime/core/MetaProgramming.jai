members :: (object: $T, body: Code, flags: For_Flags) #expand {
	object_info := type_info(type_of(<<object));
	// print("object_info:%\n", object_info.type);
	if object_info.type == .STRUCT {
		object_tis := cast(*Type_Info_Struct)object_info;
		// print("object_tis:%\n", <<object_tis);

		// print("object_tis.members:%\n", object_tis.members.count);
		// print("object_tis.members:%\n", object_tis.members);

		for member, i: object_tis.members {
			memberField := get_field(object_tis, member.name);
			member_tis := cast(*Type_Info_Struct)memberField.type;
			memberPtr := (cast(*u8)object) + memberField.offset_in_bytes;// + memberField.offset_in_bytes;
			`it := member;
			`it_index := i;
			`memberName := member.name;
			`memberSize := member.type.runtime_size;

			// if memberField.type.type == .ARRAY {
			// 	tia := cast(*Type_Info_Array)memberField.type;
			// 	element_type := tia.element_type;
			// 	if tia.array_type == .RESIZABLE {
			// 		`it := cast(*memberField.type)memberPtr;
			// 	}
			// }

			#insert body;
		}
	} else {
		print("members: not a struct\n");
	}

}

printMembers :: (object: $T) {
	print("--- printMembers ---\n");
	print("object:%\n", object);
	totalSize := 0;
	for :members object {
		print("- %:% (size=%)\n", it_index, memberName, memberSize);
		totalSize += memberSize;
	}
	print("totalSize:%\n", totalSize);
}

// printMembers :: (node: *$T) {
// 	node_info := type_info(type_of(<<node));
// 	node_tis := cast(*Type_Info_Struct)node_info;
// 	// paramsField := get_field(node_tis, "p");
// 	// params_info := type_info(type_of(node.p));
// 	// assert(params_info.type == .STRUCT, "*** handle_params: not a struct (%, type=%)\n", params_info.type, type_of(<<node));

// 	// params_tis := cast(*Type_Info_Struct)params_info;

// 	for member, i: node_tis.members {
// 		memberField := get_field(node_tis, member.name);
// 		// print("paramField: % (%/%)\n", member.name, i, params_tis.members.count);
// 		member_tis := cast(*Type_Info_Struct)memberField.type;
// 		memberPtr := (cast(*u8)node) + memberField.offset_in_bytes;// + paramField.offset_in_bytes;
// 		`it := cast(*BaseParamAny)paramPtr;
// 		`it_index := i;
// 		// `type := paramType(member_tis.name);
// 		`paramName := member.name;
// 		#insert body;
// 	}
// }