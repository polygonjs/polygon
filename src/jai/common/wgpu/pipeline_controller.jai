

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
	// id: u32;
	wgpu_context: *WGPUContext;
	shader_module: WGPUShaderModule;
	vertex_buffer_layouts:[..]WGPUVertexBufferLayout;
	vertex_attributes:[..]WGPUVertexAttribute;
	pipeline_descriptor: WGPURenderPipelineDescriptor;
	pipeline: WGPURenderPipeline;
	fragment_state: WGPUFragmentState;
	color_target_state: WGPUColorTargetState;
	//
	meshes: [..]*Mesh;
	material: *Material;
	meshes_draw_data:[..]MeshDrawData;
	//
	uniforms_dirty: bool=true;
	buffers_to_destroy: [..]BufferContainer;
};

newPipelineController :: ($T: Type, material: *Material) -> *T {
	pc: *T = alloc(size_of(T));
	pc.type = T;

	// pc.id = NEXT_PIPELINE_CONTROLLER_ID;
	// NEXT_PIPELINE_CONTROLLER_ID+=1;

	init_array(*pc.vertex_buffer_layouts);
	init_array(*pc.vertex_attributes);
	init_array(*pc.meshes);
	init_array(*pc.meshes_draw_data);
	init_array(*pc.buffers_to_destroy);

	pc.material = material;
	
	return pc;
}

pipeline_controller_init :: (pc: *PipelineController, renderer:*Renderer, wgpu_context: *WGPUContext, scene:*Scene, label: string)-> PipelineController {
	assert(pc.meshes.count > 0, "meshes is empty");
	assert(pc.material != null, "pc.material is null");

	pc.wgpu_context = wgpu_context;
	// array_resize(*pc.meshes, meshes.count, false);
	// for mesh, i: <<meshes {
	// 	assert(mesh.material != null, "mesh.material is null");
	// 	pc.meshes[i] = mesh;
	// }
	first_mesh := (pc.meshes)[0];
	// pc.material = first_mesh.material;
	pc.shader_module = material_create_module(wgpu_context, pc.material);
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


	wgpu_update_pipeline_descriptor_multisample(renderer, *pc.pipeline_descriptor);
	depth_stencil_state: WGPUDepthStencilState;
	wgpu_update_pipeline_descriptor_depth(renderer, *pc.pipeline_descriptor, *depth_stencil_state);

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
	for pc.meshes {
		draw_data := draw_data_create(pc, it, scene);

		array_add(*pc.meshes_draw_data, draw_data);
	}
	renderer_scene_uniform_buffer_assign(renderer, pc.pipeline, xx UniformBindingIndex.SCENE);
	renderer_camera_uniform_buffer_assign(renderer, pc.pipeline, xx UniformBindingIndex.CAMERA);

	return pc;
}

pipeline_controller_mesh_update_draw_data :: (pc: *PipelineController, mesh: *Mesh, scene:*Scene) {
	// TODO: release old draw data buffers, using this [0] is not good, we should look up which index matches this mesh
	draw_data_buffers_schedule_destroy(pc, *pc.meshes_draw_data[0]);

	draw_data := draw_data_create(pc, mesh, scene);
	pc.meshes_draw_data[0] = draw_data;
}



pipeline_controller_update_uniform_buffers :: (pc: *PipelineController) {
	// using the dirty flag may need a bit more work:
	// - ensure mesh uniforms trigger it
	// - ensure camera uniforms is shared and triggers it
	// - ensure material uniforms is shared and triggers it
	// if(!pc.uniforms_dirty) return;
	// defer pc.uniforms_dirty = false;
	for pc.meshes {
		mesh := it;
		draw_data := pc.meshes_draw_data[it_index];
		{
			size := cast(u64) max( 16, size_of(TransformableUniforms));
			buffer := draw_data.uniforms.object.buffer;
			wgpuQueueWriteBuffer(pc.wgpu_context.queue, buffer, 0, *mesh.transformable_uniforms, size);
		}
		// {
		// 	size := cast(u64) max( 16, size_of(CameraUniforms));
		// 	buffer := draw_data.uniforms.camera.buffer;
		// 	wgpuQueueWriteBuffer(pc.wgpu_context.queue, buffer, 0, cast(*void) *scene.orbit_controls.camera.uniforms, size);
		// }
		{
			size := cast(u64) max( 16, pc.material.uniformTypeSize);
			buffer := draw_data.uniforms.material.buffer;
			wgpuQueueWriteBuffer(pc.wgpu_context.queue, buffer, 0, pc.material.uniforms, size);
		}
		// update_object_uniforms_to_buffer(pc.wgpu_context, draw_data.uniforms.object.buffer, *mesh);
		// update_camera_uniforms_to_buffer(pc.wgpu_context, draw_data.uniforms.camera.buffer, scene_data);
		// update_sdf_uniforms_to_buffer(wgpu_context, draw_data.uniforms.material.buffer, scene_data);
	}
}

pipeline_controller_update_render_pass :: (renderer:*Renderer, pc: *PipelineController, render_pass_encoder: WGPURenderPassEncoder) {
	wgpuRenderPassEncoderSetPipeline(render_pass_encoder, pc.pipeline);
	for draw_data: pc.meshes_draw_data {
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

		mesh :*Mesh= pc.meshes[it_index];
		#if RENDER_SCENE wgpuRenderPassEncoderDrawIndexed(render_pass_encoder, xx (mesh.geometry.indices.count), 1, 0, 0, 0);
	}
}

pipeline_controller_destroy_scheduled_buffers :: (pc: *PipelineController) {
	for container: pc.buffers_to_destroy {
		wgpuBufferDestroy(container.buffer);
	}
	array_reset(*pc.buffers_to_destroy);
}



#scope_file

// NEXT_PIPELINE_CONTROLLER_ID :u32= 0;

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

