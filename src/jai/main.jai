
main :: () {
	#if WASM==true call_from_wasm_context = context;

	#if RUN_TESTS {
		runTests();
		#if WASM==false {
			return;
		}
	}
	NODES_SCENE = newNodesScene();
	assert(NODES_SCENE.timeGraphNode.name == "TimeNode", "timeGraphNode not set up correctly (A)");
	EDITOR := newEditor();
	editorSetScene(EDITOR, NODES_SCENE);
	assert(NODES_SCENE.timeGraphNode.name == "TimeNode", "timeGraphNode not set up correctly (B)");
	appInit(NODES_SCENE, EDITOR);

	#if WASM==false {
		window_size := windowInit();
		editorNativeStart(EDITOR, window_size);

		reset_temporary_storage();
		#if WASM==false && FREE_MEMORY_DEBUG==true defer report_memory_leaks();
		SDL_Quit();
		printGreen("polygon quit\n");
	}

}

init_draw_data :: () {
	#if WASM==true context = call_from_wasm_context;

	drawDataInit(EDITOR);

}

on_request_animation_frame :: ( newTime: u64, width: u64, height: u64 ) {
	#if WASM==true context = call_from_wasm_context;

	editorOnTick(EDITOR, newTime, width, height);
}


#scope_file


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
