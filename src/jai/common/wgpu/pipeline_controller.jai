

PipelineUniformData :: struct {
	buffer: WGPUBuffer;
	bind_group_entries: []WGPUBindGroupEntry;
	bind_group: WGPUBindGroup;
}
PipelineDataUniform :: struct {
	object: PipelineUniformData;
	camera: PipelineUniformData;
	material: PipelineUniformData;
}


PipelineController :: struct {
	wgpu_context: *WGPUContext;
	shader_module: WGPUShaderModule;
	vertex_buffer_layouts:[..]WGPUVertexBufferLayout;
	vertex_attributes:[..]WGPUVertexAttribute;
	pipeline_descriptor: WGPURenderPipelineDescriptor;
	pipeline: WGPURenderPipeline;
	fragment_state: WGPUFragmentState;
	color_target_state: WGPUColorTargetState;
	//
	meshes: *[..]Mesh;
	material: *Material(Any);
	meshes_draw_data:[..]MeshDrawData;
	// compute
	// compute_shader_controllers:[..]ComputeShaderController;
};


pipeline_controller_init :: (pc: *PipelineController,wgpu_context: *WGPUContext, meshes: *[..]Mesh, label: string)-> PipelineController {
	assert(meshes.count > 0, "meshes is empty");

	pc.wgpu_context = wgpu_context;
	pc.meshes = meshes;
	first_mesh := (<<meshes)[0];
	pc.material = first_mesh.material;
	pc.shader_module = material_create_module(wgpu_context, first_mesh.material);
	geometry_attributes_to_vertex_buffer_layouts(pc, *first_mesh.geometry.attributes);
	defer array_reset(*pc.vertex_buffer_layouts);
	defer array_reset(*pc.vertex_attributes);

	pc.pipeline_descriptor = .{label = to_c_string(tprint("% Pipeline", label))};

	pipeline_controller_pipeline_descriptor_layout_init(wgpu_context, *pc.pipeline_descriptor, first_mesh.material);
	pipeline_controller_create_fragment_state_init(*(pc.fragment_state), *(pc.color_target_state), pc.shader_module, wgpu_context.preferred_texture_format);
	pc.pipeline_descriptor.fragment = *(pc.fragment_state);
	// vertex
	vertex_state: WGPUVertexState;
	vertex_state.module = pc.shader_module ;
	vertex_state.entryPoint = "vertex";
	vertex_state.bufferCount = xx pc.vertex_buffer_layouts.count;
	vertex_state.buffers = pc.vertex_buffer_layouts.data;

	pc.pipeline_descriptor.vertex = vertex_state;

	pc.pipeline_descriptor.primitive = .{
		topology=.TriangleList,
		stripIndexFormat=.Undefined,
		// frontFace=.CCW,
		cullMode=.None,
	};


	wgpu_update_pipeline_descriptor_multisample(wgpu_context, *(pc.pipeline_descriptor));
	depth_stencil_state: WGPUDepthStencilState;
	wgpu_update_pipeline_descriptor_depth(wgpu_context, *(pc.pipeline_descriptor), *depth_stencil_state);

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
	pc.pipeline = wgpuDeviceCreateRenderPipeline(wgpu_context.device, *(pc.pipeline_descriptor));
	assert(pc.pipeline != null, "Pipeline is not created correctly");

	array_reset(*pc.meshes_draw_data);
	for (<<pc.meshes) {
		draw_data := draw_data_create(pc, *it);

		array_add(*pc.meshes_draw_data, draw_data);
	}


	return pc;
}

pipeline_controller_mesh_update_draw_data :: (pc: *PipelineController, mesh: *Mesh) {
	draw_data := draw_data_create(pc, mesh);
	// TODO: release old draw data buffers
	draw_data_release(*pc.meshes_draw_data[0]);
	pc.meshes_draw_data[0] = draw_data;
}



pipeline_controller_update_uniform_buffers :: (pc: *PipelineController, SCENE_DATA:*SceneData) {
	for (<<pc.meshes) {
		mesh := it;
		draw_data := pc.meshes_draw_data[it_index];
		{
			size := cast(u64) max( 16, size_of(Object3DUniforms));
			buffer := draw_data.uniforms.object.buffer;
			wgpuQueueWriteBuffer(wgpu_context.queue, buffer, 0, *mesh.uniforms, size);
		}
		{
			size := cast(u64) max( 16, size_of(CameraUniforms));
			buffer := draw_data.uniforms.camera.buffer;
			wgpuQueueWriteBuffer(wgpu_context.queue, buffer, 0, cast(*void) *SCENE_DATA.camera.uniforms, size);
		}
		{
			size := cast(u64) max( 16, size_of(type_of(pc.material.uniforms)));
			buffer := draw_data.uniforms.material.buffer;
			wgpuQueueWriteBuffer(wgpu_context.queue, buffer, 0, cast(*void) *pc.material.uniforms, size);
		}
		// update_object_uniforms_to_buffer(pc.wgpu_context, draw_data.uniforms.object.buffer, *mesh);
		// update_camera_uniforms_to_buffer(pc.wgpu_context, draw_data.uniforms.camera.buffer, SCENE_DATA);
		// update_sdf_uniforms_to_buffer(wgpu_context, draw_data.uniforms.material.buffer, SCENE_DATA);
	}
}

pipeline_controller_update_render_pass::(pc: *PipelineController, render_pass_encoder: *WGPURenderPassEncoder, SCENE_DATA:*SceneData) {
	wgpuRenderPassEncoderSetPipeline(<<render_pass_encoder, pc.pipeline);
	for pc.meshes_draw_data {
		draw_data := it;
		wgpuRenderPassEncoderSetBindGroup(<<render_pass_encoder, 0, draw_data.uniforms.object.bind_group, 0, null);
		wgpuRenderPassEncoderSetBindGroup(<<render_pass_encoder, 1, draw_data.uniforms.camera.bind_group, 0, null);
		wgpuRenderPassEncoderSetBindGroup(<<render_pass_encoder, 2, draw_data.uniforms.material.bind_group, 0, null);
		//
		for v, vi: draw_data.vertex {
			wgpuRenderPassEncoderSetVertexBuffer(<<render_pass_encoder, xx vi, v.buffer, 0, v.buffer_size);
		}
		wgpuRenderPassEncoderSetIndexBuffer(<<render_pass_encoder, draw_data.index.buffer, WGPUIndexFormat.Uint32, 0, draw_data.index.buffer_size);

		mesh := (<<pc.meshes)[it_index];
		#if RENDER_SCENE wgpuRenderPassEncoderDrawIndexed(<<render_pass_encoder, xx (mesh.geometry.indices.count), 1, 0, 0, 0);
	}
}



#scope_file

pipeline_controller_create_fragment_state_init :: (fragment_state: *WGPUFragmentState, color_target_state: *WGPUColorTargetState, shader: WGPUShaderModule, preferred_texture_format:WGPUTextureFormat ){

	color_target_state.format = preferred_texture_format;
	color_target_state.blend = *(WGPUBlendState.{
		color = .{ srcFactor = .One, dstFactor = .Zero, operation = .Add },
		alpha = .{ srcFactor = .One, dstFactor = .Zero, operation = .Add },
	});
	color_target_state.writeMask = xx WGPUColorWriteMask.All;

	fragment_state.module = shader;
	fragment_state.entryPoint = "fragment";
	fragment_state.targetCount = 1;
	fragment_state.targets = color_target_state;
}


pipeline_controller_pipeline_descriptor_layout_init :: (wgpu_context: *WGPUContext, pipeline_descriptor: *WGPURenderPipelineDescriptor, material: *Material) {
	pipeline_layout_descriptor: WGPUPipelineLayoutDescriptor;


	count := material_bind_group_layouts_count(material);
	bind_group_layouts := NewArray(count, WGPUBindGroupLayout);
	bind_group_layout_descs := NewArray(count, WGPUBindGroupLayoutDescriptor);
	#if FREE_MEMORY defer {
		for bind_group_layout_descs free(it.label);
		array_reset(*bind_group_layouts);
		array_reset(*bind_group_layout_descs);
	}
	container:BindGroupLayoutDescContainer= .{
		bind_group_layouts = bind_group_layouts,
		bind_group_layout_descs = bind_group_layout_descs,
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

