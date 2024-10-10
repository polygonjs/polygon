ComputeControllerCollection :: struct {
	controllers: [..]*ComputeController;
}

compute_controller_collection_create :: (wgpu_context: *WGPUContext, scene_data:*SceneData) -> ComputeControllerCollection {
	ccc :ComputeControllerCollection;
	print("beware the hard coded value\n");
	points_count :u64= 99846;//6534;
	position_in := wgpu_buffer_for_compute(wgpu_context, points_count * size_of(Vector3), "position in");
	normal_in := wgpu_buffer_for_compute(wgpu_context, points_count * size_of(Vector3), "normal in");
	position_out := wgpu_buffer_for_compute(wgpu_context, points_count * size_of(Vector3), "position out");

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
		compute_controller_noise_init( controller, wgpu_context, scene_data );
		compute_controller_noise_set_buffer( controller, *position_in, *normal_in, *position_out );
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

	{
		if (ccc.controllers[0].type != ComputeControllerNoise) return;
		translate_controller := cast(*ComputeControllerNoise) ccc.controllers[0];

		commands_count :u64= 1;
		command_encoder := wgpuDeviceCreateCommandEncoder(
			translate_controller.wgpu_context.device,
			*(WGPUCommandEncoderDescriptor.{label = "Command Encoder pipeline_controller_update"}),
		);
		defer wgpuCommandEncoderRelease(command_encoder);

		wgpuCommandEncoderCopyBufferToBuffer(command_encoder, pc.meshes_draw_data[0].vertex[0].buffer, 0, translate_controller.attributes.position_in.buffer, 0, translate_controller.attributes.position_in.buffer_size);
		wgpuCommandEncoderCopyBufferToBuffer(command_encoder, pc.meshes_draw_data[0].vertex[1].buffer, 0, translate_controller.attributes.normal_in.buffer, 0, translate_controller.attributes.normal_in.buffer_size);
		pc.meshes_draw_data[0].vertex[0] = translate_controller.attributes.position_out;
		// wgpuRenderPassEncoderSetVertexBuffer(<<render_pass_encoder, 0, box_controller.vertex.buffer, 0, box_controller.vertex.buffer_size);

		command_buffer := wgpuCommandEncoderFinish(command_encoder, *(WGPUCommandBufferDescriptor.{label = "Cmd Buffer pipeline_controller_update"}));
		defer wgpuCommandBufferRelease(command_buffer);
		wgpuQueueSubmit(translate_controller.wgpu_context.queue, commands_count, *command_buffer);
	}

}

compute_controller_collection_compute :: (ccc: *ComputeControllerCollection, scene_data: *SceneData) {
	// compute_controller_update_buffer(ccc.controllers[0], scene_data);
	// compute_controller_update_buffer(*ccc.controllers[1], *SCENE_DATA.offset);

	for ccc.controllers compute_controller_compute(it);
}