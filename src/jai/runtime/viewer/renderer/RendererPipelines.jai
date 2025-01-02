
rendererInitPipelines :: (renderer:*Renderer, scene:*Scene, camera:*CameraAny){

	// #if WASM==true context = call_from_wasm_context;
	// device := renderer.wgpuContext.device;
	// #if WASM==true {
	// 	queue := renderer.wgpuContext.queue;
	// } else {
	// 	queue := wgpuDeviceGetQueue(renderer.wgpuContext.device);
	// 	assert(queue != null, "Queue is not created correctly");
	// }
	{
		push_allocator(renderer.allocator);
		init(*renderer.pipelines_by_mat_type, 1);
	}
	renderer_scene_uniform_buffer_create(renderer, scene);
	renderer_camera_uniform_buffer_create(renderer, camera);

	rendererCameraUpdateMatrix(renderer, camera);

	rendererAddBackgroundMesh(renderer);
	
	// for object: scene.children {
	// 	rendererObjectAdd(renderer, object);
	// }
	// print("rendererInitPipelines\n");
	// for pc: renderer.pipelines_by_mat_type {
	// 	// pipeline_controller_init(pc, renderer, renderer.wgpuContext, "render meshes 2");

	// 	compute_initialized := false;
	// 	for mesh: pc.meshes {
	// 		if compute_initialized==false && mesh.use_compute {
	// 			compute_initialized=true;
	// 			renderer.computes = compute_controller_collection_create(renderer.wgpuContext, scene);
	// 			pipeline_controller_update(pc, *renderer.computes);
	// 		}
	// 	}
	// }
}