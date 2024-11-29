drawDataInit :: (editor: *Editor) {
	#if HAS_VIEWER_PANEL drawDataInit(editor.viewerPanel);
	#if HAS_NETWORK_PANEL drawDataInit(editor.networkPanel);
}
editorRender :: (editor: *Editor) {
	WGPU_CONTEXT.framesCount = editor.nodesScene.framesCount;
	// print("-----------editorRender: %\n", editor.nodesScene.framesCount);
	data :RenderCollectionData= rendererCollectionStart(*WGPU_CONTEXT);
	#if HAS_VIEWER_PANEL render(editor.viewerPanel, *data);
	#if HAS_NETWORK_PANEL render(editor.networkPanel, *data);

	rendererCollectionEnd(*WGPU_CONTEXT, data);
	rendererDestroyBuffers(editor);
}

rendererDestroyBuffers :: (editor: *Editor) {
	#if HAS_VIEWER_PANEL rendererDestroyBuffers(editor.viewerPanel);
	#if HAS_NETWORK_PANEL rendererDestroyBuffers(editor.networkPanel);
}
