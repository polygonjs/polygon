drawDataInit :: (using panel: *TYPE) {
	// #if WASM == false {
	// 	if renderer.wgpuContext.mode == .HEADLESS {
	// 		return;
	// 	}
	// }
	#if USE_IMGUI rendererInitUI(*panel.editor.wgpuContext, *panel.editor.imguiPolygonContext, renderer.use_depth_buffer);
	// rendererInitPipelines(renderer, editor.nodesScene.worldScene, *camera);
}

render :: (using panel: *TYPE, renderCollectionData: *RenderCollectionData) {
	// #if WASM == false {
	// 	if renderer.wgpuContext.mode == .HEADLESS {
	// 		return;
	// 	}
	// }
	// #if USE_IMGUI renderUI(renderCollectionData, renderer);
	#if USE_IMGUI {
		cmdEncoder, renderPassEncoder := renderUIStart(renderCollectionData, *renderer);
		renderUIFrameStart(*renderer, *panel.editor.eventsData, *panel.editor.imguiPolygonContext);
		paramsRender(panel);
		renderUIFrameEnd(renderPassEncoder, *panel.editor.imguiPolygonContext);
		renderUIEnd(renderCollectionData, *renderer, cmdEncoder, renderPassEncoder);
	}
}

#if USE_IMGUI {
paramsRender :: (using panel: *TYPE) {
	renderNodeNames(*editor.networkPanel);

	{
		viewport := renderer.viewport;
		ImGui.SetNextWindowSize(.{xx viewport.size.x, xx viewport.size.y}, .Always);
		ImGui.SetNextWindowPos(.{xx viewport.start.x, xx viewport.start.y}, .Always);
		ImGui.Begin("Params", flags = .NoTitleBar|.NoResize|.NoCollapse|.NoDecoration);

		// node name / type / selection count
		if editor.sceneUiData.selectedNodeIds.count > 0 {
			nodeId := editor.sceneUiData.selectedNodeIds[0];
			node := editor.nodesScene.nodes[nodeId];

			// node name and type
			{
				selectedNodeName := nodeName(editor.nodesScene, nodeId);
				nodeNameAndTypeStr := tprint("% (%)", selectedNodeName, node.type);
				ImGui.TextUnformatted(nodeNameAndTypeStr);
			}
			// params
			generatedNodeParamsRenderUI(node);
		} else {
			ImGui.TextUnformatted("No node selected");
		}
		ImGui.End();
	}

	mainMenuBarDraw(editor);

}
}
else {
	paramsRender :: (using panel: *TYPE) {}
}

rendererDestroyBuffers :: (using panel: *TYPE) {
	rendererDestroyBuffers(*renderer);
}

#scope_file

TYPE :: ParamsPanel;