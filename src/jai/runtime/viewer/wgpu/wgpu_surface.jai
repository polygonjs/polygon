
ShadersContainer :: struct {
	render: string;
	compute_box: string;
	compute_offset: string;
}
UniformBindingIndex :: enum u8 {
	SCENE :: 0;
	CAMERA :: 1;
	OBJECT :: 2;
	MATERIAL :: 3;
};

wgpu_surface_create_current_view :: (wgpu_context: *WGPUContext) -> WGPUTextureView {
	current_view_descriptor := WGPUTextureViewDescriptor.{
		format = wgpu_context.preferred_texture_format,
		dimension = WGPUTextureViewDimension._2D,
		aspect = WGPUTextureAspect.All,
		baseMipLevel = 0,
		mipLevelCount = 1,
		baseArrayLayer = 0,
		arrayLayerCount = 1,
	};
	#if WASM {
		wgpu_context.surface_texture.texture = wgpuSurfaceGetCurrentTexture();
		return wgpuTextureCreateView(wgpu_context.surface_texture.texture, *current_view_descriptor);
	} else {
		if wgpu_context.mode == .SURFACE {
			wgpuSurfaceGetCurrentTexture(wgpu_context.surface, *(wgpu_context.surface_texture));
			return wgpuTextureCreateView(wgpu_context.surface_texture.texture, *current_view_descriptor);
		} else {
			return wgpuTextureCreateView(wgpu_context.surface_texture.texture, *current_view_descriptor);
		}
	}
}

