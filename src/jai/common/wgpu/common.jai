WGPUContext :: struct {
	device: WGPUDevice;
	queue:WGPUQueue;
	preferred_texture_format :WGPUTextureFormat;
	surface: WGPUSurface; // this is the canvas heapIndex in wasm
	#if WASM==false {
		instance: WGPUInstance;
		adapter: WGPUAdapter; // only useful to keep around when releasing it
		config: WGPUSurfaceConfiguration;
		surface_texture :WGPUSurfaceTexture;
	}
	//
	use_msaa: bool=false;
	use_depth_buffer: bool=false;
	bg_color :WGPUColor =.{0.1, 0.3, 0.72, 1.0};
	//
	multisample_texture_descriptor : WGPUTextureDescriptor;
	multisample_texture: WGPUTexture;
	multisample_texture_view: *WGPUTextureView;
	//
	depth_texture: WGPUTexture;
	depth_texture_view: *WGPUTextureView;
};

ShadersContainer :: struct {
	render: string;
	compute: string;
}

wgpu_make_vertex_layout :: ($type: Type) -> WGPUVertexBufferLayout, []WGPUVertexAttribute {
	info := type_info(type);

	vertex_buffer_layout := WGPUVertexBufferLayout.{
		arrayStride=size_of(type),
		stepMode=.Vertex,
	};
	// print("vertex_buffer_layout:%\n", vertex_buffer_layout);

	vertex_attributes := NewArray(info.members.count, WGPUVertexAttribute);
	// defer array_reset(*vertex_attributes); // do not reset here, this will lead to corrupt data in wasm

	for info.members {
		vertex_attribute: WGPUVertexAttribute;

		if it.type.type == {
			case .BOOL;
				vertex_attribute.format = .Sint32;

			case .INTEGER;
				int_type_info := cast(*Type_Info_Integer) it.type;

				if int_type_info.signed {
					vertex_attribute.format = .Sint32;
				} else {
					vertex_attribute.format = .Uint32;
				}

			case .FLOAT;
				assert(it.type.runtime_size <= 4, "Only float32 is supported in Vertex Attribute Data.");
				vertex_attribute.format = .Float32;

			case .STRUCT;
				struct_type_info := cast(*Type_Info_Struct) it.type;

				if struct_type_info.name == {
					case "Vector4";
						vertex_attribute.format = .Float32x4;
					case "Vector3";
						vertex_attribute.format = .Float32x3;
					case "Vector2";
						vertex_attribute.format = .Float32x2;
					case;
						assert(false, tprint("Unsupported struct type (%). Only Vector2, Vector3, Vector4 are supported", struct_type_info.name));
				}

		}

		vertex_attribute.offset= xx it.offset_in_bytes;
		vertex_attribute.shaderLocation= xx it_index;
		vertex_attributes[it_index] = vertex_attribute;
	}

	vertex_buffer_layout.attributeCount = xx vertex_attributes.count;
	vertex_buffer_layout.attributes = vertex_attributes.data;

	return vertex_buffer_layout, vertex_attributes;
}

wgpu_fragment_state_prepare :: (
	fragment_state: *WGPUFragmentState,
	color_target_state: *WGPUColorTargetState,
	shader: WGPUShaderModule,
	preferred_texture_format:WGPUTextureFormat
){

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


wgpu_update_pipeline_descriptor_layout :: (pipeline_descriptor: *WGPURenderPipelineDescriptor, device: WGPUDevice) {
	pipeline_layout_descriptor: WGPUPipelineLayoutDescriptor;

	
	bind_group_layouts := NewArray(3, WGPUBindGroupLayout);
	#if FREE_MEMORY defer array_reset(*bind_group_layouts);

	// group 0 (object uniforms)
	{
		bind_group_layout_entries := NewArray(1, WGPUBindGroupLayoutEntry);
		#if FREE_MEMORY defer array_reset(*bind_group_layout_entries);
		bind_group_layout_entries[0] = WGPUBindGroupLayoutEntry.{
			binding = 0,
			visibility = xx WGPUShaderStage.Vertex,
			buffer = .{ type = WGPUBufferBindingType.Uniform },
		};
		// bind_group_layouts[0] = wgpuDeviceCreateBindGroupLayout(device, *(WGPUBindGroupLayoutDescriptor.{
		// 	entryCount = xx bind_group_layout_entries.count,
		// 	entries = bind_group_layout_entries.data,
		// }));
		bind_group_layouts[0] = wgpu_create_bind_group_layout(device, bind_group_layout_entries.count, bind_group_layout_entries.data);
		// print("0:%\n", cast(u64)bind_group_layouts[0]);
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
		// bind_group_layouts[1] = wgpuDeviceCreateBindGroupLayout(device, *(WGPUBindGroupLayoutDescriptor.{
		// 	entryCount = xx bind_group_layout_entries.count,
		// 	entries = bind_group_layout_entries.data,
		// }));
		bind_group_layouts[1] = wgpu_create_bind_group_layout(device, bind_group_layout_entries.count, bind_group_layout_entries.data);
		// print("1:%\n", cast(u64)bind_group_layouts[1]);
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
		// bind_group_layouts[2] = wgpuDeviceCreateBindGroupLayout(device, *(WGPUBindGroupLayoutDescriptor.{
		// 	entryCount = xx bind_group_layout_entries.count,
		// 	entries = bind_group_layout_entries.data,
		// }));
		bind_group_layouts[2] = wgpu_create_bind_group_layout(device, bind_group_layout_entries.count, bind_group_layout_entries.data);
		// print("2:%\n", cast(u64)bind_group_layouts[2]);
	}
	//
	pipeline_layout_descriptor.label = "Main Pipeline Layout (only here to test that the label can be re-created in js from wasm)";
	pipeline_layout_descriptor.bindGroupLayoutCount = xx bind_group_layouts.count;
	pipeline_layout_descriptor.bindGroupLayouts = bind_group_layouts.data;

	pipeline_descriptor.layout = wgpuDeviceCreatePipelineLayout(device, *pipeline_layout_descriptor);
}

wgpu_update_pipeline_descriptor :: (
	pipeline_descriptor: *WGPURenderPipelineDescriptor,
	// surface: WGPUSurface,
	// adapter: WGPUAdapter,
	device: WGPUDevice,
	shader: WGPUShaderModule,
	vertex_buffer_layout: *WGPUVertexBufferLayout,
	fragment_state: *WGPUFragmentState
) {
	// preferred_texture_format := WGPUSurfaceGetPreferredFormat(surface, adapter);

	// pipeline_descriptor: WGPURenderPipelineDescriptor;
	pipeline_descriptor.label = "Render Pipeline";

	// uniforms
	wgpu_update_pipeline_descriptor_layout(pipeline_descriptor, device);

	// vertex
	vertex_state: WGPUVertexState;
	vertex_state.module = shader;
	vertex_state.entryPoint = "vertex";
	vertex_state.bufferCount = 1;
	// tmp_layout := wasm_make_vertex_layout(vertex_buffer_layout_type);
	vertex_state.buffers = vertex_buffer_layout;//*Wasm_VertexBufferLayout_to_wgpu(tmp_layout);

	pipeline_descriptor.vertex = vertex_state;

	pipeline_descriptor.primitive = .{
		topology=.TriangleList,
		stripIndexFormat=.Undefined,
		// frontFace=.CCW,
		cullMode=.None,
	};
	
	// primitive: {
	// 		cullMode: "back",
	// 	},

	// pipeline_descriptor.multisample = .{
	// 	count = 1,
	// 	mask = 1,
	// 	alphaToCoverageEnabled = false,
	// };

	// color_target_state: WGPUColorTargetState;
	// color_target_state.format = preferred_texture_format;
	// color_target_state.blend = *(WGPUBlendState.{
	// 	color = .{ srcFactor = .One, dstFactor = .Zero, operation = .Add },
	// 	alpha = .{ srcFactor = .One, dstFactor = .Zero, operation = .Add },
	// });
	// color_target_state.writeMask = xx WGPUColorWriteMask.All;

	// fragment_state: WGPUFragmentState;
	// fragment_state.module = shader;
	// fragment_state.entryPoint = "fragment";
	// fragment_state.targetCount = 1;
	// fragment_state.targets = *color_target_state;

	pipeline_descriptor.fragment = fragment_state;

	// pipeline_descriptor.depthStencil = null;

}

wgpu_vertex_array_to_buffer :: (device: WGPUDevice, queue: WGPUQueue, vertices: []Vertex) -> WGPUBuffer, u64 {
	size := cast(u64) vertices.count * size_of(Vertex);

	// print("vertices:%\n",vertices);
	// print("vertices:%\n",cast([64]float) vertices.data);

	buffer_desc:WGPUBufferDescriptor = .{
		usage = xx (WGPUBufferUsage.Vertex | WGPUBufferUsage.CopyDst),
		size=size
	};
	buffer := wgpuDeviceCreateBuffer(device, *buffer_desc);
	assert(buffer != null, "Buffer is not created correctly");

	wgpuQueueWriteBuffer(queue, buffer, 0, vertices.data, size);

	return buffer, size;
}

wgpu_index_array_to_buffer :: (device: WGPUDevice, queue: WGPUQueue, indices: []VertexIndex) -> WGPUBuffer, u64 {
	size := cast(u64) indices.count * size_of(VertexIndex);

	buffer_desc:WGPUBufferDescriptor= .{
		usage = xx (WGPUBufferUsage.Index | WGPUBufferUsage.CopyDst),
		size=size
	};
	buffer := wgpuDeviceCreateBuffer(device, *buffer_desc);
	assert(buffer != null, "Buffer is not created correctly");

	wgpuQueueWriteBuffer(queue, buffer, 0, indices.data, size);

	return buffer, size;
}

wgpu_create_bind_group_layout :: (device: WGPUDevice, entryCount: s64, data: *WGPUBindGroupLayoutEntry) -> WGPUBindGroupLayout {
	bind_group_layout := wgpuDeviceCreateBindGroupLayout(device, *(WGPUBindGroupLayoutDescriptor.{
		entryCount = xx entryCount,
		entries = data,
	}));
	return bind_group_layout;
}

