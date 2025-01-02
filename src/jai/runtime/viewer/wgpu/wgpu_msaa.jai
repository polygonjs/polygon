

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
	// size := rendererTargetSize(renderer);
	using renderer.wgpuContext;
	size := windowSize;
	// width := wgpu_texture_get_width_surface(renderer.wgpuContext);
	// height := wgpu_texture_get_height_surface(renderer.wgpuContext);
	// size := renderer_size(renderer);

	if( multisampleTexture != null){
		if(
			wgpuTextureGetWidth(multisampleTexture) == size.x &&
			wgpuTextureGetHeight(multisampleTexture) == size.y
		){
			return;
		}
		wgpuTextureRelease(multisampleTexture);
	}
	if( renderer.use_msaa == false ){
		return;
	}

	// texture_descriptor := *renderer.multisample_texture_descriptor;
	// texture_descriptor.size = .{
	// 	width = xx size.x,
	// 	height = xx size.y,
	// 	depthOrArrayLayers = 1
	// };
	// textureDescriptor.sampleCount = MULTISAMPLE_SAMPLES_COUNT;
	// texture_descriptor.format = renderer.wgpuContext.preferred_texture_format;
	// texture_descriptor.usage = xx WGPUTextureUsage.RenderAttachment;
	// texture_descriptor.dimension = WGPUTextureDimension._2D;
	// texture_descriptor.mipLevelCount = 1;

	textureDescriptor :WGPUTextureDescriptor = .{
		size = .{
			width = xx size.x,
			height = xx size.y,
			depthOrArrayLayers = 1
		},
		sampleCount = MULTISAMPLE_SAMPLES_COUNT,
		format = preferred_texture_format,
		usage = xx WGPUTextureUsage.RenderAttachment,
		dimension = WGPUTextureDimension._2D,
		mipLevelCount = 1,
	};

	multisampleTexture = wgpuDeviceCreateTexture(device, *textureDescriptor);

	MULTISAMPLE_TEXTURE_VIEW_DESCRIPTOR.format = preferred_texture_format;
	multisampleTextureView = wgpuTextureCreateView(multisampleTexture, *MULTISAMPLE_TEXTURE_VIEW_DESCRIPTOR);
}

MULTISAMPLE_SAMPLES_COUNT :: 4;
MULTISAMPLE_TEXTURE_VIEW_DESCRIPTOR :WGPUTextureViewDescriptor= .{
	mipLevelCount = 1,
	arrayLayerCount = 1,
	dimension = WGPUTextureViewDimension._2D,
};


// multisample_release :: (renderer: *Renderer) {
// 	if( renderer.use_msaa && renderer.multisample_texture_view != null ) {
// 		wgpuTextureViewRelease(renderer.multisample_texture_view);
// 	}
// }

updateRenderPassDescriptorMultisample :: (
	renderer: *Renderer,
	colorAttachment: *WGPURenderPassColorAttachment,
	frame: WGPUTextureView
) #expand {
	if( renderer.use_msaa == true){
		// wgpuContext := renderer.wgpuContext;
		// if(colorAttachment.view){
		// 	wgpuTextureViewRelease((<<colorAttachment).view);
		// }
		colorAttachment.view = renderer.wgpuContext.multisampleTextureView;
		colorAttachment.resolveTarget = frame;
	} else {
		colorAttachment.view = frame;
	}
}