#load "wgpu_buffer.jai";
#load "wgpu_color.jai";
#load "wgpu_context.jai";
#load "wgpu_depth.jai";
#load "wgpu_geometry.jai";
#load "wgpu_material.jai";
#load "wgpu_msaa.jai";
#load "wgpu_shaders.jai";
#load "wgpu_uniforms.jai";

#load "draw_data.jai";
#load "pipeline_controller.jai";
#load "renderer.jai";

#if USE_COMPUTE_SHADER {
	#load "compute_controller.jai";
	#load "compute_controller_collection.jai";
	#load "compute_controller_box_create.jai";
	#load "compute_controller_translate.jai";
	#load "compute_controller_noise.jai";
}

#if WASM #load "targets/wasm.jai";
else     #load "targets/native.jai";


