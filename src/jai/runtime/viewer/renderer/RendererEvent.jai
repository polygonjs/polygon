
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


rendererFlushCommands :: (renderer: *Renderer) {
	using renderer.commands;

	doRendererObjectBeforeRemoveCommands(renderer, objectBeforeRemove);
	doRendererObjectsBeforeRemoveCommands(renderer, objectsBeforeRemove);
	doRendererObjectAddCommands(renderer, objectAdd);
	doRendererRenderableMaterialChangedCommands(renderer, renderableMaterialChanged);
	objectAdd.count = 0;
	objectBeforeRemove.count = 0;
	objectsBeforeRemove.count = 0;
	renderableMaterialChanged.count = 0;
}
rendererCommandsSetAllocator :: (renderer: *Renderer) {
	using renderer.commands;
	objectAdd.allocator = renderer.allocator;
	objectBeforeRemove.allocator = renderer.allocator;
	objectsBeforeRemove.allocator = renderer.allocator;
	renderableMaterialChanged.allocator = renderer.allocator;
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
}


#scope_file

RendererEvent :: enum u8 {
	OBJECT_ADDED :: 0;
	OBJECT_BEFORE_REMOVE;
	OBJECTS_BEFORE_REMOVE;
}

RendererObjectAddCommand :: struct {
	object: *Object3D;
}
RendererObjectBeforeRemoveCommand :: struct {
	object: *Object3D;
}
RendererObjectsBeforeRemoveCommand :: struct {
	objects: []*Object3D;
}
RendererRenderableMaterialChangedCommand :: struct {
	object: *Object3D;
	previousMaterial: *Material;
}

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
