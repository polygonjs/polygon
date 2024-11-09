RendererBufferData :: struct {
	buffer_container: BufferContainer;
	bind_group: WGPUBindGroup;
	bind_group_entries: []WGPUBindGroupEntry;
}
DEFAULT_RENDERER_BG_COLOR :Color: .{0.05, 0.05, 0.05, 1.0};
Renderer :: struct {
	#as using viewportContainer: ViewportContainer;
	name :string;
	wgpu_context: *WGPUContext;
	
	pipelines_by_mat_type: Table(u64, *PipelineController);
	computes: ComputeControllerCollection;
	// I still don't know how to have multiple renderers with different bg colors work together
	bgColor :Color = DEFAULT_RENDERER_BG_COLOR;
	scene_data: RendererBufferData;
	camera_data: RendererBufferData;

	render_ui:bool=false;
	clear:bool=true;
	//
	use_msaa: bool=true;
	use_depth_buffer: bool=true;
	//
	multisample_texture_descriptor : WGPUTextureDescriptor;
	multisample_texture: WGPUTexture;
	multisample_texture_view: WGPUTextureView=null;
	//
	depth_texture_stencil_attachment: WGPURenderPassDepthStencilAttachment;
	depth_texture: WGPUTexture;
	depth_texture_view: WGPUTextureView=null;
}

renderer_size :: (renderer:*Renderer) -> Vector2 {
	if renderer.full_screen {
		width := wgpu_texture_get_width_surface(renderer.wgpu_context);
		height := wgpu_texture_get_height_surface(renderer.wgpu_context);
		return .{xx width, xx height};
	} else {
		return renderer.viewport.size;
	}
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

renderer_init_ui :: (renderer:*Renderer){
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
			DepthStencilFormat = ifx renderer.use_depth_buffer then DEPTH_TEXTURE_FORMAT else WGPUTextureFormat.Undefined,
		};
		ImGui_ImplWGPU_Init(bd, imgui_init_info);
	}
}

renderer_init_pipelines :: (renderer:*Renderer, scene:*Scene, camera:*Camera){
	// #if WASM==true context = call_from_wasm_context;
	// device := WGPU_CONTEXT.device;
	// #if WASM==true {
	// 	queue := WGPU_CONTEXT.queue;
	// } else {
	// 	queue := wgpuDeviceGetQueue(WGPU_CONTEXT.device);
	// 	assert(queue != null, "Queue is not created correctly");
	// }
	renderer.wgpu_context = *WGPU_CONTEXT;
	init(*renderer.pipelines_by_mat_type, 1);
	renderer_scene_uniform_buffer_create(renderer, scene);
	renderer_camera_uniform_buffer_create(renderer, camera);
	
	for child: scene.children {
		if child.type == Mesh {
			mesh := cast(*Mesh)child;
			mat_id := mesh.material.id;
			if !table_contains(*renderer.pipelines_by_mat_type, mat_id) {
				pc :*PipelineController= newPipelineController(PipelineController, mesh.material);
				array_add(*pc.meshes, mesh);
				table_set(*renderer.pipelines_by_mat_type, mat_id, pc);

				
			} else {
				pc, found := table_find(*renderer.pipelines_by_mat_type, mat_id);
				assert(found, "pipeline controller not found");
				array_add(*pc.meshes, mesh);
			}
		}
	}
	for pc: renderer.pipelines_by_mat_type {
		pipeline_controller_init(pc, renderer, *WGPU_CONTEXT, scene, "render meshes 2");

		compute_initialized := false;
		for mesh: pc.meshes {
			if compute_initialized==false && mesh.use_compute {
				compute_initialized=true;
				renderer.computes = compute_controller_collection_create(*WGPU_CONTEXT, scene);
				pipeline_controller_update(pc, *renderer.computes);
			}
		}
	}


	
}
// renderer_init_pipelines_nodes :: (renderer:*Renderer, scene:*Scene, camera:*Camera){
// 	// #if WASM==true context = call_from_wasm_context;
// 	// device := WGPU_CONTEXT.device;
// 	// #if WASM==true {
// 	// 	queue := WGPU_CONTEXT.queue;
// 	// } else {
// 	// 	queue := wgpuDeviceGetQueue(WGPU_CONTEXT.device);
// 	// 	assert(queue != null, "Queue is not created correctly");
// 	// }
// 	renderer_camera_uniform_buffer_create(renderer, scene, camera.camera_uniforms, "camera");
// 	pipeline_controller :*PipelineController= newPipelineController(PipelineController);
// 	// pipeline_controller_init(*pipeline_controller0, *WGPU_CONTEXT, *SCENE_DATA.meshes0, "render meshes 0");
// 	// pipeline_controller_init(*pipeline_controller1, *WGPU_CONTEXT, *SCENE_DATA.meshes1, "render meshes 1");
// 	pipeline_controller_init(pipeline_controller, renderer, *WGPU_CONTEXT, scene, *scene.children, "render meshes 0");
// 	// array_add(*PIPELINE_CONTROLLERS, pipeline_controller0);
// 	// array_add(*PIPELINE_CONTROLLERS, pipeline_controller1);
// 	array_add(*renderer.pipelines.pipelines, pipeline_controller);
// }


render :: (data:*RenderCollectionData, renderer: *Renderer, scene:*Scene, camera: *Camera){
	
	create_multi_sample_texture_if_needed( renderer );
	create_depth_texture_if_needed( renderer );
	device := WGPU_CONTEXT.device;

	colorAttachment := WGPURenderPassColorAttachment.{
		loadOp = ifx renderer.clear then WGPULoadOp.Clear else WGPULoadOp.Load,
		storeOp = WGPUStoreOp.Store,
		clearValue = wgpu_color_create(renderer.bgColor),
	};

	update_render_pass_descriptor_multisample(renderer, *colorAttachment, *data.frame);

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
	update_render_pass_descriptor_depth(renderer, *render_pass_descriptor);

	compute_controller_collection_compute(*renderer.computes);

	renderer_scene_uniform_buffer_update(renderer, scene, scene.scene_uniforms);
	renderer_camera_uniform_buffer_update(renderer, camera, camera.camera_uniforms);
	for renderer.pipelines_by_mat_type pipeline_controller_update_uniform_buffers(it);
	
	// if(renderer.full_screen == false) {
	// 	using renderer.viewport;
	// 	// Create a separate render pass for clearing the viewport
	// 	clear_color_attachment := WGPURenderPassColorAttachment.{
	// 		view = data.frame,
	// 		resolveTarget = null,
	// 		loadOp = WGPULoadOp.Clear,
	// 		storeOp = WGPUStoreOp.Store,
	// 		clearValue = wgpu_color_create(renderer.bgColor),
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


	for renderer.pipelines_by_mat_type pipeline_controller_update_render_pass(renderer, it, render_pass_encoder);
	#if USE_IMGUI {
		if renderer.render_ui {
			gui_update(renderer, scene, render_pass_encoder, *WGPU_CONTEXT);
		}
	}
	wgpuRenderPassEncoderEnd(render_pass_encoder);

	cmd_buffer1_label := to_c_string(tprint("% %", renderer.name, FRAMES_COUNT));
	defer free(cmd_buffer1_label);
	cmd_buffer1 := wgpuCommandEncoderFinish(cmd_encoder, *(WGPUCommandBufferDescriptor.{label = cmd_buffer1_label}));
	defer wgpuCommandBufferRelease(cmd_buffer1);

	wgpuQueueSubmit(data.queue, 1, *cmd_buffer1);

}

renderer_destroy_buffers :: (renderer:*Renderer){
	for renderer.pipelines_by_mat_type {
		pipeline_controller_destroy_scheduled_buffers(it);
	}
	// multisample_release(renderer);
	// depth_release(renderer);
}

renderer_uniform_buffer_assign :: (renderer: *Renderer, pipeline: WGPURenderPipeline, buffer_data:*RendererBufferData, bind_group_layout_index: u32, label: string) {
	assert(buffer_data.buffer_container.buffer_size>0, tprint("% buffer_size is 0\n", label));
	entries := NewArray(1, WGPUBindGroupEntry);
	entries[0] = WGPUBindGroupEntry.{
		binding=0,
		size=buffer_data.buffer_container.buffer_size,
		offset=0,
		buffer=buffer_data.buffer_container.buffer,
	};
	bind_group_descriptor := WGPUBindGroupDescriptor.{
		label = "uniforms_bind_group/object",
		layout = wgpuRenderPipelineGetBindGroupLayout(pipeline, bind_group_layout_index),
		entryCount = xx entries.count,
		entries = entries.data
	};
	bind_group := wgpuDeviceCreateBindGroup(WGPU_CONTEXT.device, *bind_group_descriptor);

	buffer_data.bind_group = bind_group;
	buffer_data.bind_group_entries = entries;
}
renderer_scene_uniform_buffer_assign :: (renderer: *Renderer, pipeline: WGPURenderPipeline, bind_group_layout_index: u32) {
	renderer_uniform_buffer_assign(renderer, pipeline, *renderer.scene_data, bind_group_layout_index, "scene");
}
renderer_camera_uniform_buffer_assign :: (renderer: *Renderer, pipeline: WGPURenderPipeline, bind_group_layout_index: u32) {
	renderer_uniform_buffer_assign(renderer, pipeline, *renderer.camera_data, bind_group_layout_index, "camera");
}










#scope_file

// material_hash :: (pc: *PipelineController) -> u32 {
// 	return pc.id;
// }

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

renderer_uniform_buffer_create :: (renderer: *Renderer, buffer_data: *RendererBufferData, uniforms: $UniformType, label: string) {
	// TODO: This is a hack to make sure the buffer is at least 16 bytes
	size := cast(u64) max( 16, size_of(UniformType));

	buffer_label := to_c_string(label);
	defer free(buffer_label);
	buffer_desc: WGPUBufferDescriptor = .{
		usage = xx (WGPUBufferUsage.Uniform | WGPUBufferUsage.CopyDst),
		size = size,
		label = buffer_label,
	};
	buffer := wgpuDeviceCreateBuffer(WGPU_CONTEXT.device, *buffer_desc);
	assert(buffer != null, "Buffer is not created correctly");

	wgpuQueueWriteBuffer(WGPU_CONTEXT.queue, buffer, 0, *uniforms, size);

	buffer_data.buffer_container = .{buffer=buffer, buffer_size=size};
}

renderer_scene_uniform_buffer_create :: (renderer: *Renderer, scene:*Scene) {
	renderer_uniform_buffer_create(renderer, *renderer.scene_data, scene.scene_uniforms, "scene");
}
renderer_camera_uniform_buffer_create :: (renderer: *Renderer, camera:*Camera) {
	renderer_uniform_buffer_create(renderer, *renderer.camera_data, camera.camera_uniforms, "camera");
}

renderer_scene_uniform_buffer_update :: (renderer: *Renderer, scene:*Scene, uniforms: $UniformType){
	wgpuQueueWriteBuffer(WGPU_CONTEXT.queue, renderer.scene_data.buffer_container.buffer, 0, *scene.scene_uniforms, size_of(UniformType));
}
renderer_camera_uniform_buffer_update :: (renderer: *Renderer, camera:*Camera, uniforms: $UniformType){
	wgpuQueueWriteBuffer(WGPU_CONTEXT.queue, renderer.camera_data.buffer_container.buffer, 0, *camera.camera_uniforms, size_of(UniformType));
}
