WGPUContext :: struct {
	instance: WGPUInstance;
	surface: WGPUSurface;
	adapter:WGPUAdapter;
	device: WGPUDevice ;
	config: WGPUSurfaceConfiguration;
	surface_texture :WGPUSurfaceTexture;
	preferred_texture_format :WGPUTextureFormat;
	//
	use_msaa: bool=false;
	use_depth_buffer: bool=false;
	bg_color :WGPUColor =.{0.0, 0.0, 0.0, 1.0};
	//
	multisample_texture_descriptor : WGPUTextureDescriptor;
	multisample_texture: WGPUTexture;
	multisample_texture_view: *WGPUTextureView;
	//
	depth_texture: WGPUTexture;
	depth_texture_view: *WGPUTextureView;
};

print_c :: (format: string, args: ..Any, to_standard_error := false) #expand {
	new_context: Context;
	push_context new_context {
		print(format, ..args, to_standard_error);
	}
} @PrintLike

request_adapter :: (instance: WGPUInstance, surface: WGPUSurface, powerPreference: WGPUPowerPreference, forceFallbackAdapter := false) -> WGPUAdapter {
	adapter: WGPUAdapter;

	request_adapter_options := WGPURequestAdapterOptions.{
		compatibleSurface = surface,
		powerPreference = powerPreference,
		forceFallbackAdapter = xx forceFallbackAdapter,
	};

	wgpuInstanceRequestAdapter(instance, *request_adapter_options, (status: WGPURequestAdapterStatus, adapter: WGPUAdapter, message: *u8, user_data: *void) #c_call {
		if status != .Success {
			print_c("%\n", message);
			return;
		};

		<< cast(*WGPUAdapter) user_data = adapter;
	}, *adapter);

	return adapter;
}

create_surface :: (instance: WGPUInstance, window: *SDL_Window, label := "Main Surface") -> WGPUSurface {
	surface_desc: WGPUSurfaceDescriptor;
	surface_desc.label = to_c_string(label);
	#if FREE_MEMORY defer free(surface_desc.label);

	#if OS == .WINDOWS {
		sdl_info: SDL_SysWMinfo;
		assert(xx SDL_GetWindowWMInfo(window,  *sdl_info), "Cannot get SDL info!\n");

		surface_desc_from_windows_hwnd: WGPUSurfaceDescriptorFromWindowsHWND;
		surface_desc_from_windows_hwnd.chain.sType = .SurfaceDescriptorFromWindowsHWND;
		surface_desc_from_windows_hwnd.hwnd = sdl_info.info.win.window;

		surface_desc.nextInChain = xx *surface_desc_from_windows_hwnd;
	}

	#if OS == .MACOS {
		metal_view := SDL_Metal_CreateView(window);
		metal_layer := SDL_Metal_GetLayer(metal_view);

		surface_desc_from_metal_layer: WGPUSurfaceDescriptorFromMetalLayer;
		surface_desc_from_metal_layer.layer = metal_layer;
		surface_desc_from_metal_layer.chain.sType = .SurfaceDescriptorFromMetalLayer;

		surface_desc.nextInChain = xx *surface_desc_from_metal_layer;
	}

	#if OS == .LINUX  {
		//#assert false "LINUX IS NOT SUPPORTED RIGHT NOW.";

		sdl_info: SDL_SysWMinfo;
		SDL_VERSION(*sdl_info.version);
		assert(xx SDL_GetWindowWMInfo(window,  *sdl_info), "Cannot get SDL info!\n");

		// @TODO: Wayland
		surface_desc_from_xlib_window: WGPUSurfaceDescriptorFromXlibWindow;
		surface_desc_from_xlib_window.chain.sType = .SurfaceDescriptorFromXlibWindow;
		surface_desc_from_xlib_window.display = sdl_info.info.x11.display;
		surface_desc_from_xlib_window.window = xx sdl_info.info.x11.window;

		surface_desc.nextInChain = xx *surface_desc_from_xlib_window;
	}

	surface := wgpuInstanceCreateSurface(instance, *surface_desc);

	return surface;
}

request_device :: (adapter: WGPUAdapter, width:int, height:int) -> WGPUDevice {
	device_descriptor: WGPUDeviceDescriptor;
	device: WGPUDevice;

	// from https://eliemichel.github.io/LearnWebGPU/basic-3d-rendering/3d-meshes/depth-buffer.html
	// device_descriptor.requiredLimits.limits.maxTextureDimension1D = xx height;
	// device_descriptor.requiredLimits.limits.maxTextureDimension2D = xx width;
	// device_descriptor.requiredLimits.limits.maxTextureArrayLayers = 1;

	//
	wgpuAdapterRequestDevice(adapter, *device_descriptor, (status: WGPURequestDeviceStatus, device: WGPUDevice, message: *u8, user_data: *void) #c_call {
		if status != .Success {
			print_c("Status: %, Device: %, Message: %", status, device, to_string(message));
			return;
		}

		(cast(*WGPUDevice) user_data).* = device;
	}, *device);
	assert(device != null, "GPU Device is not created correctly");

	return device;
}
webgpu_handle_resize :: (wgpu_context: *WGPUContext, width: u32, height: u32){
	surface_configure(wgpu_context, width, height);
}

wgpu_context_create :: (window: *SDL_Window, width: u32, height: u32)->WGPUContext {
	wgpu_context:WGPUContext;

	instance_desc: WGPUInstanceDescriptor;
	wgpu_context.instance = wgpuCreateInstance(*instance_desc);
	assert(wgpu_context.instance != null, "Instance is not created correctly");

	wgpu_context.surface = create_surface(wgpu_context.instance, window);
	assert(wgpu_context.surface != null, "Surface is not created correctly");

	wgpu_context.adapter = request_adapter(wgpu_context.instance, wgpu_context.surface, powerPreference = .HighPerformance);
	assert(wgpu_context.adapter != null, "Adapter is not created correctly");

	wgpu_context.device = request_device(wgpu_context.adapter, WINDOW_WIDTH, WINDOW_HEIGHT);
	assert(wgpu_context.device != null, "Device is not created correctly");

	// surface_configure(*wgpu_context, width, height);
	surface_capabilities :WGPUSurfaceCapabilities;
	wgpuSurfaceGetCapabilities(wgpu_context.surface, wgpu_context.adapter, *surface_capabilities);
	print("init: %x%\n", width, height);
	wgpu_context.config = WGPUSurfaceConfiguration.{
		device = wgpu_context.device,
		usage = xx WGPUTextureUsage.RenderAttachment,
		format = surface_capabilities.formats[0],
		presentMode = WGPUPresentMode.Fifo,
		alphaMode = surface_capabilities.alphaModes[0],
		width = width,
		height = height,
	};
	wgpuSurfaceConfigure(wgpu_context.surface, *wgpu_context.config);

	wgpuDeviceSetUncapturedErrorCallback(wgpu_context.device, (type: WGPUErrorType, msg: *u8, user_data: *void) #c_call {
		print_c("Uncaptured Error (%d), %s\n", type, to_string(msg));
	}, null);

	return wgpu_context;
}
surface_configure :: (wgpu_context: *WGPUContext, width: u32, height: u32){
	(<<wgpu_context).config.width = width;
	(<<wgpu_context).config.height = height;
	wgpuSurfaceConfigure((<<wgpu_context).surface, *((<<wgpu_context).config));
}
surface_create_current_view :: (wgpu_context: *WGPUContext) -> WGPUTextureView {
	wgpuSurfaceGetCurrentTexture((<<wgpu_context).surface, *((<<wgpu_context).surface_texture));
		current_view_descriptor := WGPUTextureViewDescriptor.{
			format = (<<wgpu_context).preferred_texture_format,
			dimension = WGPUTextureViewDimension._2D,
			aspect = WGPUTextureAspect.All,
			baseMipLevel = 0,
			mipLevelCount = 1,
			baseArrayLayer = 0,
			arrayLayerCount = 1,
		};
	return wgpuTextureCreateView((<<wgpu_context).surface_texture.texture, *current_view_descriptor);
}

create_shader :: (device: WGPUDevice, source: string, label := "Main shader") -> WGPUShaderModule {
	wgslDescriptor: WGPUShaderModuleWGSLDescriptor;
	wgslDescriptor.chain.next = null;
	wgslDescriptor.chain.sType=.ShaderModuleWGSLDescriptor;
	wgslDescriptor.code = to_c_string(source);
	#if FREE_MEMORY defer free(wgslDescriptor.code);

	shaderModuleDescriptor: WGPUShaderModuleDescriptor;
	shaderModuleDescriptor.label = to_c_string(label);
	#if FREE_MEMORY defer free(shaderModuleDescriptor.label);
	shaderModuleDescriptor.nextInChain = xx *wgslDescriptor;
	shader_module := wgpuDeviceCreateShaderModule(device, *shaderModuleDescriptor);


	return shader_module;
}

update_pipeline_descriptor_layout :: (pipeline_descriptor: *WGPURenderPipelineDescriptor, device: WGPUDevice) {
	pipeline_layout_descriptor: WGPUPipelineLayoutDescriptor;

	
	bind_group_layouts := NewArray(3, WGPUBindGroupLayout);
	#if FREE_MEMORY defer array_reset(*bind_group_layouts);

	// group 0 (object uniforms)
	{
		bind_group_layout_entries := NewArray(1, WGPUBindGroupLayoutEntry);
		#if FREE_MEMORY defer array_reset(*bind_group_layout_entries);
		bind_group_layout_entries[0] = WGPUBindGroupLayoutEntry.{
			binding = 0,
			visibility = xx WGPUShaderStage.Vertex,
			buffer = .{ type = WGPUBufferBindingType.Uniform },
		};
		bind_group_layouts[0] = wgpuDeviceCreateBindGroupLayout(device, *(WGPUBindGroupLayoutDescriptor.{
			entryCount = xx bind_group_layout_entries.count,
			entries = bind_group_layout_entries.data,
		}));
	}
	// group 1 (camera uniforms)
	{
		bind_group_layout_entries := NewArray(1, WGPUBindGroupLayoutEntry);
		#if FREE_MEMORY defer array_reset(*bind_group_layout_entries);
		bind_group_layout_entries[0] = WGPUBindGroupLayoutEntry.{
			binding = 0,
			visibility = xx WGPUShaderStage.Vertex|WGPUShaderStage.Fragment,
			buffer = .{ type = WGPUBufferBindingType.Uniform },
		};
		bind_group_layouts[1] = wgpuDeviceCreateBindGroupLayout(device, *(WGPUBindGroupLayoutDescriptor.{
			entryCount = xx bind_group_layout_entries.count,
			entries = bind_group_layout_entries.data,
		}));
	}
	// group 2 (SDF uniforms)
	{
		bind_group_layout_entries := NewArray(1, WGPUBindGroupLayoutEntry);
		#if FREE_MEMORY defer array_reset(*bind_group_layout_entries);
		bind_group_layout_entries[0] = WGPUBindGroupLayoutEntry.{
			binding = 0,
			visibility = xx WGPUShaderStage.Vertex|WGPUShaderStage.Fragment,
			buffer = .{ type = WGPUBufferBindingType.Uniform },
		};
		bind_group_layouts[2] = wgpuDeviceCreateBindGroupLayout(device, *(WGPUBindGroupLayoutDescriptor.{
			entryCount = xx bind_group_layout_entries.count,
			entries = bind_group_layout_entries.data,
		}));
	}
	//
	pipeline_layout_descriptor.bindGroupLayoutCount = xx bind_group_layouts.count;
	pipeline_layout_descriptor.bindGroupLayouts = bind_group_layouts.data;

	pipeline_descriptor.layout = wgpuDeviceCreatePipelineLayout(device, *pipeline_layout_descriptor);
}

update_pipeline_descriptor :: (
	pipeline_descriptor: *WGPURenderPipelineDescriptor,
	// surface: WGPUSurface,
	// adapter: WGPUAdapter,
	device: WGPUDevice,
	shader: WGPUShaderModule,
	vertex_buffer_layout: *WGPUVertexBufferLayout,
	fragment_state: *WGPUFragmentState
) {
	// preferred_texture_format := WGPUSurfaceGetPreferredFormat(surface, adapter);

	// pipeline_descriptor: WGPURenderPipelineDescriptor;
	pipeline_descriptor.label = "Render Pipeline";

	// uniforms
	update_pipeline_descriptor_layout(pipeline_descriptor, device);

	// vertex
	vertex_state: WGPUVertexState;
	vertex_state.module = shader;
	vertex_state.entryPoint = "vertex";
	vertex_state.bufferCount = 1;
	// tmp_layout := wasm_make_vertex_layout(vertex_buffer_layout_type);
	vertex_state.buffers = vertex_buffer_layout;//*Wasm_VertexBufferLayout_to_wgpu(tmp_layout);

	pipeline_descriptor.vertex = vertex_state;

	pipeline_descriptor.primitive = .{
		topology=.TriangleList,
		stripIndexFormat=.Undefined,
		// frontFace=.CCW,
		cullMode=.None,
	};
	// primitive: {
	// 		cullMode: "back",
	// 	},

	// pipeline_descriptor.multisample = .{
	// 	count = 1,
	// 	mask = 1,
	// 	alphaToCoverageEnabled = false,
	// };

	// color_target_state: WGPUColorTargetState;
	// color_target_state.format = preferred_texture_format;
	// color_target_state.blend = *(WGPUBlendState.{
	// 	color = .{ srcFactor = .One, dstFactor = .Zero, operation = .Add },
	// 	alpha = .{ srcFactor = .One, dstFactor = .Zero, operation = .Add },
	// });
	// color_target_state.writeMask = xx WGPUColorWriteMask.All;

	// fragment_state: WGPUFragmentState;
	// fragment_state.module = shader;
	// fragment_state.entryPoint = "fragment";
	// fragment_state.targetCount = 1;
	// fragment_state.targets = *color_target_state;

	pipeline_descriptor.fragment = fragment_state;

	// pipeline_descriptor.depthStencil = null;

}
fragment_state_prepare :: (
	fragment_state: *WGPUFragmentState,
	color_target_state: *WGPUColorTargetState,
	shader: WGPUShaderModule,
	preferred_texture_format:WGPUTextureFormat
){

	color_target_state.format = preferred_texture_format;
	color_target_state.blend = *(WGPUBlendState.{ 
		color = .{ srcFactor = .One, dstFactor = .Zero, operation = .Add },
		alpha = .{ srcFactor = .One, dstFactor = .Zero, operation = .Add },
	});
	color_target_state.writeMask = xx WGPUColorWriteMask.All;

	fragment_state.module = shader;
	fragment_state.entryPoint = "fragment";
	fragment_state.targetCount = 1;
	fragment_state.targets = color_target_state;
}
pipeline_descriptor_print :: (pipeline_descriptor: *WGPURenderPipelineDescriptor){
	{
		info := type_info(type_of(<<pipeline_descriptor));
		log("pipeline contains the following members:");
		for info.members {
			log("%: % of type %", it_index, it.name, type_to_string(it.type));
		}
	}
	// vertex
	{
		info := type_info(type_of((<<pipeline_descriptor).vertex));
		log("vertex contains the following members:");
		for info.members {
			log("%: % of type %", it_index, it.name, type_to_string(it.type));
		}
	}
	// vertex buffers
	{
		buffers := <<((<<pipeline_descriptor).vertex.buffers);
		info := type_info(type_of(buffers));
		log("vertex.buffers contains the following members:");
		for info.members {
			log("%: % of type %", it_index, it.name, type_to_string(it.type));
		}
		print("step mode: %\n", buffers.stepMode);
	}
	// multisample
	{
		multisample := ((<<pipeline_descriptor).multisample);
		info := type_info(type_of(multisample));
		log("multisample contains the following members:");
		for info.members {
			log("%: % of type %", it_index, it.name, type_to_string(it.type));
		}
		print("multisample.count: %\n", multisample.count);
	}
}


vertex_array_to_buffer :: (device: WGPUDevice, queue: WGPUQueue, vertices: []Vertex) -> WGPUBuffer, u64 {
	size := cast(u64) vertices.count * size_of(Vertex);

	buffer := wgpuDeviceCreateBuffer(device, *(WGPUBufferDescriptor.{
		usage = xx (WGPUBufferUsage.Vertex | WGPUBufferUsage.CopyDst),
		size=size
	}));
	assert(buffer != null, "Buffer is not created correctly");

	wgpuQueueWriteBuffer(queue, buffer, 0, vertices.data, size);

	return buffer, size;
}
index_array_to_buffer :: (device: WGPUDevice, queue: WGPUQueue, indices: []VertexIndex) -> WGPUBuffer, u64 {
	size := cast(u64) indices.count * size_of(VertexIndex);

	buffer := wgpuDeviceCreateBuffer(device, *(WGPUBufferDescriptor.{
		usage = xx (WGPUBufferUsage.Index | WGPUBufferUsage.CopyDst),
		size=size
	}));
	assert(buffer != null, "Buffer is not created correctly");

	wgpuQueueWriteBuffer(queue, buffer, 0, indices.data, size);

	return buffer, size;
}

// update_vertex_array_to_buffer :: (buffer:WGPUBuffer, queue: WGPUQueue, vertices: []Vertex) {
// 	size := cast(u64) vertices.count * size_of(Vertex);
// 	wgpuQueueWriteBuffer(queue, buffer, 0, vertices.data, size);
// }
update_vertex_array_to_buffer :: (buffer:WGPUBuffer, queue: WGPUQueue, scene_data: *SceneData) {
	size := cast(u64) scene_data.vertices.count * size_of(Vertex);
	wgpuQueueWriteBuffer(queue, buffer, 0, scene_data.vertices.data, size);
}

Wasm_VertexBufferLayout_to_wgpu :: (layout: Wasm_VertexBufferLayout)-> WGPUVertexBufferLayout, []WGPUVertexAttribute {
	vertex_buffer_layout := WGPUVertexBufferLayout.{
		arrayStride=xx layout.arrayStride,
		stepMode=xx layout.stepMode,
		attributeCount=xx layout.attributeCount,
		// attributes=NewArray(layout.attributeCount, WGPUVertexAttribute);
	};

	attributes := NewArray(xx layout.attributeCount, WGPUVertexAttribute);
	for 0..(layout.attributeCount-1) {
		src_attribute := layout.attributes[it];
		attributes[it] = WGPUVertexAttribute.{
			format=xx src_attribute.format,
			offset=xx src_attribute.offset,
			shaderLocation=xx src_attribute.shaderLocation,
		};
	}
	vertex_buffer_layout.attributes = attributes.data;

	return vertex_buffer_layout, attributes;
}