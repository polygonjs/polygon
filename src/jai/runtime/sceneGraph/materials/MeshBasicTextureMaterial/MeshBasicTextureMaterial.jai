MeshBasicTextureMaterialUniforms :: struct {
	color:Color;
	// sampler:WGPUSampler;
	// texture:WGPUTexture;
};

MeshBasicTextureMaterial :: struct {
	#as using material: MaterialBase(UNIFORM_TYPE, topology = .TriangleList);
};

registerMeshBasicTextureMaterial :: () #compile_time {
	materialRegister(TYPE);
}

// uniforms :: (material: *TYPE) -> *UNIFORM_TYPE {
// 	return cast(*UNIFORM_TYPE)material.uniforms;
// }
setColor :: (material: *TYPE, color: Color) {
	material.uniforms.color = color;
}
materialInit :: (material: *TYPE) {
	baseMaterialInit(material);
	// material.name = MATERIAL_NAME;
	material.shader = SHADER_RAW;
	material.uniforms.color = .{1.0, 0.0, 0.0, 1.0};
}

materialApplyVertexBufferLayout :: (material: *TYPE, pc: *PipelineController) {
	materialApplyVertexBufferLayoutDefault(xx material, pc);
}

materialInitDrawDataMaterialUniforms :: (wgpuContext: *WGPUContext, material: *TYPE, pc: *PipelineController, drawData: *MeshDrawData) {
	using drawData.uniforms.material;
	buffer,
	bind_group,
	bind_group_entries = _wgpuUniformToBufferWithSize_TEMP(wgpuContext, pc.pipeline, xx UniformBindingIndex.MATERIAL, *pc.material.uniforms, pc.material.uniformTypeSize, "material");
}

materialApplyBindGroupLayoutDefault_MaterialUniforms :: (wgpuContext: *WGPUContext, material: *TYPE, bindGroupLayouts: *[]WGPUBindGroupLayout){
	groupIndex := UniformBindingIndex.MATERIAL;
	bind_group_layout_entries:[ENTRIES_COUNT]WGPUBindGroupLayoutEntry; //:= NewArray(1, WGPUBindGroupLayoutEntry);
	// 	#if FREE_MEMORY defer array_reset(*bind_group_layout_entries);
	bind_group_layout_entries[0] = WGPUBindGroupLayoutEntry.{
		binding = 0,
		visibility = xx WGPUShaderStage.Vertex|WGPUShaderStage.Fragment,
		buffer = .{ type = WGPUBufferBindingType.Uniform },
	};
	//
	// sampler
	//
	bind_group_layout_entries[1] = WGPUBindGroupLayoutEntry.{
		binding = 1,
		visibility = xx WGPUShaderStage.Vertex|WGPUShaderStage.Fragment,
		sampler = SAMPLER_BINDING_LAYOUT
	};
	//
	// texture
	//
	bind_group_layout_entries[2] = WGPUBindGroupLayoutEntry.{
		binding = 2,
		visibility = xx WGPUShaderStage.Vertex|WGPUShaderStage.Fragment,
		texture = TEXTURE_BINDING_LAYOUT,
	};
	layout, desc := _wgpuCreateBindGroupLayout(wgpuContext.device, bind_group_layout_entries.count, bind_group_layout_entries.data, "material uniforms");
	(<<bindGroupLayouts)[groupIndex] = layout;
}

textureCreateAndUpload :: (wgpuContext: *WGPUContext)->WGPUTexture {
	texture := wgpuDeviceCreateTexture(wgpuContext.device, *TEXTURE_DESC);
	dest :WGPUImageCopyTexture= .{
		texture = texture,
		mipLevel = 0,
		origin = .{
			x = 0,
			y = 0,
			z = 0
		},
	};
	
	wgpuQueueWriteTexture(
		wgpuContext.queue,
		*dest,
		TEXTURE_DATA.data,
		size_of(type_of(TEXTURE_DATA)),// * size_of(COMPONENT_TYPE),
		*TEXTURE_DATA_LAYOUT, // WGPUTextureDataLayout
		*TEXTURE_SIZE,
	);
	print("texture sent: %, %, %, %\n", TEXTURE_DATA.count, TEXTURE_DATA, TEXTURE_DATA_LAYOUT, size_of(type_of(TEXTURE_DATA)));

	/*
	device.queue.writeTexture(
		{ texture },
		textureData,
		{ bytesPerRow: kTextureWidth * 4 },
		{ width: kTextureWidth, height: kTextureHeight },
	);
	*/
	return texture;
}

#scope_file

SHADER_RAW :: #run import_shader();
import_shader :: () -> string { return "MeshBasicTextureMaterial.wgsl"; };
TYPE :: MeshBasicTextureMaterial;
UNIFORM_TYPE :: MeshBasicTextureMaterialUniforms;
// MATERIAL_NAME :: #run tprint("%", TYPE);

// TEX_SIZE :[2]u32: .[5, 7];
TEX_SIZE :[2]u32: .[3, 2];
PIXELS_COUNT :: TEX_SIZE[0]*TEX_SIZE[1];
DATA_SIZE :: PIXELS_COUNT*4;
COMPONENT_TYPE :: float;
TEXTURE_DATA :[DATA_SIZE]COMPONENT_TYPE: #run _createTexture();
_createTexture :: () -> [DATA_SIZE]COMPONENT_TYPE #compile_time {

	z :[4]COMPONENT_TYPE= .[0,   0,   0, 0];  // zero
	// O :[4]COMPONENT_TYPE= .[1,   0,   0, 1];  // red
	// y :[4]COMPONENT_TYPE= .[1, 1,   0, 1];  // yellow
	// b :[4]COMPONENT_TYPE= .[  0,   0, 1, 1];  // blue
	f :[4]COMPONENT_TYPE= .[  1,   1, 1, 1];  // full
	// textureDataPacked :[PIXELS_COUNT][4]COMPONENT_TYPE= .[
	// 	z, O, O, O, O,
	// 	O, y, y, y, O,
	// 	O, y, O, O, O,
	// 	O, y, y, O, O,
	// 	O, y, O, O, O,
	// 	O, y, O, O, O,
	// 	O, O, O, O, O,
	// ];
	textureDataPacked :[PIXELS_COUNT][4]COMPONENT_TYPE= .[
		f,z,z,
		z,z,f
	];
	textureData :[DATA_SIZE]COMPONENT_TYPE;
	for x: 0..(TEX_SIZE[0]-1) {
		for y: 0..(TEX_SIZE[1]-1) {
			i := y*TEX_SIZE[0]+x;
			textureData[i*4+0] = textureDataPacked[i][0];
			textureData[i*4+1] = textureDataPacked[i][1];
			textureData[i*4+2] = textureDataPacked[i][2];
			textureData[i*4+3] = textureDataPacked[i][3];
		}
	}
	return textureData;
}

ENTRIES_COUNT :: 3;

_wgpuUniformToBufferWithSize_TEMP :: (
	wgpuContext: *WGPUContext,
	pipeline: WGPURenderPipeline,
	bind_group_layout_index: u32,
	uniforms: *void,
	uniformTypeSize: u32,
	label: string
) -> WGPUBuffer, WGPUBindGroup, []WGPUBindGroupEntry {
	// TODO: This is a hack to make sure the buffer is at least 16 bytes
	size := cast(u64) max( 16, uniformTypeSize);
	print("_wgpuUniformToBufferWithSize_TEMP\n");

	buffer_label := to_c_string_temp(label);
	// defer free(buffer_label);
	buffer_desc: WGPUBufferDescriptor = .{
		usage = xx (WGPUBufferUsage.Uniform | WGPUBufferUsage.CopyDst),
		size = size,
		label = buffer_label,
	};
	buffer := wgpuDeviceCreateBuffer(wgpuContext.device, *buffer_desc);
	assert(buffer != null, "Buffer is not created correctly");

	wgpuQueueWriteBuffer(wgpuContext.queue, buffer, 0, uniforms, size);

	entries := NewArray(ENTRIES_COUNT, WGPUBindGroupEntry,, temp);
	entries[0] = WGPUBindGroupEntry.{
		binding=0,
		size=size,
		offset=0,
		buffer=buffer,
	};

	//
	// sampler
	//
	sampler := wgpuDeviceCreateSampler(wgpuContext.device, *SAMPLER_DESC);
	entries[1] = WGPUBindGroupEntry.{
		binding=1,
		sampler=sampler,
	};

	//
	// textureView
	//
	texture := textureCreateAndUpload(wgpuContext);
	textureView := wgpuTextureCreateView(texture, *TEXTURE_VIEW_DESC);
	entries[2] = WGPUBindGroupEntry.{
		binding=2,
		textureView=textureView,
	};


	//
	//
	//
	bind_group_descriptor_label := tprint("uniforms_bind_group/%", label,, temp);
	bind_group_descriptor_label_c := to_c_string_temp(bind_group_descriptor_label);
	// defer free(bind_group_descriptor_label_c);
	bind_group_descriptor := WGPUBindGroupDescriptor.{
		label = bind_group_descriptor_label_c,
		layout = wgpuRenderPipelineGetBindGroupLayout(pipeline, bind_group_layout_index),
		entryCount = xx entries.count,
		entries = entries.data
	};
	bind_group := wgpuDeviceCreateBindGroup(wgpuContext.device, *bind_group_descriptor);

	return buffer, bind_group, entries;
}

SAMPLER_DESC :WGPUSamplerDescriptor: .{
	label = "MeshBasicTextureMaterial sampler",
	maxAnisotropy = 1,
	magFilter = .Nearest,//.Linear,
	minFilter = .Nearest,//.Linear,
	mipmapFilter = .Nearest,//.Linear,
	addressModeU = .ClampToEdge,
	addressModeV = .ClampToEdge,
	addressModeW = .ClampToEdge
};
SAMPLER_BINDING_LAYOUT :WGPUSamplerBindingLayout: .{
	type = WGPUSamplerBindingType.Filtering//.NonFiltering // .Filtering
};
TEXTURE_BINDING_LAYOUT :WGPUTextureBindingLayout: .{
	sampleType = WGPUTextureSampleType.Float, //.Float, // .UnfilterableFloat
	viewDimension = WGPUTextureViewDimension._2D,
	multisampled = xx false,
};
TEXTURE_DATA_LAYOUT :WGPUTextureDataLayout = .{
	offset = 0,
	bytesPerRow = size_of(type_of(TEXTURE_DATA)) / TEX_SIZE[1],
	rowsPerImage = TEX_SIZE[1],
};

TEXTURE_FORMAT :: WGPUTextureFormat.RGBA8Unorm; //.RGBA8UnormSrgb;  // RGBA32Float,//BGRA8Unorm, //'rgba8unorm',
TEXTURE_VIEW_DESC :WGPUTextureViewDescriptor: .{
	format = TEXTURE_FORMAT,
	mipLevelCount = 1,
	arrayLayerCount = 1,
};
TEXTURE_SIZE :WGPUExtent3D: .{
	width = TEX_SIZE[0],
	height = TEX_SIZE[1],
	depthOrArrayLayers = 1,
};
viewFormats :[1]WGPUTextureFormat = .[ TEXTURE_FORMAT ];
TEXTURE_DESC :WGPUTextureDescriptor: .{
	label = "MeshBasicTextureMaterial map",
	size = TEXTURE_SIZE,
	format = TEXTURE_FORMAT,
	usage = xx WGPUTextureUsage.TextureBinding | WGPUTextureUsage.CopyDst,
	sampleCount = 1,
	dimension = WGPUTextureDimension._2D,
	mipLevelCount = 1,
	viewFormatCount = viewFormats.count,
	viewFormats = viewFormats.data,
};