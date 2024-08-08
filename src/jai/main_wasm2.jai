WASM :: true;
USE_COMPUTE_SHADER :: false;
#import "Basic";
#import "Math";
#if WASM == true #import "wgpu_wasm";
#if WASM == false #import "wgpu";

#load "common/math_helper.jai";;
#load "common/scene_data.jai";
#load "common/type_utils.jai";;
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
call_from_wasm_context :Context;


main :: () {
	call_from_wasm_context = context;
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

on_wgpu_device_ready :: (
	canvas: WGPUSurface,
	device: WGPUDevice,
	queue: WGPUQueue,
	preferred_texture_format: WGPUTextureFormat
) {
	context = call_from_wasm_context;
	print("on_wgpu_device_ready START\n");
	defer print("on_wgpu_device_ready DONE\n");

	SCENE_DATA :SceneData= create_scene_data(1.);
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

	#if WASM==true
		wgpu_context:WGPUContext = .{
			surface = canvas,
			device = device,
			preferred_texture_format = preferred_texture_format
		};
	#if WASM==false
		wgpu_context, surface_capabilities := wgpu_context_create(window, WINDOW_WIDTH, WINDOW_HEIGHT);

	shader_module := wgpu_create_shader_module(device, SHADER_RENDER, "render");
	vertex_buffer_layout, vertex_attributes := wgpu_make_vertex_layout(Vertex);
	defer array_reset(*vertex_attributes);
	// print(">>> B: %, % <<< \n", vertex_buffer_layout.attributes[0].format, vertex_buffer_layout.attributes[1].format);
	// #if FREE_MEMORY defer array_reset(*vertex_attributes);

	pipeline_descriptor: WGPURenderPipelineDescriptor = .{label = "Render Pipeline"};
	fragment_state: WGPUFragmentState;
	color_target_state: WGPUColorTargetState;
	wgpu_fragment_state_prepare(*fragment_state, *color_target_state, shader_module, preferred_texture_format);
	wgpu_update_pipeline_descriptor( *pipeline_descriptor, device, shader_module, *vertex_buffer_layout, *fragment_state );
	wgpu_update_pipeline_descriptor_multisample(*wgpu_context, *pipeline_descriptor);
	depth_stencil_state: WGPUDepthStencilState;
	wgpu_update_pipeline_descriptor_depth(*wgpu_context, *pipeline_descriptor, *depth_stencil_state);
	
	pipeline := wgpuDeviceCreateRenderPipeline(wgpu_context.device, *pipeline_descriptor);
	assert(pipeline != null, "Pipeline is not created correctly");

	#if USE_COMPUTE_SHADER {
		// compute_shader_controller := compute_shader_controller_create(*wgpu_context, queue, SHADERS.compute);
	} else {
		vertex_buffer, vertex_buffer_size := wgpu_vertex_array_to_buffer(wgpu_context.device, queue, SCENE_DATA.vertices);
	}
	index_buffer, index_buffer_size := wgpu_index_array_to_buffer(wgpu_context.device, queue, SCENE_DATA.indices);
	object_uniform_buffer, object_bind_group, object_uniform_entries := wgpu_object_uniform_to_buffer(wgpu_context.device, queue, pipeline, SCENE_DATA.object_uniforms);
	camera_uniform_buffer, camera_bind_group, camera_uniform_entries := wgpu_camera_uniform_to_buffer(wgpu_context.device, queue, pipeline, SCENE_DATA.camera_uniforms);
	sdf_uniform_buffer, sdf_bind_group, sdf_uniform_entries := wgpu_sdf_uniform_to_buffer(wgpu_context.device, queue, pipeline, SCENE_DATA.sdf_uniforms);


	print("render function start\n");

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

		
		wgpuRenderPassEncoderSetPipeline(render_pass_encoder1, pipeline);
		
		wgpuRenderPassEncoderSetBindGroup(render_pass_encoder1, 0, object_bind_group, 0, null);
		wgpuRenderPassEncoderSetBindGroup(render_pass_encoder1, 1, camera_bind_group, 0, null);
		wgpuRenderPassEncoderSetBindGroup(render_pass_encoder1, 2, sdf_bind_group, 0, null);
		//
		#if USE_COMPUTE_SHADER {
			// wgpuRenderPassEncoderSetVertexBuffer(render_pass_encoder1, 0, compute_shader_controller.vertex_buffer, 0, compute_shader_controller.vertex_buffer_size);
		} else {
			wgpuRenderPassEncoderSetVertexBuffer(render_pass_encoder1, 0, vertex_buffer, 0, vertex_buffer_size);
		}
		wgpuRenderPassEncoderSetIndexBuffer(render_pass_encoder1, index_buffer, WGPUIndexFormat.Uint32, 0, index_buffer_size);

		wgpuRenderPassEncoderDrawIndexed(render_pass_encoder1, xx SCENE_DATA.indices.count, 1, 0, 0, 0);
		// #if USE_IMGUI gui_update(window, *wgpu_context, render_pass_encoder1, *bd, *iwc, *ui_data, *SCENE_DATA);
		wgpuRenderPassEncoderEnd(render_pass_encoder1);


		cmd_buffer1 = wgpuCommandEncoderFinish(cmd_encoder1, *(WGPUCommandBufferDescriptor.{label = "Cmd Buffer 3D"}));

		wgpuQueueSubmit(queue, 1, *cmd_buffer1);
	}

	#if WASM == false wgpuSurfacePresent(wgpu_context.surface);
}