


runTests :: () {
	initTestApp();

	#if WASM==true {
		// runNextTestOrTerminate();
	}
	else {
		while TEST_APP.procedureIndex <= (TEST_APP.procedures.count-1) {
			runNextTestOrTerminate();
		}
		printTestAppStats();
	}
}



runNextTestOrTerminate :: () {
	currentIndex := TEST_APP.procedureIndex;
	test := TEST_APP.procedures[currentIndex];
	TEST_APP.procedureIndex += 1;
	found :bool= TEST_APP.requestedTestNames.count == 0 || _isRequestedTestName(test.name, TEST_APP.requestedTestNames);
	if found {
		print("% TEST: %... (%)			", tprintGreen(" "), test.name, currentIndex);
		TEST_APP.testStartTime = current_time_monotonic();
		TEST_APP.testInProgress = true;
		testOptions:TestProcedureOptions;
		// TEST_APP.testLineStart = tprint("% TEST: %... (%)			", tprintGreen(" "), test.name, TEST_APP.procedureIndex);
		if test.scene == true {
			nodesScene:NodesScene;
			APP.nodesScene = nodesScene;
			nodesSceneInit(*APP.nodesScene);
			testOptions.nodesScene = *APP.nodesScene;
		}
		if test.wgpu {
			if test.editor == true {
				editor:Editor;
				APP.editor = editor;
				testOptions.editor = *APP.editor;
				if test.headless {
					// APP.editor = testOptions.editor;
					testOptions.editor.wgpuContext = TEST_APP.headlessWGPUContext;
					
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
		TEST_APP.testOptions = testOptions;
		test.proc(testOptions);
		#if WASM==false {postTest();}
	} else {
		TEST_APP.skippedTestsCount += 1;
		postTestSkipped();
	}

}

#if WASM == true {
	batchRunNextTestOrTerminate :: (){
		if TEST_APP.testInProgress == true || TEST_APP.hasFailedAssertion==true {
			return;
		}
		if TEST_APP.procedureIndex >= TEST_APP.procedures.count {
			printTestAppStats();
			return;
		}
		runNextTestOrTerminate();
	}
	endTest :: (){
		// APP.editor = null;
		// APP.nodesScene = null;
		postTest();
	};
} else {
	endTest :: (){}
}
postTest :: () {
	if TEST_APP.testOptions.nodesScene != null {
		nodesSceneReset(TEST_APP.testOptions.nodesScene);
	}
	TEST_APP.testEndTime = current_time_monotonic();
	reset_temporary_storage();
	assertLeaksCount(0, "no leaks");
	reset_temporary_storage();
	TEST_APP.testInProgress = false;

	poolsContainerReset();
	TEST_APP.testTeardownTime = current_time_monotonic();
	
	if TEST_APP.hasFailedAssertion==true {
		postTestFailed();
	} else {
		postTestSuccessful();
	}
}
postTestFailed :: (){
	print(" % \n", tprintRed("FAILED"));
	print("%\n", TEST_APP.failedAssertionMessage);
	print_stack_trace(*TEST_APP.stackTraceNode[0]);
	TEST_APP.procedureIndex = -1;
}
postTestSuccessful :: (){
	TEST_APP.testsCount += 1;

	testTime := to_float64_seconds(TEST_APP.testEndTime-TEST_APP.testStartTime);
	teardownTime := to_float64_seconds(TEST_APP.testTeardownTime-TEST_APP.testEndTime);
	#if WASM==true {
		print("    ✅ completed in %ms\n", testTime);
	} else {
		print(" %ms, (teardown: %ms)\n", testTime*1000, teardownTime*1000);
	}

	#if WASM==true { batchRunNextTestOrTerminate(); }
}
postTestSkipped :: (){
	TEST_APP.skippedTestsCount += 1;

	#if WASM==true { batchRunNextTestOrTerminate(); }
}


printTestAppStats :: () {
	using TEST_APP;
	if statsPrinted == true {return;}
	statsPrinted = true;
	if (hasFailedAssertion == true) {return;}
	if testsCount == 0 {
		printRed("---------NO TESTS WERE EXECUTED\n");
	} else {
		tEnd := current_time_monotonic();
		print("--------- % TEST COMPLETED in % seconds.\n", testsCount, to_float64_seconds(tEnd-t0));
		if skippedTestsCount > 0 {
			print("% TEST SKIPPED: %\n", tprintYellow(" "), skippedTestsCount);
		}
	}
}

test :: (name: string, procedure: TestProcedure) {
	_ensureTestNameUnique(name);
	array_add(*NAMED_PROCEDURES_COMPILE_TIME, .{name=name, proc=procedure, wgpu=false, headless=true, scene=false, editor=false});
}
testWithWindow :: (name: string, procedure: TestProcedure) {
	_ensureTestNameUnique(name);
	array_add(*NAMED_PROCEDURES_COMPILE_TIME, .{name=name, proc=procedure, wgpu=true, headless=false, scene=true, editor=true});
}
testHeadless :: (name: string, procedure: TestProcedure) {
	_ensureTestNameUnique(name);
	array_add(*NAMED_PROCEDURES_COMPILE_TIME, .{name=name, proc=procedure, wgpu=true, headless=true, scene=true, editor=true});
}
testHeadlessNoSceneOrEditor :: (name: string, procedure: TestProcedure) {
	_ensureTestNameUnique(name);
	array_add(*NAMED_PROCEDURES_COMPILE_TIME, .{name=name, proc=procedure, wgpu=true, headless=true, scene=false, editor=false});
}
testWithScene :: (name: string, procedure: TestProcedure) {
	_ensureTestNameUnique(name);
	array_add(*NAMED_PROCEDURES_COMPILE_TIME, .{name=name, proc=procedure, wgpu=false, headless=true, scene=true, editor=false});
}

TestProcedureOptions :: struct {
	nodesScene: *NodesScene;
	editor: *Editor;
	// headlessWGPUContext: *WGPUContext;
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
#if WASM {
	TestAppTime :: u64;
} else {
	TestAppTime :: Apollo_Time;
}
TestApp :: struct {
	requestedTestNames :[..]string;
	t0 :TestAppTime;
	t1 :TestAppTime;
	testStartTime :TestAppTime;
	testEndTime :TestAppTime;
	testTeardownTime :TestAppTime;
	testInProgress: bool=false;
	headlessWGPUContext: WGPUContext;
	procedures :[]NamedProcedure;
	procedureIndex: s64;
	// testLineStart :string;
	testOptions:TestProcedureOptions;
	testsCount: u64;
	skippedTestsCount: u64;
	hasFailedAssertion:bool=false;
	failedAssertionMessage: string;
	stackTraceNode: [] Stack_Trace_Node;
	statsPrinted: bool=false;
}
TEST_APP: TestApp;

setFailedAssertion :: (message: string) {
	TEST_APP.hasFailedAssertion = true;
	TEST_APP.failedAssertionMessage = message;
	TEST_APP.stackTraceNode = pack_stack_trace();
}

#scope_file

initTestApp :: (){
	print("--------- TEST START\n");

	args := get_command_line_arguments();
	this_allocation_is_not_a_leak(args.data);
	
	for arg,i: args {
		if i > 0 {
			array_add(*TEST_APP.requestedTestNames, arg);
		}
	}
	this_allocation_is_not_a_leak(TEST_APP.requestedTestNames.data);

	#if WASM {
		#assert(FREE_MEMORY_DEBUG==false); // set FREE_MEMORY_DEBUG :: false in config.jai
	} else {
		#assert(FREE_MEMORY_DEBUG==true); // set FREE_MEMORY_DEBUG :: true in config.jai
	}
	TEST_APP.skippedTestsCount = 0;
	TEST_APP.t0 = current_time_monotonic();
	TEST_APP.testsCount = 0;
	#if WASM == false {
		headlessInit(*TEST_APP.headlessWGPUContext, .{4,4});
		TEST_APP.t1 = current_time_monotonic();
		print("headlessInit in % seconds.\n", to_float64_seconds(TEST_APP.t1-TEST_APP.t0));
	}

	TEST_APP.procedures = NAMED_PROCEDURES;
	TEST_APP.procedureIndex = 0;//NAMED_PROCEDURES.count-1;
}

getRegisteredTests :: ()->[..]NamedProcedure {
	registerTests();
	return NAMED_PROCEDURES_COMPILE_TIME;
}

NAMED_PROCEDURES_COMPILE_TIME :[..]NamedProcedure;
NAMED_PROCEDURES :[]NamedProcedure: #run getRegisteredTests();

_ensureTestNameUnique :: (name: string) {
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
