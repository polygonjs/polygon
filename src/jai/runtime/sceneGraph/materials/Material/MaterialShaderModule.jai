materialCreateModule :: (wgpuContext: *WGPUContext, material: *Material)-> WGPUShaderModule {
	return _wgpuCreateShaderModule(wgpuContext.device, material.shader, xx tprint("% Shader", material.type));
}
#scope_file


_wgpuCreateShaderModule :: (device: WGPUDevice, source: string, label: string) -> WGPUShaderModule {
	wgsl_descriptor := WGPUShaderModuleWGSLDescriptor.{
		chain = .{
			next = null,
			sType = .ShaderModuleWGSLDescriptor
		},
		code = to_c_string_temp(source)
	};
	// defer if FREE_MEMORY free(wgsl_descriptor.code);

	shader_module_descriptor := WGPUShaderModuleDescriptor.{
		nextInChain = xx *wgsl_descriptor,
		label = to_c_string_temp(label),
	};
	// defer if FREE_MEMORY free(shader_module_descriptor.label);

	return wgpuDeviceCreateShaderModule(device, *shader_module_descriptor);
}