
appSceneInit1 :: (nodesScene: *NodesScene, editor: *Editor) {

	add1 := createNode(nodesScene, AddGeoNode);
	box1 := createNode(nodesScene, BoxGeoNode);
	plane1 := createNode(nodesScene, PlaneGeoNode);
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
	setInput(output1, 3, plane1);
	setInput(output1, 4, fileSTL1);
	setInput(output1, 5, line1);
	// setInput(output1, 3, transform2);
	// setInput(transform1, 0, box1);
	// setInput(transform2, 0, transform1);
	// setInput(output1, 3, noise1);
	// setInput(transform1, 0, icosahedron1);
	// setInput(noise1, 0, transform1);


	paramSetValue(*box1.p.scale, 2.0);
	paramSetValue(*output1.p.input, 3);
	paramSetValue(*icosahedron1.p.detail, 0);

	nodeSetPosition(editor, output1, .{0,-4});

	nodeSetPosition(editor, add1, .{-4,0});
	nodeSetPosition(editor, box1, .{-2,2});
	nodeSetPosition(editor, plane1, .{-2,4});
	nodeSetPosition(editor, noise1, .{-2,0});
	nodeSetPosition(editor, icosahedron1, .{0,2});
	nodeSetPosition(editor, noise2, .{0,0});
	nodeSetPosition(editor, line1, .{2,2});
	nodeSetPosition(editor, fileSTL1, .{5,0});

	// nodeSetPosition(editor, transform1, .{0,0});
	// nodeSetPosition(editor, transform2, .{0,-2});
	// nodeSetPosition(editor, noise1, .{0,-2});
	//

	// selectNode(editor, xx box1);
	// BOX1 = box1;
	// editor.onAfterTick = (using editor: *Editor) {
	// 	if nodesScene.framesCount > 0 {
	// 		// print("select box node to debug imgui in wasm");
	// 		// selectNode(editor, xx BOX1);
	// 		editorRequestExit(editor);
	// 	}
	// };

	setTexture(*nodesScene.defaultMaterial.basicTexture, *TEXTURE);

	editorFlushCommands(editor);
}

#scope_file

// BOX1:*BoxGeoNode;


TEX_SIZE :[2]u32: .[5, 7];
// TEX_SIZE :[2]u32: .[3, 2];
PIXELS_COUNT :: TEX_SIZE[0]*TEX_SIZE[1];
DATA_SIZE :: PIXELS_COUNT*4;
COMPONENT_TYPE :: u8;
TEXTURE: Texture = .{
	size = TEX_SIZE,
	data = TEXTURE_DATA.data,
};
TEXTURE_DATA :[DATA_SIZE]COMPONENT_TYPE: #run _createTextureData();
_createTextureData :: () -> [DATA_SIZE]COMPONENT_TYPE #compile_time {

	z :[4]COMPONENT_TYPE= .[0,   0,   0, 0];  // zero
	O :[4]COMPONENT_TYPE= .[255,   0,   0, 255];  // red
	y :[4]COMPONENT_TYPE= .[255, 255,   0, 255];  // yellow
	b :[4]COMPONENT_TYPE= .[  0,   0, 255, 255];  // blue
	f :[4]COMPONENT_TYPE= .[  255,   255, 255, 255];  // full
	textureDataPacked :[PIXELS_COUNT][4]COMPONENT_TYPE= .[
		z, O, O, O, O,
		O, y, y, y, O,
		O, y, O, O, O,
		O, y, y, O, O,
		O, y, O, O, O,
		O, y, O, O, f,
		O, O, O, f, b
	];
	// textureDataPacked :[PIXELS_COUNT][4]COMPONENT_TYPE= .[
	// 	f,z,z,
	// 	z,z,f
	// ];
	textureData :[DATA_SIZE]COMPONENT_TYPE;
	for x: 0..(TEX_SIZE[0]-1) {
		for y: 0..(TEX_SIZE[1]-1) {
			i := y*TEX_SIZE[0]+x;
			textureData[i*4+0] = textureDataPacked[i][0];
			textureData[i*4+1] = textureDataPacked[i][1];
			textureData[i*4+2] = textureDataPacked[i][2];
			textureData[i*4+3] = textureDataPacked[i][3];
		}
	}
	return textureData;
}