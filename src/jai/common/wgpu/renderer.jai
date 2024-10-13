Renderer :: struct {
	full_screen:bool;
	ViewportRect :: struct {
		start: Vector2;
		size: Vector2;
	}
	viewport:ViewportRect;
	pipelines: PipelineControllerCollection;
	#if USE_COMPUTE_SHADER {
		computes: ComputeControllerCollection;
	}
	bg_color :Color =.{0.1, 0.3, 0.72, 1.0};
}


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

renderer_init_ui :: (){
	#if USE_IMGUI {
		bd := *BD;
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
		ImGui_ImplWGPU_Init(bd, imgui_init_info);
	}
}

renderer_init_pipelines_scene_data :: (renderer:*Renderer, scene:*Scene){
	// #if WASM==true context = call_from_wasm_context;
	// device := WGPU_CONTEXT.device;
	// #if WASM==true {
	// 	queue := WGPU_CONTEXT.queue;
	// } else {
	// 	queue := wgpuDeviceGetQueue(WGPU_CONTEXT.device);
	// 	assert(queue != null, "Queue is not created correctly");
	// }
	pipeline_controller :*PipelineController= newPipelineController(PipelineController);
	// pipeline_controller_init(*pipeline_controller0, *WGPU_CONTEXT, *SCENE_DATA.meshes0, "render meshes 0");
	// pipeline_controller_init(*pipeline_controller1, *WGPU_CONTEXT, *SCENE_DATA.meshes1, "render meshes 1");
	pipeline_controller_init(pipeline_controller, *WGPU_CONTEXT, scene, *scene.meshes2, "render meshes 2");
	// array_add(*PIPELINE_CONTROLLERS, pipeline_controller0);
	// array_add(*PIPELINE_CONTROLLERS, pipeline_controller1);
	array_add(*renderer.pipelines.pipelines, pipeline_controller);

	#if USE_COMPUTE_SHADER {
		renderer.computes = compute_controller_collection_create(*WGPU_CONTEXT, scene);
		pipeline_controller_update(pipeline_controller, *renderer.computes);
	}
}
renderer_init_pipelines_nodes :: (renderer:*Renderer, scene:*Scene){
	// #if WASM==true context = call_from_wasm_context;
	// device := WGPU_CONTEXT.device;
	// #if WASM==true {
	// 	queue := WGPU_CONTEXT.queue;
	// } else {
	// 	queue := wgpuDeviceGetQueue(WGPU_CONTEXT.device);
	// 	assert(queue != null, "Queue is not created correctly");
	// }
	pipeline_controller :*PipelineController= newPipelineController(PipelineController);
	// pipeline_controller_init(*pipeline_controller0, *WGPU_CONTEXT, *SCENE_DATA.meshes0, "render meshes 0");
	// pipeline_controller_init(*pipeline_controller1, *WGPU_CONTEXT, *SCENE_DATA.meshes1, "render meshes 1");
	pipeline_controller_init(pipeline_controller, *WGPU_CONTEXT, scene, *scene.meshes0, "render meshes 0");
	// array_add(*PIPELINE_CONTROLLERS, pipeline_controller0);
	// array_add(*PIPELINE_CONTROLLERS, pipeline_controller1);
	array_add(*renderer.pipelines.pipelines, pipeline_controller);
}


render :: (data:*RenderCollectionData, renderer: *Renderer, scene: *Scene, window_size:Vector2UInt, render_ui:bool, clear:bool){
	
	device := WGPU_CONTEXT.device;

	colorAttachment := WGPURenderPassColorAttachment.{
		loadOp = ifx clear then WGPULoadOp.Clear else WGPULoadOp.Load,
		storeOp = WGPUStoreOp.Store,
		clearValue = wgpu_color_create(renderer.bg_color),
	};

	update_render_pass_descriptor_multisample(*WGPU_CONTEXT, *colorAttachment, *data.frame);

	cmd_encoder := wgpuDeviceCreateCommandEncoder(
		WGPU_CONTEXT.device,
		*(WGPUCommandEncoderDescriptor.{label = "Command Encoder Render"}),
	);
	defer wgpuCommandEncoderRelease(cmd_encoder);

	render_pass_descriptor_label := to_c_string(tprint("Render Pass 3D %", FRAMES_COUNT));
	defer free(render_pass_descriptor_label);
	render_pass_descriptor := WGPURenderPassDescriptor.{
		label = render_pass_descriptor_label,
		colorAttachmentCount = 1,
		colorAttachments = *colorAttachment,
	};
	update_render_pass_descriptor_depth(*WGPU_CONTEXT, *render_pass_descriptor);

	#if USE_COMPUTE_SHADER {
		compute_controller_collection_compute(*renderer.computes, scene);
	}

	for renderer.pipelines.pipelines pipeline_controller_update_uniform_buffers(it, scene);

	// if(renderer.full_screen == false) {
	// 	using renderer.viewport;
	// 	// Create a separate render pass for clearing the viewport
	// 	clear_color_attachment := WGPURenderPassColorAttachment.{
	// 		view = data.frame,
	// 		resolveTarget = null,
	// 		loadOp = WGPULoadOp.Clear,
	// 		storeOp = WGPUStoreOp.Store,
	// 		clearValue = wgpu_color_create(renderer.bg_color),
	// 	};
	// 	clear_render_pass_descriptor := WGPURenderPassDescriptor.{
	// 		label = "Clear Viewport Pass",
	// 		colorAttachmentCount = 1,
	// 		colorAttachments = *clear_color_attachment,
	// 	};
	// 	clear_pass_encoder := wgpuCommandEncoderBeginRenderPass(cmd_encoder, *clear_render_pass_descriptor);
	// 	set_viewport(clear_pass_encoder, start.x, start.y, size.x, size.y);
	// 	set_scissor_rect(clear_pass_encoder, xx start.x, xx start.y, xx size.x, xx size.y);
	// 	wgpuRenderPassEncoderEnd(clear_pass_encoder);
	// }

	render_pass_encoder := wgpuCommandEncoderBeginRenderPass(cmd_encoder, *render_pass_descriptor);
	defer wgpuRenderPassEncoderRelease(render_pass_encoder);
	if(renderer.full_screen == false) {
		using renderer.viewport;
		// renderer_set_viewport(render_pass_encoder, start.x, start.y, size.x, size.y);
		set_viewport(render_pass_encoder, start.x, start.y, size.x, size.y);
		
		// Clear only the viewport area
		set_scissor_rect(render_pass_encoder, xx start.x, xx start.y, xx size.x, xx size.y);
		
	}


	for renderer.pipelines.pipelines pipeline_controller_update_render_pass(it, render_pass_encoder, scene);
	#if USE_IMGUI {
		if render_ui {
			gui_update(renderer, scene, render_pass_encoder, *WGPU_CONTEXT);
		}
	}
	wgpuRenderPassEncoderEnd(render_pass_encoder);
	

	cmd_buffer1_label := to_c_string(tprint("Cmd Buffer 3D %", FRAMES_COUNT));
	defer free(cmd_buffer1_label);
	cmd_buffer1 := wgpuCommandEncoderFinish(cmd_encoder, *(WGPUCommandBufferDescriptor.{label = cmd_buffer1_label}));
	defer wgpuCommandBufferRelease(cmd_buffer1);

	wgpuQueueSubmit(data.queue, 1, *cmd_buffer1);

	
	
}

renderer_destroy_buffers :: (renderer:*Renderer){
	for renderer.pipelines.pipelines pipeline_controller_destroy_scheduled_buffers(it);
}

#scope_file

// renderer_set_viewport :: (encoder: WGPURenderPassEncoder, x: float, y: float, width: float, height: float, min_depth: float = 0.0, max_depth: float = 1.0) {
// 	wgpuRenderPassEncoderSetViewport(encoder, x, y, width, height, min_depth, max_depth);
// 	wgpuRenderPassEncoderSetScissorRect(encoder, xx x, xx y, xx width, xx height);
// }
set_viewport :: (encoder: WGPURenderPassEncoder, x: float, y: float, width: float, height: float, min_depth: float = 0.0, max_depth: float = 1.0) {
	wgpuRenderPassEncoderSetViewport(encoder, x, y, width, height, min_depth, max_depth);
	// Removed: wgpuRenderPassEncoderSetScissorRect(encoder, xx x, xx y, xx width, xx height);
}

// Add a new function to set the scissor rect separately if needed
set_scissor_rect :: (encoder: WGPURenderPassEncoder, x: u32, y: u32, width: u32, height: u32) {
	wgpuRenderPassEncoderSetScissorRect(encoder, x, y, width, height);
}