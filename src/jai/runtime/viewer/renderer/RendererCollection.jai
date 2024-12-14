RenderCollectionData :: struct {
	queue: WGPUQueue;
	frame: WGPUTextureView;
}

rendererCollectionStart :: (wgpuContext:*WGPUContext) -> RenderCollectionData {
	frame := wgpu_surface_create_current_view( wgpuContext );

	#if WASM {
		queue := wgpuContext.queue;
	} else {
		queue := wgpuDeviceGetQueue(wgpuContext.device);
		assert(queue != null, "Queue is not created correctly");
	}


	return .{queue, frame};
}


rendererCollectionEnd :: (wgpuContext:*WGPUContext, data: RenderCollectionData) {
	defer wgpuTextureViewRelease(data.frame);

	#if WASM {
		wgpuTextureRelease(wgpuContext.surface_texture.texture);
	} else {
		if wgpuContext.mode != .HEADLESS {
			wgpuSurfacePresent(wgpuContext.surface);
			wgpuTextureRelease(wgpuContext.surface_texture.texture);
		}
	}

}