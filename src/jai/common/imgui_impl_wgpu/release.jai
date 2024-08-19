
SafeReleaseImDrawIdx::(res: *ImDrawIdx)
{
	if (res!=null) free(res);
		// delete[] res;
	res = null;
}
SafeReleaseImDrawVert::(res: *ImDrawVert)
{
	if (res!=null) free(res);
		// delete[] res;
	res = null;
}
SafeReleaseWGPUBindGroupLayout::(resptr: *WGPUBindGroupLayout)
{
	if (<<resptr)
		wgpuBindGroupLayoutRelease(<<resptr);
	resptr = null;
}
SafeReleaseWGPUBindGroup::(resptr: *WGPUBindGroup)
{
	if (<<resptr)
		wgpuBindGroupRelease(<<resptr);
	resptr = null;
}
SafeReleaseWGPUBuffer::(resptr: *WGPUBuffer)
{
	if (<<resptr)
		wgpuBufferRelease(<<resptr);
	resptr = null;
}
SafeReleasePipelineState::(resptr: *WGPURenderPipeline)
{
	if (<<resptr){
		wgpuRenderPipelineRelease(<<resptr);
	}
	resptr = null;
}
SafeReleaseWGPUSampler::(resptr: *WGPUSampler)
{
	if (<<resptr)
		wgpuSamplerRelease(<<resptr);
	resptr = null;
}
SafeReleaseWGPUShaderModule::(resptr: *WGPUShaderModule)
{
	if (<<resptr)
		wgpuShaderModuleRelease(<<resptr);
	resptr = null;
}
SafeReleaseWGPUTextureView::(resptr: *WGPUTextureView)
{
	if (<<resptr)
		wgpuTextureViewRelease(<<resptr);
	resptr = null;
}
SafeReleaseWGPUTexture::(resptr: *WGPUTexture)
{
	if (<<resptr)
		wgpuTextureRelease(<<resptr);
	resptr = null;
}
SafeReleaseUniforms::(resptr: *WGPUBuffer) /*not sure about that one*/
{
	if (<<resptr)
		wgpuBufferRelease(<<resptr);
	resptr = null;
}


SafeReleaseRenderResources::(res:*RenderResources)
{
	if(res.FontTexture) SafeReleaseWGPUTexture(*res.FontTexture);
	if(res.FontTextureView) SafeReleaseWGPUTextureView(*res.FontTextureView);
	if(res.Sampler) SafeReleaseWGPUSampler(*res.Sampler);
	if(res.Uniforms) SafeReleaseUniforms(*res.Uniforms);
	if(res.CommonBindGroup) SafeReleaseWGPUBindGroup(*res.CommonBindGroup);
	if(res.ImageBindGroup) SafeReleaseWGPUBindGroup(*res.ImageBindGroup);
	if(res.ImageBindGroupLayout) SafeReleaseWGPUBindGroupLayout(*res.ImageBindGroupLayout);
};

SafeReleaseFrameResources::(res:*FrameResources)
{	
	SafeReleaseWGPUBuffer(*res.IndexBuffer);
	SafeReleaseWGPUBuffer(*res.VertexBuffer);
	if(res.IndexBufferHost) SafeReleaseImDrawIdx(res.IndexBufferHost);
	if(res.VertexBufferHost) SafeReleaseImDrawVert(res.VertexBufferHost);
}




