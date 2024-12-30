SHADER_INCLUDE_START :: "// include ";
read_shader_file_with_include :: (file_path:string)->string {
	lines:[..]string;
	handlers:[..]Text_File_Handler;
	defer array_reset(*lines);
	add_file_lines(*lines, file_path, *handlers);

	content := join(..lines,"\n");

	for handlers deinit(*it);

	return content;
}
add_file_lines :: (lines:*[..]string, file_path: string, handlers:*[..]Text_File_Handler){
	handler: Text_File_Handler;
	handler.do_version_number = false;
	array_add(handlers, handler);

	short_name := "example_data";
	start_file(*handler, short_name, file_path, false);
	assert(handler.failed==false, tprint("failed to parse include chunk '%'", file_path));

	while true {
		line, found := consume_next_line(*handler);
		if !found break;
		if(begins_with(line, SHADER_INCLUDE_START)){
			include_file_name := slice(line, SHADER_INCLUDE_START.count, line.count-1);
			include_file_path := tprint("%../../shaders/common/%.wgsl", #filepath, include_file_name);
			print("include_file_path:%,%\n", include_file_name, include_file_path);
			add_file_lines(lines, include_file_path, handlers);
		} else {
			array_add(lines, line);
		}
	}
}
