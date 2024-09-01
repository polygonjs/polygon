#load "wgpu_color.jai";
#load "wgpu_context.jai";
#load "wgpu_depth.jai";
#load "wgpu_geometry.jai";
#load "wgpu_msaa.jai";
#load "wgpu_shaders.jai";
#load "wgpu_uniforms.jai";

#load "pipeline_controller.jai";
#if USE_COMPUTE_SHADER #load "compute_controller.jai";

#if WASM #load "targets/wasm.jai";
else     #load "targets/native.jai";


