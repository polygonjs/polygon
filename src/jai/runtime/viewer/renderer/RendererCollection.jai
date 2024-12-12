RenderCollectionData :: struct {
	queue: WGPUQueue;
	frame: WGPUTextureView;
}

rendererCollectionStart :: (wgpu_context:*WGPUContext) -> RenderCollectionData {
	frame := wgpu_surface_create_current_view( wgpu_context );

	#if WASM {
		queue := wgpu_context.queue;
	} else {
		queue := wgpuDeviceGetQueue(wgpu_context.device);
		assert(queue != null, "Queue is not created correctly");
	}


	return .{queue, frame};
}


rendererCollectionEnd :: (wgpu_context:*WGPUContext, data: RenderCollectionData) {
	defer wgpuTextureViewRelease(data.frame);

	#if WASM {
		wgpuTextureRelease(wgpu_context.surface_texture.texture);
	} else {
		if wgpu_context.mode != .HEADLESS {
			wgpuSurfacePresent(wgpu_context.surface);
			wgpuTextureRelease(wgpu_context.surface_texture.texture);
		}
	}

}