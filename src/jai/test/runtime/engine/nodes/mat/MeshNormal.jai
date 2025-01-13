testMeshNormalMaterial :: () {

	testHeadless("mat/MeshNormal", (using options:TestProcedureOptions) {
		mat: MeshNormalMaterial;

		materialCreateModule(*editor.wgpuContext, *mat);

		endTest();
	});

}
