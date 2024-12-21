#import "Basic";

N :: #run () -> int {
	sum := 0;
	for i: 1..100000000 {
		sum += i;
	}
	// print("%\n", sum);
	return sum;
}();

main :: () {
	print("%\n", N);
}