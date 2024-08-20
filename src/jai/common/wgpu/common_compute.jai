// TODO: there are lots of wgpu things to release here

MAP_BUFFER :: false; // to read the buffer from the GPU to the CPU

ComputeShaderController :: struct {
	wgpu_context: *WGPUContext;
	work_groups_count:Vector3;
	vertex_buffer:WGPUBuffer;
	vertex_buffer_size: u64;
	update_box_size:(this:ComputeShaderController, size:Vector3);
	compute:(this:ComputeShaderController);
	// release:(this:ComputeShaderController);
	// private
	queue:WGPUQueue;
	box_size_buffer:WGPUBuffer;
	box_size_buffer_size: u64;
	// encoder: WGPUComputePassEncoder;
	// command_buffer: WGPUCommandBuffer;
	// commands_count: u32;
	pipeline:WGPUComputePipeline;
	// for release
	// compute_pass_encoder: WGPUComputePassEncoder;
	// command_encoder: WGPUCommandEncoder;
	bind_group : struct {
		box_size: WGPUBindGroup;
		vertex :WGPUBindGroup;
	};
	#if MAP_BUFFER {
		vertex_buffer_map: WGPUBuffer;
	}
}

sprint_compute_shader :: (shader0:string, work_group_size:Vector3) -> string {
	work_group_count := work_group_size.x * work_group_size.y * work_group_size.z;

	shader1 := replace(shader0, "__WORK_GROUP_SIZE_X__", sprint("%", work_group_size.x));
	defer free(shader1);
	shader2 := replace(shader1, "__WORK_GROUP_SIZE_Y__", sprint("%", work_group_size.y));
	defer free(shader2);
	shader3 := replace(shader2, "__WORK_GROUP_SIZE_Z__", sprint("%", work_group_size.z));
	defer free(shader3);
	shader4 := replace(shader3, "__WORK_GROUP_COUNT__", sprint("%", work_group_count));
	return shader4;
}

compute_shader_controller_create :: (wgpu_context: *WGPUContext, queue:WGPUQueue, shader_compute_raw: string) -> ComputeShaderController {
	controller: ComputeShaderController = .{
		wgpu_context = wgpu_context,
		queue = queue,
		work_groups_count = .{1, 1, 1},
		bind_group = .{}
	};
	device := wgpu_context.device;

	InputType :: [3]float;
	ResultType :: [64]float;
	box_size:InputType = .[2, 1, 1];
	box_size_buffer_size := cast(u64) size_of(type_of(box_size));//cast(u64) input.count * size_of(float);
	vertex_buffer_size :u64= 64 * size_of(float);

	// work_groups_count :Vector3= .{1, 1, 1};
	// work_groups_count_total :u32= cast(u32)(work_groups_count.x)*cast(u32)(work_groups_count.y)*cast(u32)(work_groups_count.z);
	shader_compute := sprint_compute_shader(shader_compute_raw, controller.work_groups_count);
	defer free(shader_compute);
	entry_point := to_c_string("boxCompute");

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
	shader_module := wgpuDeviceCreateShaderModule(device, *shaderModuleDescriptor);

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
		bind_group_layouts[0] = wgpuDeviceCreateBindGroupLayout(device, *(WGPUBindGroupLayoutDescriptor.{
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
		bind_group_layouts[1] = wgpuDeviceCreateBindGroupLayout(device, *(WGPUBindGroupLayoutDescriptor.{
			entryCount = xx bind_group_layout_entries1.count,
			entries = bind_group_layout_entries1.data,
		}));
	}

	compute_descriptor:WGPUProgrammableStageDescriptor = .{
		entryPoint = entry_point, // this crashes if not present
		module = shader_module,
	};
	compute_layout_desc:WGPUPipelineLayoutDescriptor;
	compute_layout_desc.bindGroupLayoutCount = xx bind_group_layouts.count;
	compute_layout_desc.bindGroupLayouts = bind_group_layouts.data;
	compute_layout := wgpuDeviceCreatePipelineLayout(device, *compute_layout_desc);
	pipeline_descriptor: WGPUComputePipelineDescriptor = .{
		label = to_c_string("box geometry compute pipeline"),
		layout = compute_layout,
		compute = compute_descriptor,
	};
	controller.pipeline = wgpuDeviceCreateComputePipeline(device, *pipeline_descriptor);

	

	//
	//
	// create a buffer on the GPU to hold our computation
	// input and output
	//
	//
	box_size_buffer := wgpuDeviceCreateBuffer(device,*(WGPUBufferDescriptor.{
		label = "input size buffer",
		usage = xx (WGPUBufferUsage.Storage | WGPUBufferUsage.CopySrc | WGPUBufferUsage.CopyDst),
		size = box_size_buffer_size
	}));
	controller.box_size_buffer = box_size_buffer;
	controller.box_size_buffer_size = box_size_buffer_size;
	// Copy our input data to that buffer
	// wgpuQueueWriteBuffer(queue, box_size_buffer, 0, box_size.data, box_size_buffer_size);
	controller.update_box_size = (controller:ComputeShaderController, size:Vector3){
		size_float: [3]float = .[size.x, size.y, size.z];
		wgpuQueueWriteBuffer(controller.queue, controller.box_size_buffer, 0, size_float.data, controller.box_size_buffer_size);
	};
	box_size_v:Vector3  = .{x=box_size[0], y=box_size[1], z=box_size[2]};
	controller.update_box_size(controller, box_size_v);

	//
	//
	// create a buffer on the GPU to get a copy of the results
	//
	//
	#if MAP_BUFFER {
		vertex_buffer_usage := WGPUBufferUsage.Storage | WGPUBufferUsage.CopySrc | WGPUBufferUsage.CopyDst | WGPUBufferUsage.Vertex;
	} else {
		vertex_buffer_usage := WGPUBufferUsage.Storage | WGPUBufferUsage.CopyDst | WGPUBufferUsage.Vertex;
	}
	vertex_buffer := wgpuDeviceCreateBuffer(device, *(WGPUBufferDescriptor.{
		label = "vertex buffer",
		usage = xx vertex_buffer_usage,
		size = vertex_buffer_size
	}));
	controller.vertex_buffer = vertex_buffer;
	controller.vertex_buffer_size = vertex_buffer_size;
	#if MAP_BUFFER {
		controller.vertex_buffer_map = wgpuDeviceCreateBuffer(device, *(WGPUBufferDescriptor.{
			label = "vertex buffer",
			usage = xx (WGPUBufferUsage.MapRead | WGPUBufferUsage.CopyDst),
			size = vertex_buffer_size
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
			label = "bind_group_box_size",
			layout = wgpuComputePipelineGetBindGroupLayout(controller.pipeline, 0),
			entryCount = xx bind_group_box_size_entries.count,
			entries = bind_group_box_size_entries.data
		};
		controller.bind_group.box_size = wgpuDeviceCreateBindGroup(device, *bind_group_descriptor);
	}
	// bind_group_vertex :WGPUBindGroup;
	bind_group_vertex_entries := NewArray(1, WGPUBindGroupEntry);
	defer array_reset(*bind_group_vertex_entries);
	{
		bind_group_vertex_entries[0] = WGPUBindGroupEntry.{
			binding = 0,
			size = vertex_buffer_size,
			offset = 0,
			buffer = vertex_buffer,
		};
		bind_group_descriptor := WGPUBindGroupDescriptor.{
			label = "bind_group_vertex",
			layout = wgpuComputePipelineGetBindGroupLayout(controller.pipeline, 1),
			entryCount = xx bind_group_vertex_entries.count,
			entries = bind_group_vertex_entries.data
		};
		controller.bind_group.vertex = wgpuDeviceCreateBindGroup(device, *bind_group_descriptor);
	}

	//
	//
	// Encode commands to do the computation
	//
	//


	//
	//
	// compute
	//
	//
	
	controller.compute = (controller:ComputeShaderController) {
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
			wgpuComputePassEncoderSetBindGroup(compute_pass_encoder, 0, controller.bind_group.box_size, 0, null);
			wgpuComputePassEncoderSetBindGroup(compute_pass_encoder, 1, controller.bind_group.vertex, 0, null);
			wgpuComputePassEncoderDispatchWorkgroups(compute_pass_encoder, xx controller.work_groups_count.x, xx controller.work_groups_count.y, xx controller.work_groups_count.z);
			wgpuComputePassEncoderEnd(compute_pass_encoder);
		}

		#if MAP_BUFFER {
			// Encode a command to copy the results to a mappable buffer.
			wgpuCommandEncoderCopyBufferToBuffer(command_encoder, controller.vertex_buffer, 0, controller.vertex_buffer_map, 0, controller.vertex_buffer_size);
		}

		command_buffer := wgpuCommandEncoderFinish(command_encoder, *(WGPUCommandBufferDescriptor.{label = "Cmd Buffer Compute"}));
		defer wgpuCommandBufferRelease(command_buffer);
		wgpuQueueSubmit(controller.queue, commands_count, *command_buffer);

		#if MAP_BUFFER {
			wgpuBufferMapAsync(controller.vertex_buffer_map, xx WGPUMapMode.Read, 0, controller.vertex_buffer_size, wgpu_compute_buffer_map_async_callback, null);
			wgpuDevicePoll(controller.wgpu_context.device, xx true, null);
			result_values := cast(ResultType) wgpuBufferGetMappedRange(controller.vertex_buffer_map, 0, controller.vertex_buffer_size);

			//
			// print_green(tprint("pipeline created:%\n", controller.pipeline));
			// print("result_values:%\n", result_values);

			wgpuBufferUnmap(controller.vertex_buffer_map);
		}
	};
	controller.compute(controller);
	

	

	// controller.release = (controller:ComputeShaderController) {
	// 	wgpuComputePassEncoderRelease(controller.compute_pass_encoder);
	// 	// wgpuCommandBufferRelease(controller.command_buffer);
	// 	// wgpuCommandEncoderRelease(controller.command_encoder);
	// };

	return controller;
}

wgpu_compute_buffer_map_async_callback :: (status: WGPUBufferMapAsyncStatus, userdata: *void) #c_call {
	if(status!=WGPUBufferMapAsyncStatus.Success){
		new_context: Context;
		push_context new_context {
			print("*** status:%\n", status);
		}
	}
}