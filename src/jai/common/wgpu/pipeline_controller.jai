
BufferContainer :: struct {
	buffer:WGPUBuffer;
	buffer_size: u64;
}
PipelineUniformData :: struct {
	buffer: WGPUBuffer;
	bind_group_entries: []WGPUBindGroupEntry;
	bind_group: WGPUBindGroup;
}
PipelineDataUniform :: struct {
	object: PipelineUniformData;
	camera: PipelineUniformData;
	sdf: PipelineUniformData;
}


PipelineController :: struct {
	shader_module: WGPUShaderModule;
	vertex_buffer_layouts:[..]WGPUVertexBufferLayout;
	vertex_attributes:[..]WGPUVertexAttribute;
	pipeline_descriptor: WGPURenderPipelineDescriptor;
	pipeline: WGPURenderPipeline;
	fragment_state: WGPUFragmentState;
	color_target_state: WGPUColorTargetState;
	//
	vertex:[..]BufferContainer;
	index:BufferContainer;
	uniforms:PipelineDataUniform;
};


pipeline_controller_create :: (wgpu_context: *WGPUContext, meshes: [..]Mesh, shader: string, label: string)-> PipelineController {
	assert(meshes.count > 0, "meshes is empty");

	pc : PipelineController;
	pc.shader_module = wgpu_create_shader_module(wgpu_context.device, shader, xx tprint("% Shader", label));
	geometry_attributes_to_vertex_buffer_layouts(*pc, *(meshes[0].geometry.attributes));
	defer array_reset(*pc.vertex_buffer_layouts);
	defer array_reset(*pc.vertex_attributes);

	pc.pipeline_descriptor = .{label = to_c_string(tprint("% Pipeline", label))};

	pipeline_controller_pipeline_descriptor_layout_init(*pc.pipeline_descriptor, wgpu_context.device);
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

	mesh := SCENE_DATA.meshes[0];
	#if USE_COMPUTE_SHADER {
		// buffer_container := wgpu_geometry_attribute_to_buffer(wgpu_context, *mesh.geometry.attributes.position, Vector3);
		buffer_container := wgpu_geometry_attribute_to_buffer(wgpu_context, *mesh.geometry.attributes.position, Vector3, compute=true);

		box_controller = compute_shader_controller_create(
			wgpu_context,
			SHADER_COMPUTE_BOX,
			"boxCompute",
			buffer_container
		);

		offset_controller = compute_shader_controller_create(
			wgpu_context,
			SHADER_COMPUTE_OFFSET,
			"boxOffsetCompute",
			buffer_container
		);
	} else {
		array_add(*pc.vertex, wgpu_geometry_attribute_to_buffer(wgpu_context, *mesh.geometry.attributes.position, Vector3));
	}
	array_add(*pc.vertex, wgpu_geometry_attribute_to_buffer(wgpu_context, *mesh.geometry.attributes.normal, Vector3));
	array_add(*pc.vertex, wgpu_geometry_attribute_to_buffer(wgpu_context, *mesh.geometry.attributes.color, Vector3));
	array_add(*pc.vertex, wgpu_geometry_attribute_to_buffer(wgpu_context, *mesh.geometry.attributes.uv, Vector2));
	pc.index.buffer,
	pc.index.buffer_size = wgpu_index_array_to_buffer(wgpu_context, mesh.geometry.indices);

	pc.uniforms.object.buffer,
	pc.uniforms.object.bind_group,
	pc.uniforms.object.bind_group_entries = wgpu_object_uniform_to_buffer(wgpu_context, pc.pipeline, mesh.uniforms);

	pc.uniforms.camera.buffer,
	pc.uniforms.camera.bind_group,
	pc.uniforms.camera.bind_group_entries = wgpu_camera_uniform_to_buffer(wgpu_context, pc.pipeline, SCENE_DATA.camera.uniforms);

	pc.uniforms.sdf.buffer,
	pc.uniforms.sdf.bind_group,
	pc.uniforms.sdf.bind_group_entries = wgpu_sdf_uniform_to_buffer(wgpu_context, pc.pipeline, SCENE_DATA.sdf_uniforms);

	return pc;
}

pipeline_controller_update_buffers :: (wgpu_context: *WGPUContext, pc: *PipelineController, SCENE_DATA:*SceneData) {
	for SCENE_DATA.meshes update_object_uniforms_to_buffer(wgpu_context, pc.uniforms.object.buffer, *it);
	update_camera_uniforms_to_buffer(wgpu_context, pc.uniforms.camera.buffer, SCENE_DATA);
	update_sdf_uniforms_to_buffer(wgpu_context, pc.uniforms.sdf.buffer, SCENE_DATA);
}

pipeline_controller_update_render_pass::( pc: *PipelineController, render_pass_encoder: *WGPURenderPassEncoder, SCENE_DATA:*SceneData) {
	wgpuRenderPassEncoderSetPipeline(<<render_pass_encoder, pc.pipeline);
	wgpuRenderPassEncoderSetBindGroup(<<render_pass_encoder, 0, pc.uniforms.object.bind_group, 0, null);
	wgpuRenderPassEncoderSetBindGroup(<<render_pass_encoder, 1, pc.uniforms.camera.bind_group, 0, null);
	wgpuRenderPassEncoderSetBindGroup(<<render_pass_encoder, 2, pc.uniforms.sdf.bind_group, 0, null);
	//
	#if USE_COMPUTE_SHADER {
		wgpuRenderPassEncoderSetVertexBuffer(<<render_pass_encoder, 0, box_controller.vertex.buffer, 0, box_controller.vertex.buffer_size);
		for pc.vertex {
			wgpuRenderPassEncoderSetVertexBuffer(<<render_pass_encoder, xx (it_index+1), it.buffer, 0, it.buffer_size);
		}
	} else {
		for pc.vertex {
			wgpuRenderPassEncoderSetVertexBuffer(<<render_pass_encoder, xx it_index, it.buffer, 0, it.buffer_size);
		}
	}
	wgpuRenderPassEncoderSetIndexBuffer(<<render_pass_encoder, pc.index.buffer, WGPUIndexFormat.Uint32, 0, pc.index.buffer_size);

	#if RENDER_SCENE wgpuRenderPassEncoderDrawIndexed(<<render_pass_encoder, xx SCENE_DATA.meshes[0].geometry.indices.count, 1, 0, 0, 0);
}

#scope_file


pipeline_controller_create_fragment_state_init :: ( fragment_state: *WGPUFragmentState, color_target_state: *WGPUColorTargetState, shader: WGPUShaderModule, preferred_texture_format:WGPUTextureFormat ){

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


pipeline_controller_pipeline_descriptor_layout_init :: (pipeline_descriptor: *WGPURenderPipelineDescriptor, device: WGPUDevice) {
	pipeline_layout_descriptor: WGPUPipelineLayoutDescriptor;

	
	bind_group_layouts := NewArray(3, WGPUBindGroupLayout);
	bind_group_layout_descs := NewArray(3, WGPUBindGroupLayoutDescriptor);
	#if FREE_MEMORY defer {
		for bind_group_layout_descs free(it.label);
		array_reset(*bind_group_layouts);
		array_reset(*bind_group_layout_descs);
	}

	// group 0 (object uniforms)
	{
		bind_group_layout_entries := NewArray(1, WGPUBindGroupLayoutEntry);
		#if FREE_MEMORY defer array_reset(*bind_group_layout_entries);
		bind_group_layout_entries[0] = WGPUBindGroupLayoutEntry.{
			binding = 0,
			visibility = xx WGPUShaderStage.Vertex,
			buffer = .{ type = WGPUBufferBindingType.Uniform },
		};
		layout, desc := wgpu_create_bind_group_layout(device, bind_group_layout_entries.count, bind_group_layout_entries.data, "object uniforms");
		bind_group_layouts[0] = layout;
		bind_group_layout_descs[0] = desc;
	}
	// group 1 (camera uniforms)
	{
		bind_group_layout_entries := NewArray(1, WGPUBindGroupLayoutEntry);
		#if FREE_MEMORY defer array_reset(*bind_group_layout_entries);
		bind_group_layout_entries[0] = WGPUBindGroupLayoutEntry.{
			binding = 0,
			visibility = xx WGPUShaderStage.Vertex|WGPUShaderStage.Fragment,
			buffer = .{ type = WGPUBufferBindingType.Uniform },
		};
		layout, desc := wgpu_create_bind_group_layout(device, bind_group_layout_entries.count, bind_group_layout_entries.data, "camera uniforms");
		bind_group_layouts[1] = layout;
		bind_group_layout_descs[1] = desc;
	}
	// group 2 (SDF uniforms)
	{
		bind_group_layout_entries := NewArray(1, WGPUBindGroupLayoutEntry);
		#if FREE_MEMORY defer array_reset(*bind_group_layout_entries);
		bind_group_layout_entries[0] = WGPUBindGroupLayoutEntry.{
			binding = 0,
			visibility = xx WGPUShaderStage.Vertex|WGPUShaderStage.Fragment,
			buffer = .{ type = WGPUBufferBindingType.Uniform },
		};
		layout, desc := wgpu_create_bind_group_layout(device, bind_group_layout_entries.count, bind_group_layout_entries.data, "sdf uniforms");
		bind_group_layouts[2] = layout;
		bind_group_layout_descs[2] = desc;
	}
	//
	pipeline_layout_descriptor.label = "Main Pipeline Layout (only here to test that the label can be re-created in js from wasm)";
	pipeline_layout_descriptor.bindGroupLayoutCount = xx bind_group_layouts.count;
	pipeline_layout_descriptor.bindGroupLayouts = bind_group_layouts.data;

	pipeline_descriptor.layout = wgpuDeviceCreatePipelineLayout(device, *pipeline_layout_descriptor);
}

wgpu_create_bind_group_layout :: (device: WGPUDevice, entryCount: s64, data: *WGPUBindGroupLayoutEntry, label:string) -> WGPUBindGroupLayout, WGPUBindGroupLayoutDescriptor {
	desc :WGPUBindGroupLayoutDescriptor= .{
		label = to_c_string(label),
		entryCount = xx entryCount,
		entries = data,
	};
	bind_group_layout := wgpuDeviceCreateBindGroupLayout(device, *desc);
	return bind_group_layout, desc;
}


wgpu_create_shader_module :: (device: WGPUDevice, source: string, label: string) -> WGPUShaderModule {
	wgsl_descriptor := WGPUShaderModuleWGSLDescriptor.{
		chain = .{
			next = null,
			sType = .ShaderModuleWGSLDescriptor
		},
		code = to_c_string(source)
	};
	defer if FREE_MEMORY free(wgsl_descriptor.code);

	shader_module_descriptor := WGPUShaderModuleDescriptor.{
		nextInChain = xx *wgsl_descriptor,
		label = to_c_string(label),
	};
	defer if FREE_MEMORY free(shader_module_descriptor.label);

	return wgpuDeviceCreateShaderModule(device, *shader_module_descriptor);
}