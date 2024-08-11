



wgpu_texture_get_width_surface :: (wgpu_context: *WGPUContext) -> u32 {
	return wgpuTextureGetWidth(wgpu_context.surface_texture.texture);
}
wgpu_texture_get_height_surface :: (wgpu_context: *WGPUContext) -> u32 {
	return wgpuTextureGetHeight(wgpu_context.surface_texture.texture);
}

wgpu_surface_create_current_view :: (wgpu_context: *WGPUContext) -> WGPUTextureView {
	wgpuSurfaceGetCurrentTexture(wgpu_context.surface, *(wgpu_context.surface_texture));
	current_view_descriptor := WGPUTextureViewDescriptor.{
		format = wgpu_context.preferred_texture_format,
		dimension = WGPUTextureViewDimension._2D,
		aspect = WGPUTextureAspect.All,
		baseMipLevel = 0,
		mipLevelCount = 1,
		baseArrayLayer = 0,
		arrayLayerCount = 1,
	};
	return wgpuTextureCreateView(wgpu_context.surface_texture.texture, *current_view_descriptor);
}
