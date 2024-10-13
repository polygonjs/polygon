RenderCollectionData :: struct {
	queue:WGPUQueue;
	frame: WGPUTextureView;
}

renderer_collection_start :: (wgpu_context:*WGPUContext)->RenderCollectionData{
	frame := wgpu_surface_create_current_view( wgpu_context );

	#if WASM {
		queue := WGPU_CONTEXT.queue;
	} else {
		queue := wgpuDeviceGetQueue(WGPU_CONTEXT.device);
		assert(queue != null, "Queue is not created correctly");
	}

	create_multi_sample_texture_if_needed( wgpu_context );
	create_depth_texture_if_needed( wgpu_context );

	return .{queue, frame};
}


renderer_collection_end :: (wgpu_context:*WGPUContext, data: RenderCollectionData) {
	defer wgpuTextureViewRelease(data.frame);
	

	#if WASM == false {
		wgpuSurfacePresent(wgpu_context.surface);
	}
	wgpuTextureRelease(wgpu_context.surface_texture.texture);
	multisample_release(wgpu_context);
	depth_release(wgpu_context);
	#if USE_IMGUI imgui_gui_free();
	
}