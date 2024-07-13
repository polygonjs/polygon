MULTISAMPLE_SAMPLES_COUNT :: 4;

update_pipeline_descriptor_multisample :: (wgpu_config: *WGPUContext, pipeline_descriptor: *wgpu.RenderPipelineDescriptor) {
	if( (<<wgpu_config).use_msaa ){
		pipeline_descriptor.multisample = .{
			count = MULTISAMPLE_SAMPLES_COUNT,
			mask = 0xFFFFFFFF,
			alphaToCoverageEnabled = xx true,
		};
	} else {
		pipeline_descriptor.multisample = .{
			count = 1,
			mask = 0xFFFFFFFF,
			alphaToCoverageEnabled = xx false,
		};
	}
}

create_multi_sample_texture_if_needed :: ( wgpu_context: *WGPUContext )  {


	width := wgpu.TextureGetWidth(wgpu_context.surface_texture.texture);
	height := wgpu.TextureGetHeight(wgpu_context.surface_texture.texture);

	if( (<<wgpu_context).multisample_texture != null){
		if(
			wgpu.TextureGetWidth(wgpu_context.multisample_texture) == width &&
			wgpu.TextureGetHeight(wgpu_context.multisample_texture) == height
		){
			return;
		}
		wgpu.TextureRelease(wgpu_context.multisample_texture);
	}
	if( wgpu_context.use_msaa == false ){
		return;
	}

	texture_descriptor := *(<<wgpu_context).multisample_texture_descriptor;
	texture_descriptor.size = .{
		width = width,
		height = height,
		depthOrArrayLayers = 1
	};
	texture_descriptor.sampleCount = MULTISAMPLE_SAMPLES_COUNT;
	texture_descriptor.format = wgpu_context.preferred_texture_format;
	texture_descriptor.usage = xx wgpu.TextureUsage.RenderAttachment;
	texture_descriptor.dimension = wgpu.TextureDimension._2D;
	texture_descriptor.mipLevelCount = 1;
	wgpu_context.multisample_texture = wgpu.DeviceCreateTexture(wgpu_context.device, texture_descriptor);
}

multisample_texture_view_descriptor := wgpu.TextureViewDescriptor.{
	mipLevelCount = 1,
	arrayLayerCount = 1,
};
update_render_pass_descriptor_multisample :: (
	wgpu_context: *WGPUContext,
	colorAttachment: *wgpu.RenderPassColorAttachment,
	current_texture_view: *wgpu.TextureView
) #expand {
	if( wgpu_context.use_msaa == true){
		// if(colorAttachment.view){
		// 	wgpu.TextureViewRelease((<<colorAttachment).view);
		// }
		multisample_texture_view_descriptor.format = wgpu_context.preferred_texture_format;
		texture_view := wgpu.TextureCreateView(wgpu_context.multisample_texture, *multisample_texture_view_descriptor);
		colorAttachment.view = texture_view;
		colorAttachment.resolveTarget = <<current_texture_view;
		(<<wgpu_context).multisample_texture_view = *texture_view;
	} else {
		colorAttachment.view = <<current_texture_view;
	}
}

multisample_release :: (wgpu_context: *WGPUContext) {
	if( wgpu_context.use_msaa && wgpu_context.multisample_texture_view != null ) {
		wgpu.TextureViewRelease(<<(wgpu_context.multisample_texture_view));
	}
}