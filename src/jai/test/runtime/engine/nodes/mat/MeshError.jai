testMeshErrorMaterial :: () {

	testHeadless("mat/MeshError", (using options:TestProcedureOptions) {
		MIN_EXPECTED_ERROR_SIZE :: 12;
		mat: MeshErrorMaterial;
		materialInit(*mat);

		wgpuDevicePushErrorScope(editor.wgpuContext.device, .Validation);
		materialCreateModule(*editor.wgpuContext, xx *mat);
		wgpuDevicePopErrorScope(editor.wgpuContext.device, onCapturedError, *editor.wgpuContext);

		#if WASM {
			setOnPopErrorScopeCompletedCallback(*editor.wgpuContext, (errorSize:u64){
				assertMoreThan(errorSize, MIN_EXPECTED_ERROR_SIZE);

				endTest();
			});
		} else {
			assertMoreThan(editor.wgpuContext.capturedError.count, MIN_EXPECTED_ERROR_SIZE);
			endTest();
		}

	});

}
