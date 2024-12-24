// members :: (object: *$T, body: Code, flags: For_Flags) #expand {
// 	object_info := type_info(type_of(<<object));
// 	object_tis := cast(*Type_Info_Struct)object_info;

// 	for member, i: object_tis.members {
// 		memberField := get_field(object_tis, member.name);
// 		member_tis := cast(*Type_Info_Struct)memberField.type;
// 		memberPtr := (cast(*u8)object) + memberField.offset_in_bytes + memberField.offset_in_bytes;
// 		`it_index := i;
// 		`memberName := member.name;

// 		if memberField.type.type == .ARRAY {
// 			tia := cast(*Type_Info_Array)memberField.type;
// 			element_type := tia.element_type;
// 			if tia.array_type == .RESIZABLE {
// 				`it := cast(*memberField.type)memberPtr;
// 			}
// 		}

// 		#insert body;
// 	}
// }