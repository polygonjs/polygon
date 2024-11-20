
main :: () {

	// Declare a Flat_Pool as so:
	pool: Flat_Pool;

	// You do not have to call init() to start using it:
	memory := cast(*u8) get(*pool, 100);  // Get 100 bytes.

	// ... Here, you would do something with 'memory'.
	for 0..99 memory[it] = xx it;

	Thing :: struct {
		name := "A Thing";
		value := 42.0;
	}

	// We can also use Flat_Pool_Allocator:
	a: Allocator;
	a.proc = flat_pool_allocator_proc;
	a.data = *pool;
	thing := New(Thing,, a);

	print("(1) 'thing' is: %\n", <<thing);

	// Call reset() to reclaim the memory. You would do this perhaps once per frame,
	// or, generally just when you want to free all previous allocations in the Pool.

	// You can pass overwrite_memory=true to help ensure you do not have use-after-free
	// bugs that take a long time to detect. This will cost some performance so maybe
	// you only want to do it in Debug builds.

	reset(*pool, overwrite_memory=true);

	// If we were to print <<thing now, we would crash, or see garbage, because
	// the memory of 'thing' has been overwritten -- but a hard crash is good in this case
	// since it tells us we have a problem (it is much better than a subtle bug living on
	// for a long time in a program that appears to work, because you fix the crash and now
	// you no longer have a problem). Uncomment to see the problem:

	print("(2) 'thing' is: %\n", <<thing);


	// If you want to release a Flat_Pool, including returning all its resources to the
	// operating system, call fini(). However, you don't need to do this if your program
	// is just going to exit -- your OS will take care of it anyway, and if you call fini()
	// you are just being slow. We're doing it here just to show the example:

	fini(*pool);
}

#import "Basic";
#import "Flat_Pool";
