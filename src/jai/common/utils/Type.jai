print_type_info :: ($T:Type){
	info := type_info(T);
	print("% (with size=%) contains the following members:\n", T, size_of(T));
	for info.members {
		print(tprint("%: % of type % with offset %\n", it_index, it.name, type_to_string(it.type), it.offset_in_bytes));
	}
}