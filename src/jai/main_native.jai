FREE_MEMORY :: true;
DEBUG_MEMORY_LEAKS :: false;
WINDOW_WIDTH  :u32: 1280;
WINDOW_HEIGHT :u32: 720;
INIT_RATIO :float = (cast(float) WINDOW_WIDTH) / (cast(float) WINDOW_HEIGHT);
USE_IMGUI :: true;
USE_COMPUTE_SHADER :: true;

#if OS == .LINUX  {
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

#import "Basic"()(MEMORY_DEBUGGER=true);
#import "Math";
#import "String";
#import "wgpu";
#import "SDL";
#import "imgui"; // not "ImGui"
// #import "imgui_impl_wgpu";
#load "common/wgpu_mock.jai";
#load "common/wgpu/native.jai";

#load "common/math_helper.jai";
#load "common/orbit_controls.jai";
#load "common/scene_data.jai";
#load "native/helpers_imgui_impl_sdl.jai";
#load "native/helpers_sdl.jai";
#load "native/helpers_webgpu.jai";
#load "native/imgui_impl_wgpu/index.jai";
#load "native/helpers_ui.jai";
#load "native/print_utils.jai";
#load "native/uniforms_helpers.jai";
#load "native/shaders.jai";
#load "native/orbit_controls.jai";
#load "native/wgpu_compute.jai";
#load "native/wgpu_depth.jai";
// #load "native/wgpu_multisample.jai";
#load "common/wgpu/common_multisample.jai";




wgpu_log_callback :: (level: WGPULogLevel, msg: *u8, userdata: *void) #c_call {
	new_context: Context;
	push_context new_context {
		print("\n");
		print_red("ERROR WGPU START\n");
	}
	print_c("[WGPU :: %]: %\n", level, to_string(msg));
	push_context new_context {
		print_red("ERROR WGPU END\n");
		print("\n");
	}
}


main :: () {
	SHADERS :: #run create_shaders();
	SCENE_DATA :SceneData;
	init_scene_data(*SCENE_DATA, INIT_RATIO);
	orbit_controls :OrbitControls;

	SDL_Init(SDL_INIT_VIDEO);

	window := SDL_CreateWindow("Polygon Compute",
		SDL_WINDOWPOS_UNDEFINED,
		SDL_WINDOWPOS_UNDEFINED,
		xx WINDOW_WIDTH,
		xx WINDOW_HEIGHT,
		SDL_WINDOW_ALLOW_HIGHDPI|SDL_WINDOW_RESIZABLE
	);
	assert(window != null, "Could not create window: %\n", to_string(SDL_GetError()));

	imgui_context := ImGui.CreateContext();
	sdl_init_success := ImGui_ImplSdl_Init(window);
	assert(sdl_init_success, "ImGui_ImplSdl_Init returns false");
	ImGui.StyleColorsDark();
	// io := ImGui.GetIO();
	// imgui_context, io := gui_init(window);
	// imgui_context := ImGui.CreateContext();
	// // Setup ImGui binding
	ImGui_ImplSdl_Init(window);
	// // Setup style
	// // ImGuiStyleColorsClassic();
	// ImGui.StyleColorsDark();
	// //ImGui.StyleColorsLight();
	// io := ImGui.GetIO();
	// io.ConfigFlags |= ImGuiConfigFlags_NavEnableKeyboard;  // Enable Keyboard Controls
	// io.ConfigFlags |= ImGuiConfigFlags_NavEnableGamepad; // Enable Gamepad Controls
	ui_data :UiData= .{};
	// show_demo_window := true;
	// show_another_window := true;


	wgpuSetLogCallback(wgpu_log_callback, null);
	wgpuSetLogLevel(.Error); //(.Warn);

	wgpu_context, surface_capabilities := wgpu_context_create(window, WINDOW_WIDTH, WINDOW_HEIGHT);

	queue := wgpuDeviceGetQueue(wgpu_context.device);
	assert(queue != null, "Queue is not created correctly");


	shader_module := wgpu_create_shader_module(wgpu_context.device, SHADERS.render, "Main Shader");
	assert(shader_module != null, "shader_module is not created correctly");
	print("shader_module:%\n", shader_module);

	pipeline_descriptor: WGPURenderPipelineDescriptor;
	fragment_state: WGPUFragmentState;
	color_target_state: WGPUColorTargetState;
	wasm_vertex_layout_layout, vertex_attributes := wasm_make_vertex_layout(Vertex);
	vertex_buffer_layout, attributes := Wasm_VertexBufferLayout_to_wgpu(wasm_vertex_layout_layout);
	#if FREE_MEMORY defer array_reset(*vertex_attributes);
	#if FREE_MEMORY defer array_reset(*attributes);
	fragment_state_prepare(*fragment_state, *color_target_state, shader_module, wgpu_context.preferred_texture_format);
	update_pipeline_descriptor( *pipeline_descriptor, wgpu_context.device, shader_module, *vertex_buffer_layout, *fragment_state );
	wgpu_update_pipeline_descriptor_multisample(*wgpu_context, *pipeline_descriptor);
	depth_stencil_state: WGPUDepthStencilState;
	update_pipeline_descriptor_depth(*wgpu_context, *pipeline_descriptor, *depth_stencil_state);
	// pipeline_descriptor_print(*pipeline_descriptor);
	pipeline := wgpuDeviceCreateRenderPipeline(wgpu_context.device, *pipeline_descriptor);
	assert(pipeline != null, "Pipeline is not created correctly");

	#if USE_COMPUTE_SHADER {
		compute_shader_controller := compute_shader_controller_create(*wgpu_context, queue, SHADERS.compute);
	} else {
		vertex_buffer, vertex_buffer_size := vertex_array_to_buffer(wgpu_context.device, queue, SCENE_DATA.vertices);
	}
	index_buffer, index_buffer_size := index_array_to_buffer(wgpu_context.device, queue, SCENE_DATA.indices);
	object_uniform_buffer, object_bind_group, object_uniform_entries := object_uniform_to_buffer(wgpu_context.device, queue, pipeline, SCENE_DATA.object_uniforms);
	camera_uniform_buffer, camera_bind_group, camera_uniform_entries := camera_uniform_to_buffer(wgpu_context.device, queue, pipeline, SCENE_DATA.camera_uniforms);
	sdf_uniform_buffer, sdf_bind_group, sdf_uniform_entries := sdf_uniform_to_buffer(wgpu_context.device, queue, pipeline, SCENE_DATA.sdf_uniforms);
	#if FREE_MEMORY defer array_reset(*object_uniform_entries);
	#if FREE_MEMORY defer array_reset(*camera_uniform_entries);
	#if FREE_MEMORY defer array_reset(*sdf_uniform_entries);

	imgui_init_info := ImGui_ImplWGPU_InitInfo.{
		Device = wgpu_context.device,
		NumFramesInFlight = 3,
		RenderTargetFormat = wgpu_context.preferred_texture_format,
		DepthStencilFormat = ifx wgpu_context.use_depth_buffer then DEPTH_TEXTURE_FORMAT else WGPUTextureFormat.Undefined,
	};
	// sdl_init := ImGui_ImplWGPU_InitInfo_init(*sdl_init_info);
	bd:ImGui_ImplWGPU_Data = .{};
	iwc:ImGui_WGPU_Common = .{};
	ImGui_ImplWGPU_Init(*bd, imgui_init_info);
	// wgpuQueueSubmit(queue, 0, null);

	do_exit := false;
	frames_count :u64= 0;
	while !do_exit {
		event: SDL_Event;
		while SDL_PollEvent(*event) {
			ImGui_ImplSdl_ProcessEvent(*event);
			io := ImGui.GetIO();

			if event.type == {
				case SDL_QUIT; {do_exit = true;}
				case SDL_WINDOWEVENT; {
					if (event.window.event == SDL_WINDOWEVENT_RESIZED) {
						new_width := event.window.data1;
						new_height := event.window.data2;
						if(new_width > 0 && new_height > 0){
							webgpu_handle_resize(*wgpu_context, xx event.window.data1, xx event.window.data2);
							SCENE_DATA.camera_aspect = (cast(float32) event.window.data1) / (cast(float32) event.window.data2);
							update_camera_data_projection(*SCENE_DATA);

						}
					}
				}
				case SDL_KEYDOWN; {
					if(io.WantCaptureKeyboard==false){
						if event.key.keysym.sym == SDLK_ESCAPE {
							do_exit = true;
						}
					}
				}
			}

			if(io.WantCaptureMouse==false){
				orbit_controls_process_event(*orbit_controls, *event);
			}

		}
		time := SDL_GetTicks() / 1000.0;
		frame := surface_create_current_view( *wgpu_context );
		defer wgpuTextureViewRelease(frame);
		create_multi_sample_texture_if_needed( *wgpu_context );
		create_depth_texture_if_needed( *wgpu_context );
		//
		orbit_controls_update_camera(*orbit_controls, *SCENE_DATA.camera_data[0]);
		update_scene_data(*SCENE_DATA, time);
		update_scene_data_uniforms(*SCENE_DATA);
		// update_vertex_array_to_buffer(vertex_buffer, queue, *SCENE_DATA);
		

		#if USE_COMPUTE_SHADER {
			compute_shader_controller.update_box_size(compute_shader_controller, SCENE_DATA.box_size);
			compute_shader_controller.compute(compute_shader_controller);
		}
		

		colorAttachment := WGPURenderPassColorAttachment.{
			loadOp = WGPULoadOp.Clear,
			storeOp = WGPUStoreOp.Store,
			clearValue = wgpu_context.bg_color,
		};

		update_render_pass_descriptor_multisample(*wgpu_context, *colorAttachment, *frame);

		{
			render_pass_encoder1: WGPURenderPassEncoder;
			cmd_buffer1: WGPUCommandBuffer;
			cmd_encoder1 := wgpuDeviceCreateCommandEncoder(
				wgpu_context.device,
				*(WGPUCommandEncoderDescriptor.{label = "Command Encoder Render"}),
			);
			defer wgpuRenderPassEncoderRelease(render_pass_encoder1);
			defer wgpuCommandBufferRelease(cmd_buffer1);
			defer wgpuCommandEncoderRelease(cmd_encoder1);
			{	
				render_pass_descriptor := WGPURenderPassDescriptor.{
					label = "Render Pass 3D",
					colorAttachmentCount = 1,
					colorAttachments = *colorAttachment,
				};
				update_render_pass_descriptor_depth(*wgpu_context, *render_pass_descriptor);
				render_pass_encoder1 = wgpuCommandEncoderBeginRenderPass(cmd_encoder1, *render_pass_descriptor);

				//
				wgpuRenderPassEncoderSetPipeline(render_pass_encoder1, pipeline);
				//
				wgpuRenderPassEncoderSetBindGroup(render_pass_encoder1, 0, object_bind_group, 0, null);
				wgpuRenderPassEncoderSetBindGroup(render_pass_encoder1, 1, camera_bind_group, 0, null);
				wgpuRenderPassEncoderSetBindGroup(render_pass_encoder1, 2, sdf_bind_group, 0, null);
				//
				#if USE_COMPUTE_SHADER {
					wgpuRenderPassEncoderSetVertexBuffer(render_pass_encoder1, 0, compute_shader_controller.vertex_buffer, 0, compute_shader_controller.vertex_buffer_size);
				} else {
					wgpuRenderPassEncoderSetVertexBuffer(render_pass_encoder1, 0, vertex_buffer, 0, vertex_buffer_size);
				}
				wgpuRenderPassEncoderSetIndexBuffer(render_pass_encoder1, index_buffer, WGPUIndexFormat.Uint32, 0, index_buffer_size);

				wgpuRenderPassEncoderDrawIndexed(render_pass_encoder1, xx SCENE_DATA.indices.count, 1, 0, 0, 0);
				#if USE_IMGUI gui_update(window, *wgpu_context, render_pass_encoder1, *bd, *iwc, *ui_data, *SCENE_DATA);
				wgpuRenderPassEncoderEnd(render_pass_encoder1);


				cmd_buffer1 = wgpuCommandEncoderFinish(cmd_encoder1, *(WGPUCommandBufferDescriptor.{label = "Cmd Buffer 3D"}));

				wgpuQueueSubmit(queue, 1, *cmd_buffer1);
			}
		}



		// {
		// 	render_pass_encoder2: WGPURenderPassEncoder;
		// 	cmd_buffer2: WGPUCommandBuffer;
		// 	cmd_encoder2 := wgpuDeviceCreateCommandEncoder(
		// 		wgpu_context.device,
		// 		*(WGPUCommandEncoderDescriptor.{label = "Command Encoder UI"}),
		// 	);
		// 	defer wgpuRenderPassEncoderRelease(render_pass_encoder2);
		// 	defer wgpuCommandBufferRelease(cmd_buffer2);
		// 	defer wgpuCommandEncoderRelease(cmd_encoder2);
		// 	{
		// 		render_pass_descriptor := WGPURenderPassDescriptor.{
		// 			label = "Render Pass UI",
		// 			colorAttachmentCount = 1,
		// 			colorAttachments = *colorAttachment,
		// 			depthStencilAttachment = null,
		// 		};
		// 		update_render_pass_descriptor_depth(*wgpu_context, *render_pass_descriptor);
		// 		render_pass_encoder2 = wgpuCommandEncoderBeginRenderPass(cmd_encoder2, *render_pass_descriptor);

		// 		gui_update(window, *wgpu_context, render_pass_encoder2, *bd, *imgui_wgpu_common, *ui_data);
		// 		wgpuRenderPassEncoderEnd(render_pass_encoder2);
		// 		cmd_buffer2 = wgpuCommandEncoderFinish(cmd_encoder2, *(WGPUCommandBufferDescriptor.{label = "Cmd Buffer UI"}));

		// 		wgpuQueueSubmit(queue, 1, *cmd_buffer2);
		// 	}
		// }



		wgpuSurfacePresent(wgpu_context.surface);
		wgpuTextureRelease(wgpu_context.surface_texture.texture);
		multisample_release(*wgpu_context);
		depth_release(*wgpu_context);
		#if USE_IMGUI imgui_gui_free(*iwc);
		
		// if frames_count>1 { do_exit = true; }
		// print_green(tprint("frames_count:%\n", frames_count));
		frames_count += 1;
	}

	// Close and destroy the window
	// see https://github.com/gfx-rs/wgpu-native/blob/trunk/examples/triangle/main.c
	wgpuRenderPipelineRelease(pipeline);
	wgpuPipelineLayoutRelease(pipeline_descriptor.layout);
	wgpuShaderModuleRelease(shader_module);
	wgpuSurfaceCapabilitiesFreeMembers(surface_capabilities);
	wgpuQueueRelease(queue);
	wgpuDeviceRelease(wgpu_context.device);
	wgpuAdapterRelease(wgpu_context.adapter);
	wgpuSurfaceRelease(wgpu_context.surface);
	ImGui_ImplWGPU_Shutdown();
	ImGui_ImplSdl_Shutdown();
	ImGui.DestroyContext();
	SDL_DestroyWindow(window);
	wgpuInstanceRelease(wgpu_context.instance);

	#if DEBUG_MEMORY_LEAKS defer report_memory_leaks();

	// Clean up
	SDL_Quit();
	print_green(tprint("polygon closed gracefully at frame: %.\n", frames_count));
}

