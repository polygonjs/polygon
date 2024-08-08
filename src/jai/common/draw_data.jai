BufferSizePair :: struct {
	buffer: WGPUBuffer;
	buffer_size: u64;
}
DrawUniformData :: struct {
	buffer: WGPUBuffer;
	bind_group_entries: []WGPUBindGroupEntry;
	bind_group: WGPUBindGroup;
}
DrawDataUniform :: struct {
	object: DrawUniformData;
	camera: DrawUniformData;
	sdf: DrawUniformData;
}


DrawData :: struct {
	shader_module: WGPUShaderModule;
	vertex_buffer_layout:WGPUVertexBufferLayout;
	vertex_attributes:[]WGPUVertexAttribute;
	pipeline_descriptor: WGPURenderPipelineDescriptor;
	pipeline: WGPURenderPipeline;
	fragment_state: WGPUFragmentState;
	color_target_state: WGPUColorTargetState;
	//
	vertex:BufferSizePair;
	index:BufferSizePair;
	uniforms:DrawDataUniform;
	// object_uniform_buffer:WGPUBuffer;
	// object_bind_group:WGPUBindGroup;
	// object_uniform_entries:[]WGPUBindGroupEntry;
	// //
	// camera_uniform_buffer: WGPUBuffer;
	// camera_bind_group: WGPUBindGroup;
	// camera_uniform_entries: []WGPUBindGroupEntry;
	// //
	// sdf_uniform_buffer: WGPUBuffer;
	// sdf_bind_group:WGPUBindGroup;
	// sdf_uniform_entries:[]WGPUBindGroupEntry;
};
