#load "runtime/_index.jai";
#load "editor/_index.jai";


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

	testsCount := 0;
	for test,i: NAMED_PROCEDURES {
		found :bool= testNames.count == 0 || array_find(testNames, test.name);
		if found {
			print("TEST: %\n", test.name);
			test.proc();
			testsCount += 1;
		} else {
			print("TEST SKIPPED: %\n", test.name);
		}
	}

	print("---------TEST COMPLETED: (%)\n", testsCount);
}

#scope_file

SimpleProcedure :: #type () -> ();

NamedProcedure :: struct {
	name: string;
	proc: SimpleProcedure;
}

NAMED_PROCEDURES :[]NamedProcedure: #run getNamedProcedures();

getNamedProcedures :: ()->[..]NamedProcedure {
	list: [..]NamedProcedure;

	addTest :: ($code: Code) #expand {
		array_add(*list, namedProcedure(code));
	}
	// runtime
	addTest(testArray);
	addTest(testBitArray);
	addTest(testCoreGraph);
	addTest(testMath);
	addTest(testNodesBasicDependency);
	addTest(testPerlinNoise);
	// editor
	addTest(testNetworkPanel);

	return list;
}

namedProcedure :: ($code: Code) -> NamedProcedure {
	root, expressions := compiler_get_nodes(code);
	for expression, i: expressions {
		if expression.kind == .PROCEDURE_HEADER {
			header := cast(*Code_Procedure_Header) expression;
			return .{
				name = header.name,
				proc = #insert code
			};
		}
	}
	
	assert(false, "NO PROCEDURE FOUND");
	return .{
		name = "unknown",
		proc = (){}
	};
}

