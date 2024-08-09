// wgpuTextureCreateView :: (texture: WGPUTexture, descriptor: *WGPUTextureViewDescriptor) -> WGPUTextureView #foreign libwgpu_native;
export function wgpuTextureCreateView(
	texture: bigint,
	descriptorPointer: bigint
) {
	console.log("wgpuTextureCreateView", texture, descriptorPointer);
}
