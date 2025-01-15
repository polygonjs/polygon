main :: () {
	call_from_wasm_context = context;

	#if FOR_THREE {
		nodesSceneInit(*APP.nodesScene);
		appInit(*APP);
	}
}


on_wgpu_device_ready :: ( canvas: WGPUSurface, device: WGPUDevice, queue: WGPUQueue, preferred_texture_format: WGPUTextureFormat, width: u64, height: u64 ) {
	context = call_from_wasm_context;

	loadFontImage();

	#if RUN_TESTS {

		wgpuContextInit(*APP.testApp.headlessWGPUContext, canvas, device, queue, preferred_texture_format, width, height);
		runTests(*APP);

	} else {

		nodesSceneInit(*APP.nodesScene);
		#if USE_EDITOR {
			// TODO: the scene should have access to the wgpuContext when we don't have an editor (or always).
			wgpuContextInit(*APP.editor.wgpuContext, canvas, device, queue, preferred_texture_format, width, height);
		}
		appInit(*APP);
		#if USE_EDITOR {
			editorStart(*APP.editor);
		}

	}
}

on_request_animation_frame :: ( newTimeInMs: u64, width: u64, height: u64 ) {
	context = call_from_wasm_context;

	newTimeInSeconds :Time= xx (newTimeInMs / 1000.0);

	if appValid(*APP) {
		#if USE_EDITOR {
			if(APP.editor.exitRequested==true){
				editorReset(*APP.editor);
			} else {
				editorOnTick(*APP.editor, newTimeInSeconds, width, height);
			}
		} else {
			sceneOnTick(*APP.nodesScene, newTimeInSeconds);
		}
	} else {
		// #if USE_EDITOR {
		// 	print("nodesSceneValid(APP.nodesScene):% editorValid(APP.editor):% (APP.editor=%, APP=%, initialized=% disposed=%)\n", nodesSceneValid(*APP.nodesScene), editorValid(*APP.editor), *APP.editor, *APP, APP.editor.initialized, APP.editor.disposed);
		// } else {
		// 	print("nodesSceneValid(APP.nodesScene):%", nodesSceneValid(*APP.nodesScene));
		// }
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
requestRealloc :: (oldDataPointer: *u8, newSize: s64) {
	context = call_from_wasm_context;
	size := newSize;//ifx oldSize < newSize then oldSize else newSize;
	newData := NewArray(size, u8,, temp);

	memcpy(newData.data, oldDataPointer, size);

	onReallocReady(xx newData.data);
}
onPopErrorScopeCompleted :: (errorSize: u64) {
	#if USE_EDITOR {
		// TODO: ideally we should:
		// - build be able to build without wgpu, and in that case no include the onPopErrorScopeCompleted function
		// - the scene should still be able to be loaded without editor, with wgpu, and therefore have access to the wgpuContext
	 	onCapturedErrorWasm(errorSize, *APP.editor.wgpuContext);
	}
}

#scope_file

call_from_wasm_context :#Context;

appValid :: (app:*PolygonApp)->bool {
	if nodesSceneValid(*APP.nodesScene) == false {
		return false;
	}
	#if USE_EDITOR {
		if editorValid(*APP.editor) == false {
			return false;
		}
	}
	return true;
}

