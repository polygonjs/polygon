wgpu_create_shader_module :: (device: WGPUDevice, source: string, label :string)-> WGPUShaderModule {
	return js_wgpu_create_shader_module(device, source.count, source.data, label.count, label.data);
}
wgpu_texture_get_width_surface :: (wgpu_context: *WGPUContext) -> u32 {
	return js_wgpu_texture_get_width_surface(wgpu_context.surface);
}
wgpu_texture_get_height_surface :: (wgpu_context: *WGPUContext) -> u32 {
	return js_wgpu_texture_get_height_surface(wgpu_context.surface);
}

js_wgpu_create_shader_module :: (device: WGPUDevice, source_count: s64, source_data: *u8, label_count: s64, label_data: *u8)-> WGPUShaderModule #foreign;
js_wgpu_texture_get_width_surface :: (surface: WGPUSurface)-> u32 #foreign;
js_wgpu_texture_get_height_surface :: (surface: WGPUSurface)-> u32 #foreign;

// Methods of RenderPipeline
wgpuRenderPipelineGetBindGroupLayout :: (pipeline: WGPURenderPipeline, index: u32) -> WGPUBindGroupLayout #foreign;

// Methods of Device
wgpuDeviceCreateTexture :: (device: WGPUDevice, descriptor: *WGPUTextureDescriptor) -> WGPUTexture #foreign;
wgpuDeviceCreateBindGroup :: (device: WGPUDevice, bind_group_descriptor: *WGPUBindGroupDescriptor) -> WGPUBindGroup #foreign;
wgpuDeviceCreateCommandEncoder :: (device: WGPUDevice, descriptor: *WGPUCommandEncoderDescriptor) -> WGPUCommandEncoder #foreign;

// Methods of Queue
wgpuDeviceCreateBindGroupLayout :: (device: WGPUDevice, descriptor: *WGPUBindGroupLayoutDescriptor) -> WGPUBindGroupLayout #foreign;
wgpuDeviceCreatePipelineLayout :: (device: WGPUDevice, data: *WGPUPipelineLayoutDescriptor)-> WGPUPipelineLayout #foreign;
wgpuDeviceCreateRenderPipeline :: (device: WGPUDevice, pipeline_descriptor: *WGPURenderPipelineDescriptor)-> WGPURenderPipeline #foreign;
wgpuDeviceCreateBuffer :: (device: WGPUDevice, descriptor: *WGPUBufferDescriptor)-> WGPUBuffer #foreign;
wgpuQueueWriteBuffer :: (queue: WGPUQueue, buffer: WGPUBuffer, bufferOffset: u64, data: *void, size: u64)-> void #foreign;
wgpuQueueSubmit :: (queue: WGPUQueue, commandCount: u64, commands: *WGPUCommandBuffer) -> void #foreign;

// Methods of RenderPassEncoder
wgpuRenderPassEncoderRelease :: (renderPassEncoder: WGPURenderPassEncoder) -> void #foreign;
wgpuRenderPassEncoderSetPipeline :: (renderPassEncoder: WGPURenderPassEncoder, pipeline: WGPURenderPipeline) -> void #foreign;
wgpuRenderPassEncoderSetBindGroup :: (renderPassEncoder: WGPURenderPassEncoder, groupIndex: u32, group: WGPUBindGroup, dynamicOffsetCount: u64, dynamicOffsets: *u32) -> void #foreign;
wgpuRenderPassEncoderSetVertexBuffer :: (renderPassEncoder: WGPURenderPassEncoder, slot: u32, buffer: WGPUBuffer, offset: u64, size: u64) -> void #foreign;
wgpuRenderPassEncoderSetIndexBuffer :: (renderPassEncoder: WGPURenderPassEncoder, buffer: WGPUBuffer, format: WGPUIndexFormat, offset: u64, size: u64) -> void #foreign;
wgpuRenderPassEncoderDrawIndexed :: (renderPassEncoder: WGPURenderPassEncoder, indexCount: u32, instanceCount: u32, firstIndex: u32, baseVertex: s32, firstInstance: u32) -> void #foreign;
wgpuRenderPassEncoderEnd :: (renderPassEncoder: WGPURenderPassEncoder) -> void #foreign;

// Methods of CommandBuffer
wgpuCommandBufferRelease :: (commandBuffer: WGPUCommandBuffer) -> void #foreign;

// Methods of CommandEncoder
wgpuCommandEncoderBeginRenderPass :: (commandEncoder: WGPUCommandEncoder, descriptor: *WGPURenderPassDescriptor) -> WGPURenderPassEncoder #foreign;
wgpuCommandEncoderRelease :: (commandEncoder: WGPUCommandEncoder) -> void #foreign;
wgpuCommandEncoderFinish :: (commandEncoder: WGPUCommandEncoder, descriptor: *WGPUCommandBufferDescriptor) -> WGPUCommandBuffer #foreign;

// Methods of Surface
// wgpuSurfaceGetCurrentTexture :: (surface: WGPUSurface, surfaceTexture: *WGPUSurfaceTexture) -> void #foreign;

// Methods of Texture
wgpuTextureCreateView :: (texture: WGPUTexture, descriptor: *WGPUTextureViewDescriptor) -> WGPUTextureView #foreign;
wgpuTextureGetHeight :: (texture: WGPUTexture) -> u32 #foreign;
wgpuTextureGetWidth :: (texture: WGPUTexture) -> u32 #foreign;
wgpuTextureRelease :: (texture: WGPUTexture) -> void #foreign;

// Methods of TextureView
wgpuTextureViewRelease :: (textureView: WGPUTextureView) -> void #foreign;
