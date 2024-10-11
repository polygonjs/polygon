// ComputeControllerNoiseParams :: struct {
// 	freq:BufferContainer;
// 	offset:BufferContainer;
// 	amount:BufferContainer;
// }
// ComputeControllerNoiseBindGroup :: struct {
// 	attributes: WGPUBindGroup;
// }
// ComputeControllerNoiseAttributes :: struct {
// 	position_in: BufferContainer;
// 	normal_in: BufferContainer;
// 	position_out: BufferContainer;
// }
// #if MAP_BUFFER {
// 	ComputeControllerNoiseAttributesMapped :: struct {
// 		position: WGPUBuffer;
// 	}
// }
// ComputeControllerNoise :: struct {
// 	#as using base: ComputeController;
// 	params:ComputeControllerNoiseParams;
// 	bind_group:ComputeControllerNoiseBindGroup;
// 	attributes:ComputeControllerNoiseAttributes;
// 	#if MAP_BUFFER {
// 		attributesMapped: ComputeControllerNoiseAttributesMapped;
// 	}
// }

// compute_controller_noise_init :: (controller: *CONTROLLER_TYPE, wgpu_context: *WGPUContext, scene_data: *SceneData) {
// 	compute_controller_init(
// 		controller = controller,
// 		wgpu_context = wgpu_context,
// 		shader = SHADER_COMPUTE_NOISE,
// 		entry_point = "noise",
// 		params_bind_groups_count = 3,
// 		attributes_bind_groups_count = 3,
// 		compute_controller_label = "compute controller noise"
// 	);

// 	// controller.attributes.position = buffer_container;
// 	#if MAP_BUFFER {
// 		controller.attributesMapped.position = wgpuDeviceCreateBuffer(wgpu_context.device, *(WGPUBufferDescriptor.{
// 			label = "vertex buffer",
// 			usage = xx (WGPUBufferUsage.MapRead | WGPUBufferUsage.CopyDst),
// 			size = controller.attributes.position_in.buffer_size
// 		}));
// 		// controller.attributesMapped.position.buffer_size = controller.attributes.position.buffer_size;
// 	}

// 	freq :Vector3= .{1, 1, 1};
// 	freq_buffer_size := cast(u64) size_of(Vector3);
// 	offset :Vector3= .{0, 0, 0};
// 	offset_buffer_size := cast(u64) size_of(Vector3);
// 	amount :Vector3= .{1, 1, 1};
// 	amount_buffer_size := cast(u64) size_of(Vector3);

// 	//
// 	//
// 	// create a buffer on the GPU to hold our computation
// 	// input and output
// 	//
// 	//
// 	freq_buffer := wgpuDeviceCreateBuffer(wgpu_context.device,*(WGPUBufferDescriptor.{
// 		label = "freq",
// 		usage = xx (WGPUBufferUsage.Storage | WGPUBufferUsage.CopySrc | WGPUBufferUsage.CopyDst),
// 		size = freq_buffer_size
// 	}));
// 	controller.params.freq = .{buffer = freq_buffer, buffer_size = freq_buffer_size};

// 	offset_buffer := wgpuDeviceCreateBuffer(wgpu_context.device,*(WGPUBufferDescriptor.{
// 		label = "offset",
// 		usage = xx (WGPUBufferUsage.Storage | WGPUBufferUsage.CopySrc | WGPUBufferUsage.CopyDst),
// 		size = offset_buffer_size
// 	}));
// 	controller.params.offset = .{buffer = offset_buffer, buffer_size = offset_buffer_size};

// 	amount_buffer := wgpuDeviceCreateBuffer(wgpu_context.device,*(WGPUBufferDescriptor.{
// 		label = "amount",
// 		usage = xx (WGPUBufferUsage.Storage | WGPUBufferUsage.CopySrc | WGPUBufferUsage.CopyDst),
// 		size = amount_buffer_size
// 	}));
// 	controller.params.amount = .{buffer = amount_buffer, buffer_size = amount_buffer_size};


// 	//
// 	//
// 	//
// 	bind_group_params_entries :[3]WGPUBindGroupEntry;
// 	{
// 		bind_group_params_entries[0] = WGPUBindGroupEntry.{
// 			binding = 0,
// 			size = controller.params.freq.buffer_size,
// 			offset = 0,
// 			buffer = controller.params.freq.buffer,
// 		};
// 		bind_group_params_entries[1] = WGPUBindGroupEntry.{
// 			binding = 1,
// 			size = controller.params.offset.buffer_size,
// 			offset = 0,
// 			buffer = controller.params.offset.buffer,
// 		};
// 		bind_group_params_entries[2] = WGPUBindGroupEntry.{
// 			binding = 2,
// 			size = controller.params.amount.buffer_size,
// 			offset = 0,
// 			buffer = controller.params.amount.buffer,
// 		};
// 		bind_group_descriptor := WGPUBindGroupDescriptor.{
// 			label = "noise params",
// 			layout = wgpuComputePipelineGetBindGroupLayout(controller.pipeline, 0),
// 			entryCount = xx bind_group_params_entries.count,
// 			entries = bind_group_params_entries.data
// 		};
// 		controller.data_bind_group_size = wgpuDeviceCreateBindGroup(wgpu_context.device, *bind_group_descriptor);
// 	}

// 	compute_controller_update_buffer_noise(controller, scene_data);
// }

// compute_controller_noise_set_buffer :: (controller: *CONTROLLER_TYPE, position_in: *BufferContainer, normal_in: *BufferContainer, position_out: *BufferContainer) {
// 	controller.attributes.position_in = position_in;
// 	controller.attributes.normal_in = normal_in;
// 	controller.attributes.position_out = position_out;

// 	//
// 	//
// 	//
// 	bind_group_vertex_entries :[3]WGPUBindGroupEntry;
// 	{
// 		bind_group_vertex_entries[0] = WGPUBindGroupEntry.{
// 			binding = 0,
// 			size = position_in.buffer_size,
// 			offset = 0,
// 			buffer = position_in.buffer,
// 			// label = "position in"
// 		};
// 		bind_group_vertex_entries[1] = WGPUBindGroupEntry.{
// 			binding = 1,
// 			size = normal_in.buffer_size,
// 			offset = 0,
// 			buffer = normal_in.buffer,
// 			// label = "position out"
// 		};
// 		bind_group_vertex_entries[2] = WGPUBindGroupEntry.{
// 			binding = 2,
// 			size = position_out.buffer_size,
// 			offset = 0,
// 			buffer = position_out.buffer,
// 			// label = "position out"
// 		};
// 		bind_group_descriptor := WGPUBindGroupDescriptor.{
// 			label = "bind_group_attributes",
// 			layout = wgpuComputePipelineGetBindGroupLayout(controller.pipeline, 1),
// 			entryCount = xx bind_group_vertex_entries.count,
// 			entries = bind_group_vertex_entries.data
// 		};
// 		controller.bind_group.attributes = wgpuDeviceCreateBindGroup(controller.wgpu_context.device, *bind_group_descriptor);
// 	}
// }

// compute_controller_update_buffer_noise :: (controller:*CONTROLLER_TYPE, scene_data:*SceneData){
// 	wgpuQueueWriteBuffer(controller.wgpu_context.queue, controller.params.freq.buffer, 0, *scene_data.noise.freq, controller.params.freq.buffer_size);
// 	wgpuQueueWriteBuffer(controller.wgpu_context.queue, controller.params.offset.buffer, 0, *scene_data.noise.offset, controller.params.offset.buffer_size);
// 	wgpuQueueWriteBuffer(controller.wgpu_context.queue, controller.params.amount.buffer, 0, *scene_data.noise.amount, controller.params.amount.buffer_size);
// };

// compute_controller_set_bind_group_noise :: (controller: *CONTROLLER_TYPE, compute_pass_encoder: *WGPUComputePassEncoder, command_encoder: *WGPUCommandEncoder){
// 	wgpuComputePassEncoderSetBindGroup(<<compute_pass_encoder, 1, controller.bind_group.attributes, 0, null);

// 	#if MAP_BUFFER {
// 		// Encode a command to copy the results to a mappable buffer.
// 		wgpuCommandEncoderCopyBufferToBuffer(<<command_encoder, controller.attributes.position.buffer, 0, controller.attributesMapped.position, 0, controller.attributes.position.buffer_size);
// 	}
// }

// compute_controller_handle_mapped_buffers_noise :: (controller: *CONTROLLER_TYPE) {
// 	#if MAP_BUFFER {
// 		wgpuBufferMapAsync(controller.attributesMapped.position, xx WGPUMapMode.Read, 0, controller.attributes.position.buffer_size, wgpu_compute_buffer_map_async_callback, null);
// 		wgpuDevicePoll(controller.wgpu_context.device, xx true, null);
// 		// result_values := /*cast(ResultType)*/ 
// 		wgpuBufferGetMappedRange(controller.attributesMapped.position, 0, controller.attributes.position.buffer_size);

// 		//
// 		// print_green(tprint("pipeline created:%\n", controller.pipeline));
// 		// print("result_values:%\n", cast([64]float)result_values);

// 		wgpuBufferUnmap(controller.attributesMapped.position);
// 	}
// }
// compute_controller_points_count_noise :: (controller: *CONTROLLER_TYPE)-> u64 {
// 	return controller.attributes.position_in.buffer_size / size_of(Vector3);
// }

// #scope_file

// CONTROLLER_TYPE :: ComputeControllerNoise;