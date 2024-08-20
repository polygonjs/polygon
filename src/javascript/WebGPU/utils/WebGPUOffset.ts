export const WGPU_OFFSET = {
	/*
WGPUBindGroupLayoutEntry (with size=104) contains the following members:
- 0: nextInChain of type *WGPUChainedStruct with offset 0
- 1: binding of type u32 with offset 8
- 2: visibility of type u32 with offset 12
- 3: buffer of type WGPUBufferBindingLayout with offset 16
- 4: sampler of type WGPUSamplerBindingLayout with offset 40
- 5: texture of type WGPUTextureBindingLayout with offset 56
- 6: storageTexture of type WGPUStorageTextureBindingLayout with offset 80
	*/
	WGPUBindGroupLayoutEntry: {
		nextInChain: BigInt(0),
		binding: BigInt(8),
		visibility: BigInt(12),
		buffer: BigInt(16),
		sampler: BigInt(40),
		texture: BigInt(56),
		storageTexture: BigInt(80),
	},
	/*
WGPUBufferBindingLayout contains the following members:
- 0: nextInChain of type *WGPUChainedStruct with offset 0
- 1: type of type WGPUBufferBindingType with offset 8
- 2: hasDynamicOffset of type u32 with offset 12
- 3: minBindingSize of type u64 with offset 16
	*/
	WGPUBufferBindingLayout: {
		nextInChain: BigInt(0),
		type: BigInt(8),
		hasDynamicOffset: BigInt(12),
		minBindingSize: BigInt(16),
	},
	/*
WGPUPipelineLayoutDescriptor contains the following members:
- 0: nextInChain of type *WGPUChainedStruct with offset 0
- 1: label of type *u8 with offset 8
- 2: bindGroupLayoutCount of type u64 with offset 16
- 3: bindGroupLayouts of type **WGPUBindGroupLayoutImpl with offset 24
	*/
	WGPUPipelineLayoutDescriptor: {
		nextInChain: BigInt(0),
		label: BigInt(8),
		bindGroupLayoutCount: BigInt(16),
		bindGroupLayouts: BigInt(24),
	},
	/*
WGPURenderPipelineDescriptor (with size=144) contains the following members:
- 0: nextInChain of type *WGPUChainedStruct with offset 0
- 1: label of type *u8 with offset 8
- 2: layout of type *WGPUPipelineLayoutImpl with offset 16
- 3: vertex of type WGPUVertexState with offset 24
- 4: primitive of type WGPUPrimitiveState with offset 80
- 5: depthStencil of type *WGPUDepthStencilState with offset 104
- 6: multisample of type WGPUMultisampleState with offset 112
- 7: fragment of type *WGPUFragmentState with offset 136
*/
	WGPURenderPipelineDescriptor: {
		nextInChain: BigInt(0),
		label: BigInt(8),
		layout: BigInt(16),
		vertex: BigInt(24),
		primitive: BigInt(80),
		depthStencil: BigInt(104),
		multisample: BigInt(112),
		fragment: BigInt(136),
	},
	/*
WGPUVertexState (with size=56) contains the following members:
- 0: nextInChain of type *WGPUChainedStruct with offset 0
- 1: module of type *WGPUShaderModuleImpl with offset 8
- 2: entryPoint of type *u8 with offset 16
- 3: constantCount of type u64 with offset 24
- 4: constants of type *WGPUConstantEntry with offset 32
- 5: bufferCount of type u64 with offset 40
- 6: buffers of type *WGPUVertexBufferLayout with offset 48
	 */
	WGPUVertexState: {
		nextInChain: BigInt(0),
		module: BigInt(8),
		entryPoint: BigInt(16),
		constantCount: BigInt(24),
		constants: BigInt(32),
		bufferCount: BigInt(40),
		buffers: BigInt(48),
	},
	/*
WGPUVertexBufferLayout (with size=32) contains the following members:
- 0: arrayStride of type u64 with offset 0
- 1: stepMode of type WGPUVertexStepMode with offset 8
- 2: attributeCount of type u64 with offset 16
- 3: attributes of type *WGPUVertexAttribute with offset 24
	 */
	WGPUVertexBufferLayout: {
		arrayStride: BigInt(0),
		stepMode: BigInt(8),
		attributeCount: BigInt(16),
		attributes: BigInt(24),
	},
	/*
	WGPUVertexAttribute (with size=24) contains the following members:
- 0: format of type WGPUVertexFormat with offset 0
- 1: offset of type u64 with offset 8
- 2: shaderLocation of type u32 with offset 16
	 */
	WGPUVertexAttribute: {
		format: BigInt(0),
		offset: BigInt(8),
		shaderLocation: BigInt(16),
	},
	/*
WGPUPrimitiveState (with size=24) contains the following members:
- 0: nextInChain of type *WGPUChainedStruct with offset 0
- 1: topology of type WGPUPrimitiveTopology with offset 8
- 2: stripIndexFormat of type WGPUIndexFormat with offset 12
- 3: frontFace of type WGPUFrontFace with offset 16
- 4: cullMode of type WGPUCullMode with offset 20
	 */
	WGPUPrimitiveState: {
		nextInChain: BigInt(0),
		topology: BigInt(8),
		stripIndexFormat: BigInt(12),
		frontFace: BigInt(16),
		cullMode: BigInt(20),
	},
	/*
WGPUDepthStencilState (with size=72) contains the following members:
- 0: nextInChain of type *WGPUChainedStruct with offset 0
- 1: format of type WGPUTextureFormat with offset 8
- 2: depthWriteEnabled of type u32 with offset 12
- 3: depthCompare of type WGPUCompareFunction with offset 16
- 4: stencilFront of type WGPUStencilFaceState with offset 20
- 5: stencilBack of type WGPUStencilFaceState with offset 36
- 6: stencilReadMask of type u32 with offset 52
- 7: stencilWriteMask of type u32 with offset 56
- 8: depthBias of type s32 with offset 60
- 9: depthBiasSlopeScale of type float32 with offset 64
- 10: depthBiasClamp of type float32 with offset 68
	*/
	WGPUDepthStencilState: {
		nextInChain: BigInt(0),
		format: BigInt(8),
		depthWriteEnabled: BigInt(12),
		depthCompare: BigInt(16),
		stencilFront: BigInt(20),
		stencilBack: BigInt(36),
		stencilReadMask: BigInt(52),
		stencilWriteMask: BigInt(56),
		depthBias: BigInt(60),
		depthBiasSlopeScale: BigInt(64),
		depthBiasClamp: BigInt(68),
	},
	/*
WGPUStencilFaceState (with size=16) contains the following members:
- 0: compare of type WGPUCompareFunction with offset 0
- 1: failOp of type WGPUStencilOperation with offset 4
- 2: depthFailOp of type WGPUStencilOperation with offset 8
- 3: passOp of type WGPUStencilOperation with offset 12
	*/
	WGPUStencilFaceState: {
		compare: BigInt(0),
		failOp: BigInt(4),
		depthFailOp: BigInt(8),
		passOp: BigInt(12),
	},
	/*
WGPUMultisampleState (with size=24) contains the following members:
- 0: nextInChain of type *WGPUChainedStruct with offset 0
- 1: count of type u32 with offset 8
- 2: mask of type u32 with offset 12
- 3: alphaToCoverageEnabled of type u32 with offset 16
	*/
	WGPUMultisampleState: {
		nextInChain: BigInt(0),
		count: BigInt(8),
		mask: BigInt(12),
		alphaToCoverageEnabled: BigInt(16),
	},
	/*
	WGPUFragmentState (with size=56) contains the following members:
- 0: nextInChain of type *WGPUChainedStruct with offset 0
- 1: module of type *WGPUShaderModuleImpl with offset 8
- 2: entryPoint of type *u8 with offset 16
- 3: constantCount of type u64 with offset 24
- 4: constants of type *WGPUConstantEntry with offset 32
- 5: targetCount of type u64 with offset 40
- 6: targets of type *WGPUColorTargetState with offset 48
	*/
	WGPUFragmentState: {
		nextInChain: BigInt(0),
		module: BigInt(8),
		entryPoint: BigInt(16),
		constantCount: BigInt(24),
		constants: BigInt(32),
		targetCount: BigInt(40),
		targets: BigInt(48),
	},
	/*
WGPUColorTargetState (with size=32) contains the following members:
- 0: nextInChain of type *WGPUChainedStruct with offset 0
- 1: format of type WGPUTextureFormat with offset 8
- 2: blend of type *WGPUBlendState with offset 16
- 3: writeMask of type u32 with offset 24
	 */
	WGPUColorTargetState: {
		nextInChain: BigInt(0),
		format: BigInt(8),
		blend: BigInt(16),
		writeMask: BigInt(24),
	},
	/*
WGPUBlendState (with size=24) contains the following members:
- 0: color of type WGPUBlendComponent with offset 0
- 1: alpha of type WGPUBlendComponent with offset 12 
	 */
	WGPUBlendState: {
		color: BigInt(0),
		alpha: BigInt(12),
	},
	/*
WGPUBlendComponent (with size=12) contains the following members:
- 0: operation of type WGPUBlendOperation with offset 0
- 1: srcFactor of type WGPUBlendFactor with offset 4
- 2: dstFactor of type WGPUBlendFactor with offset 8
	*/
	WGPUBlendComponent: {
		operation: BigInt(0),
		srcFactor: BigInt(4),
		dstFactor: BigInt(8),
	},
	/*
WGPUBufferDescriptor (with size=40) contains the following members:
- 0: nextInChain of type *WGPUChainedStruct with offset 0
- 1: label of type *u8 with offset 8
- 2: usage of type u32 with offset 16
- 3: size of type u64 with offset 24
- 4: mappedAtCreation of type u32 with offset 32
	 */
	WGPUBufferDescriptor: {
		nextInChain: BigInt(0),
		label: BigInt(8),
		usage: BigInt(16),
		size: BigInt(24),
		mappedAtCreation: BigInt(32),
	},
	/*
WGPUBindGroupDescriptor (with size=40) contains the following members:
- 0: nextInChain of type *WGPUChainedStruct with offset 0
- 1: label of type *u8 with offset 8
- 2: layout of type *WGPUBindGroupLayoutImpl with offset 16
- 3: entryCount of type u64 with offset 24
- 4: entries of type *WGPUBindGroupEntry with offset 32
	*/
	WGPUBindGroupDescriptor: {
		nextInChain: BigInt(0),
		label: BigInt(8),
		layout: BigInt(16),
		entryCount: BigInt(24),
		entries: BigInt(32),
	},
	/*
WGPUBindGroupEntry (with size=56) contains the following members:
- 0: nextInChain of type *WGPUChainedStruct with offset 0
- 1: binding of type u32 with offset 8
- 2: buffer of type *WGPUBufferImpl with offset 16
- 3: offset of type u64 with offset 24
- 4: size of type u64 with offset 32
- 5: sampler of type *WGPUSamplerImpl with offset 40
- 6: textureView of type *WGPUTextureViewImpl with offset 48
	*/
	WGPUBindGroupEntry: {
		nextInChain: BigInt(0),
		binding: BigInt(8),
		buffer: BigInt(16),
		offset: BigInt(24),
		size: BigInt(32),
		sampler: BigInt(40),
		textureView: BigInt(48),
	},
	/*
WGPUCommandEncoderDescriptor (with size=16) contains the following members:
- 0: nextInChain of type *WGPUChainedStruct with offset 0
- 1: label of type *u8 with offset 8
	*/
	WGPUCommandEncoderDescriptor: {
		nextInChain: BigInt(0),
		label: BigInt(8),
	},
	/*
WGPURenderPassDescriptor (with size=56) contains the following members:
- 0: nextInChain of type *WGPUChainedStruct with offset 0
- 1: label of type *u8 with offset 8
- 2: colorAttachmentCount of type u64 with offset 16
- 3: colorAttachments of type *WGPURenderPassColorAttachment with offset 24
- 4: depthStencilAttachment of type *WGPURenderPassDepthStencilAttachment with offset 32
- 5: occlusionQuerySet of type *WGPUQuerySetImpl with offset 40
- 6: timestampWrites of type *WGPURenderPassTimestampWrites with offset 48
	*/
	WGPURenderPassDescriptor: {
		nextInChain: BigInt(0),
		label: BigInt(8),
		colorAttachmentCount: BigInt(16),
		colorAttachments: BigInt(24),
		depthStencilAttachment: BigInt(32),
		occlusionQuerySet: BigInt(40),
		timestampWrites: BigInt(48),
	},
	/*
	WGPURenderPassColorAttachment (with size=64) contains the following members:
- 0: nextInChain of type *WGPUChainedStruct with offset 0
- 1: view of type *WGPUTextureViewImpl with offset 8
- 2: resolveTarget of type *WGPUTextureViewImpl with offset 16
- 3: loadOp of type WGPULoadOp with offset 24
- 4: storeOp of type WGPUStoreOp with offset 28
- 5: clearValue of type WGPUColor with offset 32
	*/
	WGPURenderPassColorAttachment: {
		nextInChain: BigInt(0),
		view: BigInt(8),
		resolveTarget: BigInt(16),
		loadOp: BigInt(24),
		storeOp: BigInt(28),
		clearValue: BigInt(32),
	},
	/**
WGPUBindGroupLayoutDescriptor (with size=32) contains the following members:
- 0: nextInChain of type *WGPUChainedStruct with offset 0
- 1: label of type *u8 with offset 8
- 2: entryCount of type u64 with offset 16
- 3: entries of type *WGPUBindGroupLayoutEntry with offset 24
	 */
	WGPUBindGroupLayoutDescriptor: {
		nextInChain: BigInt(0),
		label: BigInt(8),
		entryCount: BigInt(16),
		entries: BigInt(24),
	},
	/*
	WGPUCommandBufferDescriptor (with size=16) contains the following members:
- 0: nextInChain of type *WGPUChainedStruct with offset 0
- 1: label of type *u8 with offset 8
	*/
	WGPUCommandBufferDescriptor: {
		nextInChain: BigInt(0),
		label: BigInt(8),
	},
	/*
WGPUTextureViewDescriptor (with size=48) contains the following members:
- 0: nextInChain of type *WGPUChainedStruct with offset 0
- 1: label of type *u8 with offset 8
- 2: format of type WGPUTextureFormat with offset 16
- 3: dimension of type WGPUTextureViewDimension with offset 20
- 4: baseMipLevel of type u32 with offset 24
- 5: mipLevelCount of type u32 with offset 28
- 6: baseArrayLayer of type u32 with offset 32
- 7: arrayLayerCount of type u32 with offset 36
- 8: aspect of type WGPUTextureAspect with offset 40
	*/
	WGPUTextureViewDescriptor: {
		nextInChain: BigInt(0),
		label: BigInt(8),
		format: BigInt(16),
		dimension: BigInt(20),
		baseMipLevel: BigInt(24),
		mipLevelCount: BigInt(28),
		baseArrayLayer: BigInt(32),
		arrayLayerCount: BigInt(36),
		aspect: BigInt(40),
	},
	/*
WGPUShaderModuleDescriptor (with size=32) contains the following members:
- 0: nextInChain of type *WGPUChainedStruct with offset 0
- 1: label of type *u8 with offset 8
- 2: hintCount of type u64 with offset 16
- 3: hints of type *WGPUShaderModuleCompilationHint with offset 24
	*/
	WGPUShaderModuleDescriptor: {
		nextInChain: BigInt(0),
		label: BigInt(8),
		hintCount: BigInt(16),
		hints: BigInt(24),
	},
	/*
	WGPUShaderModuleWGSLDescriptor (with size=24) contains the following members:
- 0: chain of type WGPUChainedStruct with offset 0
- 1: code of type *u8 with offset 16
	*/
	WGPUShaderModuleWGSLDescriptor: {
		chain: BigInt(0),
		code: BigInt(16),
	},
	/*
WGPUTextureDescriptor (with size=64) contains the following members:
- 0: nextInChain of type *WGPUChainedStruct with offset 0
- 1: label of type *u8 with offset 8
- 2: usage of type u32 with offset 16
- 3: dimension of type WGPUTextureDimension with offset 20
- 4: size of type WGPUExtent3D with offset 24
- 5: format of type WGPUTextureFormat with offset 36
- 6: mipLevelCount of type u32 with offset 40
- 7: sampleCount of type u32 with offset 44
- 8: viewFormatCount of type u64 with offset 48
- 9: viewFormats of type *WGPUTextureFormat with offset 56
	*/
	WGPUTextureDescriptor: {
		nextInChain: BigInt(0),
		label: BigInt(8),
		usage: BigInt(16),
		dimension: BigInt(20),
		size: BigInt(24),
		format: BigInt(36),
		mipLevelCount: BigInt(40),
		sampleCount: BigInt(44),
		viewFormatCount: BigInt(48),
		viewFormats: BigInt(56),
	},
	/**
WGPUExtent3D (with size=12) contains the following members:
- 0: width of type u32 with offset 0
- 1: height of type u32 with offset 4
- 2: depthOrArrayLayers of type u32 with offset 8
	 */
	WGPUExtent3D: {
		width: BigInt(0),
		height: BigInt(4),
		depthOrArrayLayers: BigInt(8),
	},
	/*
WGPUImageCopyTexture (with size=40) contains the following members:
- 0: nextInChain of type *WGPUChainedStruct with offset 0
- 1: texture of type *WGPUTextureImpl with offset 8
- 2: mipLevel of type u32 with offset 16
- 3: origin of type WGPUOrigin3D with offset 20
- 4: aspect of type WGPUTextureAspect with offset 32
	*/
	WGPUImageCopyTexture: {
		nextInChain: BigInt(0),
		texture: BigInt(8),
		mipLevel: BigInt(16),
		origin: BigInt(20),
		aspect: BigInt(32),
	},
	/*
WGPUTextureDataLayout (with size=24) contains the following members:
- 0: nextInChain of type *WGPUChainedStruct with offset 0
- 1: offset of type u64 with offset 8
- 2: bytesPerRow of type u32 with offset 16
- 3: rowsPerImage of type u32 with offset 20
	*/
	WGPUTextureDataLayout: {
		nextInChain: BigInt(0),
		offset: BigInt(8),
		bytesPerRow: BigInt(16),
		rowsPerImage: BigInt(20),
	},
	/*
WGPUOrigin3D (with size=12) contains the following members:
- 0: x of type u32 with offset 0
- 1: y of type u32 with offset 4
- 2: z of type u32 with offset 8
	*/
	WGPUOrigin3D: {
		x: BigInt(0),
		y: BigInt(4),
		z: BigInt(8),
	},
	/*
WGPUSamplerDescriptor (with size=56) contains the following members:
- 0: nextInChain of type *WGPUChainedStruct with offset 0
- 1: label of type *u8 with offset 8
- 2: addressModeU of type WGPUAddressMode with offset 16
- 3: addressModeV of type WGPUAddressMode with offset 20
- 4: addressModeW of type WGPUAddressMode with offset 24
- 5: magFilter of type WGPUFilterMode with offset 28
- 6: minFilter of type WGPUFilterMode with offset 32
- 7: mipmapFilter of type WGPUMipmapFilterMode with offset 36
- 8: lodMinClamp of type float32 with offset 40
- 9: lodMaxClamp of type float32 with offset 44
- 10: compare of type WGPUCompareFunction with offset 48
- 11: maxAnisotropy of type u16 with offset 52
	*/
	WGPUSamplerDescriptor: {
		nextInChain: BigInt(0),
		label: BigInt(8),
		addressModeU: BigInt(16),
		addressModeV: BigInt(20),
		addressModeW: BigInt(24),
		magFilter: BigInt(28),
		minFilter: BigInt(32),
		mipmapFilter: BigInt(36),
		lodMinClamp: BigInt(40),
		lodMaxClamp: BigInt(44),
		compare: BigInt(48),
		maxAnisotropy: BigInt(52),
	},
	/*
WGPUColor (with size=32) contains the following members:
- 0: r of type float64 with offset 0
- 1: g of type float64 with offset 8
- 2: b of type float64 with offset 16
- 3: a of type float64 with offset 24
	*/
	WGPUColor: {
		r: BigInt(0),
		g: BigInt(8),
		b: BigInt(16),
		a: BigInt(24),
	},
	/*
WGPUSamplerBindingLayout (with size=16) contains the following members:
- 0: nextInChain of type *WGPUChainedStruct with offset 0
- 1: type of type WGPUSamplerBindingType with offset 8
	*/
	WGPUSamplerBindingLayout: {
		nextInChain: BigInt(0),
		type: BigInt(8),
	},
	/*
WGPUTextureBindingLayout (with size=24) contains the following members:
- 0: nextInChain of type *WGPUChainedStruct with offset 0
- 1: sampleType of type WGPUTextureSampleType with offset 8
- 2: viewDimension of type WGPUTextureViewDimension with offset 12
- 3: multisampled of type u32 with offset 16
	*/
	WGPUTextureBindingLayout: {
		nextInChain: BigInt(0),
		sampleType: BigInt(8),
		viewDimension: BigInt(12),
		multisampled: BigInt(16),
	},
	/*
WGPUStorageTextureBindingLayout (with size=24) contains the following members:
- 0: nextInChain of type *WGPUChainedStruct with offset 0
- 1: access of type WGPUStorageTextureAccess with offset 8
- 2: format of type WGPUTextureFormat with offset 12
- 3: viewDimension of type WGPUTextureViewDimension with offset 16
	*/
	WGPUStorageTextureBindingLayout: {
		nextInChain: BigInt(0),
		access: BigInt(8),
		format: BigInt(12),
		viewDimension: BigInt(16),
	},
	/*
WGPURenderPassDepthStencilAttachment (with size=40) contains the following members:
- 0: view of type *WGPUTextureViewImpl with offset 0
- 1: depthLoadOp of type WGPULoadOp with offset 8
- 2: depthStoreOp of type WGPUStoreOp with offset 12
- 3: depthClearValue of type float32 with offset 16
- 4: depthReadOnly of type u32 with offset 20
- 5: stencilLoadOp of type WGPULoadOp with offset 24
- 6: stencilStoreOp of type WGPUStoreOp with offset 28
- 7: stencilClearValue of type u32 with offset 32
- 8: stencilReadOnly of type u32 with offset 36
	*/
	WGPURenderPassDepthStencilAttachment: {
		view: BigInt(0),
		depthLoadOp: BigInt(8),
		depthStoreOp: BigInt(12),
		depthClearValue: BigInt(16),
		depthReadOnly: BigInt(20),
		stencilLoadOp: BigInt(24),
		stencilStoreOp: BigInt(28),
		stencilClearValue: BigInt(32),
		stencilReadOnly: BigInt(36),
	},
	/*
WGPUProgrammableStageDescriptor (with size=40) contains the following members:
- 0: nextInChain of type *WGPUChainedStruct with offset 0
- 1: module of type *WGPUShaderModuleImpl with offset 8
- 2: entryPoint of type *u8 with offset 16
- 3: constantCount of type u64 with offset 24
- 4: constants of type *WGPUConstantEntry with offset 32
	*/
	WGPUProgrammableStageDescriptor: {
		nextInChain: BigInt(0),
		module: BigInt(8),
		entryPoint: BigInt(16),
		constantCount: BigInt(24),
		constants: BigInt(32),
	},
	/*
WGPUComputePipelineDescriptor (with size=64) contains the following members:
- 0: nextInChain of type *WGPUChainedStruct with offset 0
- 1: label of type *u8 with offset 8
- 2: layout of type *WGPUPipelineLayoutImpl with offset 16
- 3: compute of type WGPUProgrammableStageDescriptor with offset 24
	*/
	WGPUComputePipelineDescriptor: {
		nextInChain: BigInt(0),
		label: BigInt(8),
		layout: BigInt(16),
		compute: BigInt(24),
	},
	/*
	WGPUComputePassDescriptor (with size=24) contains the following members:
- 0: nextInChain of type *WGPUChainedStruct with offset 0
- 1: label of type *u8 with offset 8
- 2: timestampWrites of type *WGPUComputePassTimestampWrites with offset 16
	*/
	WGPUComputePassDescriptor: {
		nextInChain: BigInt(0),
		label: BigInt(8),
		timestampWrites: BigInt(16),
	},
};
export const WGPU_SIZE = {
	bool: BigInt(1),
	u8: BigInt(1),
	u16: BigInt(2),
	u32: BigInt(4),
	u64: BigInt(8),
	s32: BigInt(4),
	float: BigInt(4),
	float64: BigInt(8),
	WGPUBindGroupLayoutEntry: BigInt(104),
	// WGPURenderPipelineDescriptor: 144,
	WGPUVertexBufferLayout: BigInt(32),
	WGPUVertexAttribute: BigInt(24),
	WGPUPrimitiveState: BigInt(24),
	WGPUColorTargetState: BigInt(32),
	WGPUBindGroupEntry: BigInt(56),
	WGPURenderPassColorAttachment: BigInt(64),
	WGPUExtent3D: BigInt(12),
	WGPUTextureFormat: BigInt(4),
	WGPUProgrammableStageDescriptor: BigInt(40),
};

