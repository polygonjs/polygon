
pipeline_controller_pipeline_descriptor_layout_init :: (wgpuContext: *WGPUContext, pc_descriptor: *WGPURenderPipelineDescriptor, material: *Material) {


	bindGroupLayoutCount := materialBindGroupLayoutsCount(material);
	bindGroupLayouts := NewArray(bindGroupLayoutCount, WGPUBindGroupLayout,, temp);
	layoutDescriptor: WGPUPipelineLayoutDescriptor = .{
		label = "desc layout",//to_c_string_temp(tprint("% Pipeline Layout", pc.label)),
		bindGroupLayoutCount = bindGroupLayoutCount,
		bindGroupLayouts = bindGroupLayouts.data,
	};
	// bind_group_layout_descs := NewArray(count, WGPUBindGroupLayoutDescriptor);
	// #if FREE_MEMORY defer {
	// 	// for bind_group_layout_descs free(it.label);
	// 	// array_reset(*bind_group_layouts);
	// 	// array_reset(*bind_group_layout_descs);
	// }
	// container:BindGroupLayoutDescContainer= .{
	// 	bind_group_layouts = bind_group_layouts,
	// 	// bind_group_layout_descs = bind_group_layout_descs,
	// };

	materialApplyBindGroupLayout(wgpuContext, material, *bindGroupLayouts);

	// layoutDescriptor.bindGroupLayoutCount = xx count;
	// layoutDescriptor.bindGroupLayouts = bindGroupLayouts.data;

	// pipeline_layout_descriptor.label = tprint("% layout", pc.label);
	//"Main Pipeline Layout (only here to test that the label can be re-created in js from wasm)";
	// pipeline_layout_descriptor.bindGroupLayoutCount = xx bind_group_layouts.count;
	// pipeline_layout_descriptor.bindGroupLayouts = bind_group_layouts.data;

	pc_descriptor.layout = wgpuDeviceCreatePipelineLayout(wgpuContext.device, *layoutDescriptor);
}

