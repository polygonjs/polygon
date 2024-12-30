


runTests :: (app:*PolygonApp) {
	initTestApp(app);

	#if WASM == true {
		// runNextTestOrTerminate();
	}
	else {
		while app.testApp.procedureIndex>=0 && app.testApp.procedureIndex <= (app.testApp.procedures.count-1) {
			runNextTestOrTerminate(app);
		}
		printTestAppStats(app);
	}
}



runNextTestOrTerminate :: (app:*PolygonApp) {
	currentIndex := app.testApp.procedureIndex;
	test := app.testApp.procedures[currentIndex];
	app.testApp.procedureIndex += 1;
	found :bool= app.testApp.requestedTestNames.count == 0 || _isRequestedTestName(test.name, app.testApp.requestedTestNames);
	if found {
		print("% TEST: %... (%)			", tprintGreen(" "), test.name, currentIndex);
		app.testApp.testStartTime = current_time_monotonic();
		app.testApp.testInProgress = true;
		testOptions:TestProcedureOptions;
		// app.testApp.testLineStart = tprint("% TEST: %... (%)			", tprintGreen(" "), test.name, app.testApp.procedureIndex);
		if test.scene == true || test.editor == true {
			_nodesScene:NodesScene;
			app.nodesScene = _nodesScene;
			nodesSceneInit(*app.nodesScene);
			testOptions.nodesScene = *app.nodesScene;
		}
		if test.wgpu {
			if test.editor == true {
				_editor:Editor;
				assert(_editor.initialized==false, "editor initialized=true");
				assert(_editor.disposed==false, "editor disposed=true");
				app.editor = _editor;
				assert(app.editor.initialized==false, "app.editor initialized=true");
				assert(app.editor.disposed==false, "app.editor disposed=true");
				testOptions.editor = *app.editor;
				if test.headless {
					// app.editor = testOptions.editor;
					app.editor.wgpuContext = app.testApp.headlessWGPUContext;
					editorInit(*app.editor);
					if testOptions.nodesScene != null {
						editorSetScene(*app.editor, *app.nodesScene);
					}
					testOptions.editor = *app.editor;
				} else {
					assert(false, "non headless mode not yet implemented");
					// testOptions.editor = newEditor();
					// testOptions.editor.wgpuContext = headlessWGPUContext;
					// editorInit(testOptions.editor);
					// if testOptions.nodesScene != null {
					// 	editorSetScene(testOptions.editor, testOptions.nodesScene);
					// }
				}
				assert(app.editor.initialized==true, "app.editor initialized=false");
				assert(app.editor.disposed==false, "app.editor disposed=true");
			}
		}
		app.testApp.testOptions = testOptions;
		app.testApp.testOptions.app = app;
		app.testApp.testOptions.testApp = *app.testApp;
		test.proc(app.testApp.testOptions);
		#if WASM == false {postTest(app);}
	} else {
		app.testApp.skippedTestsCount += 1;
		postTestSkipped(app);
	}

}

#if WASM == true {
	batchRunNextTestOrTerminate :: (app: *PolygonApp){
		if app.testApp.testInProgress == true || app.testApp.hasFailedAssertion==true {
			return;
		}
		if app.testApp.procedureIndex >= app.testApp.procedures.count {
			printTestAppStats(app);
			return;
		}
		runNextTestOrTerminate(app);
	}
	endTest :: (){
		// app.editor = null;
		// app.nodesScene = null;
		postTest(*APP);
	};
} else {
	endTest :: (){}
}
postTest :: (app: *PolygonApp) {
	if app.testApp.testOptions.nodesScene != null {
		nodesSceneReset(app.testApp.testOptions.nodesScene);
	}
	app.testApp.testEndTime = current_time_monotonic();
	reset_temporary_storage();
	#if SKIP_MEM_TEST == false {
		assertLeaksCount(0, "no leaks");
		reset_temporary_storage();
	}

	app.testApp.testTeardownTime = current_time_monotonic();
	
	if app.testApp.hasFailedAssertion==true {
		postTestFailed(app);
	} else {
		postTestSuccessful(app);
	}
	app.testApp.testInProgress = false;
}
postTestFailed :: (app: *PolygonApp){
	print(" % \n", tprintRed("FAILED"));
	print("%\n", app.testApp.failedAssertionMessage);
	print_stack_trace(*app.testApp.stackTraceNode[0]);
	app.testApp.procedureIndex = -1;
}
postTestSuccessful :: (app: *PolygonApp){
	app.testApp.testsCount += 1;

	testTime := to_float64_seconds(app.testApp.testEndTime-app.testApp.testStartTime);
	teardownTime := to_float64_seconds(app.testApp.testTeardownTime-app.testApp.testEndTime);
	#if WASM == true {
		print("    ✅ completed in %ms\n", testTime);
	} else {
		#if SKIP_MEM_TEST {
			print(" %ms, (no teardown)\n", testTime*1000);
		} else {
			print(" %ms, (teardown: %ms)\n", testTime*1000, teardownTime*1000);
		}
	}

	#if WASM == true { batchRunNextTestOrTerminate(app); }
}
postTestSkipped :: (app: *PolygonApp){
	app.testApp.skippedTestsCount += 1;

	#if WASM == true { batchRunNextTestOrTerminate(app); }
}


printTestAppStats :: (app: *PolygonApp) {
	using app.testApp;
	if statsPrinted == true {return;}
	statsPrinted = true;
	if (hasFailedAssertion == true) {return;}
	if testsCount == 0 {
		printRed("---------NO TESTS WERE EXECUTED\n");
	} else {
		tEnd := current_time_monotonic();
		#if WASM == true {
			totalTimeInt := to_float64_seconds(tEnd-t0);
			totalTime :float = totalTimeInt * 0.001;
		} else {
			totalTime := to_float64_seconds(tEnd-t0);
		}
		print("--------- % TEST COMPLETED in % seconds.\n", testsCount, totalTime);
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
	app: *PolygonApp;
	testApp: *TestApp;
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


setFailedAssertion :: (message: string) {
	APP.testApp.hasFailedAssertion = true;
	APP.testApp.failedAssertionMessage = message;
	APP.testApp.stackTraceNode = pack_stack_trace();
}

#scope_file

initTestApp :: (app: *PolygonApp){
	print("--------- TEST START\n");

	args := get_command_line_arguments();
	this_allocation_is_not_a_leak(args.data);
	
	for arg,i: args {
		if i > 0 {
			array_add(*app.testApp.requestedTestNames, arg);
		}
	}
	this_allocation_is_not_a_leak(app.testApp.requestedTestNames.data);

	#if WASM {
		#assert(FREE_MEMORY_DEBUG==false); // set FREE_MEMORY_DEBUG :: false in config.jai
	} else {
		#assert(FREE_MEMORY_DEBUG==true||SKIP_MEM_TEST==true); // set FREE_MEMORY_DEBUG :: true in config.jai
	}
	app.testApp.skippedTestsCount = 0;
	app.testApp.t0 = current_time_monotonic();
	app.testApp.testsCount = 0;
	#if WASM == false {
		headlessInit(*app.testApp.headlessWGPUContext, .{128,128});
		app.testApp.t1 = current_time_monotonic();
		print("headlessInit in % seconds.\n", to_float64_seconds(app.testApp.t1-app.testApp.t0));
	}

	app.testApp.procedures = NAMED_PROCEDURES;
	app.testApp.procedureIndex = 0;//NAMED_PROCEDURES.count-1;
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
