testMeshNormalMaterial :: () {

	testHeadless("mat/MeshNormal", (using options:TestProcedureOptions) {
		mat: MeshNormalMaterial;
		materialInit(*mat);

		wgpuDevicePushErrorScope(editor.wgpuContext.device, .Validation);
		materialCreateModule(*editor.wgpuContext, xx *mat);
		wgpuDevicePopErrorScope(editor.wgpuContext.device, onCapturedError, *editor.wgpuContext);

		#if WASM {
			setOnPopErrorScopeCompletedCallback(*editor.wgpuContext, (errorSize:u64){
				assertEqual(errorSize, 0);

				endTest();
			});
		} else {
			assertEqual(editor.wgpuContext.capturedError.count, 0);
			endTest();
		}
	});

}
