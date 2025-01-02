drawDataInit :: (using editor: *Editor) {
	#if HAS_VIEWER_PANEL drawDataInit(*viewerPanel);
	#if HAS_NETWORK_PANEL drawDataInit(*networkPanel);
	drawDataInit(*paramsPanel);
}
editorRender :: (editor: *Editor) {
	editor.wgpuContext.framesCount = editor.nodesScene.framesCount;
	// print("-----------editorRender: %\n", editor.nodesScene.framesCount);
	data :RenderCollectionData= rendererCollectionStart(*editor.wgpuContext);
	#if HAS_NETWORK_PANEL render(*editor.networkPanel, *data);
	render(*editor.paramsPanel, *data);
	#if HAS_VIEWER_PANEL render(*editor.viewerPanel, *data);

	eventsDataClearText(*editor.eventsData);

	rendererCollectionEnd(*editor.wgpuContext, data);
	rendererDestroyBuffers(editor);
	#if USE_IMGUI imgui_gui_free(*editor.imguiPolygonContext);
}

rendererDestroyBuffers :: (using editor: *Editor) {
	#if HAS_VIEWER_PANEL rendererDestroyBuffers(*viewerPanel);
	#if HAS_NETWORK_PANEL rendererDestroyBuffers(*networkPanel);
	rendererDestroyBuffers(*paramsPanel);
}
