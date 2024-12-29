
mainMenuBarDraw :: (using editor: *Editor) {
	#if USE_IMGUI if (ImGui.BeginMainMenuBar()) {
		if (ImGui.BeginMenu("File")) {
			// ShowExampleMenuFile();
			if (ImGui.MenuItem("Save", "CTRL+S")) {}
			if (ImGui.MenuItem("Save As", "CTRL+SHIFT+S")) {}
			if (ImGui.MenuItem("Open", "CTRL+O")) {}
			ImGui.EndMenu();
		}
		if (ImGui.BeginMenu("Edit")) {
			if (ImGui.MenuItem("Undo", to_c_string_temp("CTRL+Z"))) {}
			if (ImGui.MenuItem("Redo", "CTRL+Y", selected=false, enabled=false)) {}
			ImGui.Separator();
			if (ImGui.MenuItem("Cut", "CTRL+X")) {}
			if (ImGui.MenuItem("Copy", "CTRL+C")) {}
			if (ImGui.MenuItem("Paste", "CTRL+V")) {}
			ImGui.EndMenu();
		}
		{
			// fps
			// for some reason, this now makes the UI flicker in wasm
			#if WASM == false {
				frameRateStr := tprint("FPS:%", editor.nodesScene.fps);
				ImGui.TextUnformatted(frameRateStr);
			}
		}
		ImGui.EndMainMenuBar();
	}
}