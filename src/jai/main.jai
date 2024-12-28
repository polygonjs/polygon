#placeholder WASM; // for some reason if this is not a placeholder, there will be compilation errors, such as "/home/gui/work/web/games/polygon-next/src/jai/runtime/engine/registers/ComputeControllersRegister.jai:72,52: Error: While executing this #run, we stalled waiting for another directive, that will never be executed because it is waiting on this #run to finish"
#placeholder RUN_TESTS;
// FREE_MEMORY_DEBUG :: true; // added in build.jai

#if WASM==true #load "main_wasm.jai";
else           #load "main_native.jai";

// in wasm, having editor and nodesScene as globals is not enough,
// as they seem reset to null after main().
// but wrapping them in a PolygonApp struct seems to fix the problem.
PolygonApp :: struct {
	editor:*Editor;
	nodesScene:*NodesScene;
	poolsContainer: PoolsContainer;
}
APP:PolygonApp;

initSceneAndAttachToEditor :: (app: *PolygonApp) {
	editorInit(app.editor);
	editorSetScene(app.editor, app.nodesScene);
	appSceneInit(app.nodesScene, app.editor);
}


#scope_file


#load "config.jai";
#load "globals.jai";

#if FREE_MEMORY_DEBUG #import "Basic"()(MEMORY_DEBUGGER=true);
else #import "Basic";
#if FREE_MEMORY_DEBUG #import "Debug";
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
