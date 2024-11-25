
onObjectAdded :: (renderer: *Renderer, scene: *Scene, object: *$T) {
	array_add(*renderer.commands.objectAdd, .{object=xx object});
}
onObjectBeforeRemove :: (renderer: *Renderer, scene: *Scene, object: *$T) {
	array_add(*renderer.commands.objectBeforeRemove, .{object=xx object});
}


rendererFlushCommands :: (renderer: *Renderer) {
	using renderer.commands;
	doRendererObjectAddCommands(renderer, objectAdd);
	doRendererObjectBeforeRemoveCommands(renderer, objectBeforeRemove);

	objectAdd.count = 0;
	objectBeforeRemove.count = 0;
}
rendererCommandsSetAllocator :: (renderer: *Renderer) {
	using renderer.commands;
	objectAdd.allocator = renderer.allocator;
	objectBeforeRemove.allocator = renderer.allocator;
}
// rendererCommandsDelete :: (using commands: *RendererCommands) {
// 	array_reset(*objectAdd);
// 	array_reset(*objectBeforeRemove);
// }


RendererCommands :: struct {
	objectAdd :[..]RendererObjectAddCommand;
	objectBeforeRemove :[..]RendererObjectBeforeRemoveCommand;
}


#scope_file

RendererEvent :: enum u8 {
	OBJECT_ADDED :: 0;
	OBJECT_BEFORE_REMOVE;
}

RendererObjectAddCommand :: struct {
	object: *Object3D;
}
RendererObjectBeforeRemoveCommand :: struct {
	object: *Object3D;
}

doRendererObjectAddCommands :: (renderer: *Renderer, commands: [..]RendererObjectAddCommand) {
	for cmd: commands {
		rendererObjectAdd(renderer, cmd.object);
	}
}
doRendererObjectBeforeRemoveCommands :: (renderer: *Renderer, commands: [..]RendererObjectBeforeRemoveCommand) {
}
