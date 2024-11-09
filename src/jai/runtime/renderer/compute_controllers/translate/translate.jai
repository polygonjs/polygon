ComputeControllerTranslateParams :: struct {
	translate:BufferContainer;
}
ComputeControllerTranslateBindGroup :: struct {
	attributes: WGPUBindGroup;
}
ComputeControllerTranslateAttributes :: struct {
	position_in: BufferContainer;
	position_out: BufferContainer;
}
#if MAP_BUFFER {
	ComputeControllerTranslateAttributesMapped :: struct {
		position: WGPUBuffer;
	}
}
ComputeControllerTranslate :: struct {
	#as using base: ComputeController;
	params:ComputeControllerTranslateParams;
	bind_group:ComputeControllerTranslateBindGroup;
	attributes:ComputeControllerTranslateAttributes;
	#if MAP_BUFFER {
		attributesMapped: ComputeControllerTranslateAttributesMapped;
	}
	init :ComputeControllerInitMethod= init_translate;
}
TranslateComputeControllerParams :: struct {
	translate: Vector3=.{0.0, 0.0, 0.0};
}

compute_controller_translate_set_buffer :: (controller: *CONTROLLER_TYPE, position_in: *BufferContainer, position_out: *BufferContainer) {
	controller.attributes.position_in = position_in;
	controller.attributes.position_out = position_out;

	//
	//
	//
	bind_group_vertex_entries :[2]WGPUBindGroupEntry;
	{
		bind_group_vertex_entries[0] = WGPUBindGroupEntry.{
			binding = 0,
			size = position_in.buffer_size,
			offset = 0,
			buffer = position_in.buffer,
			// label = "position in"
		};
		bind_group_vertex_entries[1] = WGPUBindGroupEntry.{
			binding = 1,
			size = position_out.buffer_size,
			offset = 0,
			buffer = position_out.buffer,
			// label = "position out"
		};
		bind_group_descriptor := WGPUBindGroupDescriptor.{
			label = "bind_group_attributes",
			layout = wgpuComputePipelineGetBindGroupLayout(controller.pipeline, 1),
			entryCount = xx bind_group_vertex_entries.count,
			entries = bind_group_vertex_entries.data
		};
		controller.bind_group.attributes = wgpuDeviceCreateBindGroup(controller.wgpu_context.device, *bind_group_descriptor);
	}
}







#scope_file

CONTROLLER_TYPE :: ComputeControllerTranslate;
SHADER_ENTRY_POINT :: "translate";
SHADER_RAW :: #run import_shader();
import_shader :: () -> string { return "translate.wgsl"; };


init_translate :: (_controller: *ComputeController, wgpu_context: *WGPUContext, scene: *Scene) {
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
		attributes_bind_groups_count = 2,
		compute_controller_label = "compute controller translate"
	);

	// controller.attributes.position = buffer_container;
	#if MAP_BUFFER {
		controller.attributesMapped.position = wgpuDeviceCreateBuffer(wgpu_context.device, *(WGPUBufferDescriptor.{
			label = "vertex buffer",
			usage = xx (WGPUBufferUsage.MapRead | WGPUBufferUsage.CopyDst),
			size = controller.attributes.position_in.buffer_size
		}));
		// controller.attributesMapped.position.buffer_size = controller.attributes.position.buffer_size;
	}

	translate :Vector3= .{-1, -1, 0};
	translate_buffer_size := cast(u64) size_of(Vector3);

	//
	//
	// create a buffer on the GPU to hold our computation
	// input and output
	//
	//
	translate_buffer := wgpuDeviceCreateBuffer(wgpu_context.device,*(WGPUBufferDescriptor.{
		label = "translate",
		usage = xx (WGPUBufferUsage.Storage | WGPUBufferUsage.CopySrc | WGPUBufferUsage.CopyDst),
		size = translate_buffer_size
	}));
	controller.params.translate.buffer = translate_buffer;
	controller.params.translate.buffer_size = translate_buffer_size;


	//
	//
	//
	bind_group_params_entries :[1]WGPUBindGroupEntry;
	{
		bind_group_params_entries[0] = WGPUBindGroupEntry.{
			binding = 0,
			size = controller.params.translate.buffer_size,
			offset = 0,
			buffer = controller.params.translate.buffer,
			// label = "translate offset"
		};
		bind_group_descriptor := WGPUBindGroupDescriptor.{
			label = "translate params",
			layout = wgpuComputePipelineGetBindGroupLayout(controller.pipeline, 0),
			entryCount = xx bind_group_params_entries.count,
			entries = bind_group_params_entries.data
		};
		controller.data_bind_group_size = wgpuDeviceCreateBindGroup(wgpu_context.device, *bind_group_descriptor);
	}

	controller.update_buffer(controller, scene);
}

update_buffer :: (controller:*CONTROLLER_TYPE, params:*TranslateComputeControllerParams){
	{
		// size_float: [3]float = .[scene_data.translate.x, scene_data.translate.y, scene_data.translate.z];
		// print("size_float:%\n",scene_data.translate.x);
		wgpuQueueWriteBuffer(controller.wgpu_context.queue, controller.params.translate.buffer, 0, *params.translate, controller.params.translate.buffer_size);
	}
};

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
	return controller.attributes.position_in.buffer_size / size_of(Vector3);
}
