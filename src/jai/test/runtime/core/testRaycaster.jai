testRaycaster :: (){
	test("testRaycaster",(options:TestProcedureOptions) {
		sceneWorld := newScene(temp);
		camera := newObject3D(sceneWorld, OrthographicCamera);
		camera.aspect = 1;
		camera.near = 0;
		camera.far = 100;

		camera.position = .{5,10,2};
		sceneObjectUpdateMatrix(sceneWorld, camera);
		cameraProjectionUpdate(camera);

		raycaster: Raycaster;
		raycasterSetFromCamera(*raycaster, camera, .{0,0});

		assertEqual(raycaster.ray.origin.x, 5);
		assertEqual(raycaster.ray.origin.y, 10);
	});
}
