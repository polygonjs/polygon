EditorHistory :: struct {
	commands: [..]Any;
	index: s64=-1;
}

editorHistoryInit :: (using editor: *Editor){
	array_init(*history.commands);
	history.index = -1;
}

EditorCommand :: Type.[
	NodeMoveCommand,
	NodeSelectCommand
];
pushCommand :: (using editor:*Editor, cmd: *$T/EditorCommand) {
	history.index += 1;

	history.commands.count = history.index+1;
	maybe_grow(*history.commands);

	cmdAny:Any = <<cmd;
	history.commands[history.index] = cmdAny;

	commandDo(editor, cmd);
}

editorUndo :: (using editor:*Editor) {
	if history.index < 0 { return; }

	cmdAny := history.commands[history.index];
	history.index -= 1;

	if (cast(*Type_Info_Struct)cmdAny.type).name == {
		case "NodeMoveCommand"; { commandUndo(editor, <<(cast(*NodeMoveCommand)cmdAny.value_pointer)); }
		case "NodeSelectCommand"; { commandUndo(editor, <<(cast(*NodeSelectCommand)cmdAny.value_pointer)); }
	}
}
editorRedo :: (using editor:*Editor){
	if history.index >= (history.commands.count-1) { return; }

	cmdAny := history.commands[history.index+1];
	history.index += 1;

	if (cast(*Type_Info_Struct)cmdAny.type).name == {
		case "NodeMoveCommand"; { commandDo(editor, <<(cast(*NodeMoveCommand)cmdAny.value_pointer)); }
		case "NodeSelectCommand"; { commandDo(editor, <<(cast(*NodeSelectCommand)cmdAny.value_pointer)); }
	}
}