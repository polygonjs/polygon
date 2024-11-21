
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
			assert(expectedCount == count.leaks_total, tprint("leaks count mismatch: expected=%, leaks_total=%, bytes_total=% (%)", expectedCount, count.leaks_total, count.bytes_total, message));
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
			assert(false, tprint("leaks count mismatch: expected=%, leaks_total=%, bytes_total=% (%)", expectedCounts, count.leaks_total, count.bytes_total, message));
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

}