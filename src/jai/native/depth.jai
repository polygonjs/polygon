DEPTH_TEXTURE_FORMAT :: wgpu.TextureFormat.Depth24Plus;
// DEPTH_STENCIL_STATE :: wgpu.DepthStencilState.{
// 	depthWriteEnabled = true,
// 	depthCompare = wgpu.CompareFunction.Less, //"less",
// 	format = DEPTH_TEXTURE_FORMAT,
// 	stencilReadMask = 0,
// 	stencilWriteMask = 0,
// };

stencil_face_state_set_default :: (stencil_face_state: *wgpu.StencilFaceState) {
	stencil_face_state.compare = wgpu.CompareFunction.Always;
	stencil_face_state.failOp = wgpu.StencilOperation.Keep;
	stencil_face_state.depthFailOp = wgpu.StencilOperation.Keep;
	stencil_face_state.passOp = wgpu.StencilOperation.Keep;
}

depth_stencil_state_set_default :: (depth_stencil_state: *wgpu.DepthStencilState) {
	depth_stencil_state.format = wgpu.TextureFormat.Undefined;
	depth_stencil_state.depthWriteEnabled = xx false;
	depth_stencil_state.depthCompare = wgpu.CompareFunction.Always;
	depth_stencil_state.stencilReadMask = 0xFFFFFFFF;
	depth_stencil_state.stencilWriteMask = 0xFFFFFFFF;
	depth_stencil_state.depthBias = 0;
	depth_stencil_state.depthBiasSlopeScale = 0;
	depth_stencil_state.depthBiasClamp = 0;
	stencil_face_state_set_default(*depth_stencil_state.stencilFront);
	stencil_face_state_set_default(*depth_stencil_state.stencilBack);
}

depth_stencil_state_prepare :: (depth_stencil_state: *wgpu.DepthStencilState) {
	depth_stencil_state_set_default(depth_stencil_state);
	depth_stencil_state.depthCompare = wgpu.CompareFunction.Less;
	depth_stencil_state.depthWriteEnabled = xx true;
	depth_stencil_state.format = DEPTH_TEXTURE_FORMAT;
	depth_stencil_state.stencilReadMask = 0;
	depth_stencil_state.stencilWriteMask = 0;
}


update_pipeline_descriptor_depth :: (wgpu_context:*WGPUContext, pipeline_descriptor: *wgpu.RenderPipelineDescriptor, depth_stencil_state: *wgpu.DepthStencilState) {
	if(wgpu_context.use_depth_buffer){
		depth_stencil_state_prepare(depth_stencil_state);
		pipeline_descriptor.depthStencil = depth_stencil_state;
	}else{
		pipeline_descriptor.depthStencil = null;
	}
}

DEPTH_VIEW_FORMATS := DEPTH_TEXTURE_FORMAT;
create_depth_texture_if_needed :: ( wgpu_context: *WGPUContext ) {

	width := wgpu.TextureGetWidth(wgpu_context.surface_texture.texture);
	height := wgpu.TextureGetHeight(wgpu_context.surface_texture.texture);

	// texture_create_required := (<<wgpu_context).depth_texture == null;
	if( (<<wgpu_context).depth_texture != null) {
		if(
			wgpu.TextureGetWidth(wgpu_context.depth_texture) == width &&
			wgpu.TextureGetHeight(wgpu_context.depth_texture) == height
		){
			return;
		}
		wgpu.TextureRelease(wgpu_context.depth_texture);
		// texture_create_required = true;
	}

	if( wgpu_context.use_depth_buffer == false ){
		return;
	}

	sampleCount :u32= xx (ifx wgpu_context.use_msaa then MULTISAMPLE_SAMPLES_COUNT else 1);
	texture_descriptor := wgpu.TextureDescriptor.{
		size = .{
			width = width,
			height = height,
			depthOrArrayLayers = 1
		},
		sampleCount = sampleCount,
		format = DEPTH_TEXTURE_FORMAT,
		usage = xx wgpu.TextureUsage.RenderAttachment,
		dimension = wgpu.TextureDimension._2D,
		mipLevelCount = 1,
		viewFormatCount = 1,
		viewFormats = *DEPTH_VIEW_FORMATS,
	};
	wgpu_context.depth_texture = wgpu.DeviceCreateTexture(wgpu_context.device, *texture_descriptor);
}

depth_texture_view_descriptor :: wgpu.TextureViewDescriptor.{
	mipLevelCount = 1,
	arrayLayerCount = 1,
	// format = DEPTH_TEXTURE_FORMAT,
};
update_render_pass_descriptor_depth :: (
	wgpu_context: *WGPUContext,
	render_pass_descriptor: *wgpu.RenderPassDescriptor
	// we need #expand here, to ensure that the pointer to depth_texture_stencil_attachment
	// remains in the caller stack
) #expand {
	// if(render_pass_descriptor.depthStencilAttachment.view){
	// 	wgpu.TextureViewRelease(render_pass_descriptor.depthStencilAttachment.view);
	// }

	if(wgpu_context.use_depth_buffer){
		
		texture_view := wgpu.TextureCreateView((<<wgpu_context).depth_texture, *depth_texture_view_descriptor);
		depth_texture_stencil_attachment := wgpu.RenderPassDepthStencilAttachment.{
			view = texture_view,
			depthClearValue = 1.0,
			depthLoadOp = wgpu.LoadOp.Clear, //"clear",
			depthStoreOp = wgpu.StoreOp.Store, //"store",
			depthReadOnly = xx false,
			stencilClearValue = 0,
			stencilLoadOp = wgpu.LoadOp.Clear,
			stencilStoreOp = wgpu.StoreOp.Store,
			stencilReadOnly = xx true,
		};
		render_pass_descriptor.depthStencilAttachment = *depth_texture_stencil_attachment;
		(<<wgpu_context).depth_texture_view = *texture_view;
	} else {
		render_pass_descriptor.depthStencilAttachment = null;
	}
}

depth_release :: (wgpu_context: *WGPUContext) {
	if( wgpu_context.depth_texture_view !=null ) {
		wgpu.TextureViewRelease(<<(wgpu_context.depth_texture_view));
	}
}