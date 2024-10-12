ComputeControllerCollection :: struct {
	controllers: [..]*ComputeController;
}

compute_controller_collection_create :: (wgpu_context: *WGPUContext, scene_data:*SceneData) -> ComputeControllerCollection {
	ccc :ComputeControllerCollection;
	print("beware the hard coded value\n");
	// points_count :u64= 150;//6534;
	// index_count :u64= 576;
	// points_count:u64=486;
	// index_count:u64=2304;
	// points_count :u64= 99846;//6534;
	// index_count :u64= 589824;
	// points_count:u64=16641;
	// index_count:u64=98304;
	// points_count:u64=2562;
	// index_count:u32=15360;
	// points_count:u64=10242;
	// index_count:u32=61440;
	// points_count:u64=40962;
	// index_count:u32=245760;
	points_count:u64=3612;
	index_count:u64=21660;
	position_in := wgpu_buffer_for_compute(wgpu_context, points_count * size_of(Vector3), "position_in");
	normal_in := wgpu_buffer_for_compute(wgpu_context, points_count * size_of(Vector3), "normal_in");
	index_in := wgpu_buffer_for_compute(wgpu_context, index_count * size_of(VertexIndex), "index_in");
	position_out := wgpu_buffer_for_compute(wgpu_context, points_count * size_of(Vector3), "position_out");
	normal_tmp := wgpu_buffer_for_compute(wgpu_context, points_count * size_of(Vector3), "normal_tmp");
	normal_out := wgpu_buffer_for_compute(wgpu_context, points_count * size_of(Vector3), "normal_out");

	// box_create_controller := heap_compute_controller(ComputeControllerBoxCreate);
	// compute_controller_box_create_init( box_create_controller, wgpu_context, position_in, scene_data );

	// {
	// 	controller := heap_compute_controller(ComputeControllerTranslate);
	// 	compute_controller_translate_init( controller, wgpu_context, scene_data );
	// 	compute_controller_translate_set_buffer( controller, *position_in, *position_out );
	// 	array_add(*ccc.controllers, controller);
	// }

	{
		controller := heap_compute_controller(ComputeControllerNoise);
		controller.init( controller, wgpu_context, scene_data );
		controller.set_buffers( controller, *position_in, *normal_in, *position_out );
		array_add(*ccc.controllers, controller);
	}
	{
		controller := heap_compute_controller(ComputeControllerAttributeSet);
		controller.init( controller, wgpu_context, scene_data );
		controller.set_buffers( controller, *normal_tmp );
		array_add(*ccc.controllers, controller);
	}
	{
		controller := heap_compute_controller(ComputeControllerComputeNormals);
		controller.init( controller, wgpu_context, scene_data );
		controller.set_buffers( controller, *position_out, *index_in, *normal_tmp );
		array_add(*ccc.controllers, controller);
	}
	{
		controller := heap_compute_controller(ComputeControllerAttributeNormalize);
		controller.init( controller, wgpu_context, scene_data );
		controller.set_buffers( controller, *normal_tmp, *normal_out );
		array_add(*ccc.controllers, controller);
	}

	// offset_controller := compute_controller_create(
	// 	wgpu_context,
	// 	SHADER_COMPUTE_OFFSET,
	// 	"geometryOffset",
	// 	buffer_container
	// );

	// array_add(*ccc.controllers, box_create_controller);
	
	return ccc;
}

pipeline_controller_update :: (pc: *PipelineController, ccc: *ComputeControllerCollection) {
	if (ccc.controllers.count == 0) return;

	// {
	// 	if (ccc.controllers[0].type != ComputeControllerTranslate) return;
	// 	translate_controller := cast(*ComputeControllerTranslate) ccc.controllers[0];

	// 	commands_count :u64= 1;
	// 	command_encoder := wgpuDeviceCreateCommandEncoder(
	// 		translate_controller.wgpu_context.device,
	// 		*(WGPUCommandEncoderDescriptor.{label = "Command Encoder pipeline_controller_update"}),
	// 	);
	// 	defer wgpuCommandEncoderRelease(command_encoder);

	// 	wgpuCommandEncoderCopyBufferToBuffer(command_encoder, pc.meshes_draw_data[0].vertex[0].buffer, 0, translate_controller.attributes.position_in.buffer, 0, translate_controller.attributes.position_in.buffer_size);
	// 	pc.meshes_draw_data[0].vertex[0] = translate_controller.attributes.position_out;
	// 	// wgpuRenderPassEncoderSetVertexBuffer(<<render_pass_encoder, 0, box_controller.vertex.buffer, 0, box_controller.vertex.buffer_size);

	// 	command_buffer := wgpuCommandEncoderFinish(command_encoder, *(WGPUCommandBufferDescriptor.{label = "Cmd Buffer pipeline_controller_update"}));
	// 	defer wgpuCommandBufferRelease(command_buffer);
	// 	wgpuQueueSubmit(translate_controller.wgpu_context.queue, commands_count, *command_buffer);
	// }

	// {
	// 	if (ccc.controllers[0].type != ComputeControllerNoise) return;
	// 	controller := cast(*ComputeControllerNoise) ccc.controllers[0];

	// 	commands_count :u64= 1;
	// 	command_encoder := wgpuDeviceCreateCommandEncoder(
	// 		controller.wgpu_context.device,
	// 		*(WGPUCommandEncoderDescriptor.{label = "Command Encoder pipeline_controller_update"}),
	// 	);
	// 	defer wgpuCommandEncoderRelease(command_encoder);

	// 	wgpuCommandEncoderCopyBufferToBuffer(command_encoder, pc.meshes_draw_data[0].vertex[0].buffer, 0, controller.attributes.position_in.buffer, 0, controller.attributes.position_in.buffer_size);
	// 	wgpuCommandEncoderCopyBufferToBuffer(command_encoder, pc.meshes_draw_data[0].vertex[1].buffer, 0, controller.attributes.normal_in.buffer, 0, controller.attributes.normal_in.buffer_size);
	// 	pc.meshes_draw_data[0].vertex[0] = controller.attributes.position_out;
	// 	// wgpuRenderPassEncoderSetVertexBuffer(<<render_pass_encoder, 0, box_controller.vertex.buffer, 0, box_controller.vertex.buffer_size);

	// 	command_buffer := wgpuCommandEncoderFinish(command_encoder, *(WGPUCommandBufferDescriptor.{label = "Cmd Buffer pipeline_controller_update"}));
	// 	defer wgpuCommandBufferRelease(command_buffer);
	// 	wgpuQueueSubmit(controller.wgpu_context.queue, commands_count, *command_buffer);
	// }

	{
		if (ccc.controllers[0].type != ComputeControllerNoise) return;
		if (ccc.controllers[1].type != ComputeControllerAttributeSet) return;
		if (ccc.controllers[2].type != ComputeControllerComputeNormals) return;
		if (ccc.controllers[3].type != ComputeControllerAttributeNormalize) return;
		controller_noise := cast(*ComputeControllerNoise) ccc.controllers[0];
		controller_attribute_set := cast(*ComputeControllerAttributeSet) ccc.controllers[1];
		controller_normals := cast(*ComputeControllerComputeNormals) ccc.controllers[2];
		controller_attribute_normalize := cast(*ComputeControllerAttributeNormalize) ccc.controllers[3];

		device := controller_noise.wgpu_context.device;
		queue := controller_noise.wgpu_context.queue;

		commands_count :u64= 1;
		command_encoder := wgpuDeviceCreateCommandEncoder(
			device,
			*(WGPUCommandEncoderDescriptor.{label = "Command Encoder pipeline_controller_update"}),
		);
		defer wgpuCommandEncoderRelease(command_encoder);

		{
			using controller_noise.attributes;
			draw_data := *pc.meshes_draw_data[0];
			wgpuCommandEncoderCopyBufferToBuffer(command_encoder, draw_data.vertex[0].buffer, 0, position_in.buffer, 0, position_in.buffer_size);
			wgpuCommandEncoderCopyBufferToBuffer(command_encoder, draw_data.vertex[1].buffer, 0, normal_in.buffer, 0, normal_in.buffer_size);
			draw_data.vertex[0] = position_out;
		}
		{
			// using controller_attribute_set.attributes;
			// attribute_out = normal_out;
		}
		{
			using controller_normals.attributes;
			draw_data := *pc.meshes_draw_data[0];
			wgpuCommandEncoderCopyBufferToBuffer(command_encoder, draw_data.index.buffer, 0, index_in.buffer, 0, index_in.buffer_size);
		}
		{
			using controller_attribute_normalize.attributes;
			draw_data := *pc.meshes_draw_data[0];
			draw_data.vertex[1] = attribute_out;
		}

		command_buffer := wgpuCommandEncoderFinish(command_encoder, *(WGPUCommandBufferDescriptor.{label = "Cmd Buffer pipeline_controller_update"}));
		defer wgpuCommandBufferRelease(command_buffer);
		wgpuQueueSubmit(queue, commands_count, *command_buffer);
	}

}

compute_controller_collection_compute :: (ccc: *ComputeControllerCollection, scene_data: *SceneData) {
	// compute_controller_update_buffer(ccc.controllers[0], scene_data);
	// compute_controller_update_buffer(*ccc.controllers[1], *SCENE_DATA.offset);
	if(ccc.controllers.count == 0)return;

	first_controller := ccc.controllers[0];
	device := first_controller.wgpu_context.device;
	queue := first_controller.wgpu_context.queue;

	commands_count :u64= 1;
	command_encoder := wgpuDeviceCreateCommandEncoder(
		device,
		*(WGPUCommandEncoderDescriptor.{label = "Command Encoder Compute"}),
	);
	defer wgpuCommandEncoderRelease(command_encoder);

	compute_pass_descriptor := WGPUComputePassDescriptor.{
		label = "Compute Pass",
	};
	compute_pass_encoder := wgpuCommandEncoderBeginComputePass(command_encoder, *compute_pass_descriptor);
	defer wgpuComputePassEncoderRelease(compute_pass_encoder);

	for ccc.controllers {
		compute_controller_compute(it, command_encoder, compute_pass_encoder);

		// wgpuCommandEncoderInsertDebugMarker(command_encoder, "Memory Barrier");
		// wgpuCommandEncoderMemoryBarrier(command_encoder, .COMPUTE_SHADER, .COMPUTE_SHADER);

	}
	wgpuComputePassEncoderEnd(compute_pass_encoder);

	command_buffer := wgpuCommandEncoderFinish(command_encoder, *(WGPUCommandBufferDescriptor.{label = "Cmd Buffer Compute"}));
	defer wgpuCommandBufferRelease(command_buffer);
	wgpuQueueSubmit(queue, commands_count, *command_buffer);

	// wgpuDevicePoll(device, xx true, null);
}