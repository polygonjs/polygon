

compute_test :: (wgpu_context: *WGPUContext, queue:WGPUQueue, shader_compute: string){
	device := wgpu_context.device;

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
	print("creating pipeline...\n");
	compute_descriptor:WGPUProgrammableStageDescriptor = .{
		module = shader_module,
		entryPoint = "computeSomething" // this crashes if not present
	};
	compute_layout_desc:WGPUPipelineLayoutDescriptor;
	bind_group_layouts := NewArray(1, WGPUBindGroupLayout);
	#if FREE_MEMORY defer array_reset(*bind_group_layouts);
	// group 0
	{
		bind_group_layout_entries := NewArray(1, WGPUBindGroupLayoutEntry);
		#if FREE_MEMORY defer array_reset(*bind_group_layout_entries);
		bind_group_layout_entries[0] = WGPUBindGroupLayoutEntry.{
			binding = 0,
			visibility = xx WGPUShaderStage.Compute,
			buffer = .{ type = WGPUBufferBindingType.Storage }, // should be storage, not uniform like in render pipeline
		};
		bind_group_layouts[0] = wgpuDeviceCreateBindGroupLayout(device, *(WGPUBindGroupLayoutDescriptor.{
			entryCount = xx bind_group_layout_entries.count,
			entries = bind_group_layout_entries.data,
		}));
	}

	compute_layout_desc.bindGroupLayoutCount = xx bind_group_layouts.count;
	compute_layout_desc.bindGroupLayouts = bind_group_layouts.data;
	compute_layout := wgpuDeviceCreatePipelineLayout(device, *compute_layout_desc);
	pipeline_descriptor: WGPUComputePipelineDescriptor = .{
		label = to_c_string("doubling compute pipeline"),
		layout = compute_layout,
		compute = compute_descriptor,
	};
	pipeline := wgpuDeviceCreateComputePipeline(device, *pipeline_descriptor);

	InputType :: [6]float;
	input:InputType = .[1, 3, 5, 7, 11, 17];
	input_size := cast(u64) size_of(type_of(input));//cast(u64) input.count * size_of(float);

	// create a buffer on the GPU to hold our computation
	// input and output
	work_buffer := wgpuDeviceCreateBuffer(device,*(WGPUBufferDescriptor.{
		label = "work buffer",
		usage = xx (WGPUBufferUsage.Storage | WGPUBufferUsage.CopySrc | WGPUBufferUsage.CopyDst),
		size = input_size
	}));
	// Copy our input data to that buffer
	wgpuQueueWriteBuffer(queue, work_buffer, 0, input.data, input_size);

	// create a buffer on the GPU to get a copy of the results
	result_buffer := wgpuDeviceCreateBuffer(device, *(WGPUBufferDescriptor.{
		label = "result buffer",
		usage = xx (WGPUBufferUsage.MapRead  | WGPUBufferUsage.CopyDst),
		size = input_size
	}));

	// Setup a bindGroup to tell the shader which
	// buffer to use for the computation
	entries := NewArray(1, WGPUBindGroupEntry);
	entries[0] = WGPUBindGroupEntry.{
		binding = 0,
		size = input_size,
		offset = 0,
		buffer = work_buffer,
	};
	bind_group_descriptor := WGPUBindGroupDescriptor.{
		layout = wgpuComputePipelineGetBindGroupLayout(pipeline, 0),
		entryCount = xx entries.count,
		entries = entries.data
	};
	bind_group := wgpuDeviceCreateBindGroup(device, *bind_group_descriptor);

	// Encode commands to do the computation
	// const encoder = device.createCommandEncoder({
	// 	label: "doubling encoder",
	// });
	// const pass = encoder.beginComputePass({
	// 	label: "doubling compute pass",
	// });
	// pass.setPipeline(pipeline);
	// pass.setBindGroup(0, bindGroup);
	// pass.dispatchWorkgroups(input.length);
	// pass.end();
	compute_pass_encoder: WGPUComputePassEncoder;
	cmd_buffer1: WGPUCommandBuffer;
	cmd_encoder := wgpuDeviceCreateCommandEncoder(
		device,
		*(WGPUCommandEncoderDescriptor.{label = "Command Encoder Compute"}),
	);
	defer wgpuComputePassEncoderRelease(compute_pass_encoder);
	defer wgpuCommandBufferRelease(cmd_buffer1);
	defer wgpuCommandEncoderRelease(cmd_encoder);

	compute_pass_descriptor := WGPUComputePassDescriptor.{
		label = "Compute Pass",
	};
	{
		compute_pass_encoder = wgpuCommandEncoderBeginComputePass(cmd_encoder, *compute_pass_descriptor);
		wgpuComputePassEncoderSetPipeline(compute_pass_encoder, pipeline);
		object_dynamicOffsets:[0]u32;
		wgpuComputePassEncoderSetBindGroup(compute_pass_encoder, 0, bind_group, 0, object_dynamicOffsets.data);
		wgpuComputePassEncoderDispatchWorkgroups(compute_pass_encoder, input.count, 1, 1);
		wgpuComputePassEncoderEnd(compute_pass_encoder);
	}

	// Encode a command to copy the results to a mappable buffer.
	wgpuCommandEncoderCopyBufferToBuffer(cmd_encoder, work_buffer, 0, result_buffer, 0, input_size);

	// Finish encoding and submit the commands
	cmd_buffer1 = wgpuCommandEncoderFinish(cmd_encoder, *(WGPUCommandBufferDescriptor.{label = "Cmd Buffer Compute"}));
	wgpuQueueSubmit(queue, 1, *cmd_buffer1);


	wgpuBufferMapAsync(result_buffer, xx WGPUMapMode.Read, 0, input_size, wgpu_compute_buffer_map_async_callback, null);
	wgpuDevicePoll(device, xx true, null);
	result_values := cast(InputType) wgpuBufferGetMappedRange(result_buffer, 0, input_size);

	//
	print_green(tprint("pipeline created:%\n", pipeline));
	print("result_values:%\n", result_values);

	wgpuBufferUnmap(result_buffer);
}

wgpu_compute_buffer_map_async_callback :: (status: WGPUBufferMapAsyncStatus, userdata: *void) #c_call {
	if(status!=WGPUBufferMapAsyncStatus.Success){
		new_context: Context;
		push_context new_context {
			print("*** status:%\n", status);
		}
	}
}