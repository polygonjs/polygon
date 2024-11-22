


runTests :: () {
	print("--------- TEST START\n");

	args := get_command_line_arguments();
	this_allocation_is_not_a_leak(args.data);
	testNames :[..]string;
	for arg,i: args {
		if i > 0 {
			array_add(*testNames, arg);
		}
	}
	this_allocation_is_not_a_leak(testNames.data);

	#if WASM {
		#assert(FREE_MEMORY_DEBUG==false); // set FREE_MEMORY_DEBUG :: false in config.jai
	} else {
		#assert(FREE_MEMORY_DEBUG==true); // set FREE_MEMORY_DEBUG :: true in config.jai
	}
	windowCreated:bool = false;
	testOptions:TestProcedureOptions;

	testsCount := 0;
	for test,i: NAMED_PROCEDURES {
		found :bool= testNames.count == 0 || array_find(testNames, test.name);
		if found {
			if test.requiresWindow && windowCreated==false {
				testOptions.window_size = windowInit();
				windowCreated = true;
			}
			print("% TEST: %\n", tprintGreen(" "),test.name);
			test.proc(testOptions);
			testsCount += 1;
			reset_temporary_storage();
		} else {
			print("% TEST SKIPPED: %\n", tprintYellow(" "),test.name);
		}
	}

	print("---------TEST COMPLETED: (%)\n", testsCount);
}

test :: (name: string, procedure: TestProcedure) {
	_ensure_test_name_is_unique(name);
	//
	array_add(*NAMED_PROCEDURES_COMPILE_TIME, .{name=name, proc=procedure, requiresWindow=false});
}
testWithWindow :: (name: string, procedure: TestProcedure) {
	_ensure_test_name_is_unique(name);
	//
	array_add(*NAMED_PROCEDURES_COMPILE_TIME, .{name=name, proc=procedure, requiresWindow=true});
}

TestProcedureOptions :: struct {
	window_size: Vector2UInt;
}
TestProcedure :: #type (options: TestProcedureOptions) -> ();

NamedProcedure :: struct {
	name: string;
	proc: TestProcedure;
	requiresWindow: bool;
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

