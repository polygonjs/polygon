FontDataDeclaration :: struct {
	type:string;
	value:string;
}
createTextureDataDeclaration :: () -> FontDataDeclaration #compile_time {
	startTime := current_time_monotonic();
	data := createTextureData();

	builder: String_Builder;
	print_to_builder(*builder, ".[");
	for byte, i: data {
		print_to_builder(*builder, tprint("%", byte));
		if i < data.count-1 {
			print_to_builder(*builder, ",");
		}
	}

	print_to_builder(*builder, "]");
	result := builder_to_string(*builder);
	// reset(*builder);

	type := tprint("[%]u8", data.count);
	declaration :FontDataDeclaration = .{
		type = type,
		value = result
	};

	duration := current_time_monotonic() - startTime;
	print("font loaded in: %s\n", to_float64_seconds(duration));
	return declaration;
}

createTextureData :: () -> [] u8 #compile_time {
	filePath := tprint("%../../../assets/fonts/dejavu_sans_mono.png", #filepath);
	result, success := read_entire_file(filePath);

	if !success compiler_report(tprint("Unable to read file '%'!\n", filePath));
	return xx result;
}
