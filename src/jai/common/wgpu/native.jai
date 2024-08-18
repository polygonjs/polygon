



wgpu_texture_get_width_surface :: (wgpu_context: *WGPUContext) -> u32 {
	return wgpuTextureGetWidth(wgpu_context.surface_texture.texture);
}
wgpu_texture_get_height_surface :: (wgpu_context: *WGPUContext) -> u32 {
	return wgpuTextureGetHeight(wgpu_context.surface_texture.texture);
}

