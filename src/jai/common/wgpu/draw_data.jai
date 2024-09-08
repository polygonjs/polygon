MeshDrawData :: struct {
	vertex:[..]BufferContainer;
	index:BufferContainer;
	uniforms:PipelineDataUniform;
}

draw_data_create :: (pc: *PipelineController, mesh: *Mesh)-> MeshDrawData {
	wgpu_context := pc.wgpu_context;
	attributes := mesh.geometry.attributes;
	indices := mesh.geometry.indices;
	draw_data :MeshDrawData;
	// if pc.compute_shader_controllers.count > 0 {
	// 	// buffer_container := wgpu_geometry_attribute_to_buffer(wgpu_context, *mesh.geometry.attributes.position, Vector3);
	// 	buffer_container := wgpu_buffer_from_geometry_attribute(wgpu_context, *attributes.position, Vector3, compute=true);
	// 	for pc.compute_shader_controllers {

	// 		box_controller = compute_shader_controller_create(
	// 			wgpu_context,
	// 			SHADER_COMPUTE_BOX,
	// 			"boxCompute",
	// 			buffer_container
	// 		);

	// 		offset_controller = compute_shader_controller_create(
	// 			wgpu_context,
	// 			SHADER_COMPUTE_OFFSET,
	// 			"boxOffsetCompute",
	// 			buffer_container
	// 		);
	// 	}
	// } else {
		array_add(*draw_data.vertex, wgpu_buffer_from_geometry_attribute(wgpu_context, *attributes.position, Vector3));
	// }
	array_add(*draw_data.vertex, wgpu_buffer_from_geometry_attribute(wgpu_context, *attributes.normal, Vector3));
	array_add(*draw_data.vertex, wgpu_buffer_from_geometry_attribute(wgpu_context, *attributes.color, Vector3));
	array_add(*draw_data.vertex, wgpu_buffer_from_geometry_attribute(wgpu_context, *attributes.uv, Vector2));
	draw_data.index.buffer,
	draw_data.index.buffer_size = wgpu_index_array_to_buffer(wgpu_context, indices);

	draw_data.uniforms.object.buffer,
	draw_data.uniforms.object.bind_group,
	draw_data.uniforms.object.bind_group_entries = wgpu_uniform_to_buffer(wgpu_context, pc.pipeline, 0, mesh.uniforms);//wgpu_object_uniform_to_buffer(wgpu_context, pc.pipeline, mesh.uniforms);

	draw_data.uniforms.camera.buffer,
	draw_data.uniforms.camera.bind_group,
	draw_data.uniforms.camera.bind_group_entries = wgpu_uniform_to_buffer(wgpu_context, pc.pipeline, 1, SCENE_DATA.camera.uniforms);//wgpu_camera_uniform_to_buffer(wgpu_context, pc.pipeline, SCENE_DATA.camera.uniforms);

	draw_data.uniforms.material.buffer,
	draw_data.uniforms.material.bind_group,
	draw_data.uniforms.material.bind_group_entries = wgpu_uniform_to_buffer(wgpu_context, pc.pipeline, 2, pc.material.uniforms);//wgpu_sdf_uniform_to_buffer(wgpu_context, pc.pipeline, SCENE_DATA.sdf_uniforms);

	return draw_data;
}


draw_data_update :: (pc: *PipelineController, draw_data: *MeshDrawData, mesh: *Mesh) {
	// TODO: this is a duplication with the create function, refactor
	{
		using mesh.geometry.attributes;
		container := draw_data.vertex[0];
		wgpuQueueWriteBuffer(pc.wgpu_context.queue, container.buffer, 0, position.values.data, container.buffer_size);
		container = draw_data.vertex[1];
		wgpuQueueWriteBuffer(pc.wgpu_context.queue, container.buffer, 0, normal.values.data, container.buffer_size);
		container = draw_data.vertex[2];
		wgpuQueueWriteBuffer(pc.wgpu_context.queue, container.buffer, 0, color.values.data, container.buffer_size);
		container = draw_data.vertex[3];
		wgpuQueueWriteBuffer(pc.wgpu_context.queue, container.buffer, 0, uv.values.data, container.buffer_size);
	}

	{
		using mesh.geometry;
		container := draw_data.index;
		wgpuQueueWriteBuffer(pc.wgpu_context.queue, container.buffer, 0, indices.data, container.buffer_size);
	}

}

draw_data_release :: (draw_data: *MeshDrawData) {
	for v: draw_data.vertex {
		wgpuBufferRelease(v.buffer);
		// wgpuBufferDestroy(v.buffer);
	}
	wgpuBufferRelease(draw_data.index.buffer);
	// wgpuBufferDestroy(draw_data.index.buffer);
}