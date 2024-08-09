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