
appSceneInit :: (nodesScene: *NodesScene, editor: *Editor) {

	add1 := createNode(nodesScene, AddGeoNode);
	box1 := createNode(nodesScene, BoxGeoNode);
	line1 := createNode(nodesScene, LineGeoNode);
	icosahedron1 := createNode(nodesScene, IcosahedronGeoNode);
	fileSTL1 := createNode(nodesScene, FileSTLGeoNode);
	// transform1 := createNode(nodesScene, TransformGeoNode);
	// transform2 := createNode(nodesScene, TransformGeoNode);
	noise1 := createNode(nodesScene, NoiseGeoNode);
	noise2 := createNode(nodesScene, NoiseGeoNode);
	assert(graphNodeScene(box1)!=null, "scene can be found from node");
	output1 := createNode(nodesScene, OutputGeoNode);

	{
		#if WASM {
			assetPath := tprint("%/models/stl/rounded_cube_sphere_boolean.stl", TEST_ASSETS);
		} else {
			assetPath := tprint("%/models/stl/cube_sphere_boolean.stl", TEST_ASSETS);
		}
		paramSetValue(*fileSTL1.p.path, assetPath);
	}

	setInput(noise1, 0, box1);
	setInput(noise2, 0, icosahedron1);

	setInput(output1, 0, add1);
	setInput(output1, 1, noise1);
	setInput(output1, 2, noise2);
	setInput(output1, 3, line1);
	setInput(output1, 4, fileSTL1);
	// setInput(output1, 3, transform2);
	// setInput(transform1, 0, box1);
	// setInput(transform2, 0, transform1);
	// setInput(output1, 3, noise1);
	// setInput(transform1, 0, icosahedron1);
	// setInput(noise1, 0, transform1);


	paramSetValue(*box1.p.scale, 2.0);
	paramSetValue(*output1.p.input, 4);
	paramSetValue(*icosahedron1.p.detail, 40);

	nodeSetPosition(editor, output1, .{0,-4});

	nodeSetPosition(editor, add1, .{-4,2});
	nodeSetPosition(editor, box1, .{-2,2});
	nodeSetPosition(editor, noise1, .{-2,0});
	nodeSetPosition(editor, icosahedron1, .{0,2});
	nodeSetPosition(editor, noise2, .{0,0});
	nodeSetPosition(editor, line1, .{2,2});
	nodeSetPosition(editor, fileSTL1, .{4,2});

	// nodeSetPosition(editor, transform1, .{0,0});
	// nodeSetPosition(editor, transform2, .{0,-2});
	// nodeSetPosition(editor, noise1, .{0,-2});
	//
	editorFlushCommands(editor);
}

