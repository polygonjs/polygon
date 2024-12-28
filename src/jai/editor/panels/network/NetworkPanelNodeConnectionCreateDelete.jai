NETWORK_PANEL_CONNECTION_HEIGHT :: NETWORK_PANEL_NODE_HALF_SIZE / 2;

networkPanelAddNodeConnection :: (panel: *TYPE, connection: NodeConnection) {

	geometry :*Geometry = newGeometry(panel.sceneWorld.allocator);
	geometryBoxUpdate(geometry, .{size=.{0.1,1,0.1}});
	geometryTranslate(geometry, .{x=0, y=0.5, z=0});

	_addConnection(panel, connection, geometry, forRaycast=false);
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER _addConnection(panel, connection, geometry, forRaycast=true);
}

networkPanelRemoveNodeConnection :: (panel: *TYPE, connection: NodeConnection) {
	_removeConnection(panel, connection, forRaycast=false);
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER _removeConnection(panel, connection, forRaycast=true);
}

networkPanelConnectionSetMatrix :: (using panel: *TYPE, connection: NodeConnection, mesh: *Mesh, scene: *Scene) {
	nodeSrcPos := editor.sceneUiData.nodePositions[connection.src.nodeId] - Vector2.{x=0, y=NETWORK_PANEL_NODE_HALF_SIZE};
	nodeDestPos := editor.sceneUiData.nodePositions[connection.dest.nodeId] + Vector2.{x=0, y=NETWORK_PANEL_NODE_HALF_SIZE};
	dist := distance(nodeSrcPos, nodeDestPos);
	angle_delta := angle(nodeDestPos-nodeSrcPos) + PI/2;
	mesh.position = .{x = nodeDestPos.x, y = nodeDestPos.y, z = NETWORK_PANEL_CONNECTION_HEIGHT};
	// mesh.scale.x = dist;
	mesh.scale.y = dist;
	set_from_axis_and_angle(*mesh.quaternion, .{x=0, y=0, z=1}, angle_delta);
	// mesh.scale.z = dist;
	sceneObjectUpdateMatrix(scene, mesh);
}
networkPanelConnectionSetMatrix :: (using panel: *TYPE, connection: NodeConnection, $forRaycast:bool) {
	if connectionObjectIndexByConnectionId.count <= xx connection.id {
		return;
	}
	meshIndex := connectionObjectIndexByConnectionId[connection.id];
	if meshIndex >= 0 {
		#if forRaycast {
			scene := *sceneRaycast;
		} else {
			scene := *sceneWorld;
		}
		object := scene.children[meshIndex];
		mesh := cast(*Mesh)object;
		networkPanelConnectionSetMatrix(panel, connection, mesh, scene);
	}
}

#scope_file

TYPE :: NetworkPanel;
MATERIAL_RAYCAST :: NETWORK_PANEL_MATERIAL_RAYCAST;

_addConnection :: (using panel: *TYPE, connection: NodeConnection, geometry: *Geometry, $forRaycast:bool) {
	#if forRaycast == true {
		scene := *sceneRaycast;
	} else {
		scene := *sceneWorld;
	}
	mesh := newMesh(scene, Mesh, geometry);
	mesh.transformOrder = .TRS;

	#if forRaycast {
		material := newMaterial(MATERIAL_RAYCAST, panel.allocator);
		material.uniforms.id = xx connection.id;
		meshSetMaterial(scene, mesh, xx material);
	} else {
		meshSetMaterial(scene, mesh, xx *panel.mat.connectionBasic);
	}

	networkPanelConnectionSetMatrix(panel, connection, mesh, scene);
	{
		#if forRaycast==false {
			if connectionObjectIndexByConnectionId.count < xx connection.id {
				array_resize(*connectionObjectIndexByConnectionId, xx connection.id+1);
			}
			array_insert_at(*connectionObjectIndexByConnectionId, item=xx scene.children.count, index=xx connection.id);
		}
		sceneObjectAdd(scene, mesh);
	}
}

_removeConnection :: (using panel:*TYPE, connection:NodeConnection, $forRaycast:bool) {
	meshIndex := connectionObjectIndexByConnectionId[connection.id];
	if meshIndex >= 0 {
		#if forRaycast {
			scene := *sceneRaycast;
		} else {
			scene := *sceneWorld;
		}
		object := scene.children[meshIndex];
		#if forRaycast {
			mesh := cast(*Mesh)object;
			materialDelete(cast(*MATERIAL_RAYCAST)mesh.material);
			geometryDelete(mesh.geometry);
		}
		sceneObjectRemove(scene, object, delete=false);
		#if forRaycast == true {
			connectionObjectIndexByConnectionId[connection.id] = 0;
		}
	}
}
