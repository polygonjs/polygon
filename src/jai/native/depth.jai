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


update_pipeline_descriptor_depth :: (pipeline_descriptor: *wgpu.RenderPipelineDescriptor, depth_stencil_state: *wgpu.DepthStencilState, do_depth:bool) {
	if(do_depth){
		depth_stencil_state_prepare(depth_stencil_state);
		pipeline_descriptor.depthStencil = depth_stencil_state;
	}else{
		pipeline_descriptor.depthStencil = null;
	}
}

create_depth_texture_if_needed :: (
	device: wgpu.Device,
	surface_texture: *wgpu.SurfaceTexture,
	viewFormats:*wgpu.TextureFormat,
	depth: bool,
	multisample: bool
) -> wgpu.Texture {

	width := wgpu.TextureGetWidth(surface_texture.texture);
	height := wgpu.TextureGetHeight(surface_texture.texture);
	sampleCount :u32= xx (ifx multisample then MULTISAMPLE_SAMPLES_COUNT else 1);
	texture_descriptor := wgpu.TextureDescriptor.{
		size = .{
			width =width,
			height = height,
			depthOrArrayLayers = 1
		},
		sampleCount = sampleCount,
		format = DEPTH_TEXTURE_FORMAT,
		usage = xx wgpu.TextureUsage.RenderAttachment,
		dimension = wgpu.TextureDimension._2D,
		mipLevelCount = 1,
		viewFormatCount = 1,
		viewFormats = viewFormats,
	};
	texture := wgpu.DeviceCreateTexture(device, *texture_descriptor);

	return texture;
}

depth_texture_view_descriptor :: wgpu.TextureViewDescriptor.{
	mipLevelCount = 1,
	arrayLayerCount = 1,
	// format = DEPTH_TEXTURE_FORMAT,
};
update_render_pass_descriptor_depth :: (
	render_pass_descriptor: *wgpu.RenderPassDescriptor,
	texture: *wgpu.Texture,
	depth:bool
	// we need #expand here, to ensure that the pointer to depth_texture_stencil_attachment
	// remains in the caller stack
) -> wgpu.TextureView #expand {
	// if(render_pass_descriptor.depthStencilAttachment.view){
	// 	wgpu.TextureViewRelease(render_pass_descriptor.depthStencilAttachment.view);
	// }

	if(depth){
		
		texture_view := wgpu.TextureCreateView(<<texture, *depth_texture_view_descriptor);
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
		return texture_view;
	} else {
		render_pass_descriptor.depthStencilAttachment = null;
	}
}
