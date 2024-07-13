MULTISAMPLE_SAMPLES_COUNT :: 4;

update_pipeline_descriptor_multisample :: (pipeline_descriptor: *wgpu.RenderPipelineDescriptor, multisample: bool) {
	if( multisample ){
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

create_multi_sample_texture_if_needed :: (
	device: wgpu.Device,
	surface_texture: *wgpu.SurfaceTexture,
	format :wgpu.TextureFormat,
	texture_descriptor: *wgpu.TextureDescriptor,
	multisample: bool
) -> wgpu.Texture {

	
	width := wgpu.TextureGetWidth(surface_texture.texture);
	height := wgpu.TextureGetHeight(surface_texture.texture);
	texture_descriptor.size = .{
		width = width,
		height = height,
		depthOrArrayLayers = 1
	};
	texture_descriptor.sampleCount = MULTISAMPLE_SAMPLES_COUNT;
	texture_descriptor.format = format;
	texture_descriptor.usage = xx wgpu.TextureUsage.RenderAttachment;
	texture_descriptor.dimension = wgpu.TextureDimension._2D;
	texture_descriptor.mipLevelCount = 1;
	texture := wgpu.DeviceCreateTexture(device, texture_descriptor);

	return texture;
}

multisample_texture_view_descriptor := wgpu.TextureViewDescriptor.{
	mipLevelCount = 1,
	arrayLayerCount = 1,
};
update_render_pass_descriptor_multisample :: (
	colorAttachment: *wgpu.RenderPassColorAttachment,
	frame: *wgpu.TextureView,
	format :wgpu.TextureFormat,
	multisample_texture: *wgpu.Texture,
	multisample: bool
) -> wgpu.TextureView #expand {
	if( multisample == true){
		// if(colorAttachment.view){
		// 	wgpu.TextureViewRelease((<<colorAttachment).view);
		// }
		multisample_texture_view_descriptor.format = format;
		texture_view := wgpu.TextureCreateView(<<multisample_texture, *multisample_texture_view_descriptor);
		colorAttachment.view = texture_view;
		colorAttachment.resolveTarget = <<frame;
		return texture_view;
	} else {
		colorAttachment.view = <<frame;
	}
}
