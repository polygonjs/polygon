ComputeControllerComputeNormalsParams :: struct {
}
ComputeControllerComputeNormalsBindGroup :: struct {
	attributes: WGPUBindGroup;
}
ComputeControllerComputeNormalsAttributes :: struct {
	position_in: BufferContainer;
	index_in: BufferContainer;
	normal_out: BufferContainer;
}
#if MAP_BUFFER {
	ComputeControllerComputeNormalsAttributesMapped :: struct {
		position: WGPUBuffer;
	}
}
ComputeControllerComputeNormals :: struct {
	#as using base: ComputeController;
	params:ComputeControllerComputeNormalsParams;
	bind_group:ComputeControllerComputeNormalsBindGroup;
	attributes:ComputeControllerComputeNormalsAttributes;
	#if MAP_BUFFER {
		attributesMapped: ComputeControllerComputeNormalsAttributesMapped;
	}
	// init :ComputeControllerInitMethod= compute_normals_init;
	// set_buffers: SetBufferMethod = compute_normals_set_buffer;
}


registerComputeControllerComputeNormals :: () {
	computeControllerRegister(CONTROLLER_TYPE);
}

computeControllerInit :: (controller: *CONTROLLER_TYPE, wgpu_context: *WGPUContext) {
	compute_controller_init(
		controller = controller,
		wgpu_context = wgpu_context,
		shader = SHADER_RAW,
		entry_point = SHADER_ENTRY_POINT,
		// methods = .{
		// 	// update_buffer = xx update_buffer,
		// 	set_bind_group = xx set_bind_group,
		// 	handle_mapped_buffers = xx handle_mapped_buffers,
		// 	entities_count = xx entities_count,
		// },
		params_bind_groups_count = 0,
		attributes_bind_groups_count = 3,
		compute_controller_label = "compute controller compute normals"
	);
	// controller.set_buffers = compute_normals_set_buffer;

	// controller.attributes.position = buffer_container;
	#if MAP_BUFFER {
		controller.attributesMapped.position = wgpuDeviceCreateBuffer(wgpu_context.device, *(WGPUBufferDescriptor.{
			label = "vertex buffer",
			usage = xx (WGPUBufferUsage.MapRead | WGPUBufferUsage.CopyDst),
			size = controller.attributes.position_in.buffer_size
		}));
		// controller.attributesMapped.position.buffer_size = controller.attributes.position.buffer_size;
	}


	//
	//
	//
	bind_group_params_entries :[0]WGPUBindGroupEntry;
	{
		bind_group_descriptor := WGPUBindGroupDescriptor.{
			label = "compute normals params",
			layout = wgpuComputePipelineGetBindGroupLayout(controller.pipeline, 0),
			entryCount = xx bind_group_params_entries.count,
			entries = bind_group_params_entries.data
		};
		controller.data_bind_group_size = wgpuDeviceCreateBindGroup(wgpu_context.device, *bind_group_descriptor);
	}

	// controller.update_buffer(controller, scene);
}

computeControllerSetBuffers :: (controller: *CONTROLLER_TYPE, position_in: *BufferContainer, index_in: *BufferContainer, normal_out: *BufferContainer) {
	controller.attributes.position_in = position_in;
	controller.attributes.index_in = index_in;
	controller.attributes.normal_out = normal_out;

	//
	//
	//
	bind_group_vertex_entries :[3]WGPUBindGroupEntry;
	{
		bind_group_vertex_entries[0] = buffer_container_to_bind_group_entry(position_in, 0);
		bind_group_vertex_entries[1] = buffer_container_to_bind_group_entry(index_in, 1);
		bind_group_vertex_entries[2] = buffer_container_to_bind_group_entry(normal_out, 2);
		bind_group_descriptor := WGPUBindGroupDescriptor.{
			label = "bind_group_attributes compute normals",
			layout = wgpuComputePipelineGetBindGroupLayout(controller.pipeline, 1),
			entryCount = xx bind_group_vertex_entries.count,
			entries = bind_group_vertex_entries.data
		};
		controller.bind_group.attributes = wgpuDeviceCreateBindGroup(controller.wgpu_context.device, *bind_group_descriptor);
	}
}




// update_buffer :: (controller:*CONTROLLER_TYPE, scene:*Scene){};
setBindGroup :: (controller: *CONTROLLER_TYPE, compute_pass_encoder: *WGPUComputePassEncoder, command_encoder: *WGPUCommandEncoder){
	wgpuComputePassEncoderSetBindGroup(<<compute_pass_encoder, 1, controller.bind_group.attributes, 0, null);

	#if MAP_BUFFER {
		// Encode a command to copy the results to a mappable buffer.
		wgpuCommandEncoderCopyBufferToBuffer(<<command_encoder, controller.attributes.position.buffer, 0, controller.attributesMapped.position, 0, controller.attributes.position.buffer_size);
	}
}
handleMappedBuffers :: (controller: *CONTROLLER_TYPE) {
	#if MAP_BUFFER {
		wgpuBufferMapAsync(controller.attributesMapped.position, xx WGPUMapMode.Read, 0, controller.attributes.position.buffer_size, wgpu_compute_buffer_map_async_callback, null);
		wgpuDevicePoll(controller.wgpu_context.device, xx true, null);
		// result_values := /*cast(ResultType)*/ 
		wgpuBufferGetMappedRange(controller.attributesMapped.position, 0, controller.attributes.position.buffer_size);

		//
		// print_green(tprint("pipeline created:%\n", controller.pipeline));
		// print("result_values:%\n", cast([64]float)result_values);

		wgpuBufferUnmap(controller.attributesMapped.position);
	}
}
entitiesCount :: (controller: *CONTROLLER_TYPE)-> u64 {
	faces_count := (controller.attributes.index_in.buffer_size / size_of(VertexIndex)) / 3;
	return faces_count;
}




#scope_file

CONTROLLER_TYPE :: ComputeControllerComputeNormals;
SHADER_ENTRY_POINT :: "computeNormals";
SHADER_RAW :: #run import_shader();
import_shader :: () -> string { return "compute_normals.wgsl"; };

// SetBufferMethod :: #type (controller: *CONTROLLER_TYPE, position_in: *BufferContainer, index_in: *BufferContainer, normal_out: *BufferContainer);
