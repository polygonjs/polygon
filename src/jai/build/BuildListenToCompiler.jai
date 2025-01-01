listen_to_compiler_messages :: (w: Workspace, wasm:bool, test:bool) {

	generated_code := false;
	count := 0;
	while true {
		message := compiler_wait_for_message();
		if message.kind == {
			case .TYPECHECKED;{
				update_procedures(message);
			}
			case .PHASE;
				messagePhase := cast(*Message_Phase) message;
				if messagePhase.phase == .TYPECHECKED_ALL_WE_CAN {
					if !generated_code {
						add_build_string(tprint("WASM :: %;", wasm), w);
						add_build_string(tprint("RUN_TESTS :: %;", test), w);

						fontData := createTextureDataDeclaration();
						add_build_string(tprint("FONT_TEXTURE_DATA :%: %;", fontData.type, fontData.value), w);
						generated_code = true;
					}
				}

			case .COMPLETE;
				break;
		}
	}
}