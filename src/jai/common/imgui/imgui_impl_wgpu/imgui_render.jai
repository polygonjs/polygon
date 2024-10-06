ImGui_ImplWGPU_SetupRenderState :: ( draw_data: *ImDrawData, ctx: WGPURenderPassEncoder, fr: *FrameResources) {
	bd := ImGui_ImplWGPU_GetBackendData();

	// Setup orthographic projection matrix into our constant buffer
	// Our visible imgui space lies from draw_data->DisplayPos (top left) to draw_data->DisplayPos+data_data->DisplaySize (bottom right).
	{
		L: = draw_data.DisplayPos.x;
		R: = draw_data.DisplayPos.x + draw_data.DisplaySize.x;
		T: = draw_data.DisplayPos.y;
		B: = draw_data.DisplayPos.y + draw_data.DisplaySize.y;
		mvp: Matrix4 =
		.{
			2.0/(R-L),   0.0,           0.0,       0.0,
			0.0,         2.0/(T-B),     0.0,       0.0,
			0.0,         0.0,           0.5,       0.0,
			(R+L)/(L-R),  (T+B)/(B-T),    0.5,       1.0,
		};
		// mvp = transpose(mvp);
		// TODO: copy this buffer like I copy the matrix4 for the webgpu camera uniforms
		wgpuQueueWriteBuffer(
			bd.defaultQueue,
			bd.renderResources.Uniforms,
			xx offset_of(type_info(ImGui_WGPU_Uniforms), "MVP"),
			*mvp.coef,
			size_of(type_of(ImGui_WGPU_Uniforms.MVP))
		);
		// gamma:float;
		// if bd.renderTargetFormat == {
		// case WGPUTextureFormat.ASTC10x10UnormSrgb;
		// case WGPUTextureFormat.ASTC10x5UnormSrgb;
		// case WGPUTextureFormat.ASTC10x6UnormSrgb;
		// case WGPUTextureFormat.ASTC10x8UnormSrgb;
		// case WGPUTextureFormat.ASTC12x10UnormSrgb;
		// case WGPUTextureFormat.ASTC12x12UnormSrgb;
		// case WGPUTextureFormat.ASTC4x4UnormSrgb;
		// case WGPUTextureFormat.ASTC5x5UnormSrgb;
		// case WGPUTextureFormat.ASTC6x5UnormSrgb;
		// case WGPUTextureFormat.ASTC6x6UnormSrgb;
		// case WGPUTextureFormat.ASTC8x5UnormSrgb;
		// case WGPUTextureFormat.ASTC8x6UnormSrgb;
		// case WGPUTextureFormat.ASTC8x8UnormSrgb;
		// case WGPUTextureFormat.BC1RGBAUnormSrgb;
		// case WGPUTextureFormat.BC2RGBAUnormSrgb;
		// case WGPUTextureFormat.BC3RGBAUnormSrgb;
		// case WGPUTextureFormat.BC7RGBAUnormSrgb;
		// case WGPUTextureFormat.BGRA8UnormSrgb;
		// case WGPUTextureFormat.ETC2RGB8A1UnormSrgb;
		// case WGPUTextureFormat.ETC2RGB8UnormSrgb;
		// case WGPUTextureFormat.ETC2RGBA8UnormSrgb;
		// case WGPUTextureFormat.RGBA8UnormSrgb;
		// 	gamma = 2.2;
		// case;
		// 	gamma = 1.0;
		// }
		// wgpuQueueWriteBuffer(
		// 	bd.defaultQueue,
		// 	bd.renderResources.Uniforms,
		// 	xx offset_of(type_info(ImGui_WGPU_Uniforms), "Gamma"),
		// 	*gamma,
		// 	size_of(type_of(ImGui_WGPU_Uniforms.Gamma))
		// );
	}

	// Setup viewport
	wgpuRenderPassEncoderSetViewport(ctx, 0, 0, draw_data.FramebufferScale.x * draw_data.DisplaySize.x, draw_data.FramebufferScale.y * draw_data.DisplaySize.y, 0, 1);

	// Bind shader and vertex buffers
	vertex_buffer_size:= fr.VertexBufferSize * size_of(ImDrawVert);
	wgpuRenderPassEncoderSetVertexBuffer(
		ctx,
		0,
		fr.VertexBuffer,
		0,
		xx vertex_buffer_size
	);
	index_buffer_format := ifx (size_of(ImDrawIdx) == 2) then WGPUIndexFormat.Uint16 else WGPUIndexFormat.Uint32;
	wgpuRenderPassEncoderSetIndexBuffer(ctx, fr.IndexBuffer, index_buffer_format, 0, fr.IndexBufferSize * size_of(ImDrawIdx));
	wgpuRenderPassEncoderSetPipeline(ctx, bd.pipeline);
	wgpuRenderPassEncoderSetBindGroup(ctx, 0, bd.renderResources.CommonBindGroup, 0, null);

	// Setup blend factor
	blend_color:WGPUColor = .{ 0, 0, 0, 0 };
	wgpuRenderPassEncoderSetBlendConstant(ctx, *blend_color);
}

// Render function
// (this used to be set in io.RenderDrawListsFn and called by ImGui::Render(), but you can now call this directly from your main loop)
ImGui_ImplWGPU_RenderDrawData :: ( iwc_draw:*ImGui_WGPU_Common_Draw, draw_data:*ImDrawData, pass_encoder: WGPURenderPassEncoder) {
	// print("ImGui_ImplWGPU_RenderDrawData: quick return\n");
	// if(1+1)return;
	// print_yellow("ImGui_ImplWGPU_RenderDrawData START\n");
	// Avoid rendering when minimized
	width := draw_data.DisplaySize.x * draw_data.FramebufferScale.x;
	height := draw_data.DisplaySize.y * draw_data.FramebufferScale.y;
	if (width <= 0.0 || height <= 0.0 || draw_data.CmdListsCount == 0){
		print_red(tprint("not rendering, width:%, height:%, draw_data.CmdListsCount:%\n", width, height, draw_data.CmdListsCount));
		return;
	}

	// FIXME: Assuming that this only gets called once per frame!
	// If not, we can't just re-allocate the IB or VB, we'll have to do a proper allocator.
	bd := ImGui_ImplWGPU_GetBackendData();
	bd.frameIndex = bd.frameIndex + 1;
	frame_index := bd.frameIndex % bd.numFramesInFlight;
	fr := *(bd.pFrameResources[frame_index]);

	// Create and grow vertex/index buffers if needed
	array_reset(*iwc_draw.vertices);
	array_reset(*iwc_draw.indices);
	if (fr.VertexBuffer == null || fr.VertexBufferSize < xx draw_data.TotalVtxCount) {
		if (fr.VertexBuffer) {
			wgpuBufferDestroy(fr.VertexBuffer);
			// wgpuBufferRelease(fr.VertexBuffer);
			fr.VertexBuffer = null;
		}
		SafeReleaseImDrawVert(fr.VertexBufferHost);
		if (fr.VertexBuffer == null){
			fr.VertexBufferSize = cast(u64) draw_data.TotalVtxCount + 5000;

			vb_desc:WGPUBufferDescriptor = .{
				label = "Dear ImGui Vertex buffer",
				usage = xx WGPUBufferUsage.CopyDst | WGPUBufferUsage.Vertex,
				size = memalign(fr.VertexBufferSize * size_of(ImDrawVert), 4),
				mappedAtCreation = xx false
			};

			fr.VertexBuffer = wgpuDeviceCreateBuffer(bd.wgpuDevice, *vb_desc);
		}
		if (!fr.VertexBuffer) {
			print_red("fr.VertexBuffer not created\n");
			return;
		}

		for 0..(fr.VertexBufferSize-1) {
			array_add(*iwc_draw.vertices, .{});
		}
		fr.VertexBufferHost = iwc_draw.vertices.data; //New(ImDrawVert[fr.VertexBufferSize]);
	}
	if (fr.IndexBuffer == null || fr.IndexBufferSize < xx draw_data.TotalIdxCount) {
		if (fr.IndexBuffer) {
			wgpuBufferDestroy(fr.IndexBuffer);
			// wgpuBufferRelease(fr.IndexBuffer);
			fr.IndexBuffer = null;
		}
		// SafeReleaseImDrawIdx(fr.IndexBufferHost);
		if (fr.IndexBuffer == null){
			fr.IndexBufferSize = cast(u64) draw_data.TotalIdxCount + 10000;

			ib_desc:WGPUBufferDescriptor = .{
				label = "Dear ImGui Index buffer",
				usage = xx WGPUBufferUsage.CopyDst | WGPUBufferUsage.Index,
				size = memalign(fr.IndexBufferSize * size_of(ImDrawIdx), 4),
				mappedAtCreation = xx false
			};
			fr.IndexBuffer = wgpuDeviceCreateBuffer(bd.wgpuDevice, *ib_desc);
			if (!fr.IndexBuffer){
				print_red("fr.IndexBuffer not created\n");
				return;
			}
		}

		for 0..(fr.IndexBufferSize-1) {
			array_add(*iwc_draw.indices, 0);
		}
		fr.IndexBufferHost = iwc_draw.indices.data;
	}

	// Upload vertex/index data into a single contiguous GPU buffer
	vtx_dst:*ImDrawVert = fr.VertexBufferHost;
	assert(vtx_dst!=null, "fr.VertexBufferHost is null\n");
	idx_dst:*ImDrawIdx = fr.IndexBufferHost;
	assert(idx_dst!=null, "idx_dst is null\n");
	for n:0..(draw_data.CmdListsCount-1) {
		cmd_list:*ImDrawList = draw_data.CmdLists.Data[n];//*size_of(ImDrawList)]; //draw_data.CmdLists[n];
		memcpy(vtx_dst, cmd_list.VtxBuffer.Data, cmd_list.VtxBuffer.Size * size_of(ImDrawVert));
		memcpy(idx_dst, cmd_list.IdxBuffer.Data, cmd_list.IdxBuffer.Size * size_of(ImDrawIdx));
		vtx_dst += cmd_list.VtxBuffer.Size;
		idx_dst += cmd_list.IdxBuffer.Size;
	}
	// vb_write_size:s64  = MEMALIGN((char*)vtx_dst - (char*)fr.VertexBufferHost, 4);
	// ib_write_size:s64  = MEMALIGN((char*)idx_dst - (char*)fr>IndexBufferHost, 4);
	vb_write_size := memalign((cast(u64) vtx_dst) - (cast(u64) fr.VertexBufferHost), 4);
	ib_write_size := memalign((cast(u64) idx_dst) - (cast(u64) fr.IndexBufferHost), 4);
	wgpuQueueWriteBuffer(bd.defaultQueue, fr.VertexBuffer, 0, fr.VertexBufferHost, vb_write_size);
	wgpuQueueWriteBuffer(bd.defaultQueue, fr.IndexBuffer,  0, fr.IndexBufferHost,  ib_write_size);

	// Setup desired render state
	fr2 := bd.pFrameResources[frame_index];
	ImGui_ImplWGPU_SetupRenderState(draw_data, pass_encoder, *fr2);

	// Render command lists
	// (Because we merged all buffers into a single one, we maintain our own offset into them)
	global_vtx_offset:int = 0;
	global_idx_offset:int = 0;
	clip_scale:ImVec2 = draw_data.FramebufferScale;
	clip_off:ImVec2 = draw_data.DisplayPos;
	for n:0..(draw_data.CmdListsCount-1) {
		cmd_list :*ImDrawList= draw_data.CmdLists.Data[n];//*size_of(ImDrawList)]; //draw_data.CmdLists[n];
		//for (int cmd_i = 0; cmd_i < cmd_list->CmdBuffer.Size; cmd_i++)
		for cmd_i: 0..(cmd_list.CmdBuffer.Size-1) {
			pcmd:ImDrawCmd = cmd_list.CmdBuffer.Data[cmd_i];//*size_of(ImDrawCmd)]; //;cmd_list.CmdBuffer[cmd_i];
			if (pcmd.UserCallback != null) {
				print("pcmd.UserCallback not null:%\n", pcmd.UserCallback);
				// User callback, registered via ImDrawList::AddCallback()
				// (ImDrawCallback_ResetRenderState is a special callback value used by the user to request the renderer to reset render state.)
				// if (pcmd.UserCallback == ImDrawCallback.ResetRenderState)
					ImGui_ImplWGPU_SetupRenderState(draw_data, pass_encoder, *fr2);
				// else
				// pcmd.UserCallback(cmd_list, *pcmd);
				print("UserCallback DONE\n");
			} else {
				// Bind custom texture
				tex_id:ImTextureID = pcmd.TextureId;//pcmd.GetTexID();
				tex_id_hash:ImGuiID = ImHashData(tex_id, size_of(type_of(tex_id)), 0);
				bind_group := bd.renderResources.ImageBindGroups.GetVoidPtr(*bd.renderResources.ImageBindGroups, tex_id_hash);
				if (bind_group) {
					wgpuRenderPassEncoderSetBindGroup(pass_encoder, 1, bind_group, 0, null);
				} else {
					image_bind_group:WGPUBindGroup = ImGui_ImplWGPU_CreateImageBindGroup(bd.renderResources.ImageBindGroupLayout, cast(WGPUTextureView)tex_id);
					bd.renderResources.ImageBindGroups.SetVoidPtr(*bd.renderResources.ImageBindGroups, tex_id_hash, image_bind_group);
					wgpuRenderPassEncoderSetBindGroup(pass_encoder, 1, image_bind_group, 0, null);
				}

				// Project scissor/clipping rectangles into framebuffer space
				clip_min:ImVec2=.{
					(pcmd.ClipRect.x - clip_off.x) * clip_scale.x,
					(pcmd.ClipRect.y - clip_off.y) * clip_scale.y
				};
				clip_max:ImVec2=.{
					(pcmd.ClipRect.z - clip_off.x) * clip_scale.x,
					(pcmd.ClipRect.w - clip_off.y) * clip_scale.y
				};
				if (clip_max.x <= clip_min.x || clip_max.y <= clip_min.y){
					print_yellow("incorrect clip bounds\n");
					continue;
				}

				// Apply scissor/clipping rectangle, Draw
				wgpuRenderPassEncoderSetScissorRect(pass_encoder, xx clip_min.x, xx clip_min.y, xx (clip_max.x - clip_min.x), xx (clip_max.y - clip_min.y));
				wgpuRenderPassEncoderDrawIndexed(pass_encoder, pcmd.ElemCount, 1, xx (pcmd.IdxOffset + global_idx_offset), xx (pcmd.VtxOffset + global_vtx_offset), 0);
			}
		}
		global_idx_offset += cmd_list.IdxBuffer.Size;
		global_vtx_offset += cmd_list.VtxBuffer.Size;
	}
	// print_green("ImGui_ImplWGPU_RenderDrawData DONE\n");

}

// ImGui_ImplWGPU_NewFrame :: () {
// 	print("ImGui_ImplWGPU_NewFrame START\n");
// 	bd := ImGui_ImplWGPU_GetBackendData("ImGui_ImplWGPU_NewFrame");
// 	if (bd.pipeline==null) {
// 		print("A2\n");
// 		ImGui_ImplWGPU_CreateDeviceObjects();
// 	}
// 	print("ImGui_ImplWGPU_NewFrame DONE\n");
// }