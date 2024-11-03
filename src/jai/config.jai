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
RENDER_WORLD :: true && USE_WGPU==true;
RENDER_NODES_NETWORK :: true && USE_WGPU==true;
RUN_SCENE :: true;

// it would be great if FREE_MEMORY_DEBUG could be set
// depending on the value of RUN_TESTS, but since RUN_TESTS
// is a placeholder, it looks like the Basic module
// would already have been imported, and the program parameter
// would already have been set.
// So for now, we do it manually.
// TODO: maybe consider updating this file from build.jai,
// before the compiler starts.
FREE_MEMORY_DEBUG :: true;//RUN_TESTS==true;
