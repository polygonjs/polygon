


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

	testsCount := 0;
	for test,i: NAMED_PROCEDURES {
		found :bool= testNames.count == 0 || array_find(testNames, test.name);
		if found {
			print("% TEST: %\n", tprintGreen(" "),test.name);
			test.proc();
			testsCount += 1;
		} else {
			print("% TEST SKIPPED: %\n", tprintYellow(" "),test.name);
		}
	}

	print("---------TEST COMPLETED: (%)\n", testsCount);
}

test :: (name: string, procedure: SimpleProcedure) {
	// ensure we don't already have a test with this name
	for test,i: NAMED_PROCEDURES_COMPILE_TIME {
		if test.name == name {
			assert(false, tprint("TEST NAME ALREADY EXISTS (%)", test.name));
		}
	}
	//
	array_add(*NAMED_PROCEDURES_COMPILE_TIME, .{name, procedure});
}

SimpleProcedure :: #type () -> ();

NamedProcedure :: struct {
	name: string;
	proc: SimpleProcedure;
}

NAMED_PROCEDURES_COMPILE_TIME :[..]NamedProcedure;

#scope_file


NAMED_PROCEDURES :[]NamedProcedure: #run registerTests();


