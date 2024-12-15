MeshDrawData :: struct {
	vertex:[..]BufferContainer;
	index:BufferContainer;
	uniforms:PipelineDataUniform;
}

newDrawData :: (pc: *PipelineController, mesh: *Mesh)-> *MeshDrawData {
	renderer := pc.renderer;
	wgpuContext := renderer.wgpuContext;
	drawData :*MeshDrawData = New(MeshDrawData,, renderer.allocator);
	push_allocator(pc.renderer.allocator);
	array_init(*drawData.vertex);

	{
		using mesh.geometry.attributes;
		// if pc.compute_shader_controllers.count > 0 {
		// 	// buffer_container := wgpu_geometry_attribute_to_buffer(wgpuContext, *mesh.geometry.attributes.position, Vector3);
		// 	buffer_container := wgpu_buffer_from_geometry_attribute(wgpuContext, *attributes.position, Vector3, compute=true);
		// 	for pc.compute_shader_controllers {

		// 		box_controller = compute_shader_controller_create(
		// 			wgpuContext,
		// 			SHADER_COMPUTE_BOX,
		// 			"boxCompute",
		// 			buffer_container
		// 		);

		// 		offset_controller = compute_shader_controller_create(
		// 			wgpuContext,
		// 			SHADER_COMPUTE_OFFSET,
		// 			"boxOffsetCompute",
		// 			buffer_container
		// 		);
		// 	}
		// } else {
			array_add(*drawData.vertex, wgpu_buffer_from_geometry_attribute(wgpuContext, *position, Vector3, "position"));
		// }
		array_add(*drawData.vertex, wgpu_buffer_from_geometry_attribute(wgpuContext, *normal, Vector3, "normal"));
		// array_add(*draw_data.vertex, wgpu_buffer_from_geometry_attribute(wgpuContext, *color, Vector3, "color"));
		array_add(*drawData.vertex, wgpu_buffer_from_geometry_attribute(wgpuContext, *uv, Vector2, "uv"));
	}

	{
		using drawData.index;
		buffer,
		buffer_size = wgpu_index_array_to_buffer(wgpuContext, mesh.geometry.indices);
	}

	{
		using drawData.uniforms;
		{
			using object;
			buffer,
			bind_group,
			bind_group_entries = wgpu_uniform_to_buffer(wgpuContext, pc.pipeline, xx UniformBindingIndex.OBJECT, mesh.transformableUniforms, "object");
		}
		{
			using material;
			buffer,
			bind_group,
			bind_group_entries = wgpu_uniform_to_buffer_with_size(wgpuContext, pc.pipeline, xx UniformBindingIndex.MATERIAL, *pc.material.uniforms, pc.material.uniformTypeSize, "material");
		}
	}


	return drawData;
}


draw_data_update :: (pc: *PipelineController, using draw_data: *MeshDrawData, mesh: *Mesh) {
	// TODO: this is a duplication with the create function, refactor
	queue := pc.renderer.wgpuContext.queue;
	{
		using mesh.geometry.attributes;
		{
			container := vertex[0];
			wgpuQueueWriteBuffer(queue, container.buffer, 0, position.values.data, container.buffer_size);
		}
		{
			container := vertex[1];
			wgpuQueueWriteBuffer(queue, container.buffer, 0, normal.values.data, container.buffer_size);
		}
		{
			// container := draw_data.vertex[2];
			// wgpuQueueWriteBuffer(pc.wgpuContext.queue, container.buffer, 0, color.values.data, container.buffer_size);
		}
		{
			container := vertex[2];
			wgpuQueueWriteBuffer(queue, container.buffer, 0, uv.values.data, container.buffer_size);
		}
	}

	{
		using mesh.geometry;
		container := index;
		wgpuQueueWriteBuffer(queue, container.buffer, 0, indices.data, container.buffer_size);
	}
}

drawDataBuffersScheduleDestroy :: (using renderer: *Renderer, drawData: *MeshDrawData) {
	for v: drawData.vertex {
		array_add(*buffers_to_destroy, v);
	}
	array_add(*buffers_to_destroy, drawData.index);
}