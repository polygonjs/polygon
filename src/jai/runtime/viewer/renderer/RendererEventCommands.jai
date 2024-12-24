
onObjectAdded :: (renderer: *Renderer, scene: *Scene, object: *$T) {
	array_add(*renderer.commands.objectAdd, .{object=xx object});
}
onObjectsAdded :: (renderer: *Renderer, scene: *Scene, objects: []*$T) {
	for o: objects array_add(*renderer.commands.objectAdd, .{object=xx o});
}
onObjectBeforeRemove :: (renderer: *Renderer, scene: *Scene, object: *$T) {
	array_add(*renderer.commands.objectBeforeRemove, .{object=xx object});
}
onObjectsBeforeRemove :: (renderer: *Renderer, scene: *Scene, objects: []*$T) {
	array_add(*renderer.commands.objectsBeforeRemove, .{objects=xx objects});
}
onRenderableMaterialChanged :: (renderer: *Renderer, scene: *Scene, object: *$T, previousMaterial:*Material) {
	array_add(*renderer.commands.renderableMaterialChanged, .{object=xx object, previousMaterial=previousMaterial});
}
onObjectMatrixUpdated :: (renderer: *Renderer, scene: *Scene, object: *$T) {
	for cmd, i: renderer.commands.objectMatrixUpdated {
		if cmd.object == object {
			return;
		}
	}
	array_add(*renderer.commands.objectMatrixUpdated, .{object=xx object});
}
onCameraMatrixUpdated :: (renderer: *Renderer, scene: *Scene, camera: *$T/Camera) {
	for cmd, i: renderer.commands.cameraMatrixUpdated {
		if cmd.camera == camera {
			return;
		}
	}
	array_add(*renderer.commands.cameraMatrixUpdated, .{camera=xx camera});
}


rendererFlushCommands :: (renderer: *Renderer) {
	using renderer.commands;

	doRendererObjectBeforeRemoveCommands(renderer, objectBeforeRemove);
	doRendererObjectsBeforeRemoveCommands(renderer, objectsBeforeRemove);
	doRendererObjectAddCommands(renderer, objectAdd);
	doRendererRenderableMaterialChangedCommands(renderer, renderableMaterialChanged);
	doRendererTransformableMatrixUpdatedCommands(renderer, objectMatrixUpdated);
	doRendererCameraMatrixUpdatedCommands(renderer, cameraMatrixUpdated);

	// print("objectAdd 1: %\n", objectAdd.count);
	// for :members renderer.commands {
	// 	// (<<member).count = 0;
	// 	array_reset_keeping_memory(it);
	// }
	// print("objectAdd 2: %\n", objectAdd.count);
	objectAdd.count = 0;
	objectBeforeRemove.count = 0;
	objectsBeforeRemove.count = 0;
	renderableMaterialChanged.count = 0;
	objectMatrixUpdated.count = 0;
	cameraMatrixUpdated.count = 0;
}
rendererCommandsSetAllocator :: (renderer: *Renderer) {
	using renderer.commands;
	// print("set allocator\n");
	// for :members member: renderer.commands {
	// 	print("%,%\n", it_index, memberName);
	// 	member.allocator = renderer.allocator;
	// 	array_reserve(member, 1024);
	// }

	array_init(*objectAdd, renderer.allocator, reserve=true);
	array_init(*objectBeforeRemove, renderer.allocator, reserve=true);
	array_init(*objectsBeforeRemove, renderer.allocator, reserve=true);
	array_init(*renderableMaterialChanged, renderer.allocator, reserve=true);
	array_init(*objectMatrixUpdated, renderer.allocator, reserve=true);
	array_init(*cameraMatrixUpdated, renderer.allocator, reserve=true);
}


RendererCommands :: struct {
	objectBeforeRemove :[..]RendererObjectBeforeRemoveCommand;
	objectsBeforeRemove :[..]RendererObjectsBeforeRemoveCommand;
	objectAdd :[..]RendererObjectAddCommand;
	renderableMaterialChanged :[..]RendererRenderableMaterialChangedCommand;
	objectMatrixUpdated :[..]RendererObjectMatrixUpdatedCommand;
	cameraMatrixUpdated :[..]RendererCameraMatrixUpdatedCommand;
}

// members :: (using object: *RendererCommands, body: Code, flags: For_Flags) #expand {
// 	object_info := type_info(type_of(<<object));
// 	object_tis := cast(*Type_Info_Struct)object_info;

// 	for member, i: object_tis.members {
// 		memberField := get_field(object_tis, member.name);
// 		member_tis := cast(*Type_Info_Struct)memberField.type;
// 		memberPtr := (cast(*u8)object) + memberField.offset_in_bytes + memberField.offset_in_bytes;
// 		`it := cast(*[..]Any)memberPtr;
// 		`it_index := i;
// 		`memberName := member.name;

// 		#insert body;
// 	}
// 	// `it_index := 0; `it :[..]Any= objectBeforeRemove; #insert body;
// 	// `it_index = 1; `it = objectAdd; #insert body;
// 	// `it_index = 2; `it = objectsBeforeRemove; #insert body;
// 	// `it_index = 3; `it = renderableMaterialChanged; #insert body;
// 	// `it_index = 4; `it = objectMatrixUpdated; #insert body;
// 	// `it_index = 5; `it = cameraMatrixUpdated; #insert body;
// }


#scope_file

RendererObjectCommand :: struct {
	object: *Object3D;
}
RendererCameraCommand :: struct {
	camera: *Camera;
}
RendererObjectAddCommand :: RendererObjectCommand;
RendererObjectBeforeRemoveCommand :: RendererObjectCommand;

RendererObjectsBeforeRemoveCommand :: struct {
	objects: []*Object3D;
}
RendererRenderableMaterialChangedCommand :: struct {
	object: *Object3D;
	previousMaterial: *Material;
}
RendererObjectMatrixUpdatedCommand :: RendererObjectCommand;
RendererCameraMatrixUpdatedCommand :: RendererCameraCommand;


doRendererObjectAddCommands :: (renderer: *Renderer, commands: [..]RendererObjectAddCommand) {
	for cmd: commands { rendererObjectAdd(renderer, cmd.object); }
}
doRendererObjectBeforeRemoveCommands :: (renderer: *Renderer, commands: [..]RendererObjectBeforeRemoveCommand) {
	for cmd: commands { rendererObjectRemove(renderer, cmd.object); }
}
doRendererObjectsBeforeRemoveCommands :: (renderer: *Renderer, commands: [..]RendererObjectsBeforeRemoveCommand) {
	for cmd: commands { for o: cmd.objects { rendererObjectRemove(renderer, o); } }
}
doRendererRenderableMaterialChangedCommands :: (renderer: *Renderer, commands: [..]RendererRenderableMaterialChangedCommand) {
	for cmd: commands { rendererRenderableMaterialChanged(renderer, cmd.object, cmd.previousMaterial); }
}
doRendererTransformableMatrixUpdatedCommands :: (renderer: *Renderer, commands: [..]RendererObjectMatrixUpdatedCommand) {
	for cmd: commands {
		if cmd.object.type == Mesh {
			rendererTransformableUpdateMatrix(renderer, cast(*Mesh)cmd.object);
		} else {
			print("doRendererTransformableMatrixUpdatedCommands: unknown object type:%\n", cmd.object.type);
		}
	}
}
doRendererCameraMatrixUpdatedCommands :: (renderer: *Renderer, commands: [..]RendererCameraMatrixUpdatedCommand) {
	for cmd: commands {
		rendererCameraUpdateMatrix(renderer, cmd.camera);
	}
}
