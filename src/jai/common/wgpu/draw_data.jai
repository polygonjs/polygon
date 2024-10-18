MeshDrawData :: struct {
	vertex:[..]BufferContainer;
	index:BufferContainer;
	uniforms:PipelineDataUniform;
}

draw_data_create :: (pc: *PipelineController, mesh: *Mesh, scene:*Scene)-> MeshDrawData {
	wgpu_context := pc.wgpu_context;
	draw_data :MeshDrawData;

	{
		using mesh.geometry.attributes;
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
			array_add(*draw_data.vertex, wgpu_buffer_from_geometry_attribute(wgpu_context, *position, Vector3, "position"));
		// }
		array_add(*draw_data.vertex, wgpu_buffer_from_geometry_attribute(wgpu_context, *normal, Vector3, "normal"));
		// array_add(*draw_data.vertex, wgpu_buffer_from_geometry_attribute(wgpu_context, *color, Vector3, "color"));
		array_add(*draw_data.vertex, wgpu_buffer_from_geometry_attribute(wgpu_context, *uv, Vector2, "uv"));
	}

	{
		using draw_data.index;
		buffer,
		buffer_size = wgpu_index_array_to_buffer(wgpu_context, mesh.geometry.indices);
	}

	{
		using draw_data.uniforms;
		{
			using object;
			buffer,
			bind_group,
			bind_group_entries = wgpu_uniform_to_buffer(wgpu_context, pc.pipeline, xx UniformBindingIndex.OBJECT, mesh.transformable_uniforms, "object");
		}
		// {
		// 	using camera;
		// 	buffer,
		// 	bind_group,
		// 	bind_group_entries = wgpu_uniform_to_buffer(wgpu_context, pc.pipeline, xx UniformBindingIndex.CAMERA, scene.orbit_controls.camera.uniforms, "camera");
		// }
		{
			using material;
			buffer,
			bind_group,
			bind_group_entries = wgpu_uniform_to_buffer(wgpu_context, pc.pipeline, xx UniformBindingIndex.MATERIAL, pc.material.uniforms, "material");
		}
	}


	return draw_data;
}


draw_data_update :: (pc: *PipelineController, draw_data: *MeshDrawData, mesh: *Mesh) {
	// TODO: this is a duplication with the create function, refactor
	{
		using mesh.geometry.attributes;
		{
			container := draw_data.vertex[0];
			wgpuQueueWriteBuffer(pc.wgpu_context.queue, container.buffer, 0, position.values.data, container.buffer_size);
		}
		{
			container := draw_data.vertex[1];
			wgpuQueueWriteBuffer(pc.wgpu_context.queue, container.buffer, 0, normal.values.data, container.buffer_size);
		}
		{
			// container := draw_data.vertex[2];
			// wgpuQueueWriteBuffer(pc.wgpu_context.queue, container.buffer, 0, color.values.data, container.buffer_size);
		}
		{
			container := draw_data.vertex[2];
			wgpuQueueWriteBuffer(pc.wgpu_context.queue, container.buffer, 0, uv.values.data, container.buffer_size);
		}
	}

	{
		using mesh.geometry;
		container := draw_data.index;
		wgpuQueueWriteBuffer(pc.wgpu_context.queue, container.buffer, 0, indices.data, container.buffer_size);
	}
}

draw_data_buffers_schedule_destroy :: (pc: *PipelineController, draw_data: *MeshDrawData) {
	for v: draw_data.vertex {
		array_add(*pc.buffers_to_destroy, v);
	}
	array_add(*pc.buffers_to_destroy, draw_data.index);
}