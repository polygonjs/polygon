


runTests :: () {
	print("--------- TEST START\n");

	args := get_command_line_arguments();
	this_allocation_is_not_a_leak(args.data);
	requestedTestNames :[..]string;
	for arg,i: args {
		if i > 0 {
			array_add(*requestedTestNames, arg);
		}
	}
	this_allocation_is_not_a_leak(requestedTestNames.data);

	#if WASM {
		#assert(FREE_MEMORY_DEBUG==false); // set FREE_MEMORY_DEBUG :: false in config.jai
	} else {
		#assert(FREE_MEMORY_DEBUG==true); // set FREE_MEMORY_DEBUG :: true in config.jai
	}
	testsCount := 0;
	headlessWGPUContext: WGPUContext;
	headlessInit(*headlessWGPUContext, .{4,4});
	for test,i: NAMED_PROCEDURES {
		found :bool= requestedTestNames.count == 0 || _isRequestedTestName(test.name, requestedTestNames);
		if found {
			testOptions:TestProcedureOptions;
			testOptions.headlessWGPUContext = *headlessWGPUContext;
			print("% TEST: %\n", tprintGreen(" "),test.name);
			if test.scene == true {
				testOptions.nodesScene = newNodesScene();
			}
			if test.wgpu {
				if test.editor == true {
					if test.headless {
						testOptions.editor = newEditor();
						testOptions.editor.wgpuContext = headlessWGPUContext;
						
						editorInit(testOptions.editor);
						if testOptions.nodesScene != null {
							editorSetScene(testOptions.editor, testOptions.nodesScene);
						}
					} else {
						assert(false, "non headless mode not yet implemented");
						// testOptions.editor = newEditor();
						// testOptions.editor.wgpuContext = headlessWGPUContext;
						// editorInit(testOptions.editor);
						// if testOptions.nodesScene != null {
						// 	editorSetScene(testOptions.editor, testOptions.nodesScene);
						// }
					}
				}
			}
			test.proc(testOptions);
			testsCount += 1;
	
			if testOptions.nodesScene != null {
				sceneDelete(testOptions.nodesScene);
			}
			reset_temporary_storage();
			assertLeaksCount(0, "no leaks");
			reset_temporary_storage();
		} else {
			print("% TEST SKIPPED: %\n", tprintYellow(" "),test.name);
		}
	}
	if testsCount == 0 {
		printRed("---------NO TESTS WERE EXECUTED\n");
	} else {
		print("---------TEST COMPLETED: (%)\n", testsCount);
	}
}

test :: (name: string, procedure: TestProcedure) {
	_ensure_test_name_is_unique(name);
	//
	array_add(*NAMED_PROCEDURES_COMPILE_TIME, .{name=name, proc=procedure, wgpu=false, headless=true, scene=false, editor=false});
}
testWithWindow :: (name: string, procedure: TestProcedure) {
	_ensure_test_name_is_unique(name);
	//
	array_add(*NAMED_PROCEDURES_COMPILE_TIME, .{name=name, proc=procedure, wgpu=true, headless=false, scene=true, editor=true});
}
testHeadless :: (name: string, procedure: TestProcedure) {
	_ensure_test_name_is_unique(name);
	//
	array_add(*NAMED_PROCEDURES_COMPILE_TIME, .{name=name, proc=procedure, wgpu=true, headless=true, scene=true, editor=true});
}
testHeadlessNoSceneOrEditor :: (name: string, procedure: TestProcedure) {
	_ensure_test_name_is_unique(name);
	//
	array_add(*NAMED_PROCEDURES_COMPILE_TIME, .{name=name, proc=procedure, wgpu=true, headless=true, scene=false, editor=false});
}
testWithScene :: (name: string, procedure: TestProcedure) {
	_ensure_test_name_is_unique(name);
	//
	array_add(*NAMED_PROCEDURES_COMPILE_TIME, .{name=name, proc=procedure, wgpu=false, headless=true, scene=true, editor=false});
}

TestProcedureOptions :: struct {
	nodesScene: *NodesScene;
	editor: *Editor;
	headlessWGPUContext: *WGPUContext;
}
TestProcedure :: #type (options: TestProcedureOptions) -> ();

NamedProcedure :: struct {
	name: string;
	proc: TestProcedure;
	wgpu: bool;
	headless: bool;
	scene: bool;
	editor: bool;
}


#scope_file

getRegisteredTests :: ()->[..]NamedProcedure {
	registerTests();
	return NAMED_PROCEDURES_COMPILE_TIME;
}

NAMED_PROCEDURES_COMPILE_TIME :[..]NamedProcedure;
NAMED_PROCEDURES :[]NamedProcedure: #run getRegisteredTests();

_ensure_test_name_is_unique :: (name: string) {
	for test,i: NAMED_PROCEDURES_COMPILE_TIME {
		if test.name == name {
			assert(false, tprint("TEST NAME ALREADY EXISTS (%)", test.name));
		}
	}
}

_isRequestedTestName :: (testName: string, requestedTestNames: []string)->bool {
	// return array_find(requestedTestNames, test.name);
	for requestedTestName,i: requestedTestNames {
		if contains(testName, requestedTestName) {
			return true;
		}
	}
	return false;
}
