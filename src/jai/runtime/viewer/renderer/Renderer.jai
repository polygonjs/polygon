RendererBufferData :: struct {
	buffer_container: BufferContainer;
	bind_group: WGPUBindGroup;
	bind_group_entries: []WGPUBindGroupEntry;
}
DEFAULT_RENDERER_BG_COLOR :Color: .{0.05, 0.05, 0.05, 1.0};

Renderer :: struct {
	#as using viewportContainer: ViewportContainer;

	#if USE_FLAT_POOL {
		pool: Flat_Pool;
	} else #if USE_POOL {
		pool: Pool;
	}
	allocator: Allocator;

	label :string;
	wgpuContext: *WGPUContext;
	
	pipelines_by_mat_type: Table(u64, *PipelineController);
	computes: ComputeControllerCollection;
	// I still don't know how to have multiple renderers with different bg colors work together
	bgColor :Color = DEFAULT_RENDERER_BG_COLOR;
	scene_data: RendererBufferData;
	camera_data: RendererBufferData;

	clear:bool=true;
	//
	use_msaa: bool=true;
	use_depth_buffer: bool=true;
	useReadback: bool=false;
	//
	multisample_texture_descriptor : WGPUTextureDescriptor;
	multisample_texture: WGPUTexture;
	multisample_texture_view: WGPUTextureView=null;
	//
	depth_texture_stencil_attachment: WGPURenderPassDepthStencilAttachment;
	depth_texture: WGPUTexture;
	depth_texture_view: WGPUTextureView=null;
	//
	readback_buffer: WGPUBuffer;
	readback_texture: WGPUTexture;
	readback_view: WGPUTextureView;
	//
	commands: RendererCommands;
	buffers_to_destroy: [..]BufferContainer;
}

newRenderer :: (wgpuContext: *WGPUContext, $ensureWGPUContextValid: bool=true/*, _allocator: *Allocator=null*/) -> *Renderer {
	pool := nextPool();
	set_allocators(pool);
	renderer := New(Renderer);
	// if _allocator == null {
		allocatorAssign(renderer, pool, do_set_allocators=false);
	// } else {
	// 	renderer.allocator = _allocator;
	// }
	rendererCommandsSetAllocator(renderer);
	array_init(*renderer.buffers_to_destroy, renderer.allocator, reserve=true);
	renderer.wgpuContext = wgpuContext;
	#if ensureWGPUContextValid {
		assert(renderer.wgpuContext.device != null, "renderer.wgpuContext.device is null");
		assert(renderer.wgpuContext.queue != null, "renderer.wgpuContext.queue is null");
	}
	return renderer;
}

rendererSize :: (renderer:*Renderer) -> Vector2UInt64 {
	if renderer.fullScreen {
		width := wgpu_texture_get_width_surface(renderer.wgpuContext);
		height := wgpu_texture_get_height_surface(renderer.wgpuContext);
		return .{xx width, xx height};
	} else {
		return renderer.viewport.size;
	}
}
rendererSetSize :: (renderer:*Renderer, size: Vector2UInt64){
	renderer.viewport.size = size;

	if renderer.useReadback {
		createPixelReadbackResources(renderer);
	}
}
rendererCopySize :: (src:*Renderer, target: *Renderer){
	rendererSetSize(target, src.viewport.size);
}
rendererTargetSize :: (renderer:*Renderer) -> Vector2UInt64 {
	if renderer.useReadback {
		return renderer.viewport.size;
	} else {
		width := wgpu_texture_get_width_surface(renderer.wgpuContext);
		height := wgpu_texture_get_height_surface(renderer.wgpuContext);
		return .{xx width, xx height};
	}
}
rendererFormat :: (renderer:*Renderer) -> WGPUTextureFormat {
	if renderer.useReadback {
		return .BGRA8Unorm; // .RGBA32Uint; // could potentially work with RGBA32Float
	} else {
		return renderer.wgpuContext.preferred_texture_format;
	}
}





rendererInitPipelines :: (renderer:*Renderer, scene:*Scene, camera:*Camera){

	// #if WASM==true context = call_from_wasm_context;
	// device := renderer.wgpuContext.device;
	// #if WASM==true {
	// 	queue := renderer.wgpuContext.queue;
	// } else {
	// 	queue := wgpuDeviceGetQueue(renderer.wgpuContext.device);
	// 	assert(queue != null, "Queue is not created correctly");
	// }
	{
		push_allocator(renderer.allocator);
		init(*renderer.pipelines_by_mat_type, 1);
	}
	renderer_scene_uniform_buffer_create(renderer, scene);
	renderer_camera_uniform_buffer_create(renderer, camera);

	rendererCameraUpdateMatrix(renderer, camera);
	
	// for object: scene.children {
	// 	rendererObjectAdd(renderer, object);
	// }
	// print("rendererInitPipelines\n");
	// for pc: renderer.pipelines_by_mat_type {
	// 	// pipeline_controller_init(pc, renderer, renderer.wgpuContext, "render meshes 2");

	// 	compute_initialized := false;
	// 	for mesh: pc.meshes {
	// 		if compute_initialized==false && mesh.use_compute {
	// 			compute_initialized=true;
	// 			renderer.computes = compute_controller_collection_create(renderer.wgpuContext, scene);
	// 			pipeline_controller_update(pc, *renderer.computes);
	// 		}
	// 	}
	// }
}
rendererObjectAdd :: (renderer:*Renderer, object:*Object3D) {
	if object.type != Mesh {
		print("unknown object type\n");
		return;
	}
	mesh := cast(*Mesh)object;
	matId := mesh.material.id;
	if !table_contains(*renderer.pipelines_by_mat_type, matId) {
		pc :*PipelineController= newPipelineController(renderer, PipelineController, mesh.material);
		pipelineControllerAddMesh(pc, mesh);
		table_set(*renderer.pipelines_by_mat_type, matId, pc);
	} else {
		pc, found := table_find(*renderer.pipelines_by_mat_type, matId);
		assert(found, "pipeline controller not found");
		pipelineControllerAddMesh(pc, mesh);
	}
}
rendererObjectRemove :: (renderer:*Renderer, object:*Object3D) {
	if object.type != Mesh {
		print("unknown object type\n");
		return;
	}
	mesh := cast(*Mesh)object;
	matId := mesh.material.id;

	pipelineControllerRemoveMeshAndDeleteIfEmpty(renderer, mesh, matId);
	// pc, found := table_find(*renderer.pipelines_by_mat_type, matId);
	// if found {
	// 	pipelineControllerRemoveMesh(pc, mesh);
	// 	if pc.meshes.count == 0 {
	// 		pipelineControllerDelete(pc);
	// 		table_remove(*renderer.pipelines_by_mat_type, matId);
	// 	}
	// }
}
rendererRenderableMaterialChanged :: (renderer:*Renderer, object:*Object3D, previousMaterial:*Material) {
	if object.type != Mesh {
		print("unknown object type\n");
		return;
	}
	mesh := cast(*Mesh)object;
	previousMatId := previousMaterial.id;

	pipelineControllerRemoveMeshAndDeleteIfEmpty(renderer, mesh, previousMatId);
	rendererObjectAdd(renderer, object);
}
rendererTransformableUpdateMatrix :: (renderer:*Renderer, mesh:*Mesh) {
	matId := mesh.material.id;
	pc, found := table_find(*renderer.pipelines_by_mat_type, matId);
	if found {
		pipelineControllerUpdateUniformBuffers(pc, mesh);
	} else {
		print("pipeline controller not found\n");
	}
}
rendererCameraUpdateMatrix :: (renderer: *Renderer, camera:*Camera) {
	cameraUniformsUpdate(camera);
	renderer_camera_uniform_buffer_update(renderer, camera, camera.cameraUniforms);
}
pipelineControllerRemoveMeshAndDeleteIfEmpty :: (renderer:*Renderer, mesh:*Mesh, matId:u64) {
	pc, found := table_find(*renderer.pipelines_by_mat_type, matId);
	if found {
		pipelineControllerRemoveMesh(pc, mesh);
		if pc.drawDatas.count == 0 {
			pipelineControllerDelete(pc);
			table_remove(*renderer.pipelines_by_mat_type, matId);
		}
	}
}
// renderer_init_pipelines_nodes :: (renderer:*Renderer, scene:*Scene, camera:*Camera){
// 	// #if WASM==true context = call_from_wasm_context;
// 	// device := renderer.wgpuContext.device;
// 	// #if WASM==true {
// 	// 	queue := renderer.wgpuContext.queue;
// 	// } else {
// 	// 	queue := wgpuDeviceGetQueue(renderer.wgpuContext.device);
// 	// 	assert(queue != null, "Queue is not created correctly");
// 	// }
// 	renderer_camera_uniform_buffer_create(renderer, scene, camera.cameraUniforms, "camera");
// 	pipeline_controller :*PipelineController= newPipelineController(PipelineController);
// 	// pipeline_controller_init(*pipeline_controller0, renderer.wgpuContext, *SCENE_DATA.meshes0, "render meshes 0");
// 	// pipeline_controller_init(*pipeline_controller1, renderer.wgpuContext, *SCENE_DATA.meshes1, "render meshes 1");
// 	pipeline_controller_init(pipeline_controller, renderer, renderer.wgpuContext, scene, *scene.children, "render meshes 0");
// 	// array_add(*PIPELINE_CONTROLLERS, pipeline_controller0);
// 	// array_add(*PIPELINE_CONTROLLERS, pipeline_controller1);
// 	array_add(*renderer.pipelines.pipelines, pipeline_controller);
// }

rendererPreRender :: inline (renderer:*Renderer, camera:*Camera) {
	rendererFlushCommands(renderer);
	// cameraUniformsUpdate(camera);
}

render :: (data:*RenderCollectionData, renderer: *Renderer, scene:*Scene, camera: *Camera){
	rendererPreRender(renderer, camera);

	create_multi_sample_texture_if_needed( renderer );
	create_depth_texture_if_needed( renderer );
	device := renderer.wgpuContext.device;

	colorAttachment := WGPURenderPassColorAttachment.{
		loadOp = ifx renderer.clear then WGPULoadOp.Clear else WGPULoadOp.Load,
		storeOp = WGPUStoreOp.Store,
		clearValue = wgpu_color_create(renderer.bgColor),
	};

	update_render_pass_descriptor_multisample(renderer, *colorAttachment, *data.frame);

	cmdEncoderLabel := tprint("Command Encoder %", renderer.label,, temp);
	cmdEncoderLabel_c := to_c_string_temp(cmdEncoderLabel);
	cmd_encoder := wgpuDeviceCreateCommandEncoder(
		device,
		*(WGPUCommandEncoderDescriptor.{label = cmdEncoderLabel_c}),
	);
	defer wgpuCommandEncoderRelease(cmd_encoder);

	renderPassDescriptorLabel := tprint("Render Pass 3D %", renderer.wgpuContext.framesCount,, temp);
	renderPassDescriptorLabel_c := to_c_string_temp(renderPassDescriptorLabel);
	// defer free(renderPassDescriptorLabel_c);
	render_pass_descriptor := WGPURenderPassDescriptor.{
		label = renderPassDescriptorLabel_c,
		colorAttachmentCount = 1,
		colorAttachments = *colorAttachment,
	};
	update_render_pass_descriptor_depth(renderer, *render_pass_descriptor);

	compute_controller_collection_compute(*renderer.computes);

	renderer_scene_uniform_buffer_update(renderer, scene, scene.sceneUniforms);
	
	for renderer.pipelines_by_mat_type {
		// pipelineControllerUpdateRenderableUniformBuffers(it);
		pipelineControllerUpdateMaterialUniformBuffers(it);
	}
	
	// if(renderer.fullScreen == false) {
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
	if(renderer.fullScreen == false) {
		using renderer.viewport;
		// renderer_set_viewport(render_pass_encoder, start.x, start.y, size.x, size.y);
		set_viewport(render_pass_encoder, xx start.x, xx start.y, xx size.x, xx size.y);
		// Clear only the viewport area
		set_scissor_rect(render_pass_encoder, xx start.x, xx start.y, xx size.x, xx size.y);
	}


	for renderer.pipelines_by_mat_type pipeline_controller_update_render_pass(it, render_pass_encoder);
	// #if USE_IMGUI {
	// 	if renderer.render_ui {
	// 		gui_update(renderer, scene, render_pass_encoder, *rendererwgpuContext);
	// 	}
	// }
	wgpuRenderPassEncoderEnd(render_pass_encoder);

	cmd_buffer1_label := to_c_string_temp(tprint("% %", renderer.label, renderer.wgpuContext.framesCount));
	// defer free(cmd_buffer1_label);
	cmd_buffer1 := wgpuCommandEncoderFinish(cmd_encoder, *(WGPUCommandBufferDescriptor.{label = cmd_buffer1_label}));
	defer wgpuCommandBufferRelease(cmd_buffer1);

	wgpuQueueSubmit(data.queue, 1, *cmd_buffer1);

}

rendererDestroyBuffers :: (using renderer:*Renderer){
	for container: buffers_to_destroy {
		wgpuBufferDestroy(container.buffer);
	}
	buffers_to_destroy.count = 0;
	// for renderer.pipelines_by_mat_type {
	// 	pipelineControllerDestroyScheduledBuffers(it);
	// }
	// multisample_release(renderer);
	// depth_release(renderer);
}

rendererDelete :: (renderer:*Renderer) {
	rendererDestroyBuffers(renderer);
	allocatorReset(renderer);
	// rendererCommandsDelete(*renderer.commands);
	free(renderer);
}

#scope_file

// material_hash :: (pc: *PipelineController) -> u32 {
// 	return pc.id;
// }


