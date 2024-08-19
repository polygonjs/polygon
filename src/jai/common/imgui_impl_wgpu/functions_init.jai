ImGui_ImplWGPU_GetBackendData :: ()-> *ImGui_ImplWGPU_Data {
	// print("-- ImGui_ImplWGPU_GetBackendData:%\n", debug_message);
	// if (ImGui.GetCurrentContext()){
	// 	bdpv := ImGui.GetIO().BackendRendererUserData;
	// 	// print("ImGui_ImplWGPU_GetBackendData:bdpv:%\n", bdpv);
	// 	bdp:= cast(*ImGui_ImplWGPU_Data) bdpv;
	// 	// print("ImGui_ImplWGPU_GetBackendData:device: %\n", (<<bdp).wgpuDevice);
	// 	return bdp;
	// } else {
	// 	return null;
	// }
	return ifx ImGui.GetCurrentContext() then cast(*ImGui_ImplWGPU_Data) ImGui.GetIO().BackendRendererUserData else null;
}

// device: WGPUDevice, num_frames_in_flight:u64, rt_format:WGPUTextureFormat, depth_format: WGPUTextureFormat
ImGui_ImplWGPU_Init :: (
	bd:*ImGui_ImplWGPU_Data,
	info: ImGui_ImplWGPU_InitInfo
) -> bool {
	io := ImGui.GetIO();
	//IM_ASSERT(io.BackendRendererUserData == nullptr && "Already initialized a renderer backend!");
	assert(io.BackendRendererUserData == null, "Already initialized a renderer backend!");

	// Setup backend capabilities flags
	// bd := IM_NEW(ImGui_ImplWGPU_Data)();
	// bd:ImGui_ImplWGPU_Data = New(ImGui_ImplWGPU_Data);
	io.BackendRendererUserData = bd;
	io.BackendRendererName = "imgui_impl_webgpu";
	io.BackendFlags |= ImGuiBackendFlags.RendererHasVtxOffset;  // We can honor the ImDrawCmd::VtxOffset field, allowing for large meshes.

	// bd.wgpuDevice = info.Device;
	bd.defaultQueue = wgpuDeviceGetQueue(bd.wgpuDevice);
	bd.renderTargetFormat = info.RenderTargetFormat;
	bd.depthStencilFormat = info.DepthStencilFormat;
	bd.numFramesInFlight = info.NumFramesInFlight;
	bd.frameIndex = U32_MAX;//UINT_MAX;

	bd.renderResources.FontTexture = null;
	bd.renderResources.FontTextureView = null;
	bd.renderResources.Sampler = null;
	bd.renderResources.Uniforms = null;
	bd.renderResources.CommonBindGroup = null;
	// bd.renderResources.ImageBindGroups.Data.reserve(100);
	bd.renderResources.ImageBindGroup = null;
	bd.renderResources.ImageBindGroupLayout = null;

	// Create buffers with a default size (they will later be grown as needed)
	// frame_resources := [..]FrameResources;
	// bd.pFrameResources = [..]FrameResources; //New(FrameResources[num_frames_in_flight]);
	for 0..(info.NumFramesInFlight-1) {
		array_add(*bd.pFrameResources, .{
			IndexBuffer = null,
			VertexBuffer = null,
			IndexBufferHost = null,
			VertexBufferHost = null,
			IndexBufferSize = 10000,
			VertexBufferSize = 5000,
		});
	}
	this_allocation_is_not_a_leak(bd.pFrameResources.data);
	// bd2 := ImGui_ImplWGPU_GetBackendData();
	return true;
}