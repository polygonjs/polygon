
materialInitDrawDataVertexBuffers :: (wgpuContext: *WGPUContext, mesh: *Mesh, material: *Material, pc: *PipelineController, drawData: *MeshDrawData) {

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

materialApplyVertexBufferLayout :: (material: *$T, pc : *PipelineController) {
	materialApplyVertexBufferLayoutDefault(xx material, pc);
}
materialApplyVertexBufferLayoutDefault :: (material: *Material, pc : *PipelineController) {

	_attributeToVertexBufferLayout :: (format:WGPUVertexFormat, stride: u64, location: u32) -> WGPUVertexBufferLayout, WGPUVertexAttribute {
		assert(format != WGPUVertexFormat.Undefined, "format is Undefined\n");
		attribute:WGPUVertexAttribute= .{
			format=format,
			offset=0,
			shaderLocation=location,
		};
		layout := WGPUVertexBufferLayout.{
			arrayStride=stride, //size_of(type),
			stepMode=.Vertex,
			attributeCount=1,
			// attributes=attributes.data
		};
		return layout, attribute;
	}

	array_reset(*pc.vertexBufferLayouts);
	array_reset(*pc.vertexAttributes);

	i :u32= 0; // position
	{
		layout, attribute := _attributeToVertexBufferLayout(.Float32x3, xx size_of(Vector3), i);
		array_add(*pc.vertexBufferLayouts, layout);
		array_add(*pc.vertexAttributes, attribute);
		pc.vertexBufferLayouts[i].attributes = *pc.vertexAttributes[i];
	}
	i+=1; // normal
	{
		layout, attribute := _attributeToVertexBufferLayout(.Float32x3, xx size_of(Vector3), i);
		array_add(*pc.vertexBufferLayouts, layout);
		array_add(*pc.vertexAttributes, attribute);
		pc.vertexBufferLayouts[i].attributes = *pc.vertexAttributes[i];
	}
	i+=1; // uv
	{
		layout, attribute := _attributeToVertexBufferLayout(.Float32x2, xx size_of(Vector2), i);
		array_add(*pc.vertexBufferLayouts, layout);
		array_add(*pc.vertexAttributes, attribute);
		pc.vertexBufferLayouts[i].attributes = *pc.vertexAttributes[i];
	}
}