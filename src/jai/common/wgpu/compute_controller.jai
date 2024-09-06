// TODO: there are lots of wgpu things to release here





ComputeShaderControllerBindGroup :: struct {
	data_size:WGPUBindGroup;
	vertex:WGPUBindGroup;
}

ComputeShaderController :: struct {
	wgpu_context: *WGPUContext;
	work_groups_count:Vector3;
	vertex:BufferContainer;
	// release:(this:ComputeShaderController);
	// private
	// queue:WGPUQueue;
	data:BufferContainer;
	// encoder: WGPUComputePassEncoder;
	// command_buffer: WGPUCommandBuffer;
	// commands_count: u32;
	pipeline:WGPUComputePipeline;
	// for release
	// compute_pass_encoder: WGPUComputePassEncoder;
	// command_encoder: WGPUCommandEncoder;
	bind_group:ComputeShaderControllerBindGroup;
	#if MAP_BUFFER {
		vertex_buffer_map: WGPUBuffer;
	}
}

// this is an alternative version to replace() from the String module,
// that reset the segments array after the join,
// as otherwise we have a memory leak
// TODO: could there be a faster implementation for the case where we only need to replace a single instance of the string?
// I could actually replace the characters of the string in place, even if that leaves empty spaces:
// "__WORK_GROUP_SIZE_X__" -> "   3                  "
replace_with_array_reset :: (s: string, old: string, new: string) -> string {
	segments := split(s, old);
	result := join(..segments, new);
	array_reset(*segments);
	return result;
}

build_compute_shader :: (shader0:string, work_group_size:Vector3) -> string {
	work_group_count := work_group_size.x * work_group_size.y * work_group_size.z;

	shader1 := replace_with_array_reset(shader0, "__WORK_GROUP_SIZE_X__", tprint("%", work_group_size.x));
	defer free(shader1);
	shader2 := replace_with_array_reset(shader1, "__WORK_GROUP_SIZE_Y__", tprint("%", work_group_size.y));
	defer free(shader2);
	shader3 := replace_with_array_reset(shader2, "__WORK_GROUP_SIZE_Z__", tprint("%", work_group_size.z));
	defer free(shader3);
	shader4 := replace_with_array_reset(shader3, "__WORK_GROUP_COUNT__", tprint("%", work_group_count));

	return shader4;
}

// buffer_container_create :: (wgpu_context: *WGPUContext, size:u64, label:string) -> BufferContainer {
// 	#if MAP_BUFFER {
// 		vertex_buffer_usage := WGPUBufferUsage.Storage | WGPUBufferUsage.CopySrc | WGPUBufferUsage.CopyDst | WGPUBufferUsage.Vertex;
// 	} else {
// 		vertex_buffer_usage := WGPUBufferUsage.Storage | WGPUBufferUsage.CopyDst | WGPUBufferUsage.Vertex;
// 	}
// 	label_c := to_c_string(label);
// 	defer free(label_c);
// 	buffer := wgpuDeviceCreateBuffer(wgpu_context.device, *(WGPUBufferDescriptor.{
// 		label = label_c,
// 		usage = xx vertex_buffer_usage,
// 		size = size
// 	}));

// 	container :BufferContainer = .{
// 		buffer = buffer,
// 		buffer_size = size,
// 	};
// 	return container;
// }

// InputType :: [3]float;
// ResultType :: [64]float;
compute_shader_controller_create :: (wgpu_context: *WGPUContext, shader_compute_raw: string, entry_point:string, buffer_container:BufferContainer) -> ComputeShaderController {
	controller: ComputeShaderController = .{
		wgpu_context = wgpu_context,
		// queue = queue,
		work_groups_count = .{1, 1, 1},
		bind_group = .{}
	};
	// device := wgpu_context.device;

	box_size :[3]float= .[2, 1, 1];
	box_size_buffer_size := cast(u64) size_of(type_of(box_size));//cast(u64) input.count * size_of(float);
	// print("entry_point:%\n", entry_point);
	// print("shader_compute_raw:%\n", shader_compute_raw);

	// work_groups_count :Vector3= .{1, 1, 1};
	// work_groups_count_total :u32= cast(u32)(work_groups_count.x)*cast(u32)(work_groups_count.y)*cast(u32)(work_groups_count.z);
	shader_compute := build_compute_shader(shader_compute_raw, controller.work_groups_count);
	defer free(shader_compute);
	entry_point_c := to_c_string(entry_point);
	defer free(entry_point_c);

	// create shader module
	wgslDescriptor: WGPUShaderModuleWGSLDescriptor;
	wgslDescriptor.chain.next = null;
	wgslDescriptor.chain.sType=.ShaderModuleWGSLDescriptor;
	wgslDescriptor.code = to_c_string(shader_compute);
	#if FREE_MEMORY defer free(wgslDescriptor.code);

	// shaderModuleDescriptor: WGPUShaderModuleDescriptor = .{
	// 	label = "compute shader"
	// };
	label := "compute shader";
	shaderModuleDescriptor: WGPUShaderModuleDescriptor;
	shaderModuleDescriptor.label = to_c_string(label);
	#if FREE_MEMORY defer free(shaderModuleDescriptor.label);
	shaderModuleDescriptor.nextInChain = xx *wgslDescriptor;
	shader_module := wgpuDeviceCreateShaderModule(wgpu_context.device, *shaderModuleDescriptor);

	// create pipeline
	
	bind_group_layouts := NewArray(2, WGPUBindGroupLayout);
	#if FREE_MEMORY defer array_reset(*bind_group_layouts);
	// group 0
	bind_group_layout_entries0 := NewArray(1, WGPUBindGroupLayoutEntry);
	#if FREE_MEMORY defer array_reset(*bind_group_layout_entries0);
	{
		bind_group_layout_entries0[0] = WGPUBindGroupLayoutEntry.{
			binding = 0,
			visibility = xx WGPUShaderStage.Compute,
			buffer = .{ type = WGPUBufferBindingType.Storage }, // should be storage, not uniform like in render pipeline
		};
		bind_group_layouts[0] = wgpuDeviceCreateBindGroupLayout(wgpu_context.device, *(WGPUBindGroupLayoutDescriptor.{
			entryCount = xx bind_group_layout_entries0.count,
			entries = bind_group_layout_entries0.data,
		}));
	}
	// group 1
	bind_group_layout_entries1 := NewArray(1, WGPUBindGroupLayoutEntry);
	#if FREE_MEMORY defer array_reset(*bind_group_layout_entries1);
	{
		bind_group_layout_entries1[0] = WGPUBindGroupLayoutEntry.{
			binding = 0,
			visibility = xx WGPUShaderStage.Compute,
			buffer = .{ type = WGPUBufferBindingType.Storage }, // should be storage, not uniform like in render pipeline
		};
		bind_group_layouts[1] = wgpuDeviceCreateBindGroupLayout(wgpu_context.device, *(WGPUBindGroupLayoutDescriptor.{
			entryCount = xx bind_group_layout_entries1.count,
			entries = bind_group_layout_entries1.data,
		}));
	}

	compute_descriptor:WGPUProgrammableStageDescriptor = .{
		entryPoint = entry_point_c, // this crashes if not present
		module = shader_module,
	};
	compute_layout_desc:WGPUPipelineLayoutDescriptor;
	compute_layout_desc.bindGroupLayoutCount = xx bind_group_layouts.count;
	compute_layout_desc.bindGroupLayouts = bind_group_layouts.data;
	compute_layout := wgpuDeviceCreatePipelineLayout(wgpu_context.device, *compute_layout_desc);
	pipeline_descriptor: WGPUComputePipelineDescriptor = .{
		label = to_c_string("box geometry compute pipeline"),
		layout = compute_layout,
		compute = compute_descriptor,
	};
	controller.pipeline = wgpuDeviceCreateComputePipeline(wgpu_context.device, *pipeline_descriptor);
	free(pipeline_descriptor.label);

	

	//
	//
	// create a buffer on the GPU to hold our computation
	// input and output
	//
	//
	box_size_buffer := wgpuDeviceCreateBuffer(wgpu_context.device,*(WGPUBufferDescriptor.{
		label = "input size buffer",
		usage = xx (WGPUBufferUsage.Storage | WGPUBufferUsage.CopySrc | WGPUBufferUsage.CopyDst),
		size = box_size_buffer_size
	}));
	controller.data.buffer = box_size_buffer;
	controller.data.buffer_size = box_size_buffer_size;
	// Copy our input data to that buffer
	// wgpuQueueWriteBuffer(queue, box_size_buffer, 0, box_size.data, box_size_buffer_size);
	
	box_size_v:Vector3 = .{x=box_size[0], y=box_size[1], z=box_size[2]};
	compute_shader_controller_update_buffer(*controller, box_size_v);

	//
	//
	// create a buffer on the GPU to get a copy of the results
	//
	//
	// #if MAP_BUFFER {
	// 	vertex_buffer_usage := WGPUBufferUsage.Storage | WGPUBufferUsage.CopySrc | WGPUBufferUsage.CopyDst | WGPUBufferUsage.Vertex;
	// } else {
	// 	vertex_buffer_usage := WGPUBufferUsage.Storage | WGPUBufferUsage.CopyDst | WGPUBufferUsage.Vertex;
	// }
	// vertex_buffer := wgpuDeviceCreateBuffer(device, *(WGPUBufferDescriptor.{
	// 	label = "vertex buffer",
	// 	usage = xx vertex_buffer_usage,
	// 	size = vertex_buffer_size
	// }));
	controller.vertex = buffer_container;
	// controller.vertex.buffer_size = vertex_buffer_size;
	#if MAP_BUFFER {
			controller.vertex_buffer_map = wgpuDeviceCreateBuffer(wgpu_context.device, *(WGPUBufferDescriptor.{
			label = "vertex buffer",
			usage = xx (WGPUBufferUsage.MapRead | WGPUBufferUsage.CopyDst),
			size = controller.vertex.buffer_size
		}));
	}

	//
	//
	// Setup a bindGroup to tell the shader which
	// buffer to use for the computation
	//
	//
	// bind_group_box_size :WGPUBindGroup;
	bind_group_box_size_entries := NewArray(1, WGPUBindGroupEntry);
	defer array_reset(*bind_group_box_size_entries);
	{
		bind_group_box_size_entries[0] = WGPUBindGroupEntry.{
			binding = 0,
			size = box_size_buffer_size,
			offset = 0,
			buffer = box_size_buffer,
		};
		bind_group_descriptor := WGPUBindGroupDescriptor.{
			label = "bind_group_data_size",
			layout = wgpuComputePipelineGetBindGroupLayout(controller.pipeline, 0),
			entryCount = xx bind_group_box_size_entries.count,
			entries = bind_group_box_size_entries.data
		};
		controller.bind_group.data_size = wgpuDeviceCreateBindGroup(wgpu_context.device, *bind_group_descriptor);
	}
	// bind_group_vertex :WGPUBindGroup;
	bind_group_vertex_entries := NewArray(1, WGPUBindGroupEntry);
	defer array_reset(*bind_group_vertex_entries);
	{
		bind_group_vertex_entries[0] = WGPUBindGroupEntry.{
			binding = 0,
			size = buffer_container.buffer_size,
			offset = 0,
			buffer = buffer_container.buffer,
		};
		bind_group_descriptor := WGPUBindGroupDescriptor.{
			label = "bind_group_vertex",
			layout = wgpuComputePipelineGetBindGroupLayout(controller.pipeline, 1),
			entryCount = xx bind_group_vertex_entries.count,
			entries = bind_group_vertex_entries.data
		};
		controller.bind_group.vertex = wgpuDeviceCreateBindGroup(wgpu_context.device, *bind_group_descriptor);
	}

	compute_shader_controller_compute(*controller);
	

	

	// controller.release = (controller:ComputeShaderController) {
	// 	wgpuComputePassEncoderRelease(controller.compute_pass_encoder);
	// 	// wgpuCommandBufferRelease(controller.command_buffer);
	// 	// wgpuCommandEncoderRelease(controller.command_encoder);
	// };

	return controller;
}

compute_shader_controller_update_buffer :: (controller:*ComputeShaderController, size:Vector3){
	size_float: [3]float = .[size.x, size.y, size.z];
	wgpuQueueWriteBuffer(controller.wgpu_context.queue, controller.data.buffer, 0, size_float.data, controller.data.buffer_size);
};
compute_shader_controller_compute :: (controller:*ComputeShaderController) {
	compute_pass_encoder: WGPUComputePassEncoder;
	commands_count :u64= 1;
	command_encoder := wgpuDeviceCreateCommandEncoder(
		controller.wgpu_context.device,
		*(WGPUCommandEncoderDescriptor.{label = "Command Encoder Compute"}),
	);
	defer wgpuComputePassEncoderRelease(compute_pass_encoder);
	defer wgpuCommandEncoderRelease(command_encoder);

	compute_pass_descriptor := WGPUComputePassDescriptor.{
		label = "Compute Pass",
	};
	{
		compute_pass_encoder = wgpuCommandEncoderBeginComputePass(command_encoder, *compute_pass_descriptor);
		wgpuComputePassEncoderSetPipeline(compute_pass_encoder, controller.pipeline);
		wgpuComputePassEncoderSetBindGroup(compute_pass_encoder, 0, controller.bind_group.data_size, 0, null);
		wgpuComputePassEncoderSetBindGroup(compute_pass_encoder, 1, controller.bind_group.vertex, 0, null);
		wgpuComputePassEncoderDispatchWorkgroups(compute_pass_encoder, xx controller.work_groups_count.x, xx controller.work_groups_count.y, xx controller.work_groups_count.z);
		wgpuComputePassEncoderEnd(compute_pass_encoder);
	}

	#if MAP_BUFFER {
		// Encode a command to copy the results to a mappable buffer.
		wgpuCommandEncoderCopyBufferToBuffer(command_encoder, controller.vertex.buffer, 0, controller.vertex_buffer_map, 0, controller.vertex.buffer_size);
	}

	command_buffer := wgpuCommandEncoderFinish(command_encoder, *(WGPUCommandBufferDescriptor.{label = "Cmd Buffer Compute"}));
	defer wgpuCommandBufferRelease(command_buffer);
	wgpuQueueSubmit(controller.wgpu_context.queue, commands_count, *command_buffer);

	#if MAP_BUFFER {
		wgpuBufferMapAsync(controller.vertex_buffer_map, xx WGPUMapMode.Read, 0, controller.vertex.buffer_size, wgpu_compute_buffer_map_async_callback, null);
		wgpuDevicePoll(controller.wgpu_context.device, xx true, null);
		// result_values := /*cast(ResultType)*/ 
		wgpuBufferGetMappedRange(controller.vertex_buffer_map, 0, controller.vertex.buffer_size);

		//
		// print_green(tprint("pipeline created:%\n", controller.pipeline));
		// print("result_values:%\n", cast([64]float)result_values);

		wgpuBufferUnmap(controller.vertex_buffer_map);
	}
};

wgpu_compute_buffer_map_async_callback :: (status: WGPUBufferMapAsyncStatus, userdata: *void) #c_call {
	if(status!=WGPUBufferMapAsyncStatus.Success){
		new_context: Context;
		push_context new_context {
			print("*** status:%\n", status);
		}
	}
}