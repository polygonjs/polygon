WGPUContext :: struct {
	instance: wgpu.Instance;
	surface: wgpu.Surface;
	adapter:wgpu.Adapter;
	device: wgpu.Device ;
	config: wgpu.SurfaceConfiguration;
	surface_texture :wgpu.SurfaceTexture;
	preferred_texture_format :wgpu.TextureFormat;
	//
	use_msaa: bool=true;
	use_depth_buffer: bool=true;
	bg_color :wgpu.Color =.{0.0, 0.0, 0.0, 1.0};
	//
	multisample_texture_descriptor : wgpu.TextureDescriptor;
	multisample_texture: wgpu.Texture;
	multisample_texture_view: *wgpu.TextureView;
	//
	depth_texture: wgpu.Texture;
	depth_texture_view: *wgpu.TextureView;
};

print_c :: (format: string, args: ..Any, to_standard_error := false) #expand {
	new_context: Context;
	push_context new_context {
		print(format, ..args, to_standard_error);
	}
} @PrintLike

request_adapter :: (instance: wgpu.Instance, surface: wgpu.Surface, powerPreference: wgpu.PowerPreference, forceFallbackAdapter := false) -> wgpu.Adapter {
	adapter: wgpu.Adapter;

	request_adapter_options := wgpu.RequestAdapterOptions.{
		compatibleSurface = surface,
		powerPreference = powerPreference,
		forceFallbackAdapter = xx forceFallbackAdapter,
	};

	wgpu.InstanceRequestAdapter(instance, *request_adapter_options, (status: wgpu.RequestAdapterStatus, adapter: wgpu.Adapter, message: *u8, user_data: *void) #c_call {
		if status != .Success {
			print_c("%\n", message);
			return;
		};

		<< cast(*wgpu.Adapter) user_data = adapter;
	}, *adapter);

	return adapter;
}

create_surface :: (instance: wgpu.Instance, window: *SDL_Window, label := "Main Surface") -> wgpu.Surface {
	surface_desc: wgpu.SurfaceDescriptor;
	surface_desc.label = to_c_string(label);

	#if OS == .WINDOWS {
		sdl_info: SDL_SysWMinfo;
		assert(xx SDL_GetWindowWMInfo(window,  *sdl_info), "Cannot get SDL info!\n");

		surface_desc_from_windows_hwnd: wgpu.SurfaceDescriptorFromWindowsHWND;
		surface_desc_from_windows_hwnd.chain.sType = .SurfaceDescriptorFromWindowsHWND;
		surface_desc_from_windows_hwnd.hwnd = sdl_info.info.win.window;

		surface_desc.nextInChain = xx *surface_desc_from_windows_hwnd;
	}

	#if OS == .MACOS {
		metal_view := SDL_Metal_CreateView(window);
		metal_layer := SDL_Metal_GetLayer(metal_view);

		surface_desc_from_metal_layer: wgpu.SurfaceDescriptorFromMetalLayer;
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
		surface_desc_from_xlib_window: wgpu.SurfaceDescriptorFromXlibWindow;
		surface_desc_from_xlib_window.chain.sType = .SurfaceDescriptorFromXlibWindow;
		surface_desc_from_xlib_window.display = sdl_info.info.x11.display;
		surface_desc_from_xlib_window.window = xx sdl_info.info.x11.window;

		surface_desc.nextInChain = xx *surface_desc_from_xlib_window;
	}

	surface := wgpu.InstanceCreateSurface(instance, *surface_desc);

	return surface;
}

request_device :: (adapter: wgpu.Adapter, width:int, height:int) -> wgpu.Device {
	device_descriptor: wgpu.DeviceDescriptor;
	device: wgpu.Device;

	// from https://eliemichel.github.io/LearnWebGPU/basic-3d-rendering/3d-meshes/depth-buffer.html
	// device_descriptor.requiredLimits.limits.maxTextureDimension1D = xx height;
	// device_descriptor.requiredLimits.limits.maxTextureDimension2D = xx width;
	// device_descriptor.requiredLimits.limits.maxTextureArrayLayers = 1;

	//
	wgpu.AdapterRequestDevice(adapter, *device_descriptor, (status: wgpu.RequestDeviceStatus, device: wgpu.Device, message: *u8, user_data: *void) #c_call {
		if status != .Success {
			print_c("Status: %, Device: %, Message: %", status, device, to_string(message));
			return;
		}

		(cast(*wgpu.Device) user_data).* = device;
	}, *device);
	assert(device != null, "GPU Device is not created correctly");

	return device;
}
webgpu_handle_resize :: (wgpu_context: *WGPUContext, width: u32, height: u32){
	surface_configure(wgpu_context, width, height);
}

wgpu_context_create :: (window: *SDL_Window, width: u32, height: u32)->WGPUContext {
	wgpu_context:WGPUContext;

	instance_desc: wgpu.InstanceDescriptor;
	wgpu_context.instance = wgpu.CreateInstance(*instance_desc);
	assert(wgpu_context.instance != null, "Instance is not created correctly");

	wgpu_context.surface = create_surface(wgpu_context.instance, window);
	assert(wgpu_context.surface != null, "Surface is not created correctly");

	wgpu_context.adapter = request_adapter(wgpu_context.instance, wgpu_context.surface, powerPreference = .HighPerformance);
	assert(wgpu_context.adapter != null, "Adapter is not created correctly");

	wgpu_context.device = request_device(wgpu_context.adapter, WINDOW_WIDTH, WINDOW_HEIGHT);
	assert(wgpu_context.device != null, "Device is not created correctly");

	// surface_configure(*wgpu_context, width, height);
	surface_capabilities :wgpu.SurfaceCapabilities;
	wgpu.SurfaceGetCapabilities(wgpu_context.surface, wgpu_context.adapter, *surface_capabilities);
	print("init: %x%\n", width, height);
	wgpu_context.config = wgpu.SurfaceConfiguration.{
		device = wgpu_context.device,
		usage = xx wgpu.TextureUsage.RenderAttachment,
		format = surface_capabilities.formats[0],
		presentMode = wgpu.PresentMode.Fifo,
		alphaMode = surface_capabilities.alphaModes[0],
		width = width,
		height = height,
	};
	wgpu.SurfaceConfigure(wgpu_context.surface, *wgpu_context.config);

	wgpu.DeviceSetUncapturedErrorCallback(wgpu_context.device, (type: wgpu.ErrorType, msg: *u8, user_data: *void) #c_call {
		print_c("Uncaptured Error (%d), %s\n", type, to_string(msg));
	}, null);

	return wgpu_context;
}
surface_configure :: (wgpu_context: *WGPUContext, width: u32, height: u32){
	(<<wgpu_context).config.width = width;
	(<<wgpu_context).config.height = height;
	wgpu.SurfaceConfigure((<<wgpu_context).surface, *((<<wgpu_context).config));
}
surface_create_current_view :: (wgpu_context: *WGPUContext) -> wgpu.TextureView {
	wgpu.SurfaceGetCurrentTexture((<<wgpu_context).surface, *((<<wgpu_context).surface_texture));
		current_view_descriptor := wgpu.TextureViewDescriptor.{
			format = (<<wgpu_context).preferred_texture_format,
			dimension = wgpu.TextureViewDimension._2D,
			aspect = wgpu.TextureAspect.All,
			baseMipLevel = 0,
			mipLevelCount = 1,
			baseArrayLayer = 0,
			arrayLayerCount = 1,
		};
	return wgpu.TextureCreateView((<<wgpu_context).surface_texture.texture, *current_view_descriptor);
}

create_shader :: (device: wgpu.Device, source: string, label := "Main shader") -> wgpu.ShaderModule {
	wgslDescriptor: wgpu.ShaderModuleWGSLDescriptor;
	wgslDescriptor.chain.next = null;
	wgslDescriptor.chain.sType=.ShaderModuleWGSLDescriptor;
	wgslDescriptor.code = to_c_string(source); 

	shaderModuleDescriptor: wgpu.ShaderModuleDescriptor;
	shaderModuleDescriptor.label = to_c_string(label);
	shaderModuleDescriptor.nextInChain = xx *wgslDescriptor;

	return wgpu.DeviceCreateShaderModule(device, *shaderModuleDescriptor);
}

update_pipeline_descriptor_layout :: (pipeline_descriptor: *wgpu.RenderPipelineDescriptor, device: wgpu.Device) {
	pipeline_layout_descriptor: wgpu.PipelineLayoutDescriptor;

	
	bind_group_layouts := NewArray(2, wgpu.BindGroupLayout);

	// group 0
	{
		bind_group_layout_entries := NewArray(1, wgpu.BindGroupLayoutEntry);
		bind_group_layout_entries[0] = wgpu.BindGroupLayoutEntry.{
			binding = 0,
			visibility = xx wgpu.ShaderStage.Vertex,
			buffer = .{ type = wgpu.BufferBindingType.Uniform },
		};
		bind_group_layouts[0] = wgpu.DeviceCreateBindGroupLayout(device, *(wgpu.BindGroupLayoutDescriptor.{
			entryCount = xx bind_group_layout_entries.count,
			entries = bind_group_layout_entries.data,
		}));
	}
	// group 1
	{
		bind_group_layout_entries := NewArray(1, wgpu.BindGroupLayoutEntry);
		bind_group_layout_entries[0] = wgpu.BindGroupLayoutEntry.{
			binding = 0,
			visibility = xx wgpu.ShaderStage.Vertex|wgpu.ShaderStage.Fragment,
			buffer = .{ type = wgpu.BufferBindingType.Uniform },
		};
		bind_group_layouts[1] = wgpu.DeviceCreateBindGroupLayout(device, *(wgpu.BindGroupLayoutDescriptor.{
			entryCount = xx bind_group_layout_entries.count,
			entries = bind_group_layout_entries.data,
		}));
	}
	// 
	pipeline_layout_descriptor.bindGroupLayoutCount = xx bind_group_layouts.count;
	pipeline_layout_descriptor.bindGroupLayouts = bind_group_layouts.data;

	pipeline_descriptor.layout = wgpu.DeviceCreatePipelineLayout(device, *pipeline_layout_descriptor);
}

update_pipeline_descriptor :: (
	pipeline_descriptor: *wgpu.RenderPipelineDescriptor,
	// surface: wgpu.Surface,
	// adapter: wgpu.Adapter,
	device: wgpu.Device,
	shader: wgpu.ShaderModule,
	vertex_buffer_layout: *wgpu.VertexBufferLayout,
	fragment_state: *wgpu.FragmentState
) {
	// preferred_texture_format := wgpu.SurfaceGetPreferredFormat(surface, adapter);

	// pipeline_descriptor: wgpu.RenderPipelineDescriptor;
	pipeline_descriptor.label = "Render Pipeline";

	

	// uniforms
	update_pipeline_descriptor_layout(pipeline_descriptor, device);

	// vertex
	vertex_state: wgpu.VertexState;
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

	// color_target_state: wgpu.ColorTargetState;
	// color_target_state.format = preferred_texture_format;
	// color_target_state.blend = *(wgpu.BlendState.{ 
	// 	color = .{ srcFactor = .One, dstFactor = .Zero, operation = .Add },
	// 	alpha = .{ srcFactor = .One, dstFactor = .Zero, operation = .Add },
	// });
	// color_target_state.writeMask = xx wgpu.ColorWriteMask.All;

	// fragment_state: wgpu.FragmentState;
	// fragment_state.module = shader;
	// fragment_state.entryPoint = "fragment";
	// fragment_state.targetCount = 1;
	// fragment_state.targets = *color_target_state;

	pipeline_descriptor.fragment = fragment_state;

	// pipeline_descriptor.depthStencil = null;

}
fragment_state_prepare :: (
	fragment_state: *wgpu.FragmentState,
	color_target_state: *wgpu.ColorTargetState,
	shader: wgpu.ShaderModule,
	preferred_texture_format:wgpu.TextureFormat
){

	color_target_state.format = preferred_texture_format;
	color_target_state.blend = *(wgpu.BlendState.{ 
		color = .{ srcFactor = .One, dstFactor = .Zero, operation = .Add },
		alpha = .{ srcFactor = .One, dstFactor = .Zero, operation = .Add },
	});
	color_target_state.writeMask = xx wgpu.ColorWriteMask.All;

	fragment_state.module = shader;
	fragment_state.entryPoint = "fragment";
	fragment_state.targetCount = 1;
	fragment_state.targets = color_target_state;
}
pipeline_descriptor_print :: (pipeline_descriptor: *wgpu.RenderPipelineDescriptor){
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


vertex_array_to_buffer :: (device: wgpu.Device, queue: wgpu.Queue, vertices: []Vertex) -> wgpu.Buffer, u64 {
	size := cast(u64) vertices.count * size_of(Vertex);

	buffer := wgpu.DeviceCreateBuffer(device, *(wgpu.BufferDescriptor.{
		usage = xx (wgpu.BufferUsage.Vertex | wgpu.BufferUsage.CopyDst),
		size=size
	}));
	assert(buffer != null, "Buffer is not created correctly");

	wgpu.QueueWriteBuffer(queue, buffer, 0, vertices.data, size);

	return buffer, size;
}
index_array_to_buffer :: (device: wgpu.Device, queue: wgpu.Queue, indices: []VertexIndex) -> wgpu.Buffer, u64 {
	size := cast(u64) indices.count * size_of(VertexIndex);

	buffer := wgpu.DeviceCreateBuffer(device, *(wgpu.BufferDescriptor.{
		usage = xx (wgpu.BufferUsage.Index | wgpu.BufferUsage.CopyDst),
		size=size
	}));
	assert(buffer != null, "Buffer is not created correctly");

	wgpu.QueueWriteBuffer(queue, buffer, 0, indices.data, size);

	return buffer, size;
}

// update_vertex_array_to_buffer :: (buffer:wgpu.Buffer, queue: wgpu.Queue, vertices: []Vertex) {
// 	size := cast(u64) vertices.count * size_of(Vertex);
// 	wgpu.QueueWriteBuffer(queue, buffer, 0, vertices.data, size);
// }
update_vertex_array_to_buffer :: (buffer:wgpu.Buffer, queue: wgpu.Queue, scene_data: *SceneData) {
	size := cast(u64) scene_data.vertices.count * size_of(Vertex);
	wgpu.QueueWriteBuffer(queue, buffer, 0, scene_data.vertices.data, size);
}

Wasm_VertexBufferLayout_to_wgpu :: (layout: Wasm_VertexBufferLayout)-> wgpu.VertexBufferLayout {
	vertex_buffer_layout := wgpu.VertexBufferLayout.{
		arrayStride=xx layout.arrayStride,
		stepMode=xx layout.stepMode,
		attributeCount=xx layout.attributeCount,
		// attributes=NewArray(layout.attributeCount, WGPUVertexAttribute);
	};

	attributes := NewArray(xx layout.attributeCount, wgpu.VertexAttribute);
	for 0..(layout.attributeCount-1) {
		src_attribute := layout.attributes[it];
		attributes[it] = wgpu.VertexAttribute.{
			shaderLocation=xx src_attribute.shaderLocation,
			offset=xx src_attribute.offset,
			format=xx src_attribute.format,
		};
	}
	vertex_buffer_layout.attributes = attributes.data;

	return vertex_buffer_layout;
}