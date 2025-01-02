drawDataInit :: (using panel: *TYPE) {
	rendererInitPipelines(*renderer, *editor.nodesScene.worldScene, xx *camera);
}
render :: (using panel: *TYPE, renderCollectionData: *RenderCollectionData) {
	nodesSceneOutputNodesCompute(editor.nodesScene);
	render(renderCollectionData, *renderer, *editor.nodesScene.worldScene);
}
rendererDestroyBuffers :: (using panel: *TYPE) {
	rendererDestroyBuffers(*renderer);
}
#scope_file

TYPE :: ViewerPanel;