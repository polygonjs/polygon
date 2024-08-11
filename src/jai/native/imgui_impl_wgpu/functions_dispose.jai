ImGui_ImplWGPU_InvalidateDeviceObjects::() {
	bd :*ImGui_ImplWGPU_Data= ImGui_ImplWGPU_GetBackendData();
	if (bd.wgpuDevice==null){
		return;
	}
	SafeReleasePipelineState(*bd.pipeline);
	SafeReleaseRenderResources(*bd.renderResources);

	io := ImGui.GetIO();
	io.Fonts.TexID = xx 0; //.SetTexID(0); // We copied g_pFontTextureView to io.Fonts->TexID so let's clear that as well.

	// // for (unsigned int i = 0; i < bd->numFramesInFlight; i++)
	for bd.pFrameResources SafeReleaseFrameResources(*it);
}



ImGui_ImplWGPU_Shutdown :: () {
	bd := ImGui_ImplWGPU_GetBackendData();
	assert(bd != null, "No renderer backend to shutdown, or already shutdown?");
	io := ImGui.GetIO();

	ImGui_ImplWGPU_InvalidateDeviceObjects();
	// delete[] bd->pFrameResources;
	// free(bd.pFrameResources);
	// for *bd.pFrameResources free(it);
	array_reset(*bd.pFrameResources);

	// bd.pFrameResources = null;
	wgpuQueueRelease(bd.defaultQueue);
	bd.wgpuDevice = null;
	bd.numFramesInFlight = 0;
	bd.frameIndex = U64_MAX;

	io.BackendRendererName = null;
	io.BackendRendererUserData = null;
	io.BackendFlags &= ~ImGuiBackendFlags.RendererHasVtxOffset;
	// free(bd); // IM_DELETE(bd);
}