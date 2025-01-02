NETWORK_PANEL_NODE_SIZE :: 1.0;
NETWORK_PANEL_NODE_HALF_SIZE :: NETWORK_PANEL_NODE_SIZE / 2;
NETWORK_PANEL_NODE_SIZE_V2 :Vector2: .{NETWORK_PANEL_NODE_SIZE,NETWORK_PANEL_NODE_SIZE};
NETWORK_PANEL_TEXT_OFFSET :Vector3: .{x = NETWORK_PANEL_NODE_HALF_SIZE+0.1, y = NETWORK_PANEL_NODE_HALF_SIZE*.25, z = 1};

networkPanelAddNode :: (panel: *TYPE, node: *$T) {
	geometry :*Geometry = newGeometry(panel.sceneWorld.allocator);
	geometryPlaneAttributesSet(geometry, .{size=NETWORK_PANEL_NODE_SIZE_V2});

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
		scene := *sceneRaycast;
	} else {
		scene := *sceneWorld;
	}
	// node body
	bodyMesh := newMesh(scene, Mesh, geometry);
	{

		#if forRaycast {
			material := newMaterial(MATERIAL_RAYCAST, panel.allocator);
			material.uniforms.id = node.nodeId;
			meshSetMaterial(scene, bodyMesh, xx material);
		} else {
			meshSetMaterial(scene, bodyMesh, xx *panel.mat.nodeBasic);
		}

		pos := panel.editor.sceneUiData.nodePositions[node.nodeId];
		bodyMesh.position = .{x = pos.x, y = pos.y, z = 0.0};
		transformableUpdateMatrix(bodyMesh);
		{
			#if forRaycast==false {
				if nodeBodyObjectIndexByNodeId.count < node.nodeId {
					array_resize(*nodeBodyObjectIndexByNodeId, node.nodeId+1);
				}
				array_insert_at(*nodeBodyObjectIndexByNodeId, item=xx scene.children.count, index=xx node.nodeId);
			}
			sceneObjectAdd(scene, bodyMesh);
		}
	}
	// {
	// 	// node text
	// 	textMesh := newMesh(scene, Mesh);
	// 	name := nodeName(editor.nodesScene, node.nodeId);
	// 	textMeshUpdate(editor.nodesScene, textMesh, .{
	// 		text=name,
	// 		size=0.25
	// 	});
	// 	textMesh.position = bodyMesh.position + NETWORK_PANEL_TEXT_OFFSET;
	// 	transformableUpdateMatrix(bodyMesh);
	// 	#if forRaycast==false {
	// 		if nodeTextObjectIndexByNodeId.count < node.nodeId {
	// 			array_resize(*nodeTextObjectIndexByNodeId, node.nodeId+1);
	// 		}
	// 		array_insert_at(*nodeTextObjectIndexByNodeId, item=xx scene.children.count, index=xx node.nodeId);
	// 	}
	// 	sceneObjectAdd(scene, textMesh);
	// }
}

_removeNode :: (using panel:*TYPE, node:*$T, $forRaycast:bool) {
	bodyObjectIndex := nodeBodyObjectIndexByNodeId[node.nodeId];
	// textObjectIndex := nodeTextObjectIndexByNodeId[node.nodeId];
	if bodyObjectIndex >= 0 {
		#if forRaycast {
			scene := *sceneRaycast;
		} else {
			scene := *sceneWorld;
		}
		bodyObject := scene.children[bodyObjectIndex];
		// textObject := scene.children[textObjectIndex];
		#if forRaycast {
			bodyMesh := cast(*Mesh)bodyObject;
			materialDelete(cast(*MATERIAL_RAYCAST)bodyMesh.material);
			geometryDelete(bodyMesh.geometry);
		}
		sceneObjectRemove(scene, bodyObject, delete=false);
		// sceneObjectRemove(scene, textObject, delete=false);
		#if forRaycast == true {
			nodeBodyObjectIndexByNodeId[node.nodeId] = 0;
		}
	}
}
