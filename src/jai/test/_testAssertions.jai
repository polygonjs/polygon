
ASSERTIONS_COUNT :u32= 0;


assertEqual :: (actual: $T, expected: T, name: string="assertEqual") {
	if(actual != expected) {
		print("actual='%', expected='%', (%)\n", actual, expected, name);
		setFailedAssertion(name);
	}
	ASSERTIONS_COUNT += 1;
}
assertNotEqual ::  (actual: $T, expected: T, name: string="assertNotEqual") {
	if(actual == expected) {
		print("actual: %\n", actual);
		print("expected: %\n", expected);
		setFailedAssertion(name);
	}
	ASSERTIONS_COUNT += 1;
}

assertTrue :: (actual: $T, name: string="assertTrue") {
	if(actual != true) {
		print("% is not true\n", actual);
		setFailedAssertion(name);
	}
	ASSERTIONS_COUNT += 1;
}
assertFalse :: (actual: $T, name: string="assertFalse") {
	if(actual != false) {
		print("% is not false\n", actual);
		setFailedAssertion(name);
	}
	ASSERTIONS_COUNT += 1;
}
assertInDelta :: (actual: $T, expected: T, name: string="assertInDelta") {
	assertInDelta(actual, expected, EPS, name);
}
assertInDelta :: (actual: $T, expected: T, eps:float, name: string="assertInDelta") {
	delta := actual - expected;
	if(delta < -eps || delta > eps) {
		print("actual: %\n", actual);
		print("expected: %\n", expected);
		setFailedAssertion(name);
	}
	ASSERTIONS_COUNT += 1;
}
assertMoreThan ::  (current_value: $T, comparison: T, name: string="assertMoreThan") {
	if(current_value <= comparison) {
		print("current_value: %\n", current_value);
		print("comparison: %\n", comparison);
		setFailedAssertion(name);
	}
	ASSERTIONS_COUNT += 1;
}
assertLessThan ::  (current_value: $T, comparison: T, name: string="assertLessThan") {
	if(current_value >= comparison) {
		print("current_value: %\n", current_value);
		print("comparison: %\n", comparison);
		setFailedAssertion(name);
	}
	ASSERTIONS_COUNT += 1;
}
assertNull :: (ptr: *$T, name: string="assertNull") {
	if(ptr != null) {
		setFailedAssertion(name);
	}
	ASSERTIONS_COUNT += 1;
}
assertNotNull :: (ptr: *$T, name: string="assertNotNull") {
	if(ptr == null) {
		setFailedAssertion(name);
	}
	ASSERTIONS_COUNT += 1;
}

#if FREE_MEMORY_DEBUG {

	MemoryLeakCount :: struct {
		bytes_total:s64=0;
		leaks_total:s64=0;
	}

	assertLeaksCount :: (expectedCount:s64, message:string="no message") {
		report := make_leak_report();
		defer deinit(*report);
		count := reportLeaksCount(*report);

		if expectedCount != count.leaks_total {
			log_leak_report(report, .{});
			setFailedAssertion(tprint("leaks count mismatch: expected=%, leaks_total=%, bytes_total=% (%)", expectedCount, count.leaks_total, count.bytes_total, message));
		}
	}
	assertLeaksCount :: (expectedCounts:[]s64, message:string="no message") {
		report := make_leak_report();
		defer deinit(*report);
		count := reportLeaksCount(*report);

		matches_at_least_one := false;
		for expectedCount: expectedCounts {
			if expectedCount == count.leaks_total {
				matches_at_least_one = true;
				break;
			}
		}

		if !matches_at_least_one {
			log_leak_report(report, .{});
			setFailedAssertion(tprint("leaks count mismatch: expected=%, leaks_total=%, bytes_total=% (%)", expectedCounts, count.leaks_total, count.bytes_total, message));
		}
	}
	assertLeaksCountBetween :: (min:s64, max:s64, message:string="no message") {
		report := make_leak_report();
		defer deinit(*report);
		count := reportLeaksCount(*report);

		if count.leaks_total < min || count.leaks_total > max {
			log_leak_report(report, .{});
			setFailedAssertion(tprint("leaks count mismatch: min=%, max=%, leaks_total=%, bytes_total=% (%)", min, max, count.leaks_total, count.bytes_total, message));
		}
	}

	reportLeaksCount :: (report: *Leak_Report)->MemoryLeakCount {
		count :MemoryLeakCount;
		for summary: report.sorted_summaries {
			count.bytes_total += summary.bytes;
			count.leaks_total += summary.count;

			count.bytes_total += summary.child_bytes;
			count.leaks_total += summary.child_count;
		}
		return count;
	}

} else {
	assertLeaksCount :: (expectedCount:s64, message:string="no message") { }
	assertLeaksCount :: (expectedCounts:[]s64, message:string="no message") { }
	assertLeaksCountBetween :: (min:s64, max:s64, message:string="no message") { }
}


#scope_file

EPS :: 0.00001;

