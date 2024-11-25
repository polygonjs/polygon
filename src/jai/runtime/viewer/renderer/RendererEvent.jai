
onObjectAdded :: (renderer: *Renderer, scene: *Scene, object: *$T) {
	array_add(*renderer.commands.objectAdd, .{object=xx object});
}
onObjectBeforeRemove :: (renderer: *Renderer, scene: *Scene, object: *$T) {
	array_add(*renderer.commands.objectBeforeRemove, .{object=xx object});
}
onObjectsBeforeRemove :: (renderer: *Renderer, scene: *Scene, objects: []*$T) {
	array_add(*renderer.commands.objectsBeforeRemove, .{objects=xx objects});
}


rendererFlushCommands :: (renderer: *Renderer) {
	using renderer.commands;

	doRendererObjectBeforeRemoveCommands(renderer, objectBeforeRemove);
	doRendererObjectsBeforeRemoveCommands(renderer, objectsBeforeRemove);
	doRendererObjectAddCommands(renderer, objectAdd);

	objectAdd.count = 0;
	objectBeforeRemove.count = 0;
	objectsBeforeRemove.count = 0;
}
rendererCommandsSetAllocator :: (renderer: *Renderer) {
	using renderer.commands;
	objectAdd.allocator = renderer.allocator;
	objectBeforeRemove.allocator = renderer.allocator;
	objectsBeforeRemove.allocator = renderer.allocator;
}
// rendererCommandsDelete :: (using commands: *RendererCommands) {
// 	array_reset(*objectAdd);
// 	array_reset(*objectBeforeRemove);
// }


RendererCommands :: struct {
	objectAdd :[..]RendererObjectAddCommand;
	objectBeforeRemove :[..]RendererObjectBeforeRemoveCommand;
	objectsBeforeRemove :[..]RendererObjectsBeforeRemoveCommand;
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

doRendererObjectAddCommands :: (renderer: *Renderer, commands: [..]RendererObjectAddCommand) {
	for cmd: commands { rendererObjectAdd(renderer, cmd.object); }
}
doRendererObjectBeforeRemoveCommands :: (renderer: *Renderer, commands: [..]RendererObjectBeforeRemoveCommand) {
	for cmd: commands { rendererObjectRemove(renderer, cmd.object); }
}
doRendererObjectsBeforeRemoveCommands :: (renderer: *Renderer, commands: [..]RendererObjectsBeforeRemoveCommand) {
	for cmd: commands { for o: cmd.objects { rendererObjectRemove(renderer, o); } }
}
