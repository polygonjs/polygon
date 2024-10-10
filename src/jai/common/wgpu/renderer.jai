
#if WASM {
	renderer_init_wasm :: (canvas: WGPUSurface, device: WGPUDevice, queue: WGPUQueue, preferred_texture_format: WGPUTextureFormat){
		WGPU_CONTEXT.surface = canvas;
		WGPU_CONTEXT.device = device;
		WGPU_CONTEXT.queue = queue;
		WGPU_CONTEXT.preferred_texture_format = preferred_texture_format;
	}
} else {
	renderer_init_native :: (window: *SDL_Window, size: Vector2UInt){
		surface_capabilities := wgpu_context_init(window, *WGPU_CONTEXT, size);

		// on_wgpu_device_ready(WGPU_CONTEXT.surface, WGPU_CONTEXT.device, WGPU_CONTEXT.queue, WGPU_CONTEXT.preferred_texture_format);
	}
	renderer_resize_native :: (size: Vector2UInt){
		webgpu_handle_resize(*WGPU_CONTEXT, size);
	}
}

renderer_init_draw_data :: (){
	#if WASM==true context = call_from_wasm_context;
	device := WGPU_CONTEXT.device;
	#if WASM==true {
		queue := WGPU_CONTEXT.queue;
	}
	#if WASM==false {
		queue := wgpuDeviceGetQueue(WGPU_CONTEXT.device);
		assert(queue != null, "Queue is not created correctly");
	}
	pipeline_controller_init(*pipeline_controller0, *WGPU_CONTEXT, *SCENE_DATA.meshes0, "render meshes 0");
	// pipeline_controller_init(*pipeline_controller1, *wgpu_context, *SCENE_DATA.meshes1, "render meshes 1");
	// pipeline_controller_init(*pipeline_controller2, *wgpu_context, *SCENE_DATA.meshes2, "render meshes 2");
	array_add(*PIPELINE_CONTROLLERS, pipeline_controller0);
	// array_add(*PIPELINE_CONTROLLERS, pipeline_controller1);
	// array_add(*PIPELINE_CONTROLLERS, pipeline_controller2);

	#if USE_COMPUTE_SHADER {
		COMPUTE_CONTROLLER_COLLECTION = compute_controller_collection_create(*WGPU_CONTEXT);
		pipeline_controlller_update(*pipeline_controller2, *COMPUTE_CONTROLLER_COLLECTION);
	}
	// array_add(*pipeline_controller2.compute_shader_controllers, offset_controller);

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

		bd.wgpuDevice = WGPU_CONTEXT.device;
		imgui_init_info := ImGui_ImplWGPU_InitInfo.{
			// Device = wgpu_context.device,
			NumFramesInFlight = 3,
			RenderTargetFormat = WGPU_CONTEXT.preferred_texture_format,
			DepthStencilFormat = ifx WGPU_CONTEXT.use_depth_buffer then DEPTH_TEXTURE_FORMAT else WGPUTextureFormat.Undefined,
		};
		
		ImGui_ImplWGPU_Init(*bd, imgui_init_info);
	}
}


render :: (){
	#if WASM {
		queue := WGPU_CONTEXT.queue;
	} else {
		queue := wgpuDeviceGetQueue(WGPU_CONTEXT.device);
		assert(queue != null, "Queue is not created correctly");
	}
	device := WGPU_CONTEXT.device;

	for PIPELINE_CONTROLLERS pipeline_controller_update_uniform_buffers(*it, *SCENE_DATA);

	frame := wgpu_surface_create_current_view( *WGPU_CONTEXT );
	defer wgpuTextureViewRelease(frame);
	create_multi_sample_texture_if_needed( *WGPU_CONTEXT );
	create_depth_texture_if_needed( *WGPU_CONTEXT );
	colorAttachment := WGPURenderPassColorAttachment.{
		loadOp = WGPULoadOp.Clear,
		storeOp = WGPUStoreOp.Store,
		clearValue = wgpu_color_create(SCENE_DATA.bg_color),
	};

	update_render_pass_descriptor_multisample(*WGPU_CONTEXT, *colorAttachment, *frame);

	cmd_encoder1 := wgpuDeviceCreateCommandEncoder(
		WGPU_CONTEXT.device,
		*(WGPUCommandEncoderDescriptor.{label = "Command Encoder Render"}),
	);
	defer wgpuCommandEncoderRelease(cmd_encoder1);

	render_pass_descriptor_label := to_c_string(tprint("Render Pass 3D %", FRAMES_COUNT));
	defer free(render_pass_descriptor_label);
	render_pass_descriptor := WGPURenderPassDescriptor.{
		label = render_pass_descriptor_label,
		colorAttachmentCount = 1,
		colorAttachments = *colorAttachment,
	};
	update_render_pass_descriptor_depth(*WGPU_CONTEXT, *render_pass_descriptor);
	render_pass_encoder1 := wgpuCommandEncoderBeginRenderPass(cmd_encoder1, *render_pass_descriptor);
	defer wgpuRenderPassEncoderRelease(render_pass_encoder1);
	#if RENDER_IN_VIEWPORT wgpu_set_viewport(render_pass_encoder1, 100, 100, 500, 300);  // Render to a 500x300 area at (100, 100)

	for PIPELINE_CONTROLLERS pipeline_controller_update_render_pass(*it, render_pass_encoder1, *SCENE_DATA);
	#if USE_IMGUI gui_update(*window_context, *WGPU_CONTEXT, render_pass_encoder1, *bd, *iwc, *ui_data, *SCENE_DATA, *events_data);
	wgpuRenderPassEncoderEnd(render_pass_encoder1);

	cmd_buffer1_label := to_c_string(tprint("Cmd Buffer 3D %", FRAMES_COUNT));
	defer free(cmd_buffer1_label);
	cmd_buffer1 := wgpuCommandEncoderFinish(cmd_encoder1, *(WGPUCommandBufferDescriptor.{label = cmd_buffer1_label}));
	defer wgpuCommandBufferRelease(cmd_buffer1);

	wgpuQueueSubmit(queue, 1, *cmd_buffer1);

	#if WASM == false {
		wgpuSurfacePresent(WGPU_CONTEXT.surface);
	}
	wgpuTextureRelease(WGPU_CONTEXT.surface_texture.texture);
	multisample_release(*WGPU_CONTEXT);
	depth_release(*WGPU_CONTEXT);
	#if USE_IMGUI imgui_gui_free(*iwc);
	for PIPELINE_CONTROLLERS pipeline_controller_destroy_scheduled_buffers(*it);
}

#scope_file

WGPU_CONTEXT:WGPUContext;