allocatorAssign :: (target: *$T) {
	#if USE_FLAT_POOL {
		pool:Flat_Pool;
		target.pool = pool;
		target.allocator.proc = flat_pool_allocator_proc;
		target.allocator.data = *target.pool;
	} else #if USE_POOL {
		pool:Pool;
		target.pool = pool;
		target.allocator.proc = pool_allocator_proc;
		target.allocator.data = *target.pool;
		set_allocators(*target.pool);
	} else {
		target.allocator = Context_Base.default_allocator;
	}
	// target.allocator = *get_unmapping_allocator();
}


allocatorReset :: (target: *$T) {
	#if USE_FLAT_POOL {
		// deinit_unmapping_allocator(a);
		reset(*target.pool, overwrite_memory=true);
		fini(*target.pool);
	} else #if USE_POOL {
		reset(*target.pool);
		release(*target.pool);
	} else {
		print("allocatorReset: no allocator\n");
	}
}