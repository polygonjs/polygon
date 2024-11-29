on_wgpu_device_ready :: (
	canvas: WGPUSurface,
	device: WGPUDevice,
	queue: WGPUQueue,
	preferred_texture_format: WGPUTextureFormat
) {
	if USE_IMGUI_DEBUG return;

	context = call_from_wasm_context;
	renderer_init_wasm(canvas, device, queue, preferred_texture_format);
}

wgpu_texture_get_width_surface :: (wgpu_context: *WGPUContext) -> u32 {
	return js_wgpu_texture_get_width_surface(wgpu_context.surface);
}
wgpu_texture_get_height_surface :: (wgpu_context: *WGPUContext) -> u32 {
	return js_wgpu_texture_get_height_surface(wgpu_context.surface);
}


js_wgpu_texture_get_width_surface :: (surface: WGPUSurface)-> u32 #foreign;
js_wgpu_texture_get_height_surface :: (surface: WGPUSurface)-> u32 #foreign;

wgpuDevicePoll :: (device: WGPUDevice, wait: WGPUBool, wrappedSubmissionIndex: *WGPUWrappedSubmissionIndex) -> WGPUBool #foreign;

wgpuSurfaceGetCurrentTexture :: ()-> WGPUTexture #foreign;

// Methods of BindGroup
wgpuBindGroupRelease :: (bindGroup: WGPUBindGroup) -> void #foreign;

// Methods of BindGroupLayout
wgpuBindGroupLayoutRelease :: (bindGroupLayout: WGPUBindGroupLayout) -> void #foreign;

// Methods of Buffer
wgpuBufferDestroy :: (buffer: WGPUBuffer) -> void #foreign;
// wgpuBufferRelease :: (buffer: WGPUBuffer) -> void #foreign;
wgpuBufferGetMappedRange :: (buffer: WGPUBuffer, offset: u64, size: u64) -> *void #foreign;
wgpuBufferGetMapState :: (buffer: WGPUBuffer) -> WGPUBufferMapState #foreign;
wgpuBufferMapAsync :: (buffer: WGPUBuffer, mode: WGPUMapModeFlags, offset: u64, size: u64, callback: WGPUBufferMapCallback, userdata: *void) -> void #foreign;
wgpuBufferUnmap :: (buffer: WGPUBuffer) -> void #foreign;

// Methods of RenderPipeline
wgpuRenderPipelineGetBindGroupLayout :: (pipeline: WGPURenderPipeline, index: u32) -> WGPUBindGroupLayout #foreign;
wgpuRenderPipelineRelease :: (renderPipeline: WGPURenderPipeline) -> void #foreign;


// Methods of CommandEncoder
wgpuCommandEncoderBeginComputePass :: (commandEncoder: WGPUCommandEncoder, descriptor: *WGPUComputePassDescriptor) -> WGPUComputePassEncoder #foreign;
wgpuCommandEncoderCopyBufferToBuffer :: (commandEncoder: WGPUCommandEncoder, source: WGPUBuffer, sourceOffset: u64, destination: WGPUBuffer, destinationOffset: u64, size: u64) -> void #foreign;
wgpuCommandEncoderCopyTextureToBuffer :: (commandEncoder: WGPUCommandEncoder, source: *WGPUImageCopyTexture, destination: *WGPUImageCopyBuffer, copySize: *WGPUExtent3D) -> void #foreign;


// Methods of ComputePassEncoder
wgpuComputePassEncoderDispatchWorkgroups :: (computePassEncoder: WGPUComputePassEncoder, workgroupCountX: u32, workgroupCountY: u32, workgroupCountZ: u32) -> void #foreign;
wgpuComputePassEncoderEnd :: (computePassEncoder: WGPUComputePassEncoder) -> void #foreign;
wgpuComputePassEncoderSetBindGroup :: (computePassEncoder: WGPUComputePassEncoder, groupIndex: u32, group: WGPUBindGroup, dynamicOffsetCount: u64, dynamicOffsets: *u32) -> void #foreign;
wgpuComputePassEncoderRelease :: (computePassEncoder: WGPUComputePassEncoder) -> void #foreign;
wgpuComputePassEncoderSetPipeline :: (computePassEncoder: WGPUComputePassEncoder, pipeline: WGPUComputePipeline) -> void #foreign;
wgpuCommandEncoderInsertDebugMarker :: (commandEncoder: WGPUCommandEncoder, markerLabel: *u8) -> void #foreign;


// Methods of ComputePipeline
wgpuComputePipelineGetBindGroupLayout :: (computePipeline: WGPUComputePipeline, groupIndex: u32) -> WGPUBindGroupLayout #foreign;


// Methods of Device
wgpuDeviceCreateTexture :: (device: WGPUDevice, descriptor: *WGPUTextureDescriptor) -> WGPUTexture #foreign;
wgpuDeviceCreateBindGroup :: (device: WGPUDevice, bind_group_descriptor: *WGPUBindGroupDescriptor) -> WGPUBindGroup #foreign;
wgpuDeviceCreateCommandEncoder :: (device: WGPUDevice, descriptor: *WGPUCommandEncoderDescriptor) -> WGPUCommandEncoder #foreign;
wgpuDeviceCreateComputePipeline :: (device: WGPUDevice, descriptor: *WGPUComputePipelineDescriptor) -> WGPUComputePipeline #foreign;
wgpuDeviceCreateSampler :: (device: WGPUDevice, descriptor: *WGPUSamplerDescriptor) -> WGPUSampler #foreign;
wgpuDeviceCreateShaderModule :: (device: WGPUDevice, descriptor: *WGPUShaderModuleDescriptor) -> WGPUShaderModule #foreign;
wgpuDeviceGetQueue :: (device: WGPUDevice) -> WGPUQueue #foreign;

// Methods of Queue
wgpuDeviceCreateBindGroupLayout :: (device: WGPUDevice, descriptor: *WGPUBindGroupLayoutDescriptor) -> WGPUBindGroupLayout #foreign;
wgpuDeviceCreatePipelineLayout :: (device: WGPUDevice, data: *WGPUPipelineLayoutDescriptor)-> WGPUPipelineLayout #foreign;
wgpuDeviceCreateRenderPipeline :: (device: WGPUDevice, pipeline_descriptor: *WGPURenderPipelineDescriptor)-> WGPURenderPipeline #foreign;
wgpuDeviceCreateBuffer :: (device: WGPUDevice, descriptor: *WGPUBufferDescriptor)-> WGPUBuffer #foreign;
wgpuQueueWriteBuffer :: (queue: WGPUQueue, buffer: WGPUBuffer, bufferOffset: u64, data: *void, size: u64)-> void #foreign;
wgpuQueueSubmit :: (queue: WGPUQueue, commandCount: u64, commands: *WGPUCommandBuffer) -> void #foreign;
wgpuQueueWriteTexture :: (queue: WGPUQueue, destination: *WGPUImageCopyTexture, data: *void, dataSize: u64, dataLayout: *WGPUTextureDataLayout, writeSize: *WGPUExtent3D) -> void #foreign;
wgpuQueueRelease :: (queue: WGPUQueue) -> void #foreign;

// Methods of RenderPassEncoder
wgpuRenderPassEncoderRelease :: (renderPassEncoder: WGPURenderPassEncoder) -> void #foreign;
wgpuRenderPassEncoderSetPipeline :: (renderPassEncoder: WGPURenderPassEncoder, pipeline: WGPURenderPipeline) -> void #foreign;
wgpuRenderPassEncoderSetBindGroup :: (renderPassEncoder: WGPURenderPassEncoder, groupIndex: u32, group: WGPUBindGroup, dynamicOffsetCount: u64, dynamicOffsets: *u32) -> void #foreign;
wgpuRenderPassEncoderSetVertexBuffer :: (renderPassEncoder: WGPURenderPassEncoder, slot: u32, buffer: WGPUBuffer, offset: u64, size: u64) -> void #foreign;
wgpuRenderPassEncoderSetIndexBuffer :: (renderPassEncoder: WGPURenderPassEncoder, buffer: WGPUBuffer, format: WGPUIndexFormat, offset: u64, size: u64) -> void #foreign;
wgpuRenderPassEncoderDrawIndexed :: (renderPassEncoder: WGPURenderPassEncoder, indexCount: u32, instanceCount: u32, firstIndex: u32, baseVertex: s32, firstInstance: u32) -> void #foreign;
wgpuRenderPassEncoderEnd :: (renderPassEncoder: WGPURenderPassEncoder) -> void #foreign;
wgpuRenderPassEncoderSetViewport :: (renderPassEncoder: WGPURenderPassEncoder, x: float, y: float, width: float, height: float, minDepth: float, maxDepth: float) -> void #foreign;
wgpuRenderPassEncoderSetBlendConstant :: (renderPassEncoder: WGPURenderPassEncoder, color: *WGPUColor) -> void #foreign;
wgpuRenderPassEncoderSetScissorRect :: (renderPassEncoder: WGPURenderPassEncoder, x: u32, y: u32, width: u32, height: u32) -> void #foreign;


// Methods of CommandBuffer
wgpuCommandBufferRelease :: (commandBuffer: WGPUCommandBuffer) -> void #foreign;

// Methods of CommandEncoder
wgpuCommandEncoderBeginRenderPass :: (commandEncoder: WGPUCommandEncoder, descriptor: *WGPURenderPassDescriptor) -> WGPURenderPassEncoder #foreign;
wgpuCommandEncoderRelease :: (commandEncoder: WGPUCommandEncoder) -> void #foreign;
wgpuCommandEncoderFinish :: (commandEncoder: WGPUCommandEncoder, descriptor: *WGPUCommandBufferDescriptor) -> WGPUCommandBuffer #foreign;

// Methods of Sampler
wgpuSamplerRelease :: (sampler: WGPUSampler) -> void #foreign;

// Methods of ShaderModule
wgpuShaderModuleRelease :: (shaderModule: WGPUShaderModule) -> void #foreign;

// Methods of Surface
// wgpuSurfaceGetCurrentTexture :: (surface: WGPUSurface, surfaceTexture: *WGPUSurfaceTexture) -> void #foreign;

// Methods of Texture
wgpuTextureCreateView :: (texture: WGPUTexture, descriptor: *WGPUTextureViewDescriptor) -> WGPUTextureView #foreign;
wgpuTextureGetHeight :: (texture: WGPUTexture) -> u32 #foreign;
wgpuTextureGetWidth :: (texture: WGPUTexture) -> u32 #foreign;
wgpuTextureRelease :: (texture: WGPUTexture) -> void #foreign;

// Methods of TextureView
wgpuTextureViewRelease :: (textureView: WGPUTextureView) -> void #foreign;

