ComputeControllerAttributeNormalizeParams :: struct {
}
ComputeControllerAttributeNormalizeBindGroup :: struct {
	attributes: WGPUBindGroup;
}
ComputeControllerAttributeNormalizeAttributes :: struct {
	attribute_in: BufferContainer;
	attribute_out: BufferContainer;
}
#if MAP_BUFFER {
	ComputeControllerAttributeNormalizeAttributesMapped :: struct {
		position: WGPUBuffer;
	}
}
ComputeControllerAttributeNormalize :: struct {
	#as using base: ComputeController;
	params:ComputeControllerAttributeNormalizeParams;
	bind_group:ComputeControllerAttributeNormalizeBindGroup;
	attributes:ComputeControllerAttributeNormalizeAttributes;
	#if MAP_BUFFER {
		attributesMapped: ComputeControllerAttributeNormalizeAttributesMapped;
	}
	init :ComputeControllerInitMethod= attribute_normalize_init;
	set_buffers: SetBufferMethod = attribute_normalize_set_buffer;
}










#scope_file

CONTROLLER_TYPE :: ComputeControllerAttributeNormalize;
SHADER_ENTRY_POINT :: "attributeNormalize";
SHADER_RAW :: #run import_shader();
import_shader :: () -> string { return "attribute_normalize.wgsl"; };

SetBufferMethod :: #type (controller: *CONTROLLER_TYPE, attribute_in: *BufferContainer, attribute_out: *BufferContainer);

attribute_normalize_init :: (_controller: *ComputeController, wgpu_context: *WGPUContext, scene_data: *SceneData) {
	controller := cast(*CONTROLLER_TYPE) _controller;
	compute_controller_init(
		controller = controller,
		wgpu_context = wgpu_context,
		shader = SHADER_RAW,
		entry_point = SHADER_ENTRY_POINT,
		methods = .{
			update_buffer = xx update_buffer,
			set_bind_group = xx set_bind_group,
			handle_mapped_buffers = xx handle_mapped_buffers,
			entities_count = xx entities_count,
		},
		params_bind_groups_count = 0,
		attributes_bind_groups_count = 2,
		compute_controller_label = "compute controller attribute set"
	);
	controller.set_buffers = attribute_normalize_set_buffer;

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
			label = "attribute normalize params",
			layout = wgpuComputePipelineGetBindGroupLayout(controller.pipeline, 0),
			entryCount = xx bind_group_params_entries.count,
			entries = bind_group_params_entries.data
		};
		controller.data_bind_group_size = wgpuDeviceCreateBindGroup(wgpu_context.device, *bind_group_descriptor);
	}

	controller.update_buffer(controller, scene_data);
}

attribute_normalize_set_buffer :: (controller: *CONTROLLER_TYPE, attribute_in: *BufferContainer, attribute_out: *BufferContainer) {

	controller.attributes.attribute_in = attribute_in;
	controller.attributes.attribute_out = attribute_out;

	//
	//
	//
	bind_group_vertex_entries :[2]WGPUBindGroupEntry;
	{
		bind_group_vertex_entries[0] = buffer_container_to_bind_group_entry(attribute_in, 0);
		bind_group_vertex_entries[1] = buffer_container_to_bind_group_entry(attribute_out, 1);
		bind_group_descriptor := WGPUBindGroupDescriptor.{
			label = "bind_group_attributes attribute normalize",
			layout = wgpuComputePipelineGetBindGroupLayout(controller.pipeline, 1),
			entryCount = xx bind_group_vertex_entries.count,
			entries = bind_group_vertex_entries.data
		};
		controller.bind_group.attributes = wgpuDeviceCreateBindGroup(controller.wgpu_context.device, *bind_group_descriptor);
	}
}


update_buffer :: (controller:*CONTROLLER_TYPE, scene_data:*SceneData){};
set_bind_group :: (controller: *CONTROLLER_TYPE, compute_pass_encoder: *WGPUComputePassEncoder, command_encoder: *WGPUCommandEncoder){
	wgpuComputePassEncoderSetBindGroup(<<compute_pass_encoder, 1, controller.bind_group.attributes, 0, null);

	#if MAP_BUFFER {
		// Encode a command to copy the results to a mappable buffer.
		wgpuCommandEncoderCopyBufferToBuffer(<<command_encoder, controller.attributes.position.buffer, 0, controller.attributesMapped.position, 0, controller.attributes.position.buffer_size);
	}
}
handle_mapped_buffers :: (controller: *CONTROLLER_TYPE) {
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
entities_count :: (controller: *CONTROLLER_TYPE)-> u64 {
	return controller.attributes.attribute_out.buffer_size / size_of(Vector3);
}