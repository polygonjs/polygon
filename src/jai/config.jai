#placeholder WASM;
#placeholder RUN_TESTS;

COLOR_SPACE_LINEAR :: true; // needs to manually match same variable in WebGPURequest.ts
USE_IMGUI :: true;
USE_IMGUI_DEBUG :: false;
USE_WGPU :: true;
MAP_BUFFER :: false && WASM==false; // to read the buffer from the GPU to the CPU
FREE_MEMORY :: true; // beware wasm memory corruption when in use
RENDER_SCENE :: true;
VSYNC :: false;
RUN_SCENE :: true;
NODES_SCENE_EMIT_EVENTS :: true;

// it would be great if FREE_MEMORY_DEBUG could be set
// depending on the value of RUN_TESTS, but since RUN_TESTS
// is a placeholder, it looks like the Basic module
// would already have been imported, and the program parameter
// would already have been set.
// So for now, we do it manually.
// TODO: maybe consider updating this file from build.jai,
// before the compiler starts.
FREE_MEMORY_DEBUG :: true;//RUN_TESTS==true;
USE_FLAT_POOL :: false;
USE_POOL :: true;

#if WASM { #assert FREE_MEMORY_DEBUG==false; }
#if USE_POOL { #assert USE_FLAT_POOL==false; }
#if USE_FLAT_POOL { #assert USE_POOL==false; }
