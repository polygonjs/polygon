drawDataInit :: (using panel: *TYPE) {
	rendererInitPipelines(*renderer, *editor.nodesScene.worldScene, *camera);
}
render :: (using panel: *TYPE, renderCollectionData: *RenderCollectionData) {
	nodesSceneOutputNodesCompute(editor.nodesScene);
	render(renderCollectionData, *renderer, *editor.nodesScene.worldScene, *camera);
}
rendererDestroyBuffers :: (using panel: *TYPE) {
	rendererDestroyBuffers(*renderer);
}
#scope_file

TYPE :: ViewerPanel;