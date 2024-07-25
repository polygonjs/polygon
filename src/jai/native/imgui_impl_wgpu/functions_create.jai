ImGui_ImplWGPU_CreateShaderModule :: (iwc_shader_module: *ImGui_WGPU_Common_ShaderModule, wgsl_source: *string) -> WGPUProgrammableStageDescriptor {
	bd := ImGui_ImplWGPU_GetBackendData();

	iwc_shader_module.wgsl_desc = .{};
	iwc_shader_module.wgsl_desc.chain.sType = WGPUSType.ShaderModuleWGSLDescriptor;
	iwc_shader_module.wgsl_desc.code = wgsl_source.data;

	iwc_shader_module.desc = .{
		nextInChain = xx (*(iwc_shader_module.wgsl_desc)),//cast(*WGPUChainedStruct) wgsl_desc;
	};

	iwc_shader_module.stage_desc = .{
		module = wgpuDeviceCreateShaderModule(bd.wgpuDevice, *iwc_shader_module.desc),
		entryPoint = "main",
	};
	return iwc_shader_module.stage_desc;
}

ImGui_ImplWGPU_CreateImageBindGroup::(layout: WGPUBindGroupLayout, texture_view: WGPUTextureView) -> WGPUBindGroup {
	bd := ImGui_ImplWGPU_GetBackendData();
	image_bg_entries: [1]WGPUBindGroupEntry;
	image_bg_entries[0] = .{ textureView = texture_view };

	image_bg_descriptor:WGPUBindGroupDescriptor = .{};
	image_bg_descriptor.layout = layout;
	image_bg_descriptor.entryCount = 1;//size_of(image_bg_entries) / size_of(WGPUBindGroupEntry);
	image_bg_descriptor.entries = image_bg_entries.data;
	return wgpuDeviceCreateBindGroup(bd.wgpuDevice, *image_bg_descriptor);
}

ImGui_ImplWGPU_CreateFontsTexture :: (iwc_font_tex: *ImGui_WGPU_Common_FontTexture) {
	// Build texture atlas
	bd := ImGui_ImplWGPU_GetBackendData();
	io := ImGui.GetIO();
	// font_atlas: ImFontAtlas;
	// pixels:[..]u8;
	pixels:*u8;
	width:s32;
	height:s32;
	size_pp:s32;
	io.Fonts.GetTexDataAsRGBA32(io.Fonts,*pixels, *width, *height, *size_pp);

	// Upload texture to graphics system
	{
		iwc_font_tex.tex_desc.label = "Dear ImGui Font Texture";
		iwc_font_tex.tex_desc.dimension = WGPUTextureDimension._2D;
		iwc_font_tex.tex_desc.size.width = xx width;
		iwc_font_tex.tex_desc.size.height = xx height;
		iwc_font_tex.tex_desc.size.depthOrArrayLayers = 1;
		iwc_font_tex.tex_desc.sampleCount = 1;
		iwc_font_tex.tex_desc.format = WGPUTextureFormat.RGBA8Unorm;
		iwc_font_tex.tex_desc.mipLevelCount = 1;
		iwc_font_tex.tex_desc.usage = xx WGPUTextureUsage.CopyDst | WGPUTextureUsage.TextureBinding;
		bd.renderResources.FontTexture = wgpuDeviceCreateTexture(bd.wgpuDevice, *iwc_font_tex.tex_desc);

		iwc_font_tex.tex_view_desc.format = WGPUTextureFormat.RGBA8Unorm;
		iwc_font_tex.tex_view_desc.dimension = WGPUTextureViewDimension._2D;
		iwc_font_tex.tex_view_desc.baseMipLevel = 0;
		iwc_font_tex.tex_view_desc.mipLevelCount = 1;
		iwc_font_tex.tex_view_desc.baseArrayLayer = 0;
		iwc_font_tex.tex_view_desc.arrayLayerCount = 1;
		iwc_font_tex.tex_view_desc.aspect = WGPUTextureAspect.All;
		bd.renderResources.FontTextureView = wgpuTextureCreateView(bd.renderResources.FontTexture, *iwc_font_tex.tex_view_desc);
	}

	// Upload texture data
	{
		iwc_font_tex.dst_view.texture = bd.renderResources.FontTexture;
		iwc_font_tex.dst_view.mipLevel = 0;
		iwc_font_tex.dst_view.origin = .{ 0, 0, 0 };
		iwc_font_tex.dst_view.aspect = WGPUTextureAspect.All;
		iwc_font_tex.layout.offset = 0;
		iwc_font_tex.layout.bytesPerRow = xx (width * size_pp);
		iwc_font_tex.layout.rowsPerImage = xx height;
		iwc_font_tex.size = .{ width = xx width, height = xx height, depthOrArrayLayers = 1 };
		wgpuQueueWriteTexture(bd.defaultQueue, *iwc_font_tex.dst_view, pixels, xx (width * size_pp * height), *iwc_font_tex.layout, *iwc_font_tex.size);
	}

	// Create the associated sampler
	// (Bilinear sampling is required by default. Set 'io.Fonts->Flags |= ImFontAtlasFlags_NoBakedLines' or 'style.AntiAliasedLinesUseTex = false' to allow point/nearest sampling)
	{
		iwc_font_tex.sampler_desc.minFilter = WGPUFilterMode.Linear;
		iwc_font_tex.sampler_desc.magFilter = WGPUFilterMode.Linear;
		iwc_font_tex.sampler_desc.mipmapFilter = WGPUMipmapFilterMode.Linear;
		iwc_font_tex.sampler_desc.addressModeU = WGPUAddressMode.Repeat;
		iwc_font_tex.sampler_desc.addressModeV = WGPUAddressMode.Repeat;
		iwc_font_tex.sampler_desc.addressModeW = WGPUAddressMode.Repeat;
		iwc_font_tex.sampler_desc.maxAnisotropy = 1;
		bd.renderResources.Sampler = wgpuDeviceCreateSampler(bd.wgpuDevice, *iwc_font_tex.sampler_desc);
	}

	// Store our identifier
	assert(size_of(ImTextureID) >= size_of(type_of(bd.renderResources.FontTexture)), "Can't pack descriptor handle into TexID, 32-bit not supported yet.");
	io.Fonts.TexID = xx bd.renderResources.FontTextureView;
}

ImGui_ImplWGPU_CreateUniformBuffer :: (iwc_uniforms: *ImGui_WGPU_Common_Uniforms) {
	bd := ImGui_ImplWGPU_GetBackendData();
	iwc_uniforms.ub_desc = .{
		null,
		"Dear ImGui Uniform buffer",
		xx WGPUBufferUsage.CopyDst | WGPUBufferUsage.Uniform,
		memalign(size_of(ImGui_WGPU_Uniforms), 16),
		xx false
	};

	// size := max( cast(u64)16, cast(u64) uniforms.count * size_of(CameraUniforms));

	// buffer := wgpuDeviceCreateBuffer(device, *(WGPUBufferDescriptor.{
	// 	usage = xx (WGPUBufferUsage.Uniform | WGPUBufferUsage.CopyDst),
	// 	size = size
	// }));
	// assert(buffer != null, "Buffer is not created correctly");

	bd.renderResources.Uniforms = wgpuDeviceCreateBuffer(bd.wgpuDevice, *iwc_uniforms.ub_desc);
}

ImGui_ImplWGPU_CreateDeviceObjects :: (
	bd: *ImGui_ImplWGPU_Data,
	iwc:*ImGui_WGPU_Common,
	wgpu_context: *WGPUContext
) -> bool {
	if (bd.wgpuDevice == null) {
		print("ImGui_ImplWGPU_CreateDeviceObjects:bd.wgpuDevice is null, return false\n");
		return false;
	}
	if (bd.pipelineState != null) {
		print_red("invalidate here?!\n");
		ImGui_ImplWGPU_InvalidateDeviceObjects();
	}

	// Create render pipeline
	iwc.graphics_pipeline_desc = .{};
	iwc.graphics_pipeline_desc.primitive.topology = WGPUPrimitiveTopology.TriangleList;
	iwc.graphics_pipeline_desc.primitive.stripIndexFormat = WGPUIndexFormat.Undefined;
	iwc.graphics_pipeline_desc.primitive.frontFace = WGPUFrontFace.CW;
	iwc.graphics_pipeline_desc.primitive.cullMode = WGPUCullMode.None;
	update_pipeline_descriptor_multisample(wgpu_context,*iwc.graphics_pipeline_desc);
	// we don't rely entirely on update_pipeline_descriptor_multisample(),
	// as the imgui widgets seem to look better with alphaToCoverageEnabled = false here
	iwc.graphics_pipeline_desc.multisample.alphaToCoverageEnabled = xx false;

	// Bind group layouts
	iwc.common_bg_layout_entries[0].binding = 0;
	iwc.common_bg_layout_entries[0].visibility = xx WGPUShaderStage.Vertex | WGPUShaderStage.Fragment;
	iwc.common_bg_layout_entries[0].buffer.type = WGPUBufferBindingType.Uniform;
	iwc.common_bg_layout_entries[1].binding = 1;
	iwc.common_bg_layout_entries[1].visibility = xx WGPUShaderStage.Fragment;
	iwc.common_bg_layout_entries[1].sampler.type = WGPUSamplerBindingType.Filtering;

	iwc.image_bg_layout_entries[0].binding = 0;
	iwc.image_bg_layout_entries[0].visibility = xx WGPUShaderStage.Fragment;
	iwc.image_bg_layout_entries[0].texture.sampleType = WGPUTextureSampleType.Float;
	iwc.image_bg_layout_entries[0].texture.viewDimension = WGPUTextureViewDimension._2D;

	iwc.common_bg_layout_desc.entryCount = iwc.common_bg_layout_entries.count;
	iwc.common_bg_layout_desc.entries = iwc.common_bg_layout_entries.data;

	iwc.image_bg_layout_desc.entryCount = iwc.image_bg_layout_entries.count;
	iwc.image_bg_layout_desc.entries = iwc.image_bg_layout_entries.data;

	a:WGPUBindGroupLayout= wgpuDeviceCreateBindGroupLayout(bd.wgpuDevice, *iwc.common_bg_layout_desc);
	iwc.bg_layouts[0] = wgpuDeviceCreateBindGroupLayout(bd.wgpuDevice, *iwc.common_bg_layout_desc);
	iwc.bg_layouts[1] = wgpuDeviceCreateBindGroupLayout(bd.wgpuDevice, *iwc.image_bg_layout_desc);

	
	iwc.layout_desc.bindGroupLayoutCount = 2;
	iwc.layout_desc.bindGroupLayouts = iwc.bg_layouts.data;
	iwc.graphics_pipeline_desc.layout = wgpuDeviceCreatePipelineLayout(bd.wgpuDevice, *iwc.layout_desc);

	// Create the vertex shader
	iwc.vertex_shader_desc = ImGui_ImplWGPU_CreateShaderModule(*iwc.vert, *__shader_vert_wgsl);
	iwc.graphics_pipeline_desc.vertex.module = iwc.vertex_shader_desc.module;
	iwc.graphics_pipeline_desc.vertex.entryPoint = iwc.vertex_shader_desc.entryPoint;

	// Vertex input configuration
	iwc.attribute_desc[0] = .{format = WGPUVertexFormat.Float32x2, offset = xx offset_of(type_info(ImDrawVert), "pos"), shaderLocation = 0};
	iwc.attribute_desc[1] = .{format = WGPUVertexFormat.Float32x2, offset = xx offset_of(type_info(ImDrawVert), "uv"), shaderLocation = 1};
	iwc.attribute_desc[2] = .{format = WGPUVertexFormat.Unorm8x4, offset = xx offset_of(type_info(ImDrawVert), "col"), shaderLocation = 2};

	iwc.buffer_layouts[0] = .{arrayStride = size_of(ImDrawVert), stepMode = WGPUVertexStepMode.Vertex, attributeCount = 3, attributes = iwc.attribute_desc.data};

	iwc.graphics_pipeline_desc.vertex.bufferCount = 1;
	iwc.graphics_pipeline_desc.vertex.buffers = iwc.buffer_layouts.data;

	// Create the pixel shader
	iwc.pixel_shader_desc = ImGui_ImplWGPU_CreateShaderModule(*iwc.frag, *__shader_frag_wgsl);

	// Create the blending setup
	iwc.blend_state.alpha.operation = WGPUBlendOperation.Add;
	iwc.blend_state.alpha.srcFactor = WGPUBlendFactor.One;
	iwc.blend_state.alpha.dstFactor = WGPUBlendFactor.OneMinusSrcAlpha;
	iwc.blend_state.color.operation = WGPUBlendOperation.Add;
	iwc.blend_state.color.srcFactor = WGPUBlendFactor.SrcAlpha;
	iwc.blend_state.color.dstFactor = WGPUBlendFactor.OneMinusSrcAlpha;

	iwc.color_state.format = bd.renderTargetFormat;
	assert(iwc.color_state.format != .Undefined, "format should not be undefined\n");
	iwc.color_state.blend = *iwc.blend_state;
	iwc.color_state.writeMask = xx WGPUColorWriteMask.All;

	iwc.fragment_state.module = iwc.pixel_shader_desc.module;
	iwc.fragment_state.entryPoint = iwc.pixel_shader_desc.entryPoint;
	iwc.fragment_state.targetCount = 1;
	iwc.fragment_state.targets = *iwc.color_state;

	iwc.graphics_pipeline_desc.fragment = *iwc.fragment_state;

	// Create depth-stencil State
	iwc.depth_stencil_state.format = bd.depthStencilFormat;
	iwc.depth_stencil_state.depthWriteEnabled = xx false;
	iwc.depth_stencil_state.depthCompare = WGPUCompareFunction.Always;
	iwc.depth_stencil_state.stencilFront.compare = WGPUCompareFunction.Always;
	iwc.depth_stencil_state.stencilBack.compare = WGPUCompareFunction.Always;

	// Configure disabled depth-stencil state
	iwc.graphics_pipeline_desc.depthStencil = ifx (bd.depthStencilFormat == WGPUTextureFormat.Undefined) then null else *iwc.depth_stencil_state;

	bd.pipelineState = wgpuDeviceCreateRenderPipeline(bd.wgpuDevice, *iwc.graphics_pipeline_desc);

	ImGui_ImplWGPU_CreateFontsTexture(*iwc.font_texture);
	ImGui_ImplWGPU_CreateUniformBuffer(*iwc.uniforms);

	// Create resource bind group
	iwc.common_bg_entries[0] = .{ binding=0, buffer=bd.renderResources.Uniforms, offset=0, size=xx memalign(size_of(ImGui_WGPU_Uniforms), 16), sampler=null, textureView=null };
	iwc.common_bg_entries[1] = .{ binding=1, buffer=null, offset=0, size=0, sampler=bd.renderResources.Sampler, textureView=null };
	// {
	// 	{ nullptr, 0, bd->renderResources.Uniforms, 0, MEMALIGN(size_of(Uniforms), 16), 0, 0 },
	// 	{ nullptr, 1, 0, 0, 0, bd->renderResources.Sampler, 0 },
	// };

	iwc.common_bg_descriptor.layout = iwc.bg_layouts[0];
	iwc.common_bg_descriptor.entryCount = iwc.common_bg_entries.count;// / size_of(WGPUBindGroupEntry);
	iwc.common_bg_descriptor.entries = iwc.common_bg_entries.data;
	bd.renderResources.CommonBindGroup = wgpuDeviceCreateBindGroup(bd.wgpuDevice, *iwc.common_bg_descriptor);

	iwc.image_bind_group = ImGui_ImplWGPU_CreateImageBindGroup(iwc.bg_layouts[1], bd.renderResources.FontTextureView);
	bd.renderResources.ImageBindGroup = iwc.image_bind_group;
	bd.renderResources.ImageBindGroupLayout = iwc.bg_layouts[1];
	text_id_hash := ImHashData(bd.renderResources.FontTextureView, size_of(ImTextureID), 0);
	bd.renderResources.ImageBindGroups.SetVoidPtr( *bd.renderResources.ImageBindGroups, text_id_hash, iwc.image_bind_group );

	SafeReleaseWGPUShaderModule(*iwc.vertex_shader_desc.module);
	SafeReleaseWGPUShaderModule(*iwc.pixel_shader_desc.module);
	SafeReleaseWGPUBindGroupLayout(*iwc.bg_layouts[0]);

	return true;
}