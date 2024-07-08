MULTISAMPLE_SAMPLES_COUNT :: 4;

update_pipeline_descriptor_multisample :: (pipeline_descriptor: *wgpu.RenderPipelineDescriptor, multisample: bool) {
	if( multisample ){
		pipeline_descriptor.multisample = .{
			count = MULTISAMPLE_SAMPLES_COUNT,
			mask = 1,
			alphaToCoverageEnabled = true,
		};
	} else {
		pipeline_descriptor.multisample = .{
			count = 1,
			mask = 1,
			alphaToCoverageEnabled = false,
		};
	}
}

create_multi_sample_texture_if_needed :: (
	device: wgpu.Device,
	swap_chain_descriptor: *wgpu.SwapChainDescriptor,
	texture_descriptor: *wgpu.TextureDescriptor,
	multisample: bool
) -> wgpu.Texture {

	texture_descriptor.size = .{
		width = swap_chain_descriptor.width,
		height = swap_chain_descriptor.height,
		depthOrArrayLayers = 1
	};
	texture_descriptor.sampleCount = MULTISAMPLE_SAMPLES_COUNT;
	texture_descriptor.format = swap_chain_descriptor.format;
	texture_descriptor.usage = xx wgpu.TextureUsage.RenderAttachment;
	texture_descriptor.dimension = wgpu.TextureDimension._2D;
	texture_descriptor.mipLevelCount = 1;
	texture := wgpu.DeviceCreateTexture(device, texture_descriptor);

	return texture;
}


update_render_pass_descriptor_multisample :: (
	colorAttachment: *wgpu.RenderPassColorAttachment,
	swap_chain_descriptor: *wgpu.SwapChainDescriptor,
	current_view: *wgpu.TextureView,
	texture: *wgpu.Texture,
	multisample: bool
) #expand {
	if( multisample == true){
		// if(colorAttachment.view){
		// 	wgpu.TextureViewRelease((<<colorAttachment).view);
		// }
		multisample_texture_view_descriptor := wgpu.TextureViewDescriptor.{
			mipLevelCount = 1,
			arrayLayerCount = 1,
		};
		
		multisample_texture_view_descriptor.format = swap_chain_descriptor.format;
		texture_view := wgpu.TextureCreateView(<<texture, *multisample_texture_view_descriptor);
		colorAttachment.view = texture_view;
		colorAttachment.resolveTarget = <<current_view;
	} else {
		colorAttachment.view = <<current_view;
	}
}
