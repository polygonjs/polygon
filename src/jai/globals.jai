#if USE_WGPU {
	WGPU_CONTEXT:WGPUContext;
}
#if USE_IMGUI {
	WINDOW_CONTEXT:WindowContext;
	BD:ImGui_ImplWGPU_Data;
	IWC:ImGui_WGPU_Common;
}
EVENTS_DATA:EventsData;

TEST_ASSETS :: "/home/gui/work/web/games/polygon-next-assets/";