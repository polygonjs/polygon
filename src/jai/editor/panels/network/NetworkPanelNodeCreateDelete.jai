
networkPanelAddNode :: (panel: *TYPE, node: *$T) {
	geometry :*Geometry = newGeometry(panel.sceneWorld.allocator);
	geometryBoxAttributesSet(geometry, .{size=.{1,1,0.1}});

	_addNode(panel, node, geometry, forRaycast=false);
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER _addNode(panel, node, geometry, forRaycast=true);
}

networkPanelRemoveNode :: (panel: *TYPE, node: *$T) {
	_removeNode(panel, node, forRaycast=false);
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER _removeNode(panel, node, forRaycast=true);
}

#scope_file

TYPE :: NetworkPanel;
MATERIAL_RAYCAST :: NETWORK_PANEL_MATERIAL_RAYCAST;

_addNode :: (using panel: *TYPE, node: *$T, geometry: *Geometry, $forRaycast:bool) {

	#if forRaycast == true {
		scene := sceneRaycast;
	} else {
		scene := sceneWorld;
	}
	mesh := newMesh(scene, Mesh, geometry);

	#if forRaycast {
		material := newMaterial(MATERIAL_RAYCAST, panel.allocator);
		material.uniforms.id = node.nodeId;
		meshSetMaterial(scene, mesh, xx material);
	} else {
		meshSetMaterial(scene, mesh, xx panel.mat.nodeBasic);
	}

	pos := panel.editor.sceneUiData.nodePositions[node.nodeId];
	mesh.position = .{x = pos.x, y = pos.y, z = 0.0};
	transformableUpdateMatrix(mesh);
	{
		#if forRaycast==false {
			if nodeObjectIndexByNodeId.count < node.nodeId {
				array_resize(*nodeObjectIndexByNodeId, node.nodeId+1);
			}
			array_insert_at(*nodeObjectIndexByNodeId, item=xx scene.children.count, index=xx node.nodeId);
		}
		sceneObjectAdd(scene, mesh);
	}
}

_removeNode :: (using panel:*TYPE, node:*$T, $forRaycast:bool) {
	meshIndex := nodeObjectIndexByNodeId[node.nodeId];
	if meshIndex >= 0 {
		#if forRaycast {
			scene := sceneRaycast;
		} else {
			scene := sceneWorld;
		}
		object := scene.children[meshIndex];
		#if forRaycast {
			mesh := cast(*Mesh)object;
			materialDelete(cast(*MATERIAL_RAYCAST)mesh.material);
			geometryDelete(mesh.geometry);
		}
		sceneObjectRemove(scene, object, delete=false);
		#if forRaycast == true {
			nodeObjectIndexByNodeId[node.nodeId] = 0;
		}
	}
}
