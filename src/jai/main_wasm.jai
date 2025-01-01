main :: () {
	call_from_wasm_context = context;
}


on_wgpu_device_ready :: ( canvas: WGPUSurface, device: WGPUDevice, queue: WGPUQueue, preferred_texture_format: WGPUTextureFormat, width: u64, height: u64 ) {
	context = call_from_wasm_context;

	#if RUN_TESTS {

		wgpuContextInit(*APP.testApp.headlessWGPUContext, canvas, device, queue, preferred_texture_format, width, height);
		runTests(*APP);

	} else {

		nodesSceneInit(*APP.nodesScene);
		wgpuContextInit(*APP.editor.wgpuContext, canvas, device, queue, preferred_texture_format, width, height);
		initSceneAndAttachToEditor(*APP);
		editorStart(*APP.editor);

	}
}

on_request_animation_frame :: ( newTime: u64, width: u64, height: u64 ) {
	context = call_from_wasm_context;

	if( nodesSceneValid(*APP.nodesScene) && editorValid(*APP.editor) ){
		if(APP.editor.exitRequested==true){
			editorReset(*APP.editor);
		} else {
			editorOnTick(*APP.editor, newTime, width, height);
		}
	} else {
		// print("nodesSceneValid(APP.nodesScene):% editorValid(APP.editor):% (APP.editor=%, APP=%, initialized=% disposed=%)\n", nodesSceneValid(*APP.nodesScene), editorValid(*APP.editor), *APP.editor, *APP, APP.editor.initialized, APP.editor.disposed);
	}
	#if RUN_TESTS {
		batchRunNextTestOrTerminate(*APP);
	}

}
requestAllocation :: (nodeId: NodeId, size: u64) {
	context = call_from_wasm_context;
	__requestAllocation(*APP.nodesScene, nodeId, size);
}
onAllocatedMemoryWritten :: (nodeId: NodeId) {
	context = call_from_wasm_context;
	__onAllocatedMemoryWritten(*APP.nodesScene, nodeId);
}
requestRealloc :: (oldDataPointer: *u8, newSize: s64)  {
	context = call_from_wasm_context;
	size := newSize;//ifx oldSize < newSize then oldSize else newSize;
	newData := NewArray(size, u8,, temp);

	memcpy(newData.data, oldDataPointer, size);

	onReallocReady(xx newData.data);
}

#scope_file

call_from_wasm_context :#Context;