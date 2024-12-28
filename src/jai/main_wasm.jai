main :: () {
	call_from_wasm_context = context;

	// #if RUN_TESTS {
	// 	runTests();
	// }
	APP.nodesScene = newNodesScene();
	APP.editor = newEditor();

	// #if WASM==true assert(APP.editor!=null, "main: editor is null");

}


on_wgpu_device_ready :: (
	canvas: WGPUSurface,
	device: WGPUDevice,
	queue: WGPUQueue,
	preferred_texture_format: WGPUTextureFormat
) {
	if USE_IMGUI_DEBUG return;

	context = call_from_wasm_context;
	wgpuContextInit(*APP.editor.wgpuContext, canvas, device, queue, preferred_texture_format);
}
init_draw_data :: () {
	context = call_from_wasm_context;
	assert(APP.editor!=null, "init_draw_data: editor is null");
	initSceneAndAttachToEditor(*APP);
	drawDataInit(APP.editor);
}
on_request_animation_frame :: ( newTime: u64, width: u64, height: u64 ) {
	#if WASM==true context = call_from_wasm_context;
	#if WASM==true assert(APP.editor!=null, "on_request_animation_frame: editor is null");

	editorOnTick(APP.editor, newTime, width, height);
}
requestAllocation :: (nodeId: NodeId, size: u64) {
	#if WASM==true context = call_from_wasm_context;
	__requestAllocation(APP.editor.nodesScene, nodeId, size);
	// print("Z\n");
}
onAllocatedMemoryWritten :: (nodeId: NodeId) {
	#if WASM==true context = call_from_wasm_context;
	__onAllocatedMemoryWritten(APP.editor.nodesScene, nodeId);
}