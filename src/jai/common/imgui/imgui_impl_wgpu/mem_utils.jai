// https://discord.com/channels/661732390355337246/661732390355337249/1092628683782639696
// offset_of :: ($T: Type, $name: member) -> int {
// 	return #run -> int {
// 		for type_info(T).members {
// 			if it.name == name return it.offset_in_bytes;
// 		}
// 		return -1;
// 	};
// }
offset_of :: (t_info_struct: *Type_Info_Struct, name: string) -> s64 {
	for t_info_struct.members {
		if it.name == name return it.offset_in_bytes;
	}
	return -1;
}
// #define MEMALIGN(_SIZE,_ALIGN)        (((_SIZE) + ((_ALIGN) - 1)) & ~((_ALIGN) - 1))    // Memory align (copied from IM_ALIGN() macro).
memalign :: (size:u64, align: u64)->u64{
	// print("memalign:%,%=%\n",size,align, ((size + (align - 1)) & ~(align - 1)));
	return ((size + (align - 1)) & ~(align - 1));
}