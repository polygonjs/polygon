
NetworkPanel :: struct {
	editor: *Editor;
	worldScene: *Scene;
	nodesSceneObjectIndex: [..]u32;

	basicMat: *BasicMeshMaterial;
}

newNetworkPanel :: (editor: *Editor) -> *NetworkPanel {
	panel: *NetworkPanel = New(NetworkPanel);
	networkPanelInit(panel, editor);
	
	

	return panel;
}

networkPanelUpdateWorldScene :: (panel: *NetworkPanel, nodesScene: *NodesScene) {
	using panel.editor.sceneUiData;
	
	maxNodeId := -1;
	for node: nodesScene.nodes {
		if maxNodeId < node.nodeId {
			maxNodeId = node.nodeId;
		}
	}
	if nodePositions.count < maxNodeId + 1 {
		array_resize(*nodePositions, maxNodeId + 1);
	}

	for node, i: nodesScene.nodes {
		networkdPanelAddNode(panel, node, nodePositions[node.nodeId]);
	}
}

networkdPanelAddNode :: (panel: *NetworkPanel, node: *$T, pos: Vector2) {
	mesh := newObject3D(Mesh);
	setColor(panel.basicMat, .{1.0, 0.0, 0.0, 1.0});
	geometry_box_update(mesh.geometry, segments=.{2,2,2});
	mesh.material = panel.basicMat;

	mesh.position = .{x = pos.x, y = pos.y, z = 0.0};
	transformable_update_matrix(mesh);
	{
		using panel;
		if nodesSceneObjectIndex.count <= node.nodeId {
			array_resize(*nodesSceneObjectIndex, node.nodeId + 1);
		}
		nodesSceneObjectIndex[node.nodeId] = xx worldScene.children.count;
		array_add(*worldScene.children, mesh);
	}
}
networkdPanelRemoveNode :: (panel: *NetworkPanel, node: *$T) {
	using panel;
	meshIndex := nodesSceneObjectIndex[node.nodeId];
	if meshIndex > 0 {
		mesh := worldScene.children[meshIndex];
		sceneObjectRemove(worldScene, mesh);
		worldScene.children[meshIndex] = null;
		nodesSceneObjectIndex[node.nodeId] = 0;
	}
}

#scope_file

networkPanelInit :: (panel: *NetworkPanel, editor: *Editor) {
	panel.editor = editor;
	panel.worldScene = newObject3D(Scene);

	panel.basicMat = newMaterial(BasicMeshMaterial);
}