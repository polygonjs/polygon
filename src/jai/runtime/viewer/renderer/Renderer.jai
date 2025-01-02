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

	clear:bool=false;
	// clearViewport:bool=false;
	includeBackgroundObject:bool=false;
	backgroundMeshData:BackgroundMeshData;
	DefaultMaterial :: struct {
		backgroundBasic: MeshBackgroundBasicMaterial;
	}
	defaultMaterial:DefaultMaterial;
	//
	use_msaa: bool=true;
	use_depth_buffer: bool=true;
	useReadback: bool=false;
	//
	readback_buffer: WGPUBuffer;
	readback_texture: WGPUTexture;
	readback_view: WGPUTextureView;
	//
	commands: RendererCommands;
	buffersToDestroy: [..]BufferContainer;
}

// newRenderer :: (wgpuContext: *WGPUContext, $ensureWGPUContextValid: bool=true/*, _allocator: *Allocator=null*/) -> *Renderer {
// 	// pool := nextPool();
// 	// set_allocators(pool);
// 	renderer := New(Renderer);
// 	rendererInit(renderer, wgpuContext, ensureWGPUContextValid);
// 	// if _allocator == null {
// 	// 	allocatorAssign(renderer, pool, do_set_allocators=false);
// 	// // } else {
// 	// // 	renderer.allocator = _allocator;
// 	// // }
// 	// rendererCommandsSetAllocator(renderer);
// 	// array_init(*renderer.buffers_to_destroy, renderer.allocator, reserve=true);
// 	// renderer.wgpuContext = wgpuContext;
// 	// #if ensureWGPUContextValid {
// 	// 	assert(renderer.wgpuContext.device != null, "renderer.wgpuContext.device is null");
// 	// 	assert(renderer.wgpuContext.queue != null, "renderer.wgpuContext.queue is null");
// 	// }
// 	return renderer;
// }
rendererInit :: (renderer:*Renderer, wgpuContext: *WGPUContext, $ensureWGPUContextValid: bool=true) {
	// pool := nextPool();
	// set_allocators(pool);

	// if _allocator == null {
		allocatorAssign(renderer);
	// } else {
	// 	renderer.allocator = _allocator;
	// }
	rendererCommandsSetAllocator(renderer);
	array_init(*renderer.buffersToDestroy, renderer.allocator, reserve=true);
	renderer.wgpuContext = wgpuContext;
	#if ensureWGPUContextValid {
		assert(renderer.wgpuContext.device != null, "renderer.wgpuContext.device is null");
		assert(renderer.wgpuContext.queue != null, "renderer.wgpuContext.queue is null");
	}

	{
		using renderer.defaultMaterial;
		materialInit(*backgroundBasic);
		setColor(*backgroundBasic, DEFAULT_RENDERER_BG_COLOR);
	}
	rendererInitBackgroundMesh(renderer);
}




rendererObjectAdd :: (renderer:*Renderer, object:*Object3DAny) {
	if object.type != Mesh {
		print("unknown object type %\n", object.type);
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
rendererObjectRemove :: (renderer:*Renderer, object:*Object3DAny) {
	if object.type != Mesh {
		print("unknown object type %\n", object.type);
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
rendererRenderableMaterialChanged :: (renderer:*Renderer, object:*Object3DAny, previousMaterial:*Material) {
	if object.type != Mesh {
		print("unknown object type %\n", object.type);
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
rendererCameraUpdateMatrix :: (renderer: *Renderer, camera:*CameraAny) {
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


