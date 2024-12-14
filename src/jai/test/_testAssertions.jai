
ASSERTIONS_COUNT :u32= 0;


assertEqual ::  (actual: $T, expected: T, name: string="assertEqual") {
	if(actual != expected) {
		print("actual: %, expected=%, (%)\n", actual, expected, name);
		assert(false, name);
	}
	ASSERTIONS_COUNT += 1;
}
assertNotEqual ::  (actual: $T, expected: T, name: string="assertNotEqual") {
	if(actual == expected) {
		print("actual: %\n", actual);
		print("expected: %\n", expected);
		assert(false, name);
	}
	ASSERTIONS_COUNT += 1;
}

assertTrue :: (actual: $T, name: string="assertTrue") {
	if(actual != true) {
		print("% is not true\n", actual);
		assert(false, name);
	}
	ASSERTIONS_COUNT += 1;
}
assertFalse :: (actual: $T, name: string="assertFalse") {
	if(actual != false) {
		print("% is not false\n", actual);
		assert(false, name);
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
		assert(false, name);
	}
	ASSERTIONS_COUNT += 1;
}
assertMoreThan ::  (current_value: $T, comparison: T, name: string) {
	if(current_value <= comparison) {
		print("current_value: %\n", current_value);
		print("comparison: %\n", comparison);
		assert(false, name);
	}
	ASSERTIONS_COUNT += 1;
}
assertLessThan ::  (current_value: $T, comparison: T, name: string) {
	if(current_value >= comparison) {
		print("current_value: %\n", current_value);
		print("comparison: %\n", comparison);
		assert(false, name);
	}
	ASSERTIONS_COUNT += 1;
}
assertNull :: (ptr: *$T, name: string="assertNull") {
	if(ptr != null) {
		assert(false, name);
	}
	ASSERTIONS_COUNT += 1;
}
assertNotNull :: (ptr: *$T, name: string="assertNotNull") {
	if(ptr == null) {
		assert(false, name);
	}
	ASSERTIONS_COUNT += 1;
}

#scope_file

EPS :: 0.00001;

