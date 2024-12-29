

allocatorAssign :: (target: *$T) {
	target.allocator.proc = pool_allocator_proc;
	target.allocator.data = *target.pool;
	set_allocators(*target.pool);
}




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

poolUsedMemory :: (using pool: *Pool) -> (usedMemory:s64, blocksCount:s64) {
	nextMemBlock := used_memblocks;
	blocksCount :s64= 0;
	while nextMemBlock != null {
		blocksCount += 1;
		nextMemBlock = nextMemBlock.next;
	}
	return memblock_size*blocksCount, blocksCount;
}
