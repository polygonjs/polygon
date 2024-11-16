
#if FREE_MEMORY_DEBUG {

	leaksCount :: ()->s64 {
		report := make_leak_report();
		defer deinit(*report);
		// bytes_total: s64;
		leaks_total: s64;
		for summary: report.sorted_summaries {
			// bytes_total += summary.bytes;
			leaks_total += summary.count;

			// bytes_total += summary.child_bytes;
			leaks_total += summary.child_count;
		}
		return leaks_total;
	}

}