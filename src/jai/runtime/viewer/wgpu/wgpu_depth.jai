

stencil_face_state_set_default :: (stencil_face_state: *WGPUStencilFaceState) {
	stencil_face_state.compare = WGPUCompareFunction.Always;
	stencil_face_state.failOp = WGPUStencilOperation.Keep;
	stencil_face_state.depthFailOp = WGPUStencilOperation.Keep;
	stencil_face_state.passOp = WGPUStencilOperation.Keep;
}

depth_stencil_state_set_default :: (depth_stencil_state: *WGPUDepthStencilState) {
	depth_stencil_state.format = WGPUTextureFormat.Undefined;
	depth_stencil_state.depthWriteEnabled = xx false;
	depth_stencil_state.depthCompare = WGPUCompareFunction.Always;
	depth_stencil_state.stencilReadMask = 0xFFFFFFFF;
	depth_stencil_state.stencilWriteMask = 0xFFFFFFFF;
	depth_stencil_state.depthBias = 0;
	depth_stencil_state.depthBiasSlopeScale = 0;
	depth_stencil_state.depthBiasClamp = 0;
	stencil_face_state_set_default(*depth_stencil_state.stencilFront);
	stencil_face_state_set_default(*depth_stencil_state.stencilBack);
}


wgpu_update_pipeline_descriptor_depth :: (renderer:*Renderer, pipeline_descriptor: *WGPURenderPipelineDescriptor, depth_stencil_state: *WGPUDepthStencilState) {
	if(renderer.use_depth_buffer){
		depth_stencil_state_prepare(depth_stencil_state);
		pipeline_descriptor.depthStencil = depth_stencil_state;
	}else{
		pipeline_descriptor.depthStencil = null;
	}
}


create_depth_texture_if_needed :: ( renderer: *Renderer ) {
	assert(renderer.wgpuContext!=null, "renderer.wgpuContext is null\n");
	using renderer.wgpuContext;
	size := windowSize;

	if( depthTexture != null) {
		if(
			wgpuTextureGetWidth(depthTexture) == size.x &&
			wgpuTextureGetHeight(depthTexture) == size.y
		){
			return;
		}
		wgpuTextureRelease(depthTexture);
		// texture_create_required = true;
	}

	if( renderer.use_depth_buffer == false ){
		return;
	}

	sampleCount :u32= xx (ifx renderer.use_msaa then MULTISAMPLE_SAMPLES_COUNT else 1);
	viewFormats :[1]WGPUTextureFormat = .[DEPTH_TEXTURE_FORMAT];
	textureDescriptor := WGPUTextureDescriptor.{
		label = "Depth Texture",
		size = .{
			width = xx size.x,
			height = xx size.y,
			depthOrArrayLayers = 1
		},
		sampleCount = sampleCount,
		format = DEPTH_TEXTURE_FORMAT,
		usage = xx WGPUTextureUsage.RenderAttachment,
		dimension = WGPUTextureDimension._2D,
		mipLevelCount = 1,
		viewFormatCount = viewFormats.count,
		viewFormats = viewFormats.data,
	};
	renderer.wgpuContext.depthTexture = wgpuDeviceCreateTexture(renderer.wgpuContext.device, *textureDescriptor);

	renderer.wgpuContext.depthTextureView = wgpuTextureCreateView(renderer.wgpuContext.depthTexture, *DEPTH_TEXTURE_VIEW_DESCRIPTOR);
	renderer.wgpuContext.depthTextureStencilAttachment = depthStencilAttachment(renderer);
}

depthStencilAttachment :: (renderer: *Renderer)->WGPURenderPassDepthStencilAttachment {
	return WGPURenderPassDepthStencilAttachment.{
		view = renderer.wgpuContext.depthTextureView,
		depthClearValue = 1.0,
		depthLoadOp = WGPULoadOp.Clear,
		depthStoreOp = WGPUStoreOp.Store,
		depthReadOnly = xx false,
		// In js, the stencil are required to be not set
		// for the depth pass to work.
		// And even though setting them works in native,
		// we keep them unset for both native and wasm for now,
		// to be consistent. 
		// stencilClearValue = 0,
		// stencilLoadOp = WGPULoadOp.Clear,
		// stencilStoreOp = WGPUStoreOp.Store,
		// stencilReadOnly = xx true,
	};
}

update_render_pass_descriptor_depth :: (
	renderer: *Renderer,
	renderPassDescriptor: *WGPURenderPassDescriptor
	// we need #expand here, to ensure that the pointer to depthTextureStencilAttachment
	// remains in the caller stack
) #expand {
	// if(render_pass_descriptor.depthStencilAttachment.view){
	// 	wgpuTextureViewRelease(render_pass_descriptor.depthStencilAttachment.view);
	// }

	if(renderer.use_depth_buffer){
		renderPassDescriptor.depthStencilAttachment = *renderer.wgpuContext.depthTextureStencilAttachment;
	} else {
		renderPassDescriptor.depthStencilAttachment = null;
	}
}

// depth_release :: (renderer: *Renderer) {
// 	if( renderer.depth_texture_view != null ) {
// 		wgpuTextureViewRelease(renderer.depth_texture_view);
// 	}
// }

DEPTH_TEXTURE_FORMAT :: WGPUTextureFormat.Depth24Plus;

#scope_file

DEPTH_TEXTURE_VIEW_DESCRIPTOR :: WGPUTextureViewDescriptor.{
	label = "depth_texture_view_descriptor",
	mipLevelCount = 1,
	arrayLayerCount = 1,
	// format = DEPTH_TEXTURE_FORMAT,
};

// DEPTH_STENCIL_STATE :: WGPUDepthStencilState.{
// 	depthWriteEnabled = true,
// 	depthCompare = WGPUCompareFunction.Less, //"less",
// 	format = DEPTH_TEXTURE_FORMAT,
// 	stencilReadMask = 0,
// 	stencilWriteMask = 0,
// };

depth_stencil_state_prepare :: (depth_stencil_state: *WGPUDepthStencilState) {
	depth_stencil_state_set_default(depth_stencil_state);
	depth_stencil_state.depthCompare = WGPUCompareFunction.Less;
	depth_stencil_state.depthWriteEnabled = xx true;
	depth_stencil_state.format = DEPTH_TEXTURE_FORMAT;
	depth_stencil_state.stencilReadMask = 0;
	depth_stencil_state.stencilWriteMask = 0;
}
