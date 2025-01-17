This is a rewrite of https://polygonjs.com/ using Jai and WebGPU. The goal is to be able to deploy 3D apps on the web as well as on desktop, while increasing performance.

This is very early days, and only tested on linux so far.

# Build

## For Desktop

compile: `jai src/jai/build/build.jai - native`

run: `bin/polygon-next`

## For Web (wasm64)

-   compile: `jai src/jai/build/build.jai - wasm`
-   start dev server: `yarn dev`
-   open on http://localhost:5173

The vite config has hot reload setup for wasm, so any change to a .jai file will trigger it.

This by defaults requires WebGPU and Wasm64. From linux, you can use Chrome Beta and run it with `google-chrome-beta --enable-unsafe-webgpu --use-vulkan=true --test-type --enable-features=Vulkan,VulkanFromANGLE,DefaultANGLEVulkan --experimental-wasm-memory64 --use-angle=vulkan --enable-gpu-rasterization --enable-zero-copy`.

## For Web (wasm32)

You can also use this with wasm32, by building [this fork of wabt](https://github.com/frading/wabt) (forked from [tsoding's work](https://github.com/tsoding/wabt-wasm64232)).

-   combine the wabt fork mentioned above. Make wasm64232 accessible to your $PATH.
-   compile the wasm64 with: `jai src/jai/build/build.jai - wasm noeditor three && yarn wasm64232`
-   start dev server: `yarn dev`
-   open on http://localhost:5173/three

This is an example where geometries are generated in jai/wasm and threejs meshes are updated based on those. This can then be viewed on any browser that supports WebGL.

You may also want to change the `vite.config.ts` options `noeditor: true`, `three:true` and `wasm32: true` if you want the hot reload to trigger a re-compile with the correct options. Obviously hot reload is now much slower than with wasm64.

# Run test suite

on Desktop:

`jai src/jai/build/build.jai - native test && bin/polygon-next`

on Web:

-   in `vite.config.ts`, set `BUILD_ARGS = { ... test: true ... }`
-   compile: `jai src/jai/build/build.jai - wasm`
-   start dev server: `yarn dev`
-   open on http://localhost:5173
-   You will see the test suite run in the dev console.

