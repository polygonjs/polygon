#load "wgpu_buffer.jai";
#load "wgpu_color.jai";
#load "wgpu_context.jai";
#load "wgpu_depth.jai";
#load "wgpu_geometry.jai";
#load "wgpu_material.jai";
#load "wgpu_msaa.jai";
#load "wgpu_surface.jai";
#load "wgpu_uniforms.jai";

#load "draw_data.jai";
#load "pipeline_controller.jai";
#load "renderer.jai";
#load "renderer_collection.jai";
#load "renderer_read_pixel.jai";
#load "renderer_ui.jai";
#load "renderer_uniforms.jai";
#load "renderer_viewport.jai";
#load "RendererEvent.jai";

#load "compute_controller.jai";
#load "compute_controller_collection.jai";
#load "compute_controllers/index.jai";

#if WASM #load "targets/wasm.jai";
else     #load "targets/native.jai";


