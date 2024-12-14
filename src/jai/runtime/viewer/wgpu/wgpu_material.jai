BindGroupLayoutDescContainer :: struct {
	bind_group_layouts: []WGPUBindGroupLayout;
	// bind_group_layout_descs: []WGPUBindGroupLayoutDescriptor;
}

material_create_module :: (wgpuContext: *WGPUContext, material: *Material)-> WGPUShaderModule {
	return wgpu_create_shader_module(wgpuContext.device, material.shader, xx tprint("% Shader", material.name));
}

material_bind_group_layouts_count :: (material: *Material)->u32 {
	return 4;
}

material_apply_to_pipeline_descriptor :: (wgpuContext: *WGPUContext, pipeline_layout_descriptor: *WGPUPipelineLayoutDescriptor, material: *Material, container: *BindGroupLayoutDescContainer) {
	// pipeline_layout_descriptor: WGPUPipelineLayoutDescriptor;

	// group 0 (scene uniforms)
	{
		groupIndex := UniformBindingIndex.SCENE;
		bind_group_layout_entries:[1]WGPUBindGroupLayoutEntry; //:= NewArray(1, WGPUBindGroupLayoutEntry);
		// #if FREE_MEMORY defer array_reset(*bind_group_layout_entries);
		bind_group_layout_entries[0] = WGPUBindGroupLayoutEntry.{
			binding = 0,
			visibility = xx WGPUShaderStage.Vertex|WGPUShaderStage.Fragment,
			buffer = .{ type = WGPUBufferBindingType.Uniform },
		};
		layout, desc := wgpu_create_bind_group_layout(wgpuContext.device, bind_group_layout_entries.count, bind_group_layout_entries.data, "scene uniforms");
		container.bind_group_layouts[groupIndex] = layout;
		// container.bind_group_layout_descs[groupIndex] = desc;
	}
	// group 1 (camera uniforms)
	{
		groupIndex := UniformBindingIndex.CAMERA;
		bind_group_layout_entries:[1]WGPUBindGroupLayoutEntry; //:= NewArray(1, WGPUBindGroupLayoutEntry);
		// #if FREE_MEMORY defer array_reset(*bind_group_layout_entries);
		bind_group_layout_entries[0] = WGPUBindGroupLayoutEntry.{
			binding = 0,
			visibility = xx WGPUShaderStage.Vertex|WGPUShaderStage.Fragment,
			buffer = .{ type = WGPUBufferBindingType.Uniform },
		};
		layout, desc := wgpu_create_bind_group_layout(wgpuContext.device, bind_group_layout_entries.count, bind_group_layout_entries.data, "camera uniforms");
		container.bind_group_layouts[groupIndex] = layout;
		// container.bind_group_layout_descs[groupIndex] = desc;
	}
	// group 2 (object uniforms)
	{
		groupIndex := UniformBindingIndex.OBJECT;
		bind_group_layout_entries:[1]WGPUBindGroupLayoutEntry; //:= NewArray(1, WGPUBindGroupLayoutEntry);
		// #if FREE_MEMORY defer array_reset(*bind_group_layout_entries);
		bind_group_layout_entries[0] = WGPUBindGroupLayoutEntry.{
			binding = 0,
			visibility = xx WGPUShaderStage.Vertex,
			buffer = .{ type = WGPUBufferBindingType.Uniform },
		};
		layout, desc := wgpu_create_bind_group_layout(wgpuContext.device, bind_group_layout_entries.count, bind_group_layout_entries.data, "object uniforms");
		container.bind_group_layouts[groupIndex] = layout;
		// container.bind_group_layout_descs[groupIndex] = desc;
	}
	// group 3 (material uniforms)
	{
		groupIndex := UniformBindingIndex.MATERIAL;
		bind_group_layout_entries:[1]WGPUBindGroupLayoutEntry; //:= NewArray(1, WGPUBindGroupLayoutEntry);
		// 	#if FREE_MEMORY defer array_reset(*bind_group_layout_entries);
		bind_group_layout_entries[0] = WGPUBindGroupLayoutEntry.{
			binding = 0,
			visibility = xx WGPUShaderStage.Vertex|WGPUShaderStage.Fragment,
			buffer = .{ type = WGPUBufferBindingType.Uniform },
		};
		layout, desc := wgpu_create_bind_group_layout(wgpuContext.device, bind_group_layout_entries.count, bind_group_layout_entries.data, "material uniforms");
		container.bind_group_layouts[groupIndex] = layout;
		// container.bind_group_layout_descs[groupIndex] = desc;
	}
	//
	pipeline_layout_descriptor.bindGroupLayoutCount = xx container.bind_group_layouts.count;
	pipeline_layout_descriptor.bindGroupLayouts = container.bind_group_layouts.data;
}

#scope_file

wgpu_create_bind_group_layout :: (device: WGPUDevice, entryCount: s64, data: *WGPUBindGroupLayoutEntry, label:string) -> WGPUBindGroupLayout, WGPUBindGroupLayoutDescriptor {
	desc :WGPUBindGroupLayoutDescriptor= .{
		label = to_c_string_temp(label),
		entryCount = xx entryCount,
		entries = data,
	};
	bind_group_layout := wgpuDeviceCreateBindGroupLayout(device, *desc);
	return bind_group_layout, desc;
}

wgpu_create_shader_module :: (device: WGPUDevice, source: string, label: string) -> WGPUShaderModule {
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