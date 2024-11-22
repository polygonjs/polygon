testPerlinNoise :: (){
	test("testPerlinNoise",(options:TestProcedureOptions) {
		assertInDelta(perlin_noise(-0.5, -0.395161, -0.5), -0.902709);
		assertInDelta(perlin_noise(1.2, 0, 0), 0.234752);
		assertInDelta(perlin_noise(1.2, 1.2, 0), 0.360373);
		assertInDelta(perlin_noise(1.2, 1.2, 1.5), -0.234204);
	});
}
