ComputeControllerCollection :: struct {
	controllers: [..]ComputeShaderController;
}

compute_controller_collection_create :: (wgpu_context: *WGPUContext) -> ComputeControllerCollection {
	ccc :ComputeControllerCollection;
	buffer_container := wgpu_buffer_for_compute(wgpu_context, 8 * size_of(Vector3));

	box_controller := compute_shader_controller_create(
		wgpu_context,
		SHADER_COMPUTE_BOX,
		"boxCompute",
		buffer_container
	);

	offset_controller := compute_shader_controller_create(
		wgpu_context,
		SHADER_COMPUTE_OFFSET,
		"boxOffsetCompute",
		buffer_container
	);

	array_add(*ccc.controllers, box_controller);
	array_add(*ccc.controllers, offset_controller);
	return ccc;
}

pipeline_controlller_update :: (pc: *PipelineController, ccc: *ComputeControllerCollection) {
	pc.meshes_draw_data[0].vertex[0] = ccc.controllers[0].vertex;
	// wgpuRenderPassEncoderSetVertexBuffer(<<render_pass_encoder, 0, box_controller.vertex.buffer, 0, box_controller.vertex.buffer_size);
}

compute_controller_collection_compute :: (ccc: *ComputeControllerCollection) {
	compute_shader_controller_update_buffer(*ccc.controllers[0], *SCENE_DATA.box_size);
	compute_shader_controller_update_buffer(*ccc.controllers[1], *SCENE_DATA.offset);

	for ccc.controllers compute_shader_controller_compute(*it);
}