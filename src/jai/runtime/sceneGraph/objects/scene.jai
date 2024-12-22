Time :: float32;

// SceneDataNoise :: struct {
// 	freq: Vector3 = .{2.0, 2.0, 2.0};
// 	offset: Vector3 = .{0.0, 0.0, 0.0};
// 	amount: Vector3 = .{1.0, 1.0, 1.0};
// }

SceneUniforms :: struct {
	time:Vector4;
};


Scene :: struct {
	#as using object3D: Object3D;

	#if USE_FLAT_POOL {
		pool: Flat_Pool;
	} else #if USE_POOL {
		pool: Pool;
	}

	children: [..]*Object3D;

	sceneUniforms: SceneUniforms;
	observers:[..]Any;

	// old
	// object
	// box_size: Vector3=.{3.0, 1.0, 1.0};
	// translate: Vector3;
	// string tests
	// node_name: string;
	//
	// segments: Vector3Int = .{128, 128, 128};
	// noise:SceneDataNoise;
};
newScene :: (scene: *NodesScene) -> *TYPE {
	return newScene(scene.allocator);
}
newScene :: (allocator: Allocator) -> *TYPE {
	scene := object3DAllocate(TYPE, allocator);

	allocatorAssign(scene);

	object3DInit(scene);
	array_init(*scene.children, scene.allocator);
	array_init(*scene.observers, scene.allocator);
	return scene;
}
worldObjectClone :: (object: *TYPE)->*TYPE {
	clone := New(TYPE,, object.allocator);
	assert(false, "worldObjectClone is not implemented for Scene\n");
	return clone;
}

object3DInit :: (scene: *TYPE) {
	object3DInit(cast(*Object3D)scene);
}

sceneObjectsClear :: (scene: *TYPE) {
	sceneEmitEvent(scene, .OBJECTS_BEFORE_REMOVE, scene.children);
	array_set_count_and_maybe_grow(*scene.children, 0);
}
sceneObjectAdd :: (scene: *TYPE, object: *Object3D) {
	array_add(*scene.children, object);
	sceneEmitEvent(scene, .OBJECT_ADDED, object);
}
sceneObjectsAdd :: (scene: *TYPE, objects: [..]*Object3D) {
	for object: objects array_add(*scene.children, object);
	sceneEmitEvent(scene, .OBJECTS_ADDED, objects);
}
sceneObjectRemove :: (scene: *TYPE, object: *Object3D, $delete:bool) {
	for child, i: scene.children {
		if child == object {
			sceneEmitEvent(scene, .OBJECT_BEFORE_REMOVE, object);
			array_unordered_remove_by_index(*scene.children, i);
			#if delete {
				generatedWorldObjectDelete(object);
			}
			return;
		}
	}
}
sceneObjectUpdateMatrix :: (scene: *TYPE, object: *Object3D) {
	transformableUpdateMatrix(object);
	sceneEmitEvent(scene, .OBJECT_MATRIX_UPDATED, object);
}
sceneCameraUpdateMatrix :: (scene: *TYPE, camera: *Camera) {
	transformableUpdateMatrix(camera);
	sceneEmitEvent(scene, .CAMERA_MATRIX_UPDATED, camera);
}
sceneCameraUpdateProjectionMatrix :: (scene: *TYPE, camera: *$T/Camera) {
	cameraProjectionUpdate(camera);
	// we could emit a .CAMERA_PROJECTION_MATRIX_UPDATED event
	// but for now, we just emit the same event as .CAMERA_MATRIX_UPDATED
	// as both matrices are updated at the same time in the renderer anyway
	sceneEmitEvent(scene, .CAMERA_MATRIX_UPDATED, camera);
}

worldObjectDelete :: (scene: *TYPE) {
	allocatorReset(scene);
	free(scene,,allocator=scene.allocator);
}

sceneUniformsUpdate :: (scene: *TYPE, time:Time) {
	scene.sceneUniforms.time.x = time;

	for scene.children {
		// mesh_update_matrix(*it);
		if it!=null transformableUniformsUpdate(it);
	}
	// for scene.children {
	// 	// mesh_update_matrix(*it);
	// 	if it!=null transformableUniformsUpdate(it);
	// }
	// update_object_uniforms(*scene_data.object_data, *scene_data.object_uniforms);
	// update_sdf_uniforms(*scene_data.sdf_data, *scene_data.sdf_uniforms, scene_data.time);
}
meshSetMaterial :: (scene: *Scene, mesh: *Mesh, material: *Material) {
	previousMaterial := mesh.material;
	mesh.material = material;
	if previousMaterial != null {
		// I don't think we should send an event if the previous material is null
		// since the mesh would then not be in any pipelineController of the renderer
		sceneEmitEvent(scene, .RENDERABLE_MATERIAL_CHANGED, mesh, previousMaterial);
	}
}

#scope_file

TYPE :: Scene;


