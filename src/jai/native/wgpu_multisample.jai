MULTISAMPLE_SAMPLES_COUNT :: 4;

update_pipeline_descriptor_multisample :: (wgpu_config: *WGPUContext, pipeline_descriptor: *WGPURenderPipelineDescriptor) {
	if( (<<wgpu_config).use_msaa ){
		pipeline_descriptor.multisample = .{
			count = MULTISAMPLE_SAMPLES_COUNT,
			mask = U32_MAX,
			alphaToCoverageEnabled = xx true,
		};
	} else {
		pipeline_descriptor.multisample = .{
			count = 1,
			mask = U32_MAX,
			alphaToCoverageEnabled = xx false,
		};
	}
}

create_multi_sample_texture_if_needed :: ( wgpu_context: *WGPUContext )  {


	width := wgpuTextureGetWidth(wgpu_context.surface_texture.texture);
	height := wgpuTextureGetHeight(wgpu_context.surface_texture.texture);

	if( (<<wgpu_context).multisample_texture != null){
		if(
			wgpuTextureGetWidth(wgpu_context.multisample_texture) == width &&
			wgpuTextureGetHeight(wgpu_context.multisample_texture) == height
		){
			return;
		}
		wgpuTextureRelease(wgpu_context.multisample_texture);
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
	texture_descriptor.usage = xx WGPUTextureUsage.RenderAttachment;
	texture_descriptor.dimension = WGPUTextureDimension._2D;
	texture_descriptor.mipLevelCount = 1;
	wgpu_context.multisample_texture = wgpuDeviceCreateTexture(wgpu_context.device, texture_descriptor);
}

multisample_texture_view_descriptor := WGPUTextureViewDescriptor.{
	mipLevelCount = 1,
	arrayLayerCount = 1,
};
update_render_pass_descriptor_multisample :: (
	wgpu_context: *WGPUContext,
	colorAttachment: *WGPURenderPassColorAttachment,
	current_texture_view: *WGPUTextureView
) #expand {
	if( wgpu_context.use_msaa == true){
		// if(colorAttachment.view){
		// 	wgpuTextureViewRelease((<<colorAttachment).view);
		// }
		multisample_texture_view_descriptor.format = wgpu_context.preferred_texture_format;
		texture_view := wgpuTextureCreateView(wgpu_context.multisample_texture, *multisample_texture_view_descriptor);
		colorAttachment.view = texture_view;
		colorAttachment.resolveTarget = <<current_texture_view;
		(<<wgpu_context).multisample_texture_view = *texture_view;
	} else {
		colorAttachment.view = <<current_texture_view;
	}
}

multisample_release :: (wgpu_context: *WGPUContext) {
	if( wgpu_context.use_msaa && wgpu_context.multisample_texture_view != null ) {
		wgpuTextureViewRelease(<<(wgpu_context.multisample_texture_view));
	}
}