PoolsContainer :: struct {
	// count: u8 = 0;
	pools: [..]Pool;
}

nextPool :: () -> *Pool {
	using APP.poolsContainer;
	pools.count += 1;
	maybe_grow(*pools);

	index := pools.count-1;
	pool:Pool;
	pools[index] = pool;
	return *pools[index];
}
poolsContainerReset :: () {
	using APP.poolsContainer;
	array_reset(*pools);
}

allocatorAssign :: (target: *$T, pool: *Pool, $do_set_allocators:bool) {
	target.pool = pool;
	target.allocator.proc = pool_allocator_proc;
	target.allocator.data = *target.pool;
	#if do_set_allocators {
		set_allocators(*target.pool);
		// context.allocator = .{pool_allocator_proc, *target.pool};
	}
}

// allocatorAssign :: (target: *$T) {
// 	// print("--- allocatorAssign ---\n");
// 	// print_stack_trace(context.stack_trace);
// 	#if USE_FLAT_POOL {
// 		pool:Flat_Pool;
// 		target.pool = pool;
// 		target.allocator.proc = flat_pool_allocator_proc;
// 		target.allocator.data = *target.pool;
// 	} else #if USE_POOL {
// 		pool:Pool;
// 		allocatorAssign(target, *pool);
// 	} else {
// 		target.allocator = Context_Base.default_allocator;
// 	}
// 	// target.allocator = *get_unmapping_allocator();
// }


allocatorReset :: (target: *$T) {
	// print("--- allocatorReset ---\n");
	// print_stack_trace(context.stack_trace);
	#if USE_FLAT_POOL {
		// deinit_unmapping_allocator(a);
		reset(*target.pool, overwrite_memory=true);
		fini(*target.pool);
	} else #if USE_POOL {
		// #if FREE_MEMORY_DEBUG {
		// 	print("- target.pool.block_allocator: %\n", target.pool.block_allocator);
		// 	deinit_unmapping_allocator(target.pool.block_allocator);
		// }
		reset(*target.pool);
		release(*target.pool);
	} else {
		print("allocatorReset: no allocator\n");
	}
	// print("--- allocatorReset end ---\n");
}