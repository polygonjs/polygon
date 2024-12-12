
main :: () {
	#if WASM==true call_from_wasm_context = context;

	#if RUN_TESTS {
		runTests();
		#if WASM==false {
			return;
		}
	}
	APP.nodesScene = newNodesScene();
	APP.editor = newEditor();
	#if WASM==true assert(APP.editor!=null, "main: editor is null");
	editorSetScene(APP.editor, APP.nodesScene);
	appInit(APP.nodesScene, APP.editor);

	#if WASM==false {
		window_size := windowInit(APP.editor);
		editorStart(APP.editor, window_size);

		reset_temporary_storage();
		#if WASM==false && FREE_MEMORY_DEBUG==true defer report_memory_leaks();
		SDL_Quit();
		printGreen("polygon quit\n");
	}

	#if WASM==true assert(APP.editor!=null, "main end: editor is null");
}

init_draw_data :: () {
	#if WASM==true context = call_from_wasm_context;
	#if WASM==true assert(APP.editor!=null, "init_draw_data: editor is null");

	drawDataInit(APP.editor);

}

on_request_animation_frame :: ( newTime: u64, width: u64, height: u64 ) {
	#if WASM==true context = call_from_wasm_context;
	#if WASM==true assert(APP.editor!=null, "on_request_animation_frame: editor is null");

	editorOnTick(APP.editor, newTime, width, height);
}

#if WASM==true {
	requestAllocation :: (nodeId: NodeId, size: u64) {
		#if WASM==true context = call_from_wasm_context;
		__requestAllocation(APP.editor.nodesScene, nodeId, size);
		// print("Z\n");
	}
	onAllocatedMemoryWritten :: (nodeId: NodeId) {
		#if WASM==true context = call_from_wasm_context;
		__onAllocatedMemoryWritten(APP.editor.nodesScene, nodeId);
	}
}

#scope_file

// in wasm, having editor and nodesScene as globals is not enough,
// as they seem reset to null after main().
// but wrapping them in a PolygonApp struct seems to fix the problem.
PolygonApp :: struct {
	editor:*Editor;
	nodesScene:*NodesScene;
}
APP:PolygonApp;

#load "config.jai";
#load "globals.jai";

#if FREE_MEMORY_DEBUG #import "Basic"()(MEMORY_DEBUGGER=true);
else #import "Basic";
#if USE_FLAT_POOL #import "Flat_Pool";
#if FREE_MEMORY_DEBUG {
	#import "Unmapping_Allocator";
	#if USE_POOL #import "Pool";//()(USE_UNMAPPING_ALLOCATOR=true); // Unmapping_Allocator module seems to have its own leaks?
} else {
	#if USE_POOL #import "Pool";
}
#import "Bit_Array";
#import "Hash_Table";
#import "Math";
#import "String";
#if WASM == true  #import "wgpu_wasm";
else              #import "wgpu";
#if WASM == false {
	#import "SDL";
	#import "File";
}

#load "app.jai";
#load "editor/_index.jai";
#load "runtime/_index.jai";

#if RUN_TESTS {
	#load "test/_index.jai";
}

#if OS == .LINUX {
	// in order to import gcc_s, I initially tried:
	// gcc_s  :: #library,system,link_always "libgcc_s.so.1";
	// as the symlink from libgcc_s.so did not exist. This worked fine,
	// but to be cleaner, I created it with:
	// sudo ln -s /lib/x86_64-linux-gnu/libgcc_s.so.1 /lib/x86_64-linux-gnu/libgcc_s.so
	// and now we can import with "gcc_s"
	gcc_s  :: #library,system,link_always "gcc_s";
	// c  :: #library,system,link_always "libc";
	// m  :: #library,system,link_always "libm";
	// dl :: #library,system,link_always "libdl";
	// pt :: #library,system,link_always "libpthread";

	// for imgui_impl_wgpu lib (until we convert it to jai)
	//
	// sudo ln -s /lib/x86_64-linux-gnu/libstdc++.so.6 /lib/x86_64-linux-gnu/libstdc++.so
	// and now we can import with "gcc_s"
	// libstd :: #library,system,link_always "stdc++";
}
