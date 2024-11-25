#load "wgpu_buffer.jai";
#load "wgpu_color.jai";
#load "wgpu_context.jai";
#load "wgpu_depth.jai";
#load "wgpu_geometry.jai";
#load "wgpu_material.jai";
#load "wgpu_msaa.jai";
#load "wgpu_surface.jai";
#load "wgpu_uniforms.jai";

#if WASM #load "targets/wasm.jai";
else     #load "targets/native.jai";