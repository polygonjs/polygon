samplerDescriptor :: (texture: *Texture)-> WGPUSamplerDescriptor {
	return .{
		label = to_c_string_temp(tprint("samplerDescriptor/%", texture.label)),
		maxAnisotropy = texture.maxAnisotropy,
		magFilter = texture.magFilter,
		minFilter = texture.minFilter,
		mipmapFilter = texture.mipmapFilter,
		addressModeU = texture.addressModeU,
		addressModeV = texture.addressModeV,
		addressModeW = texture.addressModeW
	};
}
samplerBindingLayout :: (texture: *Texture)-> WGPUSamplerBindingLayout {
	return .{
		type = WGPUSamplerBindingType.Filtering//.NonFiltering // .Filtering
	};
}