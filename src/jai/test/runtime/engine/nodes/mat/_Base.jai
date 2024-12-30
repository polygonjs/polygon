testBaseMatNode :: () {

	test("material members", (using options:TestProcedureOptions) {
		mat: MeshUVMaterial;

		assertEqual(size_of(type_of(mat)), 72, "material size");

		assertTrue(is_constant(mat.topology), "topology is constant");

		endTest();
	});

}
