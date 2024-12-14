ImGui_ImplWGPU_InvalidateDeviceObjects :: (bd:*ImGui_ImplWGPU_Data) {
	// bd :*ImGui_ImplWGPU_Data= ImGui_ImplWGPU_GetBackendData();
	if (bd.wgpuDevice==null){
		return;
	}
	// we currently don't invalidate
	// as this crashes and we can resize the window just fine without it.
	// Although it is a big slow, and may lead to memory leaks.
	// SafeReleasePipelineState(*bd.pipeline);
	// SafeReleaseRenderResources(*bd.renderResources);

	// io := ImGui.GetIO();
	// io.Fonts.TexID = xx 0; //.SetTexID(0); // We copied g_pFontTextureView to io.Fonts->TexID so let's clear that as well.

	// for bd.pFrameResources SafeReleaseFrameResources(*it);
}



ImGui_ImplWGPU_Shutdown :: (imguiPolygonContext: *ImguiPolygonContext) {
	bd:*ImGui_ImplWGPU_Data=*imguiPolygonContext.bd;
	// bd := ImGui_ImplWGPU_GetBackendData();
	assert(bd != null, "No renderer backend to shutdown, or already shutdown?");
	

	ImGui_ImplWGPU_InvalidateDeviceObjects(bd);
	// delete[] bd->pFrameResources;
	// free(bd.pFrameResources);
	// for *bd.pFrameResources free(it);
	array_reset(*bd.pFrameResources);

	// bd.pFrameResources = null;
	// wgpuQueueRelease(bd.defaultQueue);
	bd.wgpuDevice = null;
	bd.numFramesInFlight = 0;
	bd.frameIndex = U64_MAX;

	if(imguiPolygonContext.io != null){
		io := ImGui.GetIO();
		io.BackendRendererName = null;
		io.BackendRendererUserData = null;
		io.BackendFlags &= ~ImGuiBackendFlags.RendererHasVtxOffset;
	}
	// free(bd); // IM_DELETE(bd);
}

imgui_gui_free :: (imguiPolygonContext: *ImguiPolygonContext){
	#if FREE_MEMORY {
		array_reset(*imguiPolygonContext.iwc.draw.vertices);
		array_reset(*imguiPolygonContext.iwc.draw.indices);
	}
}