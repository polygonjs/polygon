
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

wgpu_surface_create_current_view :: (wgpuContext: *WGPUContext) -> WGPUTextureView {
	current_view_descriptor := WGPUTextureViewDescriptor.{
		format = wgpuContext.preferred_texture_format,
		dimension = WGPUTextureViewDimension._2D,
		aspect = WGPUTextureAspect.All,
		baseMipLevel = 0,
		mipLevelCount = 1,
		baseArrayLayer = 0,
		arrayLayerCount = 1,
	};
	#if WASM {
		wgpuContext.surface_texture.texture = wgpuSurfaceGetCurrentTexture();
		return wgpuTextureCreateView(wgpuContext.surface_texture.texture, *current_view_descriptor);
	} else {
		if wgpuContext.mode == .SURFACE {
			wgpuSurfaceGetCurrentTexture(wgpuContext.surface, *(wgpuContext.surface_texture));
			return wgpuTextureCreateView(wgpuContext.surface_texture.texture, *current_view_descriptor);
		} else {
			return wgpuTextureCreateView(wgpuContext.surface_texture.texture, *current_view_descriptor);
		}
	}
}

