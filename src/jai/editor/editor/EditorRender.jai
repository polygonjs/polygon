drawDataInit :: (editor: *Editor) {
	#if HAS_VIEWER_PANEL drawDataInit(editor.viewerPanel);
	#if HAS_NETWORK_PANEL drawDataInit(editor.networkPanel);
	drawDataInit(editor.paramsPanel);
}
editorRender :: (editor: *Editor) {
	editor.wgpuContext.framesCount = editor.nodesScene.framesCount;
	// print("-----------editorRender: %\n", editor.nodesScene.framesCount);
	data :RenderCollectionData= rendererCollectionStart(*editor.wgpuContext);
	#if HAS_VIEWER_PANEL render(editor.viewerPanel, *data);
	#if HAS_NETWORK_PANEL render(editor.networkPanel, *data);
	render(editor.paramsPanel, *data);
	eventsDataClearText(*editor.eventsData);


	rendererCollectionEnd(*editor.wgpuContext, data);
	rendererDestroyBuffers(editor);
	#if USE_IMGUI imgui_gui_free(*editor.imguiPolygonContext);
}

rendererDestroyBuffers :: (editor: *Editor) {
	#if HAS_VIEWER_PANEL rendererDestroyBuffers(editor.viewerPanel);
	#if HAS_NETWORK_PANEL rendererDestroyBuffers(editor.networkPanel);
	rendererDestroyBuffers(editor.paramsPanel);
}
