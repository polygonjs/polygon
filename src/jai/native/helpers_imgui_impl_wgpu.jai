// RenderResources :: struct {
// 	FontTexture:WGPUTexture;          // Font texture
// 	FontTextureView:WGPUTextureView;      // Texture view for font texture
// 	Sampler :WGPUSampler;              // Sampler for the font texture
// 	Uniforms:WGPUBuffer;             // Shader uniforms
// 	CommonBindGroup:WGPUBindGroup;      // Resources bind-group to bind the common resources to pipeline
// 	ImageBindGroups:ImGuiStorage;                // Resources bind-group to bind the font/image resources to pipeline (this is a key->value map)
// 	ImageBindGroup:WGPUBindGroup;       // Default font-resource of Dear ImGui
// 	ImageBindGroupLayout:WGPUBindGroupLayout; // Cache layout used for the image bind group. Avoids allocating unnecessary JS objects when working with WebASM
// };

// FrameResources :: struct {
// 	IndexBuffer:WGPUBuffer;
// 	VertexBuffer:WGPUBuffer;
// 	IndexBufferHost:*ImDrawIdx;
// 	VertexBufferHost:*ImDrawVert;
// 	IndexBufferSize:u64;
// 	VertexBufferSize:u64;
// };

// Uniforms :: struct {
// 	MVP: Matrix4;
// 	Gamma: float;
// };
// ImGui_ImplWGPU_Data :: struct {
// 	wgpuDevice:	WGPUDevice;
// 	defaultQueue:WGPUQueue;
// 	renderTargetFormat:WGPUTextureFormat = WGPUTextureFormat.Undefined;
// 	depthStencilFormat:WGPUTextureFormat = WGPUTextureFormat.Undefined;
// 	pipelineState:*WGPURenderPipeline=null;

// 	renderResources:RenderResources;
// 	pFrameResources: [..]FrameResources;
// 	numFramesInFlight:u64 = 0;
// 	frameIndex:u64 = U64_MAX;//UINT_MAX;
// };
// ImGui_ImplWGPU_InitInfo :: struct {
// 	Device:WGPUDevice;
// 	NumFramesInFlight:u8 = 3;
// 	RenderTargetFormat:WGPUTextureFormat = WGPUTextureFormat.Undefined;
// 	DepthStencilFormat:WGPUTextureFormat = WGPUTextureFormat.Undefined;
// 	PipelineMultisampleState:WGPUMultisampleState = .{
// 		count = 1,
// 		mask = U32_MAX,
// 		alphaToCoverageEnabled = xx false
// 	};
// };
// // ImGui_ImplWGPU_InitInfo_init::(info: *ImGui_ImplWGPU_InitInfo) {
// // 	info.PipelineMultisampleState.count = 1;
// // 	info.PipelineMultisampleState.mask = U32_MAX;
// // 	info.PipelineMultisampleState.alphaToCoverageEnabled = xx false;
// // }

// ImGui_ImplWGPU_GetBackendData :: ()-> *ImGui_ImplWGPU_Data
// {
// 	print("ImGui_ImplWGPU_GetBackendData:ImGui.GetCurrentContext():%\n", ImGui.GetCurrentContext());
// 	print("ImGui_ImplWGPU_GetBackendData:ImGui.GetIO():%\n", ImGui.GetIO());
// 	return ifx ImGui.GetCurrentContext() then cast(*ImGui_ImplWGPU_Data) ImGui.GetIO().BackendRendererUserData else null;
// }

// //-----------------------------------------------------------------------------
// // SHADERS
// //-----------------------------------------------------------------------------

// __shader_vert_wgsl :: #string WGSL
// struct VertexInput {
// 	@location(0) position: vec2<f32>,
// 	@location(1) uv: vec2<f32>,
// 	@location(2) color: vec4<f32>,
// };

// struct VertexOutput {
// 	@builtin(position) position: vec4<f32>,
// 	@location(0) color: vec4<f32>,
// 	@location(1) uv: vec2<f32>,
// };

// struct Uniforms {
// 	mvp: mat4x4<f32>,
// 	gamma: f32,
// };

// @group(0) @binding(0) var<uniform> uniforms: Uniforms;

// @vertex
// fn main(in: VertexInput) -> VertexOutput {
// 	var out: VertexOutput;
// 	out.position = uniforms.mvp * vec4<f32>(in.position, 0.0, 1.0);
// 	out.color = in.color;
// 	out.uv = in.uv;
// 	return out;
// }
// WGSL

// __shader_frag_wgsl :: #string WGSL
// struct VertexOutput {
// 	@builtin(position) position: vec4<f32>,
// 	@location(0) color: vec4<f32>,
// 	@location(1) uv: vec2<f32>,
// };

// struct Uniforms {
// 	mvp: mat4x4<f32>,
// 	gamma: f32,
// };

// @group(0) @binding(0) var<uniform> uniforms: Uniforms;
// @group(0) @binding(1) var s: sampler;
// @group(1) @binding(0) var t: texture_2d<f32>;

// @fragment
// fn main(in: VertexOutput) -> @location(0) vec4<f32> {
// 	let color = in.color * textureSample(t, s, in.uv);
// 	let corrected_color = pow(color.rgb, vec3<f32>(uniforms.gamma));
// 	return vec4<f32>(corrected_color, color.a);
// }
// WGSL


// SafeRelease::(res: *ImDrawIdx)
// {
// 	if (res) free(res);
// 		// delete[] res;
// 	res = null;
// }
// SafeRelease::(res: *ImDrawVert)
// {
// 	if (res) free(res);
// 		// delete[] res;
// 	res = null;
// }
// SafeRelease::(res: *WGPUBindGroupLayout)
// {
// 	if (res)
// 		wgpuBindGroupLayoutRelease(<<res);
// 	res = null;
// }
// SafeRelease::(res: *WGPUBindGroup)
// {
// 	if (res)
// 		wgpuBindGroupRelease(<<res);
// 	res = null;
// }
// SafeRelease::(res: *WGPUBuffer)
// {
// 	if (res)
// 		wgpuBufferRelease(<<res);
// 	res = null;
// }
// SafeRelease::(res: *WGPURenderPipeline)
// {
// 	if (res)
// 		wgpuRenderPipelineRelease(<<res);
// 	res = null;
// }
// SafeRelease::(res: *WGPUSampler)
// {
// 	if (res)
// 		wgpuSamplerRelease(<<res);
// 	res = null;
// }
// SafeRelease::(res: *WGPUShaderModule)
// {
// 	if (res)
// 		wgpuShaderModuleRelease(<<res);
// 	res = null;
// }
// SafeRelease::(res: *WGPUTextureView)
// {
// 	if (res)
// 		wgpuTextureViewRelease(<<res);
// 	res = null;
// }
// SafeRelease::(res: *WGPUTexture)
// {
// 	if (res)
// 		wgpuTextureRelease(<<res);
// 	res = null;
// }

// SafeRelease::(res:*RenderResources)
// {
// 	SafeRelease(*res.FontTexture);
// 	SafeRelease(*res.FontTextureView);
// 	SafeRelease(*res.Sampler);
// 	SafeRelease(*res.Uniforms);
// 	SafeRelease(*res.CommonBindGroup);
// 	SafeRelease(*res.ImageBindGroup);
// 	SafeRelease(*res.ImageBindGroupLayout);
// };

// SafeRelease::(res:*FrameResources)
// {
// 	SafeRelease(*res.IndexBuffer);
// 	SafeRelease(*res.VertexBuffer);
// 	SafeRelease(res.IndexBufferHost);
// 	SafeRelease(res.VertexBufferHost);
// }

// // https://discord.com/channels/661732390355337246/661732390355337249/1092628683782639696
// // offset_of :: ($T: Type, $name: member) -> int {
// // 	return #run -> int {
// // 		for type_info(T).members {
// // 			if it.name == name return it.offset_in_bytes;
// // 		}
// // 		return -1;
// // 	};
// // }
// offset_of :: (t_info_struct: *Type_Info_Struct, name: string) -> s64 {
// 	for t_info_struct.members {
// 		if it.name == name return it.offset_in_bytes;
// 	}
// 	return -1;
// }
// // #define MEMALIGN(_SIZE,_ALIGN)        (((_SIZE) + ((_ALIGN) - 1)) & ~((_ALIGN) - 1))    // Memory align (copied from IM_ALIGN() macro).
// memalign :: (size:u64, align: u64)->u64{
// 	return ((size + (align - 1)) & ~(align - 1));
// }

// ImGui_ImplWGPU_CreateShaderModule :: (wgsl_source: *string) -> WGPUProgrammableStageDescriptor {
// 	bd := ImGui_ImplWGPU_GetBackendData();

// 	wgsl_desc := WGPUShaderModuleWGSLDescriptor.{};
// 	wgsl_desc.chain.sType = WGPUSType.ShaderModuleWGSLDescriptor;
// 	wgsl_desc.code = wgsl_source.data;

// 	desc :WGPUShaderModuleDescriptor = .{};
// 	desc.nextInChain = xx (*wgsl_desc);//cast(*WGPUChainedStruct) wgsl_desc;

// 	stage_desc :WGPUProgrammableStageDescriptor = .{};
// 	stage_desc.module = wgpuDeviceCreateShaderModule(bd.wgpuDevice, *desc);
// 	stage_desc.entryPoint = "main";
// 	return stage_desc;
// }

// ImGui_ImplWGPU_CreateImageBindGroup::(layout: WGPUBindGroupLayout, texture_view: WGPUTextureView) -> WGPUBindGroup {
// 	bd := ImGui_ImplWGPU_GetBackendData();
// 	image_bg_entries: [1]WGPUBindGroupEntry;
// 	image_bg_entries[0] = .{ textureView = texture_view };

// 	image_bg_descriptor:WGPUBindGroupDescriptor = .{};
// 	image_bg_descriptor.layout = layout;
// 	image_bg_descriptor.entryCount = 1;//size_of(image_bg_entries) / size_of(WGPUBindGroupEntry);
// 	image_bg_descriptor.entries = image_bg_entries.data;
// 	return wgpuDeviceCreateBindGroup(bd.wgpuDevice, *image_bg_descriptor);
// }

// ImGui_ImplWGPU_SetupRenderState:: ( draw_data: *ImDrawData, ctx: WGPURenderPassEncoder, fr: *FrameResources)
// {
// 	bd := ImGui_ImplWGPU_GetBackendData();

// 	// Setup orthographic projection matrix into our constant buffer
// 	// Our visible imgui space lies from draw_data->DisplayPos (top left) to draw_data->DisplayPos+data_data->DisplaySize (bottom right).
// 	{
// 		L: = draw_data.DisplayPos.x;
// 		R: = draw_data.DisplayPos.x + draw_data.DisplaySize.x;
// 		T: = draw_data.DisplayPos.y;
// 		B: = draw_data.DisplayPos.y + draw_data.DisplaySize.y;
// 		mvp: Matrix4 =
// 		.{
// 			2.0/(R-L),   0.0,           0.0,       0.0,
// 			0.0,         2.0/(T-B),     0.0,       0.0,
// 			0.0,         0.0,           0.5,       0.0,
// 			(R+L)/(L-R),  (T+B)/(B-T),    0.5,       1.0,
// 		};
// 		mvp = transpose(mvp);
// 		wgpuQueueWriteBuffer(
// 			bd.defaultQueue,
// 			bd.renderResources.Uniforms,
// 			xx offset_of(type_info(Uniforms), "MVP"),
// 			*mvp.coef,
// 			size_of(type_of(Uniforms.MVP))
// 		);
// 		gamma:float;
// 		if bd.renderTargetFormat == {
// 		case WGPUTextureFormat.ASTC10x10UnormSrgb;
// 		case WGPUTextureFormat.ASTC10x5UnormSrgb;
// 		case WGPUTextureFormat.ASTC10x6UnormSrgb;
// 		case WGPUTextureFormat.ASTC10x8UnormSrgb;
// 		case WGPUTextureFormat.ASTC12x10UnormSrgb;
// 		case WGPUTextureFormat.ASTC12x12UnormSrgb;
// 		case WGPUTextureFormat.ASTC4x4UnormSrgb;
// 		case WGPUTextureFormat.ASTC5x5UnormSrgb;
// 		case WGPUTextureFormat.ASTC6x5UnormSrgb;
// 		case WGPUTextureFormat.ASTC6x6UnormSrgb;
// 		case WGPUTextureFormat.ASTC8x5UnormSrgb;
// 		case WGPUTextureFormat.ASTC8x6UnormSrgb;
// 		case WGPUTextureFormat.ASTC8x8UnormSrgb;
// 		case WGPUTextureFormat.BC1RGBAUnormSrgb;
// 		case WGPUTextureFormat.BC2RGBAUnormSrgb;
// 		case WGPUTextureFormat.BC3RGBAUnormSrgb;
// 		case WGPUTextureFormat.BC7RGBAUnormSrgb;
// 		case WGPUTextureFormat.BGRA8UnormSrgb;
// 		case WGPUTextureFormat.ETC2RGB8A1UnormSrgb;
// 		case WGPUTextureFormat.ETC2RGB8UnormSrgb;
// 		case WGPUTextureFormat.ETC2RGBA8UnormSrgb;
// 		case WGPUTextureFormat.RGBA8UnormSrgb;
// 			gamma = 2.2;
// 		case;
// 			gamma = 1.0;
// 		}
// 		wgpuQueueWriteBuffer(
// 			bd.defaultQueue,
// 			bd.renderResources.Uniforms,
// 			xx offset_of(type_info(Uniforms), "Gamma"),
// 			*gamma,
// 			size_of(type_of(Uniforms.Gamma))
// 		);
// 	}

// 	// Setup viewport
// 	wgpuRenderPassEncoderSetViewport(ctx, 0, 0, draw_data.FramebufferScale.x * draw_data.DisplaySize.x, draw_data.FramebufferScale.y * draw_data.DisplaySize.y, 0, 1);

// 	// Bind shader and vertex buffers
// 	vertex_buffer_size:= fr.VertexBufferSize * size_of(ImDrawVert);
// 	wgpuRenderPassEncoderSetVertexBuffer(
// 		ctx,
// 		0,
// 		fr.VertexBuffer,
// 		0,
// 		xx vertex_buffer_size
// 	);
// 	index_buffer_format := ifx (size_of(ImDrawIdx) == 2) then WGPUIndexFormat.Uint16 else WGPUIndexFormat.Uint32;
// 	wgpuRenderPassEncoderSetIndexBuffer(ctx, fr.IndexBuffer, index_buffer_format, 0, fr.IndexBufferSize * size_of(ImDrawIdx));
// 	wgpuRenderPassEncoderSetPipeline(ctx, <<bd.pipelineState);
// 	wgpuRenderPassEncoderSetBindGroup(ctx, 0, bd.renderResources.CommonBindGroup, 0, null);

// 	// Setup blend factor
// 	blend_color:WGPUColor = .{ 0, 0, 0, 0 };
// 	wgpuRenderPassEncoderSetBlendConstant(ctx, *blend_color);
// }

// // Render function
// // (this used to be set in io.RenderDrawListsFn and called by ImGui::Render(), but you can now call this directly from your main loop)
// ImGui_ImplWGPU_RenderDrawData:: ( draw_data:*ImDrawData, pass_encoder: WGPURenderPassEncoder)
// {
// 	// Avoid rendering when minimized
// 	if (draw_data.DisplaySize.x <= 0.0 || draw_data.DisplaySize.y <= 0.0)
// 		return;

// 	// FIXME: Assuming that this only gets called once per frame!
// 	// If not, we can't just re-allocate the IB or VB, we'll have to do a proper allocator.
// 	bd := ImGui_ImplWGPU_GetBackendData();
// 	bd.frameIndex = bd.frameIndex + 1;
// 	fr := bd.pFrameResources[bd.frameIndex % bd.numFramesInFlight];

// 	// Create and grow vertex/index buffers if needed
// 	if (fr.VertexBuffer == null || fr.VertexBufferSize < xx draw_data.TotalVtxCount)
// 	{
// 		if (fr.VertexBuffer)
// 		{
// 			wgpuBufferDestroy(fr.VertexBuffer);
// 			wgpuBufferRelease(fr.VertexBuffer);
// 		}
// 		SafeRelease(fr.VertexBufferHost);
// 		fr.VertexBufferSize = cast(u64) draw_data.TotalVtxCount + 5000;

// 		vb_desc:WGPUBufferDescriptor =
// 		.{
// 			null,
// 			"Dear ImGui Vertex buffer",
// 			xx WGPUBufferUsage.CopyDst | WGPUBufferUsage.Vertex,
// 			memalign(fr.VertexBufferSize * size_of(ImDrawVert), 4),
// 			xx false
// 		};
// 		fr.VertexBuffer = wgpuDeviceCreateBuffer(bd.wgpuDevice, *vb_desc);
// 		if (!fr.VertexBuffer)
// 			return;

// 		im_draw_verts :[..]ImDrawVert;
// 		fr.VertexBufferHost = im_draw_verts.data; //New(ImDrawVert[fr.VertexBufferSize]);
// 		for 0..(fr.VertexBufferSize-1) {
// 			array_add(*im_draw_verts, .{});
// 		}
// 	}
// 	if (fr.IndexBuffer == null || fr.IndexBufferSize < xx draw_data.TotalIdxCount)
// 	{
// 		if (fr.IndexBuffer)
// 		{
// 			wgpuBufferDestroy(fr.IndexBuffer);
// 			wgpuBufferRelease(fr.IndexBuffer);
// 		}
// 		SafeRelease(fr.IndexBufferHost);
// 		fr.IndexBufferSize = cast(u64) draw_data.TotalIdxCount + 10000;

// 		ib_desc:WGPUBufferDescriptor =
// 		.{
// 			null,
// 			"Dear ImGui Index buffer",
// 			xx WGPUBufferUsage.CopyDst | WGPUBufferUsage.Index,
// 			memalign(fr.IndexBufferSize * size_of(ImDrawIdx), 4),
// 			xx false
// 		};
// 		fr.IndexBuffer = wgpuDeviceCreateBuffer(bd.wgpuDevice, *ib_desc);
// 		if (!fr.IndexBuffer)
// 			return;

// 		im_draw_idxs :[..]ImDrawIdx;
// 		fr.IndexBufferHost = im_draw_idxs.data;//New(ImDrawIdx[fr.IndexBufferSize]);
// 		for 0..(fr.IndexBufferSize-1) {
// 			array_add(*im_draw_idxs, 0);
// 		}
// 	}

// 	// Upload vertex/index data into a single contiguous GPU buffer
// 	vtx_dst:*ImDrawVert = xx fr.VertexBufferHost;
// 	idx_dst:*ImDrawIdx = xx fr.IndexBufferHost;
// 	for n:0..(draw_data.CmdListsCount-1) {
// 		cmd_list:*ImDrawList = draw_data.CmdLists.Data[n*size_of(ImDrawList)]; //draw_data.CmdLists[n];
// 		memcpy(vtx_dst, cmd_list.VtxBuffer.Data, cmd_list.VtxBuffer.Size * size_of(ImDrawVert));
// 		memcpy(idx_dst, cmd_list.IdxBuffer.Data, cmd_list.IdxBuffer.Size * size_of(ImDrawIdx));
// 		vtx_dst += cmd_list.VtxBuffer.Size;
// 		idx_dst += cmd_list.IdxBuffer.Size;
// 	}
// 	// vb_write_size:s64  = MEMALIGN((char*)vtx_dst - (char*)fr.VertexBufferHost, 4);
// 	// ib_write_size:s64  = MEMALIGN((char*)idx_dst - (char*)fr>IndexBufferHost, 4);
// 	vb_write_size := memalign((cast(u64) vtx_dst) - (cast(u64) fr.VertexBufferHost), 4);
// 	ib_write_size := memalign((cast(u64) idx_dst) - (cast(u64) fr.IndexBufferHost), 4);
// 	wgpuQueueWriteBuffer(bd.defaultQueue, fr.VertexBuffer, 0, fr.VertexBufferHost, vb_write_size);
// 	wgpuQueueWriteBuffer(bd.defaultQueue, fr.IndexBuffer,  0, fr.IndexBufferHost,  ib_write_size);

// 	// Setup desired render state
// 	ImGui_ImplWGPU_SetupRenderState(draw_data, pass_encoder, *fr);

// 	// Render command lists
// 	// (Because we merged all buffers into a single one, we maintain our own offset into them)
// 	global_vtx_offset:int  = 0;
// 	global_idx_offset:int = 0;
// 	clip_scale:ImVec2 = draw_data.FramebufferScale;
// 	clip_off:ImVec2 = draw_data.DisplayPos;
// 	for n:0..(draw_data.CmdListsCount-1) {
// 		cmd_list :*ImDrawList= draw_data.CmdLists.Data[n*size_of(ImDrawList)]; //draw_data.CmdLists[n];
// 		for cmd_i: 0..(cmd_list.CmdBuffer.Size-1)
// 		//for (int cmd_i = 0; cmd_i < cmd_list->CmdBuffer.Size; cmd_i++)
// 		{
// 			pcmd:ImDrawCmd = cmd_list.CmdBuffer.Data[cmd_i*size_of(ImDrawCmd)]; //;cmd_list.CmdBuffer[cmd_i];
// 			if (pcmd.UserCallback != null)
// 			{
// 				// User callback, registered via ImDrawList::AddCallback()
// 				// (ImDrawCallback_ResetRenderState is a special callback value used by the user to request the renderer to reset render state.)
// 				// if (pcmd.UserCallback == ImDrawCallback.ResetRenderState)
// 				// 	ImGui_ImplWGPU_SetupRenderState(draw_data, pass_encoder, fr);
// 				// else
// 					pcmd.UserCallback(cmd_list, *pcmd);
// 			}
// 			else
// 			{
// 				// Bind custom texture
// 				tex_id:ImTextureID = pcmd.TextureId;//pcmd.GetTexID();
// 				tex_id_hash:ImGuiID = ImHashData(tex_id, size_of(type_of(tex_id)), 0);
// 				bind_group := bd.renderResources.ImageBindGroups.GetVoidPtr(*bd.renderResources.ImageBindGroups, tex_id_hash);
// 				if (bind_group)
// 				{
// 					wgpuRenderPassEncoderSetBindGroup(pass_encoder, 1, bind_group, 0, null);
// 				}
// 				else
// 				{
// 					image_bind_group:WGPUBindGroup = ImGui_ImplWGPU_CreateImageBindGroup(bd.renderResources.ImageBindGroupLayout, cast(WGPUTextureView)tex_id);
// 					bd.renderResources.ImageBindGroups.SetVoidPtr(*bd.renderResources.ImageBindGroups, tex_id_hash, image_bind_group);
// 					wgpuRenderPassEncoderSetBindGroup(pass_encoder, 1, image_bind_group, 0, null);
// 				}

// 				// Project scissor/clipping rectangles into framebuffer space
// 				clip_min:ImVec2=.{
// 					(pcmd.ClipRect.x - clip_off.x) * clip_scale.x,
// 					(pcmd.ClipRect.y - clip_off.y) * clip_scale.y
// 				};
// 				clip_max:ImVec2=.{
// 					(pcmd.ClipRect.z - clip_off.x) * clip_scale.x,
// 					(pcmd.ClipRect.w - clip_off.y) * clip_scale.y
// 				};
// 				if (clip_max.x <= clip_min.x || clip_max.y <= clip_min.y)
// 					continue;

// 				// Apply scissor/clipping rectangle, Draw
// 				wgpuRenderPassEncoderSetScissorRect(pass_encoder, xx clip_min.x, xx clip_min.y, xx (clip_max.x - clip_min.x), xx (clip_max.y - clip_min.y));
// 				wgpuRenderPassEncoderDrawIndexed(pass_encoder, pcmd.ElemCount, 1, xx (pcmd.IdxOffset + global_idx_offset), xx (pcmd.VtxOffset + global_vtx_offset), 0);
// 			}
// 		}
// 		global_idx_offset += cmd_list.IdxBuffer.Size;
// 		global_vtx_offset += cmd_list.VtxBuffer.Size;
// 	}
// }

// ImGui_ImplWGPU_CreateFontsTexture :: () {
// 	// Build texture atlas
// 	bd := ImGui_ImplWGPU_GetBackendData();
// 	io := ImGui.GetIO();
// 	font_atlas: ImFontAtlas;
// 	pixels:[..]u8;
// 	width:s32;
// 	height:s32;
// 	size_pp:s32;
// 	io.Fonts.GetTexDataAsRGBA32(*font_atlas,*pixels.data, *width, *height, *size_pp);

// 	// Upload texture to graphics system
// 	{
// 		tex_desc:WGPUTextureDescriptor = .{};
// 		tex_desc.label = "Dear ImGui Font Texture";
// 		tex_desc.dimension = WGPUTextureDimension._2D;
// 		tex_desc.size.width = xx width;
// 		tex_desc.size.height = xx height;
// 		tex_desc.size.depthOrArrayLayers = 1;
// 		tex_desc.sampleCount = 1;
// 		tex_desc.format = WGPUTextureFormat.RGBA8Unorm;
// 		tex_desc.mipLevelCount = 1;
// 		tex_desc.usage = xx WGPUTextureUsage.CopyDst | WGPUTextureUsage.TextureBinding;
// 		bd.renderResources.FontTexture = wgpuDeviceCreateTexture(bd.wgpuDevice, *tex_desc);

// 		tex_view_desc:WGPUTextureViewDescriptor = .{};
// 		tex_view_desc.format = WGPUTextureFormat.RGBA8Unorm;
// 		tex_view_desc.dimension = WGPUTextureViewDimension._2D;
// 		tex_view_desc.baseMipLevel = 0;
// 		tex_view_desc.mipLevelCount = 1;
// 		tex_view_desc.baseArrayLayer = 0;
// 		tex_view_desc.arrayLayerCount = 1;
// 		tex_view_desc.aspect = WGPUTextureAspect.All;
// 		bd.renderResources.FontTextureView = wgpuTextureCreateView(bd.renderResources.FontTexture, *tex_view_desc);
// 	}

// 	// Upload texture data
// 	{
// 		dst_view:WGPUImageCopyTexture = .{};
// 		dst_view.texture = bd.renderResources.FontTexture;
// 		dst_view.mipLevel = 0;
// 		dst_view.origin = .{ 0, 0, 0 };
// 		dst_view.aspect = WGPUTextureAspect.All;
// 		layout:WGPUTextureDataLayout = .{};
// 		layout.offset = 0;
// 		layout.bytesPerRow = xx (width * size_pp);
// 		layout.rowsPerImage = xx height;
// 		size: WGPUExtent3D = .{ width = xx width, height = xx height, depthOrArrayLayers = 1 };
// 		wgpuQueueWriteTexture(bd.defaultQueue, *dst_view, pixels.data, xx (width * size_pp * height), *layout, *size);
// 	}

// 	// Create the associated sampler
// 	// (Bilinear sampling is required by default. Set 'io.Fonts->Flags |= ImFontAtlasFlags_NoBakedLines' or 'style.AntiAliasedLinesUseTex = false' to allow point/nearest sampling)
// 	{
// 		sampler_desc:WGPUSamplerDescriptor = .{};
// 		sampler_desc.minFilter = WGPUFilterMode.Linear;
// 		sampler_desc.magFilter = WGPUFilterMode.Linear;
// 		sampler_desc.mipmapFilter = WGPUMipmapFilterMode.Linear;
// 		sampler_desc.addressModeU = WGPUAddressMode.Repeat;
// 		sampler_desc.addressModeV = WGPUAddressMode.Repeat;
// 		sampler_desc.addressModeW = WGPUAddressMode.Repeat;
// 		sampler_desc.maxAnisotropy = 1;
// 		bd.renderResources.Sampler = wgpuDeviceCreateSampler(bd.wgpuDevice, *sampler_desc);
// 	}

// 	// Store our identifier
// 	assert(size_of(ImTextureID) >= size_of(type_of(bd.renderResources.FontTexture)), "Can't pack descriptor handle into TexID, 32-bit not supported yet.");
// 	io.Fonts.TexID = xx bd.renderResources.FontTextureView;
// }

// ImGui_ImplWGPU_CreateUniformBuffer :: () {
// 	bd := ImGui_ImplWGPU_GetBackendData();
// 	ub_desc:WGPUBufferDescriptor =
// 	.{
// 		null,
// 		"Dear ImGui Uniform buffer",
// 		xx WGPUBufferUsage.CopyDst | WGPUBufferUsage.Uniform,
// 		memalign(size_of(Uniforms), 16),
// 		xx false
// 	};
// 	bd.renderResources.Uniforms = wgpuDeviceCreateBuffer(bd.wgpuDevice, *ub_desc);
// }




// ImGui_ImplWGPU_CreateDeviceObjects :: () -> bool
// {
// 	print("ImGui_ImplWGPU_CreateDeviceObjects\n");
// 	bd := ImGui_ImplWGPU_GetBackendData();
// 	if (bd.wgpuDevice)
// 		return false;
// 	if (bd.pipelineState)
// 		ImGui_ImplWGPU_InvalidateDeviceObjects();

// 	// Create render pipeline
// 	graphics_pipeline_desc := WGPURenderPipelineDescriptor.{};
// 	graphics_pipeline_desc.primitive.topology = WGPUPrimitiveTopology.TriangleList;
// 	graphics_pipeline_desc.primitive.stripIndexFormat = WGPUIndexFormat.Undefined;
// 	graphics_pipeline_desc.primitive.frontFace = WGPUFrontFace.CW;
// 	graphics_pipeline_desc.primitive.cullMode = WGPUCullMode.None;
// 	graphics_pipeline_desc.multisample.count = 1;
// 	graphics_pipeline_desc.multisample.mask = U32_MAX;
// 	graphics_pipeline_desc.multisample.alphaToCoverageEnabled = xx false;

// 	// Bind group layouts
// 	common_bg_layout_entries: [2]WGPUBindGroupLayoutEntry;
// 	common_bg_layout_entries[0].binding = 0;
// 	common_bg_layout_entries[0].visibility = xx WGPUShaderStage.Vertex | WGPUShaderStage.Fragment;
// 	common_bg_layout_entries[0].buffer.type = WGPUBufferBindingType.Uniform;
// 	common_bg_layout_entries[1].binding = 1;
// 	common_bg_layout_entries[1].visibility = xx WGPUShaderStage.Fragment;
// 	common_bg_layout_entries[1].sampler.type = WGPUSamplerBindingType.Filtering;

// 	image_bg_layout_entries:[1]WGPUBindGroupLayoutEntry;
// 	image_bg_layout_entries[0].binding = 0;
// 	image_bg_layout_entries[0].visibility = xx WGPUShaderStage.Fragment;
// 	image_bg_layout_entries[0].texture.sampleType = WGPUTextureSampleType.Float;
// 	image_bg_layout_entries[0].texture.viewDimension = WGPUTextureViewDimension._2D;

// 	common_bg_layout_desc:WGPUBindGroupLayoutDescriptor;
// 	common_bg_layout_desc.entryCount = 2;
// 	common_bg_layout_desc.entries = common_bg_layout_entries.data;

// 	image_bg_layout_desc:WGPUBindGroupLayoutDescriptor;
// 	image_bg_layout_desc.entryCount = 1;
// 	image_bg_layout_desc.entries = image_bg_layout_entries.data;

// 	bg_layouts:[2]WGPUBindGroupLayout;
// 	bg_layouts[0] = wgpuDeviceCreateBindGroupLayout(bd.wgpuDevice, *common_bg_layout_desc);
// 	bg_layouts[1] = wgpuDeviceCreateBindGroupLayout(bd.wgpuDevice, *image_bg_layout_desc);

// 	layout_desc:WGPUPipelineLayoutDescriptor;
// 	layout_desc.bindGroupLayoutCount = 2;
// 	layout_desc.bindGroupLayouts = bg_layouts.data;
// 	graphics_pipeline_desc.layout = wgpuDeviceCreatePipelineLayout(bd.wgpuDevice, *layout_desc);

// 	// Create the vertex shader
// 	vertex_shader_desc:WGPUProgrammableStageDescriptor = ImGui_ImplWGPU_CreateShaderModule(*__shader_vert_wgsl);
// 	graphics_pipeline_desc.vertex.module = vertex_shader_desc.module;
// 	graphics_pipeline_desc.vertex.entryPoint = vertex_shader_desc.entryPoint;

// 	// Vertex input configuration
// 	attribute_desc:[3]WGPUVertexAttribute;
// 	attribute_desc[0] = .{format = WGPUVertexFormat.Float32x2, offset = xx offset_of(type_info(ImDrawVert), "pos"), shaderLocation = 0};
// 	attribute_desc[1] = .{format = WGPUVertexFormat.Float32x2, offset = xx offset_of(type_info(ImDrawVert), "uv"), shaderLocation = 1};
// 	attribute_desc[2] = .{format = WGPUVertexFormat.Unorm8x4, offset = xx offset_of(type_info(ImDrawVert), "col"), shaderLocation = 2};

// 	buffer_layouts:[1]WGPUVertexBufferLayout;
// 	buffer_layouts[0] = .{arrayStride = size_of(ImDrawVert), stepMode = WGPUVertexStepMode.Vertex, attributeCount = 3, attributes = attribute_desc.data};

// 	graphics_pipeline_desc.vertex.bufferCount = 1;
// 	graphics_pipeline_desc.vertex.buffers = buffer_layouts.data;

// 	// Create the pixel shader
// 	pixel_shader_desc :WGPUProgrammableStageDescriptor= ImGui_ImplWGPU_CreateShaderModule(*__shader_frag_wgsl);

// 	// Create the blending setup
// 	blend_state:WGPUBlendState;
// 	blend_state.alpha.operation = WGPUBlendOperation.Add;
// 	blend_state.alpha.srcFactor = WGPUBlendFactor.One;
// 	blend_state.alpha.dstFactor = WGPUBlendFactor.OneMinusSrcAlpha;
// 	blend_state.color.operation = WGPUBlendOperation.Add;
// 	blend_state.color.srcFactor = WGPUBlendFactor.SrcAlpha;
// 	blend_state.color.dstFactor = WGPUBlendFactor.OneMinusSrcAlpha;

// 	color_state:WGPUColorTargetState;
// 	color_state.format = bd.renderTargetFormat;
// 	color_state.blend = *blend_state;
// 	color_state.writeMask = xx WGPUColorWriteMask.All;

// 	fragment_state:WGPUFragmentState;
// 	fragment_state.module = pixel_shader_desc.module;
// 	fragment_state.entryPoint = pixel_shader_desc.entryPoint;
// 	fragment_state.targetCount = 1;
// 	fragment_state.targets = *color_state;

// 	graphics_pipeline_desc.fragment = *fragment_state;

// 	// Create depth-stencil State
// 	depth_stencil_state:WGPUDepthStencilState;
// 	depth_stencil_state.format = bd.depthStencilFormat;
// 	depth_stencil_state.depthWriteEnabled = xx false;
// 	depth_stencil_state.depthCompare = WGPUCompareFunction.Always;
// 	depth_stencil_state.stencilFront.compare = WGPUCompareFunction.Always;
// 	depth_stencil_state.stencilBack.compare = WGPUCompareFunction.Always;

// 	// Configure disabled depth-stencil state
// 	graphics_pipeline_desc.depthStencil = ifx (bd.depthStencilFormat == WGPUTextureFormat.Undefined) then null else *depth_stencil_state;

// 	print("**** assign pipeline state\n");
// 	bd.pipelineState = *wgpuDeviceCreateRenderPipeline(bd.wgpuDevice, *graphics_pipeline_desc);

// 	ImGui_ImplWGPU_CreateFontsTexture();
// 	ImGui_ImplWGPU_CreateUniformBuffer();

// 	// Create resource bind group
// 	common_bg_entries:[2]WGPUBindGroupEntry;
// 	common_bg_entries[0] = .{ binding=0, buffer=bd.renderResources.Uniforms, offset=0, size=xx memalign(size_of(Uniforms), 16), sampler=null, textureView=null };
// 	common_bg_entries[1] = .{ binding=1, buffer=null, offset=0, size=0, sampler=bd.renderResources.Sampler, textureView=null };
// 	// {
// 	// 	{ nullptr, 0, bd->renderResources.Uniforms, 0, MEMALIGN(size_of(Uniforms), 16), 0, 0 },
// 	// 	{ nullptr, 1, 0, 0, 0, bd->renderResources.Sampler, 0 },
// 	// };

// 	common_bg_descriptor:WGPUBindGroupDescriptor;
// 	common_bg_descriptor.layout = bg_layouts[0];
// 	common_bg_descriptor.entryCount = common_bg_entries.count;// / size_of(WGPUBindGroupEntry);
// 	common_bg_descriptor.entries = common_bg_entries.data;
// 	bd.renderResources.CommonBindGroup = wgpuDeviceCreateBindGroup(bd.wgpuDevice, *common_bg_descriptor);

// 	image_bind_group:WGPUBindGroup = ImGui_ImplWGPU_CreateImageBindGroup(bg_layouts[1], bd.renderResources.FontTextureView);
// 	bd.renderResources.ImageBindGroup = image_bind_group;
// 	bd.renderResources.ImageBindGroupLayout = bg_layouts[1];
// 	bd.renderResources.ImageBindGroups.SetVoidPtr(
// 		*bd.renderResources.ImageBindGroups,
// 		ImHashData(bd.renderResources.FontTextureView, size_of(ImTextureID), 0),
// 		image_bind_group
// 	);

// 	SafeRelease(*vertex_shader_desc.module);
// 	SafeRelease(*pixel_shader_desc.module);
// 	SafeRelease(*bg_layouts[0]);

// 	return true;
// }

// ImGui_ImplWGPU_InvalidateDeviceObjects::() {
// 	bd := ImGui_ImplWGPU_GetBackendData();
// 	if (!bd.wgpuDevice)
// 		return;

// 	SafeRelease(bd.pipelineState);
// 	SafeRelease(*bd.renderResources);

// 	io := ImGui.GetIO();
// 	io.Fonts.TexID = xx 0; //.SetTexID(0); // We copied g_pFontTextureView to io.Fonts->TexID so let's clear that as well.

// 	// for (unsigned int i = 0; i < bd->numFramesInFlight; i++)
// 	for 0..bd.numFramesInFlight {
// 		SafeRelease(*bd.pFrameResources[it]);
// 	}
// }

// // device: WGPUDevice, num_frames_in_flight:u64, rt_format:WGPUTextureFormat, depth_format: WGPUTextureFormat
// ImGui_ImplWGPU_Init :: ( info: *ImGui_ImplWGPU_InitInfo) -> bool
// {
// 	io := ImGui.GetIO();
// 	//IM_ASSERT(io.BackendRendererUserData == nullptr && "Already initialized a renderer backend!");
// 	assert(io.BackendRendererUserData == null, "Already initialized a renderer backend!");

// 	// Setup backend capabilities flags
// 	// bd := IM_NEW(ImGui_ImplWGPU_Data)();
// 	bd :ImGui_ImplWGPU_Data= New(ImGui_ImplWGPU_Data);
// 	print("init%\n", bd);
// 	print("init 2%\n", bd.pipelineState);
// 	io.BackendRendererUserData = *bd;
// 	io.BackendRendererName = "imgui_impl_webgpu";
// 	io.BackendFlags |= ImGuiBackendFlags.RendererHasVtxOffset;  // We can honor the ImDrawCmd::VtxOffset field, allowing for large meshes.

// 	bd.wgpuDevice = info.Device;
// 	bd.defaultQueue = wgpuDeviceGetQueue(bd.wgpuDevice);
// 	bd.renderTargetFormat = info.RenderTargetFormat;
// 	bd.depthStencilFormat = info.DepthStencilFormat;
// 	bd.numFramesInFlight = info.NumFramesInFlight;
// 	bd.frameIndex = U32_MAX;//UINT_MAX;

// 	bd.renderResources.FontTexture = null;
// 	bd.renderResources.FontTextureView = null;
// 	bd.renderResources.Sampler = null;
// 	bd.renderResources.Uniforms = null;
// 	bd.renderResources.CommonBindGroup = null;
// 	// bd.renderResources.ImageBindGroups.Data.reserve(100);
// 	bd.renderResources.ImageBindGroup = null;
// 	bd.renderResources.ImageBindGroupLayout = null;

// 	// Create buffers with a default size (they will later be grown as needed)
// 	// frame_resources := [..]FrameResources;
// 	// print("%\n", type_of([..]FrameResources));
// 	// bd.pFrameResources = [..]FrameResources; //New(FrameResources[num_frames_in_flight]);
// 	for 0..(info.NumFramesInFlight-1) {
// 		array_add(*bd.pFrameResources, .{
// 			IndexBuffer = null,
// 			VertexBuffer = null,
// 			IndexBufferHost = null,
// 			VertexBufferHost = null,
// 			IndexBufferSize = 10000,
// 			VertexBufferSize = 5000,
// 		});
// 	}

// 	return true;
// }

// ImGui_ImplWGPU_Shutdown :: () {
// 	bd := ImGui_ImplWGPU_GetBackendData();
// 	assert(bd != null, "No renderer backend to shutdown, or already shutdown?");
// 	io := ImGui.GetIO();

// 	ImGui_ImplWGPU_InvalidateDeviceObjects();
// 	// delete[] bd->pFrameResources;
// 	// free(bd.pFrameResources);
// 	for *bd.pFrameResources free(it);
// 	array_reset(*bd.pFrameResources);

// 	// bd.pFrameResources = null;
// 	wgpuQueueRelease(bd.defaultQueue);
// 	bd.wgpuDevice = null;
// 	bd.numFramesInFlight = 0;
// 	bd.frameIndex = U64_MAX;

// 	io.BackendRendererName = null;
// 	io.BackendRendererUserData = null;
// 	io.BackendFlags &= ~ImGuiBackendFlags.RendererHasVtxOffset;
// 	free(bd); // IM_DELETE(bd);
// }

// ImGui_ImplWGPU_NewFrame :: () {
// 	print("A\n");
// 	bd := ImGui_ImplWGPU_GetBackendData();
// 	print("A1\n");
// 	print("bd:%\n", bd);
// 	print("bd.pipelineState:%\n", bd.pipelineState);
// 	print("bd.pipelineState==null:%\n", bd.pipelineState==null);
// 	if (bd.pipelineState==null) {
// 		print("A2\n");
// 		ImGui_ImplWGPU_CreateDeviceObjects();
// 	}
// }