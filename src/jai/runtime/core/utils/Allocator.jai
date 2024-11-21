allocatorAssign :: (target: *$T) {
	flat_pool:Flat_Pool;
	target.pool = flat_pool;
	target.allocator.proc = flat_pool_allocator_proc;
	target.allocator.data = *target.pool;
	// target.allocator = *get_unmapping_allocator();
}


allocatorReset :: (target: *$T) {
	// deinit_unmapping_allocator(a);
	reset(*target.pool, overwrite_memory=true);
	fini(*target.pool);
}