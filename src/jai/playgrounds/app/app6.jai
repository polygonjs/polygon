
appSceneInit6 :: (using app: *PolygonApp) {

	output1 := createNode(*nodesScene, OutputGeoNode);
	box1 := createNode(*nodesScene, BoxGeoNode);
	noise1 := createNode(*nodesScene, NoiseGeoNode);

	setInput(output1, 0, noise1);
	setInput(noise1, 0, box1);

	paramSetValue(*output1.p.input, 0);
	paramSetValue(*box1.p.scale, 2.0);
	paramSetValue(*box1.p.segments, .{4,4,4});
	paramSetValue(*noise1.p.offset, .{1,0,0});

	nodesScene.onBeforeTick = (nodesScene:*NodesScene) {
		t :float= (0.1*nodesScene.time);
		noise1 := cast(*NoiseGeoNode)nodesScene.nodes[2];
		paramSetValue(*noise1.p.offset, Vector3.{t,0,0});
	}

	#if USE_EDITOR {
		nodeSetPosition(*editor, output1, .{0,-4});
		nodeSetPosition(*editor, noise1, .{0,-1});
		nodeSetPosition(*editor, box1, .{0,2});

		editorFlushCommands(*editor);
	}
}
