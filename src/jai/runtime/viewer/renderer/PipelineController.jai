

PipelineUniformData :: struct {
	buffer: WGPUBuffer;
	bind_group_entries: []WGPUBindGroupEntry;
	bind_group: WGPUBindGroup;
}
PipelineDataUniform :: struct {
	object: PipelineUniformData;
	material: PipelineUniformData;
}


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
	meshes: [..]*Mesh;
	material: *Material;
	meshes_draw_data:[..]*MeshDrawData;
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
	array_init(*pc.meshes);
	array_init(*pc.meshes_draw_data);
	

	pc.material = material;
	pc.label = tprint("% PipelineController %", renderer.label, material.id);
	pipelineControllerInit(pc);
	
	return pc;
}
pipelineControllerDelete :: (using pc: *PipelineController){
	push_allocator(renderer.allocator);
	array_init(*vertexBufferLayouts);
	array_init(*vertexAttributes);
	array_init(*meshes);
	array_init(*meshes_draw_data);
	free(label);
}

pipelineControllerInit :: (using pc: *PipelineController)-> PipelineController {
	// assert(pc.meshes.count > 0, "meshes is empty");
	assert(pc.material != null, "pc.material is null");

	wgpu_context := renderer.wgpu_context;
	// array_resize(*pc.meshes, meshes.count, false);
	// for mesh, i: <<meshes {
	// 	assert(mesh.material != null, "mesh.material is null");
	// 	pc.meshes[i] = mesh;
	// }
	// first_mesh := (pc.meshes)[0];
	// pc.material = first_mesh.material;
	pc.shader_module = material_create_module(wgpu_context, material);
	materialUpdatePipelineControllerLayout(material, pc);
	defer array_reset(*vertexBufferLayouts);
	defer array_reset(*vertexAttributes);

	{
		pc.pipeline_descriptor = .{label = to_c_string_temp(tprint("% Pipeline Descriptor", label))};
	}

	pipeline_controller_pipeline_descriptor_layout_init(wgpu_context, *pipeline_descriptor, material);
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
		topology= materialTopology(pc.material), //.TriangleList,
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
	pipeline = wgpuDeviceCreateRenderPipeline(wgpu_context.device, *(pipeline_descriptor));
	assert(pipeline != null, "Pipeline is not created correctly");

	
	// for pc.meshes {
	// 	drawData := newDrawData(renderer, pc, it);

	// 	array_add(*pc.meshes_draw_data, drawData);
	// }
	renderer_scene_uniform_buffer_assign(renderer, pipeline, xx UniformBindingIndex.SCENE);
	renderer_camera_uniform_buffer_assign(renderer, pipeline, xx UniformBindingIndex.CAMERA);

	return pc;
}
pipelineControllerAddMesh :: (using pc: *PipelineController, mesh: *Mesh) {
	drawData := newDrawData(pc, mesh);
	array_add(*meshes, mesh);
	array_add(*meshes_draw_data, drawData);
}
pipelineControllerRemoveMesh :: (using pc: *PipelineController, mesh: *Mesh) {
	found, index := array_find(meshes, mesh);
	if found {
		array_unordered_remove_by_index(*meshes, index);
		array_unordered_remove_by_index(*meshes_draw_data, index);
	}
	// drawData := newDrawData(pc, mesh);
	// array_add(*meshes, mesh);
	// array_add(*meshes_draw_data, drawData);
}

// pipeline_controller_mesh_update_draw_data :: (pc: *PipelineController, mesh: *Mesh, scene:*Scene) {
// 	// TODO: release old draw data buffers, using this [0] is not good, we should look up which index matches this mesh
// 	drawDataBuffersScheduleDestroy(pc.renderer, *pc.meshes_draw_data[0]);

// 	draw_data := drawDataCreate(pc, mesh, scene);
// 	pc.meshes_draw_data[0] = draw_data;
// }



pipeline_controller_update_uniform_buffers :: (using pc: *PipelineController) {
	
	wgpu_context := renderer.wgpu_context;
	// using the dirty flag may need a bit more work:
	// - ensure mesh uniforms trigger it
	// - ensure camera uniforms is shared and triggers it
	// - ensure material uniforms is shared and triggers it
	// if(!pc.uniforms_dirty) return;
	// defer pc.uniforms_dirty = false;
	assert(meshes.count > 0, "pc.meshes is empty");
	assert(meshes.count == meshes_draw_data.count, "pc.meshes.count != pc.meshes_draw_data.count");
	for mesh, i: meshes {
		draw_data := meshes_draw_data[i];
		{
			size := cast(u64) max( 16, size_of(TransformableUniforms));
			buffer := draw_data.uniforms.object.buffer;
			wgpuQueueWriteBuffer(wgpu_context.queue, buffer, 0, *mesh.transformable_uniforms, size);
		}
		// {
		// 	size := cast(u64) max( 16, size_of(CameraUniforms));
		// 	buffer := draw_data.uniforms.camera.buffer;
		// 	wgpuQueueWriteBuffer(pc.wgpu_context.queue, buffer, 0, cast(*void) *scene.orbit_controls.camera.uniforms, size);
		// }
		{
			size := cast(u64) max( 16, material.uniformTypeSize);
			buffer := draw_data.uniforms.material.buffer;
			wgpuQueueWriteBuffer(wgpu_context.queue, buffer, 0, *material.uniforms, size);
		}
		// update_object_uniforms_to_buffer(pc.wgpu_context, draw_data.uniforms.object.buffer, *mesh);
		// update_camera_uniforms_to_buffer(pc.wgpu_context, draw_data.uniforms.camera.buffer, scene_data);
		// update_sdf_uniforms_to_buffer(wgpu_context, draw_data.uniforms.material.buffer, scene_data);
	}
}

pipeline_controller_update_render_pass :: (using  pc: *PipelineController, render_pass_encoder: WGPURenderPassEncoder) {
	wgpuRenderPassEncoderSetPipeline(render_pass_encoder, pipeline);
	for draw_data: meshes_draw_data {
		{
			using draw_data.uniforms;
			wgpuRenderPassEncoderSetBindGroup(render_pass_encoder, xx UniformBindingIndex.SCENE, renderer.scene_data.bind_group, 0, null);
			wgpuRenderPassEncoderSetBindGroup(render_pass_encoder, xx UniformBindingIndex.CAMERA, renderer.camera_data.bind_group, 0, null);
			wgpuRenderPassEncoderSetBindGroup(render_pass_encoder, xx UniformBindingIndex.OBJECT, object.bind_group, 0, null);
			wgpuRenderPassEncoderSetBindGroup(render_pass_encoder, xx UniformBindingIndex.MATERIAL, material.bind_group, 0, null);
		}
		//
		for v, vi: draw_data.vertex {
			// print("submit attribute buffer START: % % (%/%)\n", v.buffer, v.label, vi+1, draw_data.vertex.count);
			wgpuRenderPassEncoderSetVertexBuffer(render_pass_encoder, xx vi, v.buffer, 0, v.buffer_size);
		}
		wgpuRenderPassEncoderSetIndexBuffer(render_pass_encoder, draw_data.index.buffer, WGPUIndexFormat.Uint32, 0, draw_data.index.buffer_size);

		mesh :*Mesh= meshes[it_index];
		#if RENDER_SCENE wgpuRenderPassEncoderDrawIndexed(render_pass_encoder, xx (mesh.geometry.indices.count), 1, 0, 0, 0);
	}
}





#scope_file

// NEXT_PIPELINE_CONTROLLER_ID :u32= 0;

pipeline_controller_create_fragment_state_init :: (fragment_state: *WGPUFragmentState, color_target_state: *WGPUColorTargetState, shader: WGPUShaderModule, format:WGPUTextureFormat ){

	color_target_state.format = format;
	if format == WGPUTextureFormat.RGBA32Uint {
		color_target_state.blend = null;
	}else {
		color_target_state.blend = *(WGPUBlendState.{
			color = .{ srcFactor = .One, dstFactor = .Zero, operation = .Add },
			alpha = .{ srcFactor = .One, dstFactor = .Zero, operation = .Add },
		});
	}
	color_target_state.writeMask = xx WGPUColorWriteMask.All;

	fragment_state.module = shader;
	fragment_state.entryPoint = "fragment";
	fragment_state.targetCount = 1;
	fragment_state.targets = color_target_state;
}


pipeline_controller_pipeline_descriptor_layout_init :: (wgpu_context: *WGPUContext, pipeline_descriptor: *WGPURenderPipelineDescriptor, material: *Material) {
	pipeline_layout_descriptor: WGPUPipelineLayoutDescriptor;


	count := material_bind_group_layouts_count(material);
	bind_group_layouts := NewArray(count, WGPUBindGroupLayout,, temp);
	// bind_group_layout_descs := NewArray(count, WGPUBindGroupLayoutDescriptor);
	// #if FREE_MEMORY defer {
	// 	// for bind_group_layout_descs free(it.label);
	// 	// array_reset(*bind_group_layouts);
	// 	// array_reset(*bind_group_layout_descs);
	// }
	container:BindGroupLayoutDescContainer= .{
		bind_group_layouts = bind_group_layouts,
		// bind_group_layout_descs = bind_group_layout_descs,
	};

	material_apply_to_pipeline_descriptor(wgpu_context, *pipeline_layout_descriptor, material, *container);

	// count := 2;
	// bind_group_layouts := NewArray(count, WGPUBindGroupLayout);
	// bind_group_layout_descs := NewArray(count, WGPUBindGroupLayoutDescriptor);
	// #if FREE_MEMORY defer {
	// 	for bind_group_layout_descs free(it.label);
	// 	array_reset(*bind_group_layouts);
	// 	array_reset(*bind_group_layout_descs);
	// }

	// // group 0 (object uniforms)
	// {
	// 	bind_group_layout_entries := NewArray(1, WGPUBindGroupLayoutEntry);
	// 	#if FREE_MEMORY defer array_reset(*bind_group_layout_entries);
	// 	bind_group_layout_entries[0] = WGPUBindGroupLayoutEntry.{
	// 		binding = 0,
	// 		visibility = xx WGPUShaderStage.Vertex,
	// 		buffer = .{ type = WGPUBufferBindingType.Uniform },
	// 	};
	// 	layout, desc := wgpu_create_bind_group_layout(device, bind_group_layout_entries.count, bind_group_layout_entries.data, "object uniforms");
	// 	bind_group_layouts[0] = layout;
	// 	bind_group_layout_descs[0] = desc;
	// }
	// // group 1 (camera uniforms)
	// {
	// 	bind_group_layout_entries := NewArray(1, WGPUBindGroupLayoutEntry);
	// 	#if FREE_MEMORY defer array_reset(*bind_group_layout_entries);
	// 	bind_group_layout_entries[0] = WGPUBindGroupLayoutEntry.{
	// 		binding = 0,
	// 		visibility = xx WGPUShaderStage.Vertex|WGPUShaderStage.Fragment,
	// 		buffer = .{ type = WGPUBufferBindingType.Uniform },
	// 	};
	// 	layout, desc := wgpu_create_bind_group_layout(device, bind_group_layout_entries.count, bind_group_layout_entries.data, "camera uniforms");
	// 	bind_group_layouts[1] = layout;
	// 	bind_group_layout_descs[1] = desc;
	// }
	// group 2 (SDF uniforms)
	// {
	// 	bind_group_layout_entries := NewArray(1, WGPUBindGroupLayoutEntry);
	// 	#if FREE_MEMORY defer array_reset(*bind_group_layout_entries);
	// 	bind_group_layout_entries[0] = WGPUBindGroupLayoutEntry.{
	// 		binding = 0,
	// 		visibility = xx WGPUShaderStage.Vertex|WGPUShaderStage.Fragment,
	// 		buffer = .{ type = WGPUBufferBindingType.Uniform },
	// 	};
	// 	layout, desc := wgpu_create_bind_group_layout(device, bind_group_layout_entries.count, bind_group_layout_entries.data, "sdf uniforms");
	// 	bind_group_layouts[2] = layout;
	// 	bind_group_layout_descs[2] = desc;
	// }
	//
	pipeline_layout_descriptor.label = "Main Pipeline Layout (only here to test that the label can be re-created in js from wasm)";
	// pipeline_layout_descriptor.bindGroupLayoutCount = xx bind_group_layouts.count;
	// pipeline_layout_descriptor.bindGroupLayouts = bind_group_layouts.data;

	pipeline_descriptor.layout = wgpuDeviceCreatePipelineLayout(wgpu_context.device, *pipeline_layout_descriptor);
}

