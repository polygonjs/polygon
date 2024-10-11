// TODO: there are lots of wgpu things to release here


ComputeControllerInitMethod :: #type (controller: *ComputeController, wgpu_context: *WGPUContext, scene_data: *SceneData);
UpdateBufferMethod :: #type (controller:*ComputeController, scene_data:*SceneData);
SetBindGroupMethod :: #type (controller:*ComputeController, compute_pass_encoder: *WGPUComputePassEncoder, command_encoder: *WGPUCommandEncoder);
HandleMappedBuffersMethod :: #type (controller:*ComputeController);
EntitiesCountMethod :: #type (controller:*ComputeController)->u64;

ComputeControllerMethods :: struct {
	update_buffer: UpdateBufferMethod;
	set_bind_group: SetBindGroupMethod;
	handle_mapped_buffers: HandleMappedBuffersMethod;
	entities_count:EntitiesCountMethod;
}

ComputeController :: struct {
	type: Type;
	wgpu_context: *WGPUContext;
	work_group_size:Vector3;
	// vertex:BufferContainer;
	// release:(this:ComputeController);
	// private
	// queue:WGPUQueue;
	// data:BufferContainer;
	// encoder: WGPUComputePassEncoder;
	// command_buffer: WGPUCommandBuffer;
	// commands_count: u32;
	pipeline:WGPUComputePipeline;
	// for release
	// compute_pass_encoder: WGPUComputePassEncoder;
	// command_encoder: WGPUCommandEncoder;
	// bind_group:ComputeControllerBindGroup;
	data_bind_group_size:WGPUBindGroup;
	// #if MAP_BUFFER {
	// 	vertex_buffer_map: WGPUBuffer;
	// }
	using methods: ComputeControllerMethods;
}

heap_compute_controller :: ($T: Type) -> *T {  // Return a pointer to a heap-allocated Document of the appropriate type.
	compute_controller: *T = alloc(size_of(T));  // alloc returns us a pointer to a series of contiguous bytes allocated on the heap.
	compute_controller.type = T;
	// we need to create a ComputeController on the stack in order to know its init method.
	tmp :T;
	compute_controller.init = tmp.init;

	return compute_controller;
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

compute_controller_init :: (controller: *ComputeController, wgpu_context: *WGPUContext, shader: string, entry_point:string, methods: ComputeControllerMethods, work_group_size:Vector3=.{256,1,1}, params_bind_groups_count:u32=1, attributes_bind_groups_count:u32=1, compute_controller_label:string="unnamed compute controller") {
	// controller: ComputeController = .{
	// 	wgpu_context = wgpu_context,
	// 	// queue = queue,
	// 	work_groups_count = .{1, 1, 1},
	// 	bind_group = .{}
	// };
	// device := wgpu_context.device;
	controller.wgpu_context = wgpu_context;
	controller.work_group_size = work_group_size;

	controller.update_buffer = methods.update_buffer;
	controller.set_bind_group = methods.set_bind_group;
	controller.handle_mapped_buffers = methods.handle_mapped_buffers;
	controller.entities_count = methods.entities_count;

	// print("entry_point:%\n", entry_point);
	// print("shader_compute_raw:%\n", shader_compute_raw);

	// work_groups_count :Vector3= .{1, 1, 1};
	// work_groups_count_total :u32= cast(u32)(work_groups_count.x)*cast(u32)(work_groups_count.y)*cast(u32)(work_groups_count.z);
	shader_compute := build_compute_shader(shader, controller.work_group_size);
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

	//
	bind_group_layouts := NewArray(2, WGPUBindGroupLayout);
	#if FREE_MEMORY defer array_reset(*bind_group_layouts);
	// group 0
	bind_group_layout_entries0 := NewArray(params_bind_groups_count, WGPUBindGroupLayoutEntry);
	#if FREE_MEMORY defer array_reset(*bind_group_layout_entries0);
	{
		if(params_bind_groups_count>0){
			for 0..(params_bind_groups_count-1){
				bind_group_layout_entries0[it] = WGPUBindGroupLayoutEntry.{
					binding = it,
					visibility = xx WGPUShaderStage.Compute,
					buffer = .{ type = WGPUBufferBindingType.Storage }, // should be storage, not uniform like in render pipeline
				};
			}
		}
		// bind_group_layout_entries0[1] = WGPUBindGroupLayoutEntry.{
		// 	binding = 1,
		// 	visibility = xx WGPUShaderStage.Compute,
		// 	buffer = .{ type = WGPUBufferBindingType.Storage }, // should be storage, not uniform like in render pipeline
		// };
		bind_group_layouts[0] = wgpuDeviceCreateBindGroupLayout(wgpu_context.device, *(WGPUBindGroupLayoutDescriptor.{
			entryCount = xx bind_group_layout_entries0.count,
			entries = bind_group_layout_entries0.data,
		}));
	}
	// group 1
	bind_group_layout_entries1 := NewArray(attributes_bind_groups_count, WGPUBindGroupLayoutEntry);
	#if FREE_MEMORY defer array_reset(*bind_group_layout_entries1);
	{
		for 0..(attributes_bind_groups_count-1){
			bind_group_layout_entries1[it] = WGPUBindGroupLayoutEntry.{
				binding = it,
				visibility = xx WGPUShaderStage.Compute,
				buffer = .{ type = WGPUBufferBindingType.Storage }, // should be storage, not uniform like in render pipeline
			};
		}
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
		label = to_c_string(compute_controller_label),
		layout = compute_layout,
		compute = compute_descriptor,
	};
	controller.pipeline = wgpuDeviceCreateComputePipeline(wgpu_context.device, *pipeline_descriptor);
	free(pipeline_descriptor.label);


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
	// controller.vertex.buffer_size = vertex_buffer_size;
	

	//
	//
	// Setup a bindGroup to tell the shader which
	// buffer to use for the computation
	//
	//
	// bind_group_box_size :WGPUBindGroup;
	// compute_controller_add_data_bind_group(*controller, 0, box_size_buffer_size);
	// bind_group_vertex :WGPUBindGroup;
	// bind_group_vertex_entries := NewArray(1, WGPUBindGroupEntry);
	// defer array_reset(*bind_group_vertex_entries);
	// {
	// 	bind_group_vertex_entries[0] = WGPUBindGroupEntry.{
	// 		binding = 0,
	// 		size = buffer_container.buffer_size,
	// 		offset = 0,
	// 		buffer = buffer_container.buffer,
	// 	};
	// 	bind_group_descriptor := WGPUBindGroupDescriptor.{
	// 		label = "bind_group_vertex",
	// 		layout = wgpuComputePipelineGetBindGroupLayout(controller.pipeline, 1),
	// 		entryCount = xx bind_group_vertex_entries.count,
	// 		entries = bind_group_vertex_entries.data
	// 	};
	// 	controller.bind_group.vertex = wgpuDeviceCreateBindGroup(wgpu_context.device, *bind_group_descriptor);
	// }

	// compute_shader_controller_compute(controller);
	

	

	// controller.release = (controller:ComputeController) {
	// 	wgpuComputePassEncoderRelease(controller.compute_pass_encoder);
	// 	// wgpuCommandBufferRelease(controller.command_buffer);
	// 	// wgpuCommandEncoderRelease(controller.command_encoder);
	// };

	// return controller;
}
// ComputeControllerBindGroupAdd :: struct {
// 	buffer_size: u64;
// 	buffer: WGPUBuffer;
// 	groupIndex: u32;
// 	label:string;
// };

// compute_controller_add_data_bind_group :: (controller:*ComputeController, data: ComputeControllerBindGroupAdd) {
// 	bind_group_box_size_entries := NewArray(1, WGPUBindGroupEntry);
// 	defer array_reset(*bind_group_box_size_entries);
// 	{
// 		bind_group_box_size_entries[0] = WGPUBindGroupEntry.{
// 			binding = 0,
// 			size = data.buffer_size,
// 			offset = 0,
// 			buffer = data.buffer,
// 		};
// 		bind_group_descriptor := WGPUBindGroupDescriptor.{
// 			label = data.label,
// 			layout = wgpuComputePipelineGetBindGroupLayout(controller.pipeline, data.groupIndex),
// 			entryCount = xx bind_group_box_size_entries.count,
// 			entries = bind_group_box_size_entries.data
// 		};
// 		controller.bind_group.data_size = wgpuDeviceCreateBindGroup(wgpu_context.device, *bind_group_descriptor);
// 	}
// }


compute_controller_compute :: (controller:*ComputeController, command_encoder : WGPUCommandEncoder, compute_pass_encoder:WGPUComputePassEncoder) {

	wgpuComputePassEncoderSetPipeline(compute_pass_encoder, controller.pipeline);
	wgpuComputePassEncoderSetBindGroup(compute_pass_encoder, 0, controller.data_bind_group_size, 0, null);
	controller.set_bind_group(controller, *compute_pass_encoder, *command_encoder);
	entities_count := controller.entities_count(controller);
	workgroup_size_x := controller.work_group_size.x;
	workgroups_x :u32= xx ((entities_count + workgroup_size_x - 1) / workgroup_size_x);
	// print("%:%,%,%\n", controller.type, entities_count, workgroups_x, workgroups_x*workgroup_size_x);
	wgpuComputePassEncoderDispatchWorkgroups(compute_pass_encoder, workgroups_x, 1, 1);
	


	// #if MAP_BUFFER controller.handle_mapped_buffers(controller);
};

wgpu_compute_buffer_map_async_callback :: (status: WGPUBufferMapAsyncStatus, userdata: *void) #c_call {
	if(status!=WGPUBufferMapAsyncStatus.Success){
		new_context: Context;
		push_context new_context {
			print("*** status:%\n", status);
		}
	}
}