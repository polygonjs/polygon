


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
	windowCreated:bool = false;

	testsCount := 0;
	windowSize :Vector2UInt;
	for test,i: NAMED_PROCEDURES {
		found :bool= requestedTestNames.count == 0 || _isRequestedTestName(test.name, requestedTestNames);
		if found {
			testOptions:TestProcedureOptions;
			print("% TEST: %\n", tprintGreen(" "),test.name);
			if test.withScene == true {
				testOptions.nodesScene = newNodesScene();
			}
			if test.requiresWGPU {
				if test.headless {
					if test.withEditor == true {
						if windowCreated==false {
							testOptions.window_size = headlessInit();
							windowSize = testOptions.window_size;
						} else {
							testOptions.window_size = windowSize;
						}
						testOptions.editor = newEditor();
						if testOptions.nodesScene != null {
							editorSetScene(testOptions.editor, testOptions.nodesScene);
						}
					}
				} else {
					if windowCreated==false {
						testOptions.window_size = windowInit();
						windowSize = testOptions.window_size;
					} else {
						testOptions.window_size = windowSize;
					}
				}
				windowCreated = true;
			}
			test.proc(testOptions);
			testsCount += 1;
	
			if testOptions.nodesScene != null {
				sceneDelete(testOptions.nodesScene);
			}
			reset_temporary_storage();
			assertLeaksCount(0, "no leaks when closing an empty editor");
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
	array_add(*NAMED_PROCEDURES_COMPILE_TIME, .{name=name, proc=procedure, requiresWGPU=false, headless=true, withScene=false, withEditor=false});
}
testWithWindow :: (name: string, procedure: TestProcedure) {
	_ensure_test_name_is_unique(name);
	//
	array_add(*NAMED_PROCEDURES_COMPILE_TIME, .{name=name, proc=procedure, requiresWGPU=true, headless=false, withScene=true, withEditor=true});
}
testHeadless :: (name: string, procedure: TestProcedure) {
	_ensure_test_name_is_unique(name);
	//
	array_add(*NAMED_PROCEDURES_COMPILE_TIME, .{name=name, proc=procedure, requiresWGPU=true, headless=true, withScene=true, withEditor=true});
}
testHeadlessNoSceneOrEditor :: (name: string, procedure: TestProcedure) {
	_ensure_test_name_is_unique(name);
	//
	array_add(*NAMED_PROCEDURES_COMPILE_TIME, .{name=name, proc=procedure, requiresWGPU=true, headless=true, withScene=false, withEditor=false});
}
testWithScene :: (name: string, procedure: TestProcedure) {
	_ensure_test_name_is_unique(name);
	//
	array_add(*NAMED_PROCEDURES_COMPILE_TIME, .{name=name, proc=procedure, requiresWGPU=false, headless=true, withScene=true, withEditor=false});
}

TestProcedureOptions :: struct {
	window_size: Vector2UInt;
	nodesScene: *NodesScene;
	editor: *Editor;
}
TestProcedure :: #type (options: TestProcedureOptions) -> ();

NamedProcedure :: struct {
	name: string;
	proc: TestProcedure;
	requiresWGPU: bool;
	headless: bool;
	withScene: bool;
	withEditor: bool;
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
