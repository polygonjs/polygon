
geometry_attribute_to_vertex_buffer_layout :: (geometry_attribute: *GeometryAttribute, stride: u64, location: u32) -> WGPUVertexBufferLayout, WGPUVertexAttribute {
	attribute:WGPUVertexAttribute= .{
		format=geometry_attribute.format,
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

geometry_attributes_to_vertex_buffer_layouts :: (pc : *PipelineController, geometry_attributes: *GeometryAttributes) {
	array_reset(*pc.vertex_buffer_layouts);
	array_reset(*pc.vertex_attributes);

	i :u32= 0;
	layout, attribute := geometry_attribute_to_vertex_buffer_layout(*geometry_attributes.position, xx size_of(Vector3), i);
	array_add(*pc.vertex_buffer_layouts, layout);
	array_add(*pc.vertex_attributes, attribute);
	pc.vertex_buffer_layouts[i].attributes = *pc.vertex_attributes[i];

	i+=1;
	layout, attribute = geometry_attribute_to_vertex_buffer_layout(*geometry_attributes.normal, xx size_of(Vector3), i);
	array_add(*pc.vertex_buffer_layouts, layout);
	array_add(*pc.vertex_attributes, attribute);
	pc.vertex_buffer_layouts[i].attributes = *pc.vertex_attributes[i];

	i+=1;
	layout, attribute = geometry_attribute_to_vertex_buffer_layout(*geometry_attributes.color, xx size_of(Vector3), i);
	array_add(*pc.vertex_buffer_layouts, layout);
	array_add(*pc.vertex_attributes, attribute);
	pc.vertex_buffer_layouts[i].attributes = *pc.vertex_attributes[i];

	i+=1;
	layout, attribute = geometry_attribute_to_vertex_buffer_layout(*geometry_attributes.uv, xx size_of(Vector2), i);
	array_add(*pc.vertex_buffer_layouts, layout);
	array_add(*pc.vertex_attributes, attribute);
	pc.vertex_buffer_layouts[i].attributes = *pc.vertex_attributes[i];

}



wgpu_index_array_to_buffer :: (wgpu_context: *WGPUContext, indices: []VertexIndex) -> WGPUBuffer, u64 {
	size := cast(u64) indices.count * size_of(VertexIndex);

	buffer_desc:WGPUBufferDescriptor= .{
		usage = xx (WGPUBufferUsage.Index | WGPUBufferUsage.CopyDst),
		size=size
	};
	buffer := wgpuDeviceCreateBuffer(wgpu_context.device, *buffer_desc);
	assert(buffer != null, "Buffer is not created correctly");

	wgpuQueueWriteBuffer(wgpu_context.queue, buffer, 0, indices.data, size);

	return buffer, size;
}