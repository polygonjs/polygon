drawDataInit :: (using panel: *TYPE) {
	rendererInitPipelines(*rendererColor, *sceneWorld, *camera);
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER rendererInitPipelines(*rendererRaycast, *sceneRaycast, *camera);
}
render :: (using panel: *TYPE, renderCollectionData: *RenderCollectionData) {
	render(renderCollectionData, *rendererColor, *sceneWorld);
}
rendererDestroyBuffers :: (using panel: *TYPE) {
	rendererDestroyBuffers(*rendererColor);
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER rendererDestroyBuffers(*rendererRaycast);
}

renderNodeNames :: (using panel: *TYPE) {

	if cameraControls.zoom > 25 {
		return;
	}

	viewport := rendererColor.viewport;
	ImGui.SetNextWindowSize(.{xx viewport.size.x, xx viewport.size.y}, .Always);
	ImGui.SetNextWindowPos(.{xx viewport.start.x, xx viewport.start.y}, .Always);
	ImGui.Begin(
		"network panel node names",
		flags =
			.NoTitleBar
			|.NoResize
			|.NoCollapse
			|.NoDecoration
			|.NoBackground
			|.NoMouseInputs
			);

	for node: editor.nodesScene.nodes {
		// do not draw below a zoom level
		position := panel.editor.sceneUiData.nodePositions[node.nodeId];
		position3D :Vector3= .{
			x = position.x + NETWORK_PANEL_TEXT_OFFSET.x,
			y = position.y + NETWORK_PANEL_TEXT_OFFSET.y,
			z = 0.0
		};
		screenPos := worldToNDC(position3D, camera);
		marginLeft :: 0.5;
		marginTop :: 0.5;
		if
			screenPos.x < (-1-marginLeft) ||
			screenPos.x > 1 ||
			screenPos.y < -1 ||
			screenPos.y > (1+marginTop) {
			// do not draw if out of viewport
			continue;
		}

		screenPos.x = viewport.size.x*(screenPos.x+1)/2;
		screenPos.y = viewport.size.y*(1-(screenPos.y+1)/2);

		ImGui.SetCursorPos(.{xx screenPos.x, xx screenPos.y});

		name := nodeName(editor.nodesScene, node.nodeId);
		ImGui.TextUnformatted(name);

	}

	ImGui.End();

}

#scope_file

TYPE :: NetworkPanel;