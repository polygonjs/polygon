main :: () {
	call_from_wasm_context = context;

	// #if RUN_TESTS {
	// 	runTests();
	// }

	// #if WASM==true assert(APP.editor!=null, "main: editor is null");

}


on_wgpu_device_ready :: ( canvas: WGPUSurface, device: WGPUDevice, queue: WGPUQueue, preferred_texture_format: WGPUTextureFormat, width: u64, height: u64 ) {
	if USE_IMGUI_DEBUG return;

	context = call_from_wasm_context;

	#if RUN_TESTS {
		
		wgpuContextInit(*TEST_APP.headlessWGPUContext, canvas, device, queue, preferred_texture_format, width, height);
		runTests();
	} else {
		nodesSceneInit(*APP.nodesScene);
		// editorInitAPP.editor = newEditor();
		wgpuContextInit(*APP.editor.wgpuContext, canvas, device, queue, preferred_texture_format, width, height);
		initSceneAndAttachToEditor(*APP);
		editorStart(*APP.editor);
	}
}

on_request_animation_frame :: ( newTime: u64, width: u64, height: u64 ) {
	context = call_from_wasm_context;
	#if RUN_TESTS == false {
		assert(APP.editor!=null, "on_request_animation_frame: editor is null");
	}

	if(APP.editor != null) {
		if(APP.editor.exitRequested==true){
			editorReset(*APP.editor);
		} else {
			editorOnTick(*APP.editor, newTime, width, height);
		}
	} else {
		#if RUN_TESTS {
			if TEST_APP.testInProgress {
				print("editor is null\n");
			}
		}
	}

	#if RUN_TESTS {
		batchRunNextTestOrTerminate();
	}
}
requestAllocation :: (nodeId: NodeId, size: u64) {
	context = call_from_wasm_context;
	__requestAllocation(APP.editor.nodesScene, nodeId, size);
}
onAllocatedMemoryWritten :: (nodeId: NodeId) {
	context = call_from_wasm_context;
	__onAllocatedMemoryWritten(APP.editor.nodesScene, nodeId);
}
