RenderCollectionData :: struct {
	queue:WGPUQueue;
	frame: WGPUTextureView;
}

renderer_collection_start :: (wgpu_context:*WGPUContext)->RenderCollectionData {
	frame := wgpu_surface_create_current_view( wgpu_context );

	#if WASM {
		queue := wgpu_context.queue;
	} else {
		queue := wgpuDeviceGetQueue(wgpu_context.device);
		assert(queue != null, "Queue is not created correctly");
	}


	return .{queue, frame};
}


renderer_collection_end :: (wgpu_context:*WGPUContext, data: RenderCollectionData) {
	defer wgpuTextureViewRelease(data.frame);

	#if WASM == false {
		wgpuSurfacePresent(wgpu_context.surface);
	}
	wgpuTextureRelease(wgpu_context.surface_texture.texture);
	
	#if USE_IMGUI imgui_gui_free();
	
}