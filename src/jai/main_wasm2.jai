WASM :: true;
USE_COMPUTE_SHADER :: false;
#import "Basic";
#import "Math";
#if WASM == true #import "wgpu_wasm";
#if WASM == false #import "wgpu";

#load "common/math_helper.jai";;
#load "common/draw_data.jai";
#load "common/scene_data.jai";
#load "common/type_utils.jai";
#if WASM == true #load "common/wgpu/wasm.jai";
#if WASM == false #load "common/wgpu/native.jai";
#load "common/wgpu/common.jai";
#load "common/wgpu/common_depth.jai";
#load "common/wgpu/common_multisample.jai";
#load "common/wgpu/common_uniforms.jai";

#placeholder SHADER_RENDER;
#placeholder SHADER_COMPUTE;

// MAX_PRINT_SIZE :: 2048;
// PRINT_STRING_BUFFER : string =.{ count = MAX_PRINT_SIZE };

FREE_MEMORY :: false; // beware wasm memory corruption when in use
#if WASM==true call_from_wasm_context :Context;


main :: () {
	#if WASM==true call_from_wasm_context = context;
	// a := 1+2;
	// set_print_string_buffer(PRINT_STRING_BUFFER);
	// js_print("main called\n");
	// js_print(tprint("a:%\n",a));
	// js_print("after tprint\n");
	// print("%\n",SHADER_RENDER);

	// context.logger = dom_logger;
	// log("Logging to the DOM via Jai.");
}

// set_print_string_buffer :: (string_buffer:string) {
// 	js_set_print_string_buffer(string_buffer.count, string_buffer.data, size_of(u8));
// }
// js_print :: (message:string) {
// 	memcpy(PRINT_STRING_BUFFER.data, message.data, min(message.count, MAX_PRINT_SIZE) * size_of(u8));
// 	// print("copied:%,%,%\n", message.count * size_of(u8),PRINT_STRING_BUFFER.count, cast(u8) PRINT_STRING_BUFFER.data[0]);
// 	js_read_print_buffer(message.count);
// }


wasm_debug_break :: ()  #foreign;
wasm_write_string :: (count: s64, data: *u8, is_error: bool)  #foreign;
// js_set_print_string_buffer :: (count: s64, data: *u8, element_size:u8) #foreign;
// js_read_print_buffer :: (count: s64) #foreign;

wgpu_context:WGPUContext;
SCENE_DATA:SceneData;
DRAW_DATA:DrawData;

on_wgpu_device_ready :: (
	canvas: WGPUSurface,
	device: WGPUDevice,
	queue: WGPUQueue,
	preferred_texture_format: WGPUTextureFormat
) {
	#if WASM==true context = call_from_wasm_context;
	// print("on_wgpu_device_ready START\n");
	// defer print("on_wgpu_device_ready DONE\n");

	#if WASM==true
		wgpu_context.device = device;
		wgpu_context.queue = queue;
		wgpu_context.surface = canvas;
		wgpu_context.preferred_texture_format = preferred_texture_format;
	#if WASM==false
		wgpu_context, surface_capabilities := wgpu_context_create(window, WINDOW_WIDTH, WINDOW_HEIGHT);

	init_scene_data(*SCENE_DATA, 1.);
	// on_request_animation_frame(0, 500, 500);
}

init_draw_data :: (){
	device := wgpu_context.device;
	queue := wgpu_context.queue;
	DRAW_DATA.shader_module = wgpu_create_shader_module(device, SHADER_RENDER, "render");
	DRAW_DATA.vertex_buffer_layout, DRAW_DATA.vertex_attributes = wgpu_make_vertex_layout(Vertex);

	// defer array_reset(*vertex_attributes);
	DRAW_DATA.pipeline_descriptor = .{label = "Render Pipeline"};

	wgpu_fragment_state_prepare(*(DRAW_DATA.fragment_state), *(DRAW_DATA.color_target_state), DRAW_DATA.shader_module, wgpu_context.preferred_texture_format);
	wgpu_update_pipeline_descriptor( *(DRAW_DATA.pipeline_descriptor), device, DRAW_DATA.shader_module, *(DRAW_DATA.vertex_buffer_layout), *(DRAW_DATA.fragment_state) );
	wgpu_update_pipeline_descriptor_multisample(*wgpu_context, *(DRAW_DATA.pipeline_descriptor));
	depth_stencil_state: WGPUDepthStencilState;
	wgpu_update_pipeline_descriptor_depth(*wgpu_context, *(DRAW_DATA.pipeline_descriptor), *depth_stencil_state);
	
	DRAW_DATA.pipeline = wgpuDeviceCreateRenderPipeline(wgpu_context.device, *(DRAW_DATA.pipeline_descriptor));
	assert(DRAW_DATA.pipeline != null, "Pipeline is not created correctly");

	#if USE_COMPUTE_SHADER {
		// compute_shader_controller := compute_shader_controller_create(*wgpu_context, queue, SHADERS.compute);
	} else {
		DRAW_DATA.vertex.buffer, DRAW_DATA.vertex.buffer_size = wgpu_vertex_array_to_buffer(wgpu_context.device, queue, SCENE_DATA.vertices);
	}
	DRAW_DATA.index.buffer, DRAW_DATA.index.buffer_size = wgpu_index_array_to_buffer(wgpu_context.device, queue, SCENE_DATA.indices);
	DRAW_DATA.uniforms.object.buffer,
	DRAW_DATA.uniforms.object.bind_group,
	DRAW_DATA.uniforms.object.bind_group_entries = wgpu_object_uniform_to_buffer(wgpu_context.device, queue, DRAW_DATA.pipeline, SCENE_DATA.object_uniforms);
	DRAW_DATA.uniforms.camera.buffer,
	DRAW_DATA.uniforms.camera.bind_group,
	DRAW_DATA.uniforms.camera.bind_group_entries = wgpu_camera_uniform_to_buffer(wgpu_context.device, queue, DRAW_DATA.pipeline, SCENE_DATA.camera_uniforms);
	DRAW_DATA.uniforms.sdf.buffer,
	DRAW_DATA.uniforms.sdf.bind_group,
	DRAW_DATA.uniforms.sdf.bind_group_entries = wgpu_sdf_uniform_to_buffer(wgpu_context.device, queue, DRAW_DATA.pipeline, SCENE_DATA.sdf_uniforms);
}

on_request_animation_frame :: (
	new_time: u64,
	width: u64,
	height: u64
) {
	#if WASM==true context = call_from_wasm_context;
	device := wgpu_context.device;
	queue := wgpu_context.queue;

	new_aspect:float = (cast(float32) width) / (cast(float32) height);

	if(new_aspect != SCENE_DATA.camera_aspect){
		SCENE_DATA.camera_aspect = new_aspect;
		update_camera_data_projection(*SCENE_DATA);
	}
	time:float = new_time / 1000.0;
	update_scene_data(*SCENE_DATA, time);
	update_scene_data_uniforms(*SCENE_DATA);

	update_object_uniforms_to_buffer(DRAW_DATA.uniforms.object.buffer, queue, *SCENE_DATA);
	update_camera_uniforms_to_buffer(DRAW_DATA.uniforms.camera.buffer, queue, *SCENE_DATA);
	update_sdf_uniforms_to_buffer(DRAW_DATA.uniforms.sdf.buffer, queue, *SCENE_DATA);

	// a := 1+20;
	// js_print("on_wgpu_device_ready START\n");
	// js_print(tprint("result:%\n", a));
	// js_print(tprint("result:%\n", a+1));
	// js_print(tprint("result:%\n", a+2));
	// js_print("on_wgpu_device_ready 2\n");

	// builder: String_Builder;
    // print_to_builder(*builder, "a:%\n", a);
    // result := builder_to_string(*builder);
	// print(result);

	// print_type_info(WGPUCommandBuffer);
	// print_type_info(WGPURenderPassColorAttachment);
	// print_type_info(WGPUColorTargetState);
	// print_type_info(WGPUBlendState);
	// print_type_info(WGPUBlendComponent);
	// print_type_info(WGPUBlendOperation); // enum/u32
	// print_type_info(WGPUBlendFactor); // enum/u32




	// DRAW_DATA.shader_module = wgpu_create_shader_module(device, SHADER_RENDER, "render");
	// print(">>> B: %, % <<< \n", vertex_buffer_layout.attributes[0].format, vertex_buffer_layout.attributes[1].format);
	// #if FREE_MEMORY defer array_reset(*vertex_attributes);

	


	colorAttachment := WGPURenderPassColorAttachment.{
		loadOp = WGPULoadOp.Clear,
		storeOp = WGPUStoreOp.Store,
		clearValue = wgpu_context.bg_color,
	};
	render_pass_encoder1: WGPURenderPassEncoder;
	cmd_buffer1: WGPUCommandBuffer;
	cmd_encoder1 := wgpuDeviceCreateCommandEncoder(
		wgpu_context.device,
		*(WGPUCommandEncoderDescriptor.{label = "Command Encoder Render"}),
	);

	{
		render_pass_descriptor := WGPURenderPassDescriptor.{
			label = "Render Pass 3D",
			colorAttachmentCount = 1,
			colorAttachments = *colorAttachment,
		};
		// update_render_pass_descriptor_depth(*wgpu_context, *render_pass_descriptor);
		render_pass_encoder1 = wgpuCommandEncoderBeginRenderPass(cmd_encoder1, *render_pass_descriptor);

		wgpuRenderPassEncoderSetPipeline(render_pass_encoder1, DRAW_DATA.pipeline);
		wgpuRenderPassEncoderSetBindGroup(render_pass_encoder1, 0, DRAW_DATA.uniforms.object.bind_group, 0, null);
		wgpuRenderPassEncoderSetBindGroup(render_pass_encoder1, 1, DRAW_DATA.uniforms.camera.bind_group, 0, null);
		wgpuRenderPassEncoderSetBindGroup(render_pass_encoder1, 2, DRAW_DATA.uniforms.sdf.bind_group, 0, null);
		//
		#if USE_COMPUTE_SHADER {
			// wgpuRenderPassEncoderSetVertexBuffer(render_pass_encoder1, 0, compute_shader_controller.vertex_buffer, 0, compute_shader_controller.vertex_buffer_size);
		} else {
			wgpuRenderPassEncoderSetVertexBuffer(render_pass_encoder1, 0, DRAW_DATA.vertex.buffer, 0, DRAW_DATA.vertex.buffer_size);
		}
		wgpuRenderPassEncoderSetIndexBuffer(render_pass_encoder1, DRAW_DATA.index.buffer, WGPUIndexFormat.Uint32, 0, DRAW_DATA.index.buffer_size);

		wgpuRenderPassEncoderDrawIndexed(render_pass_encoder1, xx SCENE_DATA.indices.count, 1, 0, 0, 0);
		// #if USE_IMGUI gui_update(window, *wgpu_context, render_pass_encoder1, *bd, *iwc, *ui_data, *SCENE_DATA);
		wgpuRenderPassEncoderEnd(render_pass_encoder1);


		cmd_buffer1 = wgpuCommandEncoderFinish(cmd_encoder1, *(WGPUCommandBufferDescriptor.{label = "Cmd Buffer 3D"}));

		wgpuQueueSubmit(queue, 1, *cmd_buffer1);
	}

	#if WASM == false wgpuSurfacePresent(wgpu_context.surface);
}