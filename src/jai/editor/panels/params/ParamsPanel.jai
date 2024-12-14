ParamsPanel :: struct {
	#if USE_FLAT_POOL {
		pool: Flat_Pool;
	} else #if USE_POOL {
		pool: Pool;
	}
	allocator: Allocator;
	//
	editor: *Editor;

	renderer: *Renderer;
}

newParamsPanel :: (editor: *Editor, $ensureWGPUContextValid: bool=true) -> *TYPE {
	panel: *TYPE = New(TYPE);
	paramsPanelInit(panel, editor, ensureWGPUContextValid);

	return panel;
}
paramsPanelDelete :: (using panel: *TYPE) {
	#if USE_IMGUI rendererUIDestroy(*panel.editor.imguiPolygonContext);
	rendererDelete(renderer);
	allocatorReset(panel);
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
		cmdEncoder, renderPassEncoder := renderUIStart(renderCollectionData, renderer);
		renderUIFrameStart(renderer, panel.editor.eventsData, *panel.editor.imguiPolygonContext);
		paramsRender(panel);
		renderUIFrameEnd(renderPassEncoder, *panel.editor.imguiPolygonContext);
		renderUIEnd(renderCollectionData, renderer, cmdEncoder, renderPassEncoder);
	}
	// nodesSceneOutputNodesCompute(editor.nodesScene);
	// rendererFlushCommands(renderer);
	// cameraUniformsUpdate(*camera);
	// render(renderCollectionData, renderer, editor.nodesScene.worldScene, *camera);
}
rendererDestroyBuffers :: (panel: *TYPE) {
	rendererDestroyBuffers(panel.renderer);
}
processEvent :: (panel: *TYPE, eventsData:*EventsData) {
	// using panel;
	// focused := element_focused(renderer, eventsData);
	// camera_controls_process_event(*cameraControls, eventsData, focused);
}
onResize :: (using panel: *TYPE) {
	newAspect:float = (cast(float32) editor.windowSize.x) / (cast(float32) editor.windowSize.y);

	renderer.viewport.start = .{ editor.windowSize.x*0, xx (0.5 * xx editor.windowSize.y) };
	renderer.viewport.size = .{ xx(cast(float32)editor.windowSize.x*0.5), xx(cast(float32)editor.windowSize.y*0.5) };
}
#if USE_IMGUI {
paramsRender :: (using panel: *TYPE) {
	ImGui.SetNextWindowSize(.{xx renderer.viewport.size.x, xx renderer.viewport.size.y}, .Always);
	ImGui.SetNextWindowPos(.{xx renderer.viewport.start.x, xx renderer.viewport.start.y}, .Always);
	ImGui.Begin("Params");

	{
		// fps
		frameRateStr := to_c_string_temp(tprint("Frame Rate: %\n", panel.editor.nodesScene.fps));
		ImGui.Text_CFormat(frameRateStr);
	}

	{
		// node name / type / selection count
		if editor.sceneUiData.selectedNodeIds.count > 0 {
			nodeId := editor.sceneUiData.selectedNodeIds[0];
			node := editor.nodesScene.nodes[nodeId];

			// node name and type
			{
				nodeName := editor.nodesScene.nodeNames[nodeId];
				nodeNameAndTypeStr := (tprint("% (%)", nodeName, node.type));
				ImGui.Text(nodeNameAndTypeStr);
			}
			// params
			generatedNodeParamsRenderUI(node);
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

paramsPanelInit :: (using panel: *TYPE, _editor: *Editor, $ensureWGPUContextValid: bool=true) {

	renderer = newRenderer(*_editor.wgpuContext, ensureWGPUContextValid);

	renderer.label = "ParamsPanelRenderer";
	renderer.full_screen = false;
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
	// camera.type = PerspectiveCamera;
	// object3DInit(*camera);
	// cameraControls.camera = *camera;

	// cameraControlsCommit(*cameraControls);
}