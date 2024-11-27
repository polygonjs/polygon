
networkPanelAddNode :: (panel: *TYPE, node: *$T) {

	_addMesh :: (panel: *TYPE, node: *$T, geometry: *Geometry, $forRaycast:bool) {
		using panel;

		#if forRaycast == true {
			scene := sceneRaycast;
		} else {
			scene := sceneWorld;
		}
		mesh := newMesh(scene, Mesh, geometry);

		#if forRaycast {
			material := newMaterial(MATERIAL_RAYCAST, panel.allocator);
			material.uniforms.id = node.nodeId;
			mesh.material = xx material;
		} else {
			setColor(panel.basicMat, .{1.0, 0.5, 0.25, 1.0});
			mesh.material = xx panel.basicMat;
		}

		pos := panel.editor.sceneUiData.nodePositions[node.nodeId];
		mesh.position = .{x = pos.x, y = pos.y, z = 0.0};
		transformable_update_matrix(mesh);
		{
			using panel;
			#if forRaycast==false {
				array_insert_at(*objectIndex, xx scene.children.count, node.nodeId);
			}
			sceneObjectAdd(scene, mesh);
		}
	}

	geometry :*Geometry = newGeometry(panel.sceneWorld.allocator);
	geometry_box_update(geometry, segments=.{2,2,2});

	_addMesh(panel, node, geometry, forRaycast=false);
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER _addMesh(panel, node, geometry, forRaycast=true);
}

networkPanelRemoveNode :: (panel: *TYPE, node: *$T) {
	_removeNode :: (panel:*TYPE, node:*T, $forRaycast:bool) {
		using panel;
		meshIndex := objectIndex[node.nodeId];
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
				objectIndex[node.nodeId] = 0;
			}
		}
	}
	_removeNode(panel, node, forRaycast=false);
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER _removeNode(panel, node, forRaycast=true);
}

#scope_file

TYPE :: NetworkPanel;
MATERIAL_RAYCAST :: NETWORK_PANEL_MATERIAL_RAYCAST;