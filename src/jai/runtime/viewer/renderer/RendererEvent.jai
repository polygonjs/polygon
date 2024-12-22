
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
	objectAdd.count = 0;
	objectBeforeRemove.count = 0;
	objectsBeforeRemove.count = 0;
	renderableMaterialChanged.count = 0;
	objectMatrixUpdated.count = 0;
	cameraMatrixUpdated.count = 0;
}
rendererCommandsSetAllocator :: (renderer: *Renderer) {
	using renderer.commands;
	objectAdd.allocator = renderer.allocator;
	objectBeforeRemove.allocator = renderer.allocator;
	objectsBeforeRemove.allocator = renderer.allocator;
	renderableMaterialChanged.allocator = renderer.allocator;
	objectMatrixUpdated.allocator = renderer.allocator;
	cameraMatrixUpdated.allocator = renderer.allocator;
}
// rendererCommandsDelete :: (using commands: *RendererCommands) {
// 	array_reset(*objectAdd);
// 	array_reset(*objectBeforeRemove);
// }


RendererCommands :: struct {
	objectAdd :[..]RendererObjectAddCommand;
	objectBeforeRemove :[..]RendererObjectBeforeRemoveCommand;
	objectsBeforeRemove :[..]RendererObjectsBeforeRemoveCommand;
	renderableMaterialChanged :[..]RendererRenderableMaterialChangedCommand;
	objectMatrixUpdated :[..]RendererObjectMatrixUpdatedCommand;
	cameraMatrixUpdated :[..]RendererCameraMatrixUpdatedCommand;
}


#scope_file

RendererEvent :: enum u8 {
	OBJECT_ADDED :: 0;
	OBJECT_BEFORE_REMOVE;
	OBJECTS_BEFORE_REMOVE;
}
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
