ComputeControllerBoxCreateParams :: struct {
	size:BufferContainer;
	segments:BufferContainer;
}
ComputeControllerBoxCreateBindGroup :: struct {
	vertex: WGPUBindGroup;
}
ComputeControllerBoxCreateAttributes :: struct {
	position: BufferContainer;
}
#if MAP_BUFFER {
	ComputeControllerBoxCreateAttributesMapped :: struct {
		position: WGPUBuffer;
	}
}
ComputeControllerBoxCreate :: struct {
	#as using base: ComputeController;
	params: ComputeControllerBoxCreateParams;
	bind_group:ComputeControllerBoxCreateBindGroup;
	attributes:ComputeControllerBoxCreateAttributes;
	#if MAP_BUFFER {
		attributesMapped: ComputeControllerBoxCreateAttributesMapped;
	}
	// init :ComputeControllerInitMethod= box_create_init;
	// set_buffers:SetBufferMethod = box_create_set_buffers;
}



BoxCreateComputeControllerParams :: struct {
	size: Vector3=.{3.0, 1.0, 1.0};
	segments: Vector3Int = .{128, 128, 128};
}

registerComputeControllerBoxCreate :: () #compile_time {
	computeControllerRegister(CONTROLLER_TYPE);
}

computeControllerInit :: (controller: *CONTROLLER_TYPE, wgpuContext: *WGPUContext) {
	compute_controller_init(
		controller = controller,
		wgpuContext = wgpuContext,
		shader = SHADER_RAW,
		entry_point = SHADER_ENTRY_POINT,
		// methods = .{
		// 	// update_buffer = xx update_buffer,
		// 	set_bind_group = xx set_bind_group,
		// 	handle_mapped_buffers = xx handle_mapped_buffers,
		// 	entities_count = xx entities_count,
		// },
		params_bind_groups_count = 2
	);

	// controller.attributes.position = buffer_container;
	#if MAP_BUFFER {
		controller.attributesMapped.position = wgpuDeviceCreateBuffer(wgpuContext.device, *(WGPUBufferDescriptor.{
			label = "vertex buffer",
			usage = xx (WGPUBufferUsage.MapRead | WGPUBufferUsage.CopyDst),
			size = controller.attributes.position.buffer_size
		}));
		// controller.attributesMapped.position.buffer_size = controller.attributes.position.buffer_size;
	}

	box_size :Vector3= .{1, 1, 1};
	box_size_buffer_size := cast(u64) size_of(Vector3);
	box_segments :Vector3= .{1, 1, 1};
	box_segments_buffer_size := cast(u64) size_of(Vector3);

	//
	//
	// create a buffer on the GPU to hold our computation
	// input and output
	//
	//
	box_size_buffer := wgpuDeviceCreateBuffer(wgpuContext.device,*(WGPUBufferDescriptor.{
		label = "box size",
		usage = xx (WGPUBufferUsage.Storage | WGPUBufferUsage.CopySrc | WGPUBufferUsage.CopyDst),
		size = box_size_buffer_size
	}));
	controller.params.size.buffer = box_size_buffer;
	controller.params.size.buffer_size = box_size_buffer_size;
	
	box_segments_buffer := wgpuDeviceCreateBuffer(wgpuContext.device,*(WGPUBufferDescriptor.{
		label = "box segments",
		usage = xx (WGPUBufferUsage.Storage | WGPUBufferUsage.CopySrc | WGPUBufferUsage.CopyDst),
		size = box_segments_buffer_size
	}));
	controller.params.segments.buffer = box_segments_buffer;
	controller.params.segments.buffer_size = box_segments_buffer_size;


	//
	//
	//
	bind_group_params_entries :[2]WGPUBindGroupEntry;
	{
		bind_group_params_entries[0] = WGPUBindGroupEntry.{
			binding = 0,
			size = controller.params.size.buffer_size,
			offset = 0,
			buffer = controller.params.size.buffer,
		};
		bind_group_params_entries[1] = WGPUBindGroupEntry.{
			binding = 1,
			size = controller.params.segments.buffer_size,
			offset = 0,
			buffer = controller.params.segments.buffer,
		};
		bind_group_descriptor := WGPUBindGroupDescriptor.{
			label = "box create params",
			layout = wgpuComputePipelineGetBindGroupLayout(controller.pipeline, 0),
			entryCount = xx bind_group_params_entries.count,
			entries = bind_group_params_entries.data
		};
		controller.data_bind_group_size = wgpuDeviceCreateBindGroup(controller.wgpuContext.device, *bind_group_descriptor);
	}

	// controller.update_buffer(controller, scene);
}
computeControllerSetBuffers :: (controller: *CONTROLLER_TYPE, buffer_container: *BufferContainer) {
	bind_group_vertex_entries :[1]WGPUBindGroupEntry;
	{
		bind_group_vertex_entries[0] = WGPUBindGroupEntry.{
			binding = 0,
			size = buffer_container.buffer_size,
			offset = 0,
			buffer = buffer_container.buffer,
		};
		bind_group_descriptor := WGPUBindGroupDescriptor.{
			label = "bind_group_attributes",
			layout = wgpuComputePipelineGetBindGroupLayout(controller.pipeline, 1),
			entryCount = xx bind_group_vertex_entries.count,
			entries = bind_group_vertex_entries.data
		};
		controller.bind_group.vertex = wgpuDeviceCreateBindGroup(controller.wgpuContext.device, *bind_group_descriptor);
	}

}


setBindGroup :: (controller: *CONTROLLER_TYPE, compute_pass_encoder: *WGPUComputePassEncoder, command_encoder: *WGPUCommandEncoder){
	wgpuComputePassEncoderSetBindGroup(<<compute_pass_encoder, 1, controller.bind_group.vertex, 0, null);

	#if MAP_BUFFER {
		// Encode a command to copy the results to a mappable buffer.
		wgpuCommandEncoderCopyBufferToBuffer(<<command_encoder, controller.attributes.position.buffer, 0, controller.attributesMapped.position, 0, controller.attributes.position.buffer_size);
	}
}
handleMappedBuffers :: (controller: *CONTROLLER_TYPE) {
	#if MAP_BUFFER {
		wgpuBufferMapAsync(controller.attributesMapped.position, xx WGPUMapMode.Read, 0, controller.attributes.position.buffer_size, wgpu_compute_buffer_map_async_callback, null);
		wgpuDevicePoll(controller.wgpuContext.device, xx true, null);
		// result_values := /*cast(ResultType)*/ 
		wgpuBufferGetMappedRange(controller.attributesMapped.position, 0, controller.attributes.position.buffer_size);

		//
		// print_green(tprint("pipeline created:%\n", controller.pipeline));
		// print("result_values:%\n", cast([64]float)result_values);

		wgpuBufferUnmap(controller.attributesMapped.position);
	}
}
entitiesCount :: (controller: *CONTROLLER_TYPE)-> u64 {
	print("NOT IMPLEMENTED\n");
	return 0;
}
updateBuffer :: (controller:*CONTROLLER_TYPE, params:*BoxCreateComputeControllerParams){
	{
		// size_float: [3]float = .[scene_data.box_size.x, scene_data.box_size.y, scene_data.box_size.z];
		wgpuQueueWriteBuffer(controller.wgpuContext.queue, controller.params.size.buffer, 0, *params.size, controller.params.size.buffer_size);
	}

	{
		// segments_float: [3]float = .[xx scene_data.segments.x, xx scene_data.segments.y, xx scene_data.segments.z];
		wgpuQueueWriteBuffer(controller.wgpuContext.queue, controller.params.segments.buffer, 0, *params.segments, controller.params.segments.buffer_size);
	}
};



#scope_file

CONTROLLER_TYPE :: ComputeControllerBoxCreate;
SHADER_ENTRY_POINT :: "boxCreate";
SHADER_RAW :: #run import_shader();
import_shader :: () -> string { return "box_create.wgsl"; };

// SetBufferMethod :: #type (controller: *CONTROLLER_TYPE, buffer_container: *BufferContainer);




