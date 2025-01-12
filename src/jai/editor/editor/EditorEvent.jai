processEvent :: (editor: *Editor, eventsData:*EventsData) {
	#if USE_IMGUI {
		if(editor.imguiPolygonContext.io != null){
			if(ImGui.GetIO().WantCaptureMouse == false) processEventPanels(editor, eventsData);
		}
	} else {
		processEventPanels(editor, eventsData);
	}
}

#scope_file

processEventPanels :: (editor: *Editor, eventsData:*EventsData) {

	if eventsData.modifiers.ctrl {
		text :string= cast(string)(eventsData.text);
		char := text[0];
		if char == {
			case (#char "y"); {
				editorRedo(editor);
				return;
			}
			case (#char "z"); {
				editorUndo(editor);
				return;
			}
		}
	}

	#if HAS_VIEWER_PANEL processEvent(*editor.viewerPanel, eventsData);
	#if HAS_NETWORK_PANEL processEvent(*editor.networkPanel, eventsData);
	processEvent(*editor.paramsPanel, eventsData);
}