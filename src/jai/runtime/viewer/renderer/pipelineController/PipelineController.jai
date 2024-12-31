




PipelineController :: struct {
	type: Type;
	renderer: *Renderer;
	label: string;
	// id: u32;
	shader_module: WGPUShaderModule;
	vertexBufferLayouts:[..]WGPUVertexBufferLayout;
	vertexAttributes:[..]WGPUVertexAttribute;
	pipeline_descriptor: WGPURenderPipelineDescriptor;
	pipeline: WGPURenderPipeline;
	fragment_state: WGPUFragmentState;
	color_target_state: WGPUColorTargetState;
	//
	material: *Material;
	drawDatas:[..]*MeshDrawData;
	//
	uniforms_dirty: bool=true;
	
};

newPipelineController :: (renderer: *Renderer, $T: Type, material: *Material) -> *T {
	pc: *T = New(T,, renderer.allocator);
	pc.type = T;
	pc.renderer = renderer;

	// pc.id = NEXT_PIPELINE_CONTROLLER_ID;
	// NEXT_PIPELINE_CONTROLLER_ID+=1;
	push_allocator(renderer.allocator);
	array_init(*pc.vertexBufferLayouts);
	array_init(*pc.vertexAttributes);
	array_init(*pc.drawDatas);
	

	pc.material = material;
	pc.label = tprint("% PipelineController %", renderer.label, material.id);
	pipelineControllerInit(pc);
	
	return pc;
}
pipelineControllerDelete :: (using pc: *PipelineController){
	push_allocator(renderer.allocator);
	array_init(*vertexBufferLayouts);
	array_init(*vertexAttributes);
	array_init(*drawDatas);
	free(label);
}

pipelineControllerInit :: (using pc: *PipelineController)-> PipelineController {
	// assert(pc.meshes.count > 0, "meshes is empty");
	assert(material != null, "pc.material is null");

	wgpuContext := renderer.wgpuContext;
	// array_resize(*pc.meshes, meshes.count, false);
	// for mesh, i: <<meshes {
	// 	assert(mesh.material != null, "mesh.material is null");
	// 	pc.meshes[i] = mesh;
	// }
	// first_mesh := (pc.meshes)[0];
	// pc.material = first_mesh.material;
	pc.shader_module = materialCreateModule(wgpuContext, material);
	generatedMaterialApplyVertexBufferLayout(material, pc);
	defer array_reset(*vertexBufferLayouts);
	defer array_reset(*vertexAttributes);

	{
		pc.pipeline_descriptor = .{label = to_c_string_temp(tprint("% Pipeline Descriptor", label))};
	}

	pipeline_controller_pipeline_descriptor_layout_init(wgpuContext, *pipeline_descriptor, material);
	pipeline_controller_create_fragment_state_init(*fragment_state, *color_target_state, shader_module, rendererFormat(renderer));
	pc.pipeline_descriptor.fragment = *fragment_state;
	// vertex
	vertex_state: WGPUVertexState;
	vertex_state.module = shader_module ;
	vertex_state.entryPoint = "vertex";
	vertex_state.bufferCount = xx vertexBufferLayouts.count;
	vertex_state.buffers = pc.vertexBufferLayouts.data;

	pipeline_descriptor.vertex = vertex_state;

	pipeline_descriptor.primitive = .{
		topology= generatedMaterialTopology(pc.material), //.TriangleList,
		stripIndexFormat=.Undefined,
		// frontFace=.CCW,
		cullMode=.None,
	};


	wgpu_update_pipeline_descriptor_multisample(renderer, *pc.pipeline_descriptor);
	depth_stencil_state: WGPUDepthStencilState;
	wgpu_update_pipeline_descriptor_depth(renderer, *pipeline_descriptor, *depth_stencil_state);

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
	pipeline = wgpuDeviceCreateRenderPipeline(wgpuContext.device, *(pipeline_descriptor));
	assert(pipeline != null, "Pipeline is not created correctly");

	
	// for pc.meshes {
	// 	drawData := newDrawData(renderer, pc, it);

	// 	array_add(*pc.meshes_draw_data, drawData);
	// }
	renderer_scene_uniform_buffer_assign(renderer, pipeline, xx UniformBindingIndex.SCENE);
	renderer_camera_uniform_buffer_assign(renderer, pipeline, xx UniformBindingIndex.CAMERA);

	return pc;
}




// pipeline_controller_mesh_update_draw_data :: (pc: *PipelineController, mesh: *Mesh, scene:*Scene) {
// 	// TODO: release old draw data buffers, using this [0] is not good, we should look up which index matches this mesh
// 	drawDataBuffersScheduleDestroy(pc.renderer, *pc.meshes_draw_data[0]);

// 	draw_data := drawDataCreate(pc, mesh, scene);
// 	pc.meshes_draw_data[0] = draw_data;
// }

