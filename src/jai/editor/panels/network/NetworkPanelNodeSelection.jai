networkPanelOnNodeSelectionAdded :: (using panel: *TYPE, node: *BaseNodeAny) {
	meshIndex := nodeBodyObjectIndexByNodeId[node.nodeId];
	object := sceneWorld.children[meshIndex];
	mesh := cast(*Mesh)object;
	meshSetMaterial(*sceneWorld, mesh, xx *panel.mat.nodeSelected);
}
networkPanelOnNodeSelectionRemoved :: (using panel: *TYPE, node: *BaseNodeAny) {
	meshIndex := nodeBodyObjectIndexByNodeId[node.nodeId];
	object := sceneWorld.children[meshIndex];
	mesh := cast(*Mesh)object;
	meshSetMaterial(*sceneWorld, mesh, xx *panel.mat.nodeBasic);
}

#scope_file

TYPE :: NetworkPanel;