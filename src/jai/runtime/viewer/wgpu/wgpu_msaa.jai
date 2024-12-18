MULTISAMPLE_SAMPLES_COUNT :: 4;

wgpu_update_pipeline_descriptor_multisample :: (renderer: *Renderer, pipeline_descriptor: *WGPURenderPipelineDescriptor) {
	if( renderer.use_msaa ){
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

create_multi_sample_texture_if_needed :: ( renderer: *Renderer )  {
	assert(renderer.wgpuContext!=null, "renderer.wgpuContext is null\n");
	size := rendererTargetSize(renderer);
	// width := wgpu_texture_get_width_surface(renderer.wgpuContext);
	// height := wgpu_texture_get_height_surface(renderer.wgpuContext);
	// size := renderer_size(renderer);

	if( renderer.multisample_texture != null){
		if(
			wgpuTextureGetWidth(renderer.multisample_texture) == size.x &&
			wgpuTextureGetHeight(renderer.multisample_texture) == size.y
		){
			return;
		}
		wgpuTextureRelease(renderer.multisample_texture);
	}
	if( renderer.use_msaa == false ){
		return;
	}

	texture_descriptor := *renderer.multisample_texture_descriptor;
	texture_descriptor.size = .{
		width = xx size.x,
		height = xx size.y,
		depthOrArrayLayers = 1
	};
	texture_descriptor.sampleCount = MULTISAMPLE_SAMPLES_COUNT;
	texture_descriptor.format = renderer.wgpuContext.preferred_texture_format;
	texture_descriptor.usage = xx WGPUTextureUsage.RenderAttachment;
	texture_descriptor.dimension = WGPUTextureDimension._2D;
	texture_descriptor.mipLevelCount = 1;
	renderer.multisample_texture = wgpuDeviceCreateTexture(renderer.wgpuContext.device, texture_descriptor);

	multisample_texture_view_descriptor.format = renderer.wgpuContext.preferred_texture_format;
	multisample_texture_view_descriptor.dimension = WGPUTextureViewDimension._2D;
	renderer.multisample_texture_view = wgpuTextureCreateView(renderer.multisample_texture, *multisample_texture_view_descriptor);
}

multisample_texture_view_descriptor := WGPUTextureViewDescriptor.{
	mipLevelCount = 1,
	arrayLayerCount = 1,
};


// multisample_release :: (renderer: *Renderer) {
// 	if( renderer.use_msaa && renderer.multisample_texture_view != null ) {
// 		wgpuTextureViewRelease(renderer.multisample_texture_view);
// 	}
// }

update_render_pass_descriptor_multisample :: (
	renderer: *Renderer,
	colorAttachment: *WGPURenderPassColorAttachment,
	frame: *WGPUTextureView
) #expand {
	if( renderer.use_msaa == true){
		// wgpuContext := renderer.wgpuContext;
		// if(colorAttachment.view){
		// 	wgpuTextureViewRelease((<<colorAttachment).view);
		// }
		colorAttachment.view = renderer.multisample_texture_view;
		colorAttachment.resolveTarget = <<frame;
	} else {
		colorAttachment.view = <<frame;
	}
}