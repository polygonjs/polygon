
USE_IMGUI :: true;
USE_IMGUI_DEBUG :: false;
USE_COMPUTE_SHADER :: true;
FREE_MEMORY :: true; // beware wasm memory corruption when in use
FREE_MEMORY_DEBUG :: false;
RENDER_IN_VIEWPORT :: false;
RENDER_SCENE :: true;

#placeholder WASM;
#placeholder SHADER_RENDER;
#placeholder SHADER_COMPUTE;

#if WASM==false {
	WINDOW_WIDTH  :u32: 1280;
	WINDOW_HEIGHT :u32: 720;
	INIT_RATIO :float = (cast(float) WINDOW_WIDTH) / (cast(float) WINDOW_HEIGHT);
	window:*SDL_Window;
}

wgpu_context:WGPUContext;
#if USE_IMGUI window_context:WindowContext;
SCENE_DATA:SceneData;
DRAW_DATA:DrawData;
orbit_controls:OrbitControls;
events_data:EventsData;
#if USE_IMGUI {
	ui_data:UiData= .{};
	bd:ImGui_ImplWGPU_Data = .{};
	iwc:ImGui_WGPU_Common = .{};
}
#if USE_COMPUTE_SHADER compute_shader_controller:ComputeShaderController;


do_exit := false;
FRAMES_COUNT:u64 = 0;
#if WASM==true {
	call_from_wasm_context :Context;
	wasm_debug_break :: ()  #foreign;
	wasm_write_string :: (count: s64, data: *u8, is_error: bool)  #foreign;
}

#if WASM==false {
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
}


//
//
//
//
//
main :: () {
	#if WASM==true call_from_wasm_context = context;

	node_name_size := 128;
	SCENE_DATA.node_name.data  = alloc(node_name_size);
	SCENE_DATA.node_name.count = node_name_size;
	test_string := "Hello World!";
	memcpy(SCENE_DATA.node_name.data, test_string.data, test_string.count);

	#if WASM==false {
		SDL_Init(SDL_INIT_VIDEO);

		window = SDL_CreateWindow("Polygon Compute",
			SDL_WINDOWPOS_UNDEFINED,
			SDL_WINDOWPOS_UNDEFINED,
			xx WINDOW_WIDTH,
			xx WINDOW_HEIGHT,
			SDL_WINDOW_ALLOW_HIGHDPI|SDL_WINDOW_RESIZABLE
		);
		assert(window != null, "Could not create window: %\n", to_string(SDL_GetError()));
		#if USE_IMGUI {
			window_context.window = window;

			imgui_context := ImGui.CreateContext();
			sdl_init_success := ImGui_ImplSdl_Init(window);
			assert(sdl_init_success, "ImGui_ImplSdl_Init returns false");
			// imgui_style := ImGui.GetStyle(); // ImGuiStyle
			// imgui_style.AntiAliasedLinesUseTex = false;
			// ImGui.StyleColorsLight(/*imgui_style*/);
		}

		wgpuSetLogCallback(wgpu_log_callback, null);
		wgpuSetLogLevel(.Error); //(.Warn);
		surface_capabilities := wgpu_context_init(window, *wgpu_context, WINDOW_WIDTH, WINDOW_HEIGHT);

		on_wgpu_device_ready(wgpu_context.surface, wgpu_context.device, wgpu_context.queue, wgpu_context.preferred_texture_format);
		init_draw_data();
		#if USE_IMGUI io := ImGui.GetIO();

		while !do_exit {
			sdl_event: SDL_Event;
			events_data_reset(*events_data);
			
			while SDL_PollEvent(*sdl_event) {
				events_data_update(*events_data, *sdl_event);
				#if USE_IMGUI {
					ImGui_ImplSdl_ProcessEvent(*sdl_event);
					if(io.WantCaptureMouse == false){
						orbit_controls_process_event(*orbit_controls, *events_data);
					}
				} else {
					orbit_controls_process_event(*orbit_controls, *events_data);
				}

				if sdl_event.type == {
					case SDL_QUIT; {do_exit = true;}
					case SDL_WINDOWEVENT; {
						if (sdl_event.window.event == SDL_WINDOWEVENT_RESIZED) {
							new_width := sdl_event.window.data1;
							new_height := sdl_event.window.data2;
							if(new_width > 0 && new_height > 0){
								webgpu_handle_resize(*wgpu_context, xx sdl_event.window.data1, xx sdl_event.window.data2);
								SCENE_DATA.camera_aspect = (cast(float32) sdl_event.window.data1) / (cast(float32) sdl_event.window.data2);
								update_camera_data_projection(*SCENE_DATA);

							}
						}
					}
					case SDL_KEYDOWN; {
						#if USE_IMGUI {
							if(io.WantCaptureKeyboard == false){
								if sdl_event.key.keysym.sym == SDLK_ESCAPE {
									do_exit = true;
								}
							}
						} else {
							if sdl_event.key.keysym.sym == SDLK_ESCAPE {
								do_exit = true;
							}
						}
					}
				}
			}
			time := SDL_GetTicks();

			#if USE_IMGUI {
				if(io.WantCaptureMouse == false){
					orbit_controls_process_event(*orbit_controls, *events_data);
				}
			} else {
				orbit_controls_process_event(*orbit_controls, *events_data);
			}

			// do_exit = true;
			on_request_animation_frame(time, WINDOW_WIDTH, WINDOW_HEIGHT);

		}
		reset_temporary_storage();
		#if WASM==false && FREE_MEMORY_DEBUG==true defer report_memory_leaks();
		SDL_Quit();
		print_green("polygon quit\n");
	}

}





on_wgpu_device_ready :: (
	canvas: WGPUSurface,
	device: WGPUDevice,
	queue: WGPUQueue,
	preferred_texture_format: WGPUTextureFormat
) {
	if USE_IMGUI_DEBUG return;

	#if WASM==true {
		context = call_from_wasm_context;
		wgpu_context.device = device;
		wgpu_context.queue = queue;
		wgpu_context.surface = canvas;
		wgpu_context.preferred_texture_format = preferred_texture_format;
	}

	init_scene_data(*SCENE_DATA, 1.);
}

//
//
//
//
//
init_draw_data :: (){
	#if WASM==true context = call_from_wasm_context;
	device := wgpu_context.device;
	#if WASM==true {
		queue := wgpu_context.queue;
	}
	#if WASM==false {
		queue := wgpuDeviceGetQueue(wgpu_context.device);
		assert(queue != null, "Queue is not created correctly");
	}
	DRAW_DATA.shader_module = wgpu_create_shader_module(device, SHADER_RENDER, "render");
	DRAW_DATA.vertex_buffer_layout, DRAW_DATA.vertex_attributes = wgpu_make_vertex_layout(Vertex);

	// defer array_reset(*vertex_attributes);
	DRAW_DATA.pipeline_descriptor = .{label = "Render Pipeline"};

	wgpu_fragment_state_prepare(*(DRAW_DATA.fragment_state), *(DRAW_DATA.color_target_state), DRAW_DATA.shader_module, wgpu_context.preferred_texture_format);
	wgpu_update_pipeline_descriptor( *(DRAW_DATA.pipeline_descriptor), device, DRAW_DATA.shader_module, *(DRAW_DATA.vertex_buffer_layout), *(DRAW_DATA.fragment_state) );
	wgpu_update_pipeline_descriptor_multisample(*wgpu_context, *(DRAW_DATA.pipeline_descriptor));
	depth_stencil_state: WGPUDepthStencilState;
	wgpu_update_pipeline_descriptor_depth(*wgpu_context, *(DRAW_DATA.pipeline_descriptor), *depth_stencil_state);

	#if WASM {
		if(depth_stencil_state.depthBias != 0){
			// we force the depthBias which is sometimes with an offset of -1 when out of wgpu_update_pipeline_descriptor_depth.
			// no idea why, could it be because of wasm64 still experimental?
			// but since depthBias is the only s32 in the wgpu definition, we assume it only happens for this member,
			// and we therefore do this hack here.
			print("*** depthBias force to 0 (currently at %)\n", depth_stencil_state.depthBias);
			depth_stencil_state.depthBias = 0;
		}
		assert(depth_stencil_state.depthBias == 0, "bias not correct: %\n", depth_stencil_state.depthBias);
	}
	DRAW_DATA.pipeline = wgpuDeviceCreateRenderPipeline(wgpu_context.device, *(DRAW_DATA.pipeline_descriptor));
	assert(DRAW_DATA.pipeline != null, "Pipeline is not created correctly");

	#if USE_COMPUTE_SHADER {
		compute_shader_controller = compute_shader_controller_create(*wgpu_context, queue, SHADER_COMPUTE, xx (SCENE_DATA.vertices.count * size_of(Vertex)));
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

	#if USE_IMGUI {
		ImGui.CreateContext(null);

		#if WASM {
			io := ImGui.GetIO();
			io.IniFilename = null;
			ImGui_ImplWasm_Init();
		}

		// imgui_style := ImGui.GetStyle();
		// imgui_style.AntiAliasedLinesUseTex = false;
		// ImGui.StyleColorsLight();

		bd.wgpuDevice = wgpu_context.device;
		imgui_init_info := ImGui_ImplWGPU_InitInfo.{
			// Device = wgpu_context.device,
			NumFramesInFlight = 3,
			RenderTargetFormat = wgpu_context.preferred_texture_format,
			DepthStencilFormat = ifx wgpu_context.use_depth_buffer then DEPTH_TEXTURE_FORMAT else WGPUTextureFormat.Undefined,
		};
		
		ImGui_ImplWGPU_Init(*bd, imgui_init_info);
	}
}


//
//
//
//
//
on_request_animation_frame :: (
	new_time: u64,
	width: u64,
	height: u64
) {
	if USE_IMGUI_DEBUG return;
	#if WASM {
		context = call_from_wasm_context;
		queue := wgpu_context.queue;
		events_data_update(*events_data);
	} else {
		queue := wgpuDeviceGetQueue(wgpu_context.device);
		assert(queue != null, "Queue is not created correctly");
	}
	device := wgpu_context.device;

	new_aspect:float = (cast(float32) width) / (cast(float32) height);

	if(new_aspect != SCENE_DATA.camera_aspect){
		SCENE_DATA.camera_aspect = new_aspect;
		update_camera_data_projection(*SCENE_DATA);
	}
	time:float = new_time / 1000.0;
	#if USE_IMGUI {
		io := ImGui.GetIO();
		if(io.WantCaptureMouse == false){
			orbit_controls_process_event(*orbit_controls, *events_data);
		}
	} else {
		orbit_controls_process_event(*orbit_controls, *events_data);
	}
	orbit_controls_update_camera(*orbit_controls, *SCENE_DATA.camera_data[0]);
	update_scene_data(*SCENE_DATA, time);
	update_scene_data_uniforms(*SCENE_DATA);

	#if USE_COMPUTE_SHADER {
		compute_shader_controller.update_box_size(compute_shader_controller, SCENE_DATA.box_size);
		compute_shader_controller.compute(compute_shader_controller);
	}

	update_object_uniforms_to_buffer(DRAW_DATA.uniforms.object.buffer, queue, *SCENE_DATA);
	update_camera_uniforms_to_buffer(DRAW_DATA.uniforms.camera.buffer, queue, *SCENE_DATA);
	update_sdf_uniforms_to_buffer(DRAW_DATA.uniforms.sdf.buffer, queue, *SCENE_DATA);

	frame := wgpu_surface_create_current_view( *wgpu_context );
	defer wgpuTextureViewRelease(frame);
	create_multi_sample_texture_if_needed( *wgpu_context );
	create_depth_texture_if_needed( *wgpu_context );
	colorAttachment := WGPURenderPassColorAttachment.{
		loadOp = WGPULoadOp.Clear,
		storeOp = WGPUStoreOp.Store,
		clearValue = wgpu_context.bg_color,
	};

	update_render_pass_descriptor_multisample(*wgpu_context, *colorAttachment, *frame);

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
		#if RENDER_IN_VIEWPORT wgpu_set_viewport(render_pass_encoder1, 100, 100, 500, 300);  // Render to a 500x300 area at (100, 100)


		wgpuRenderPassEncoderSetPipeline(render_pass_encoder1, DRAW_DATA.pipeline);
		wgpuRenderPassEncoderSetBindGroup(render_pass_encoder1, 0, DRAW_DATA.uniforms.object.bind_group, 0, null);
		wgpuRenderPassEncoderSetBindGroup(render_pass_encoder1, 1, DRAW_DATA.uniforms.camera.bind_group, 0, null);
		wgpuRenderPassEncoderSetBindGroup(render_pass_encoder1, 2, DRAW_DATA.uniforms.sdf.bind_group, 0, null);
		//
		#if USE_COMPUTE_SHADER {
			wgpuRenderPassEncoderSetVertexBuffer(render_pass_encoder1, 0, compute_shader_controller.vertex_buffer, 0, compute_shader_controller.vertex_buffer_size);
		} else {
			wgpuRenderPassEncoderSetVertexBuffer(render_pass_encoder1, 0, DRAW_DATA.vertex.buffer, 0, DRAW_DATA.vertex.buffer_size);
		}
		wgpuRenderPassEncoderSetIndexBuffer(render_pass_encoder1, DRAW_DATA.index.buffer, WGPUIndexFormat.Uint32, 0, DRAW_DATA.index.buffer_size);

		#if RENDER_SCENE wgpuRenderPassEncoderDrawIndexed(render_pass_encoder1, xx SCENE_DATA.indices.count, 1, 0, 0, 0);
		#if USE_IMGUI gui_update(*window_context, *wgpu_context, render_pass_encoder1, *bd, *iwc, *ui_data, *SCENE_DATA, *events_data);
		wgpuRenderPassEncoderEnd(render_pass_encoder1);


		cmd_buffer1 = wgpuCommandEncoderFinish(cmd_encoder1, *(WGPUCommandBufferDescriptor.{label = "Cmd Buffer 3D"}));

		wgpuQueueSubmit(queue, 1, *cmd_buffer1);
	}

	#if WASM == false {
		wgpuSurfacePresent(wgpu_context.surface);
	}
	wgpuTextureRelease(wgpu_context.surface_texture.texture);
	multisample_release(*wgpu_context);
	depth_release(*wgpu_context);
	#if USE_IMGUI imgui_gui_free(*iwc);

	reset_temporary_storage();
	FRAMES_COUNT += 1;
}

// scope_file does not yet prevent unwanted functions to be in the wasm export
#scope_file

#if FREE_MEMORY_DEBUG #import "Basic"()(MEMORY_DEBUGGER=true);
else #import "Basic";
#import "Math";
#import "String";
#if WASM == true  #import "wgpu_wasm";
#if WASM == false #import "wgpu";

#load "common/math_helper.jai";;
#load "common/draw_data.jai";
#load "common/scene_data.jai";
#load "common/type_utils.jai";
#load "common/events/common.jai";
#if WASM == true #load "common/events/wasm.jai";
else #load "common/events/native.jai";
#if WASM #load "common/wgpu/wasm.jai";
else     #load "common/wgpu/native.jai";
#load "common/wgpu/common.jai";
#load "common/wgpu/common_depth.jai";
#load "common/wgpu/common_msaa.jai";
#load "common/wgpu/common_uniforms.jai";
#load "common/wgpu/common_compute.jai";
#load "common/print_utils.jai";
#load "common/orbit_controls/common.jai";

#if WASM == false {
	#import "wgpu";
	#import "SDL";
}
#if USE_IMGUI {
	#load "common/imgui/common.jai";
	#load "common/imgui_impl_wgpu/index.jai";
	#import "imgui";
	#load "common/imgui/common_ui.jai";
	#if WASM #load "common/imgui/wasm.jai";
	else     #load "common/imgui/native.jai";
}

#if OS == .LINUX {
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
