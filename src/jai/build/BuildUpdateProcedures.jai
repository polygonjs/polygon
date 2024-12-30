update_procedures :: (message: *Message) {
	typechecked := cast(*Message_Typechecked) message;
	for tc: typechecked.procedure_bodies {
		body := tc.expression;
		if body.body_flags & .ALREADY_MODIFIED continue;

		assert(body.block != null);
		if(body.header.name == "import_shader"){
			code_literal := cast(*Code_Literal) tc.subexpressions[0];
			shader_file_name := code_literal.values._string;
			jai_file_path := code_literal.location.enclosing_load.fully_pathed_filename;
			path_elements := split(jai_file_path, "/");
			path := parse_path(jai_file_path, reduce=true);
			path.words[path.words.count-1] = shader_file_name;
			shader_file_path := path_to_string(path);
			shader_raw := read_shader_file_with_include(shader_file_path);

			new_statements : [..] *Code_Node;
			array_add(*new_statements, make_return_statement(make_string_literal(shader_raw)));

			body.block.statements = new_statements;
			compiler_modify_procedure(message.workspace, body);
		}
	}
}


make_return_statement :: (expression: *Code_Node) -> *Code_Return {
	ret := New(Code_Return);
	ret.kind = .RETURN;

	arguments_unsorted: [..] Code_Argument;

	arg: Code_Argument;
	arg.expression = expression;
	arg.name = null;

	array_add(*arguments_unsorted, arg);
	ret.arguments_unsorted = arguments_unsorted;

	arguments_sorted: [..] *Code_Node;
	array_add(*arguments_sorted, expression);
	ret.arguments_sorted = arguments_sorted;

	return ret;
}
