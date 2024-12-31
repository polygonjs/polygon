Texture :: struct {

	label: string;
	size: [2]u32;
	data: *u8;

	wgpuContext: *WGPUContext;
	wgpuTexture: WGPUTexture;

	format: WGPUTextureFormat: TEXTURE_FORMAT; // format is a constant for now, since other formats seem invalid
	maxAnisotropy: u16 = 1;
	magFilter: WGPUFilterMode = .Nearest;
	minFilter: WGPUFilterMode = .Nearest;
	mipmapFilter: WGPUMipmapFilterMode = .Nearest;
	addressModeU: WGPUAddressMode = .ClampToEdge;
	addressModeV: WGPUAddressMode = .ClampToEdge;
	addressModeW: WGPUAddressMode = .ClampToEdge;

	initialized: bool = false;
	uploaded: bool = false;
	disposed: bool = false;
}

textureInit :: (wgpuContext: *WGPUContext, texture: *Texture) {
	texture.wgpuContext = wgpuContext;
	textureDesc := _textureDescriptor(texture);
	texture.wgpuTexture = wgpuDeviceCreateTexture(wgpuContext.device, *textureDesc);
	texture.initialized = true;
}
textureUpload :: (texture: *Texture) {
	if texture.data == null {
		assert(false, "texture data is null");
	}
	if !texture.initialized {
		assert(false, "texture not initialized");
		textureInit(texture.wgpuContext, texture);
	}
	if texture.disposed {
		assert(false, "texture disposed");
		return;
	}
	dest :WGPUImageCopyTexture= .{
		texture = texture.wgpuTexture,
		mipLevel = 0,
		origin = .{
			x = 0,
			y = 0,
			z = 0
		},
	};

	dataLayout := _textureDataLayout(texture);
	dataSize := dataLayout.bytesPerRow * dataLayout.rowsPerImage;
	size := _textureSizeExtent3D(texture);
	
	wgpuQueueWriteTexture(
		texture.wgpuContext.queue,
		*dest,
		texture.data,
		dataSize,// * size_of(COMPONENT_TYPE),
		*dataLayout, // WGPUTextureDataLayout
		*size,
	);
	texture.uploaded = true;
}
textureView :: (texture: *Texture)-> WGPUTextureView {
	if !texture.initialized {
		assert(false, "texture not initialized");
		textureInit(texture.wgpuContext, texture);
	}
	if texture.disposed {
		assert(false, "texture disposed");
		return null;
	}
	textureViewDesc := textureViewDescriptor(texture);
	textureView := wgpuTextureCreateView(texture.wgpuTexture, *textureViewDesc);
	return textureView;
}

textureBindingLayout :: (texture: *Texture)-> WGPUTextureBindingLayout {
	return .{
		sampleType = WGPUTextureSampleType.Float, //.Float, // .UnfilterableFloat
		viewDimension = WGPUTextureViewDimension._2D,
		multisampled = xx false,
	};
}

textureViewDescriptor :: (texture: *Texture)-> WGPUTextureViewDescriptor {
	return .{
		format = texture.format,
		mipLevelCount = 1,
		arrayLayerCount = 1,
	};
}



TEXTURE_COMPONENT_TYPE :: u8;
VALUES_PER_PIXEL :: 4;

#scope_file

_textureDescriptor :: (texture: *Texture)-> WGPUTextureDescriptor {
	return .{
		label = to_c_string_temp(tprint("textureDescriptor/%", texture.label)),
		size = _textureSizeExtent3D(texture),
		format = TEXTURE_FORMAT,
		usage = xx WGPUTextureUsage.TextureBinding | WGPUTextureUsage.CopyDst,
		sampleCount = 1,
		dimension = WGPUTextureDimension._2D,
		mipLevelCount = 1,
		viewFormatCount = VIEW_FORMATS.count,
		viewFormats = VIEW_FORMATS.data,
	};
}
_textureSizeExtent3D :: (texture: *Texture)-> WGPUExtent3D {
	return .{
		width = texture.size[0],
		height = texture.size[1],
		depthOrArrayLayers = 1,
	};
}
_textureDataLayout :: (texture: *Texture)-> WGPUTextureDataLayout {
	return .{
		offset = 0,
		bytesPerRow = texture.size[0] * VALUES_PER_PIXEL * size_of(TEXTURE_COMPONENT_TYPE),
		rowsPerImage = texture.size[1],
	};
}

TEXTURE_FORMAT :: WGPUTextureFormat.RGBA8Unorm; //.RGBA8UnormSrgb;  // RGBA32Float,//BGRA8Unorm, //'rgba8unorm',
VIEW_FORMATS :[1]WGPUTextureFormat = .[ TEXTURE_FORMAT ];
