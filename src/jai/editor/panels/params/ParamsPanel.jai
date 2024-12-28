ParamsPanel :: struct {
	#if USE_FLAT_POOL {
		pool: Flat_Pool;
	} else #if USE_POOL {
		pool: Pool;
	}
	// allocator: Allocator;
	//
	editor: *Editor;

	renderer: Renderer;
}

newParamsPanel :: (editor: *Editor, $ensureWGPUContextValid: bool=true) -> *TYPE {
	panel: *TYPE = New(TYPE);
	paramsPanelInit(panel, editor, ensureWGPUContextValid);

	return panel;
}
paramsPanelInit :: (using panel: *TYPE, _editor: *Editor, $ensureWGPUContextValid: bool=true) {
	// allocatorAssign(panel);

	rendererInit(*renderer, *_editor.wgpuContext, ensureWGPUContextValid);

	renderer.label = "ParamsPanelRenderer";
	renderer.fullScreen = false;
	renderer.viewport = .{
		start = .{0,0},
		size = .{1,1}
	};
	renderer.bgColor = DEFAULT_RENDERER_BG_COLOR;
	renderer.use_msaa = false;
	renderer.use_depth_buffer = false;
	renderer.useReadback = false;
	// renderer.render_ui = true;
	renderer.clear = false;

	editor = _editor;
}
paramsPanelReset :: (using panel: *TYPE) {
	#if USE_IMGUI rendererUIDestroy(*panel.editor.imguiPolygonContext);
	rendererReset(*renderer);
}
paramsPanelDelete :: (using panel: *TYPE) {
	paramsPanelReset(panel);
	// allocatorReset(panel);
	free(panel);
}
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
	#if WASM == false {
		if renderer.wgpuContext.mode == .HEADLESS {
			return;
		}
	}
	// #if USE_IMGUI renderUI(renderCollectionData, renderer);
	#if USE_IMGUI {
		cmdEncoder, renderPassEncoder := renderUIStart(renderCollectionData, *renderer);
		renderUIFrameStart(*renderer, panel.editor.eventsData, *panel.editor.imguiPolygonContext);
		paramsRender(panel);
		renderUIFrameEnd(renderPassEncoder, *panel.editor.imguiPolygonContext);
		renderUIEnd(renderCollectionData, *renderer, cmdEncoder, renderPassEncoder);
	}
}
rendererDestroyBuffers :: (using panel: *TYPE) {
	rendererDestroyBuffers(*renderer);
}
processEvent :: (panel: *TYPE, eventsData:*EventsData) {
}
onResize :: (using panel: *TYPE) {
	newAspect:float = (cast(float32) editor.windowSize.x) / (cast(float32) editor.windowSize.y);

	renderer.viewport.start = .{ editor.windowSize.x*0, xx (0.5 * xx editor.windowSize.y) };
	renderer.viewport.size = .{ xx(cast(float32)editor.windowSize.x*0.5), xx(cast(float32)editor.windowSize.y*0.5) };
}
#if USE_IMGUI {
paramsRender :: (using panel: *TYPE) {
	mainMenuBarDraw(editor);

	ImGui.SetNextWindowSize(.{xx renderer.viewport.size.x, xx renderer.viewport.size.y}, .Always);
	ImGui.SetNextWindowPos(.{xx renderer.viewport.start.x, xx renderer.viewport.start.y}, .Always);
	ImGui.Begin("Params", flags = .NoResize|.NoCollapse);

	{
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
	}
	

	ImGui.End();

}
}
else {
	paramsRender :: (using panel: *TYPE) {}
}
// panelSetScene :: (panel: *TYPE, nodesScene: *NodesScene) {
// 	rendererAny: Any = <<panel.renderer;
// 	sceneAddObserver(nodesScene.worldScene, rendererAny);
// }
// panelRemoveScene :: (panel: *TYPE, nodesScene: *NodesScene) {
// 	sceneRemoveObserver(nodesScene.worldScene, panel.renderer);
// }
#scope_file

TYPE :: ParamsPanel;

