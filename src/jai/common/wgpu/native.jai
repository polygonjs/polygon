

wgpu_create_shader_module :: (device: WGPUDevice, source: string, label :string) -> WGPUShaderModule {
	wgslDescriptor: WGPUShaderModuleWGSLDescriptor;
	wgslDescriptor.chain.next = null;
	wgslDescriptor.chain.sType=.ShaderModuleWGSLDescriptor;
	wgslDescriptor.code = to_c_string(source);
	#if FREE_MEMORY defer free(wgslDescriptor.code);

	shaderModuleDescriptor: WGPUShaderModuleDescriptor;
	shaderModuleDescriptor.label = to_c_string(label);
	#if FREE_MEMORY defer free(shaderModuleDescriptor.label);
	shaderModuleDescriptor.nextInChain = xx *wgslDescriptor;
	shader_module := wgpuDeviceCreateShaderModule(device, *shaderModuleDescriptor);


	return shader_module;
}


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
