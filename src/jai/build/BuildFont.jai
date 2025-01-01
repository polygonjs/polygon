FontDataDeclaration :: struct {
	type:string;
	value:string;
}

addFontDataPlaceholder :: (w: Workspace) {
	//
	// If the font file has changed,
	// uncomment those lines and comment out the line #load "TextureFontData.jai";
	// The cached data can then later be replaced.
	//
	// fontData := createTextureDataDeclaration();
	// add_build_string(tprint("FONT_TEXTURE_DATA :%: %;", fontData.type, fontData.value), w);
}

#scope_file

createTextureDataDeclaration :: () -> FontDataDeclaration #compile_time {
	t0 := current_time_monotonic();
	data := createTextureData();
	t1 := current_time_monotonic();

	buildInitSize :: 42138;
	comma :: ",";
	builder: String_Builder;
	init_string_builder(*builder, buildInitSize);
	print_to_builder(*builder, ".[");
	for byte, i: data {
		print_to_builder(*builder, tprint("%", byte));
		if i < data.count-1 {
			append(*builder, comma, 1);
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

	t2 := current_time_monotonic();
	print("font loaded in: %s (%ms + %ms), string size:%, init with:%\n", to_float64_seconds(t2 - t0), to_float64_seconds(t1 - t0), to_float64_seconds(t2 - t1), result.count, buildInitSize);
	return declaration;
}

createTextureData :: () -> [] u8 #compile_time {
	filePath := tprint("%../../../assets/fonts/dejavu_sans_mono.png", #filepath);
	result, success := read_entire_file(filePath);

	if !success compiler_report(tprint("Unable to read file '%'!\n", filePath));
	return xx result;
}

