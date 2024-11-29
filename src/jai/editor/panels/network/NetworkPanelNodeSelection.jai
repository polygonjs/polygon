networkPanelOnNodeSelectionAdded :: (using panel: *TYPE, node: *BaseNodeAny) {
	meshIndex := objectIndex[node.nodeId];
	object := sceneWorld.children[meshIndex];
	mesh := cast(*Mesh)object;
	meshSetMaterial(sceneWorld, mesh, xx panel.mat.nodeSelected);
}
networkPanelOnNodeSelectionRemoved :: (using panel: *TYPE, node: *BaseNodeAny) {
	meshIndex := objectIndex[node.nodeId];
	object := sceneWorld.children[meshIndex];
	mesh := cast(*Mesh)object;
	meshSetMaterial(sceneWorld, mesh, xx panel.mat.basic);
}

#scope_file

TYPE :: NetworkPanel;