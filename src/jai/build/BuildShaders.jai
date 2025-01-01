SHADER_INCLUDE_START :: "// include ";
read_shader_file_with_include :: (filePath:string)->string {
	return getFileLines(filePath);;
}
getFileLines :: (filePath: string) -> content:string{
	cachedContent, found := table_find(*CONTENT_BY_FILE, filePath);
	if found {
		return cachedContent;
	}
	startTime := current_time_monotonic();
	handler: Text_File_Handler;
	handler.do_version_number = false;
	// array_add(handlers, handler);

	lines:[..]string;

	short_name := "example_data";
	start_file(*handler, short_name, filePath, false);
	assert(handler.failed==false, tprint("failed to parse include chunk '%'", filePath));

	while true {
		line, found := consume_next_line(*handler);
		if !found break;
		if(begins_with(line, SHADER_INCLUDE_START)){
			includedFileName := slice(line, SHADER_INCLUDE_START.count, line.count-1);
			includedFilePath := tprint("%../../shaders/common/%.wgsl", #filepath, includedFileName);
			includedContent := getFileLines(includedFilePath);
			array_add(*lines, includedContent);
		} else {
			array_add(*lines, line);
		}
	}

	content := join(..lines,"\n");
	table_set(*CONTENT_BY_FILE, filePath, content);
	// print("read shader file: %, %\n",  to_float64_seconds(current_time_monotonic() - startTime), filePath);
	return content;
}

#scope_file

CONTENT_BY_FILE :Table(string, string);