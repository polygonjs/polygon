



wgpu_texture_get_width_surface :: (wgpuContext: *WGPUContext) -> u32 {
	assert(wgpuContext.surface_texture.texture != null, "surface_texture.texture is null\n");
	return wgpuTextureGetWidth(wgpuContext.surface_texture.texture);
}
wgpu_texture_get_height_surface :: (wgpuContext: *WGPUContext) -> u32 {
	assert(wgpuContext.surface_texture.texture != null, "surface_texture.texture is null\n");
	return wgpuTextureGetHeight(wgpuContext.surface_texture.texture);
}




print_c :: (format: string, args: ..Any, to_standard_error := false) #expand {
	new_context: #Context;
	push_context new_context {
		print(format, ..args, to_standard_error);
	}
} @PrintLike

request_adapter :: (instance: WGPUInstance, _surface: WGPUSurface, powerPreference: WGPUPowerPreference, forceFallbackAdapter := false, $headless := false) -> WGPUAdapter {
	adapter: WGPUAdapter;

	#if headless {
		surface := null;
	} else {
		surface := _surface;
	}
	request_adapter_options := WGPURequestAdapterOptions.{
		compatibleSurface = surface,
		powerPreference = powerPreference,
		forceFallbackAdapter = xx forceFallbackAdapter,
	};

	wgpuInstanceRequestAdapter(instance, *request_adapter_options, (status: WGPURequestAdapterStatus, adapter: WGPUAdapter, message: *u8, user_data: *void) #c_call {
		// for a reason I don't understand,
		// if message is not evaluated, we get the following crash:
		// free(): invalid pointer
		// Aborted (core dumped)
		// so the solution is to evaluate it:
		message;
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
	surface_desc.label = to_c_string_temp(label);
	// #if FREE_MEMORY defer free(surface_desc.label);

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
wgpuContextResize :: (wgpuContext: *WGPUContext, size: Vector2UInt){
	wgpuContext.config.width = size.x;
	wgpuContext.config.height = size.y;
	wgpuSurfaceConfigure(wgpuContext.surface, *wgpuContext.config);
	wgpuContext.windowSize = size;
}

wgpuContextInitHeadless :: (wgpuContext: *WGPUContext, size: Vector2UInt){
	assert(wgpuContext.mode == .UNSET, "wgpuContext.mode is not .UNSET");
	wgpuContext.mode = .HEADLESS;
	surface_capabilities := wgpuContextInit(wgpuContext, size);
	// on_wgpu_device_ready(wgpuContext.surface, wgpuContext.device, wgpuContext.queue, wgpuContext.preferred_texture_format);
}
wgpuContextInitIfAllowed :: (wgpuContext: *WGPUContext, window: *SDL_Window, size: Vector2UInt){
	assert(wgpuContext.mode == .UNSET, "wgpuContext.mode is not .UNSET");
	wgpuContext.mode = .SURFACE;
	/*surface_capabilities := */wgpuContextInit(window, wgpuContext, size);

	// on_wgpu_device_ready(wgpuContext.surface, wgpuContext.device, wgpuContext.queue, wgpuContext.preferred_texture_format);
}

wgpuContextInit :: (window: *SDL_Window, wgpuContext: *WGPUContext, size: Vector2UInt) {

	instance_desc: WGPUInstanceDescriptor;
	wgpuContext.instance = wgpuCreateInstance(*instance_desc);
	assert(wgpuContext.instance != null, "Instance is not created correctly");

	wgpuContext.surface = create_surface(wgpuContext.instance, window);
	assert(wgpuContext.surface != null, "Surface is not created correctly");

	wgpuContext.adapter = request_adapter(wgpuContext.instance, wgpuContext.surface, powerPreference = .HighPerformance, headless = false);
	assert(wgpuContext.adapter != null, "Adapter is not created correctly");

	surface_capabilities :WGPUSurfaceCapabilities;
	wgpuSurfaceGetCapabilities(wgpuContext.surface, wgpuContext.adapter, *surface_capabilities);

	#if COLOR_SPACE_LINEAR {
		linearFormatIfAvailable :: (surface_capabilities :*WGPUSurfaceCapabilities, wgpuContext:*WGPUContext)->WGPUTextureFormat {
			for i:0..(surface_capabilities.formatCount-1) {
				if( surface_capabilities.formats[i] == .BGRA8Unorm){
					return surface_capabilities.formats[i];
				}
				
			}
			preferred_format := wgpuSurfaceGetPreferredFormat(wgpuContext.surface, wgpuContext.adapter);
			print("linear format not available, using device preferred format: %\n", preferred_format);
			return wgpuSurfaceGetPreferredFormat(wgpuContext.surface, wgpuContext.adapter);
		}
		wgpuContext.preferred_texture_format = linearFormatIfAvailable(*surface_capabilities, wgpuContext);
	} else {
		wgpuContext.preferred_texture_format = wgpuSurfaceGetPreferredFormat(wgpuContext.surface, wgpuContext.adapter);
	}

	wgpuContext.device = request_device(wgpuContext.adapter, size.x, size.y);
	assert(wgpuContext.device != null, "Device is not created correctly");

	wgpuContext.queue = wgpuDeviceGetQueue(wgpuContext.device);
	assert(wgpuContext.queue != null, "Queue is not created correctly");

	// printFormats :: (surface_capabilities :*WGPUSurfaceCapabilities) {
	// 	for 0..(surface_capabilities.formatCount-1) {
	// 		print("format: %\n", surface_capabilities.formats[it]);
	// 	}
	// }
	// printAlphaModes :: (surface_capabilities :*WGPUSurfaceCapabilities) {
	// 	for 0..(surface_capabilities.alphaModeCount-1) {
	// 		print("alphaMode: %\n", surface_capabilities.alphaModes[it]);
	// 	}
	// }
	// printFormats(*surface_capabilities);
	// printAlphaModes(*surface_capabilities);

	get_present_mode :: (surface_capabilities :*WGPUSurfaceCapabilities)-> WGPUPresentMode {
		presentModeAvailable :: (surface_capabilities :*WGPUSurfaceCapabilities, mode: WGPUPresentMode) -> bool {
			for 0..(surface_capabilities.presentModeCount-1) {
				if surface_capabilities.presentModes[it] == mode {
					return true;
				}
			}
			return false;
		}
		fifoPresentMode := ifx presentModeAvailable(surface_capabilities, WGPUPresentMode.FifoRelaxed) then
			WGPUPresentMode.FifoRelaxed
			else
			WGPUPresentMode.Fifo;

		#if WASM || VSYNC {
			return fifoPresentMode;
		} else {
			if presentModeAvailable(surface_capabilities, WGPUPresentMode.Mailbox)
				return WGPUPresentMode.Mailbox;
			else
				return WGPUPresentMode.Immediate;
		}
	}
	
	present_mode := get_present_mode(*surface_capabilities);
	wgpuContext.config = WGPUSurfaceConfiguration.{
		device = wgpuContext.device,
		usage = xx WGPUTextureUsage.RenderAttachment|WGPUTextureUsage.CopySrc,
		format = wgpuContext.preferred_texture_format,
		presentMode = present_mode,
		alphaMode = surface_capabilities.alphaModes[0],
		width = size.x,
		height = size.y,
	};
	wgpuSurfaceConfigure(wgpuContext.surface, *wgpuContext.config);

	wgpuDeviceSetUncapturedErrorCallback(wgpuContext.device, (type: WGPUErrorType, msg: *u8, user_data: *void) #c_call {
		print_c("Uncaptured Error (%d), %s\n", type, to_string(msg));
	}, null);

	wgpuContext.windowSize = size;
}

wgpuContextInit :: (wgpuContext: *WGPUContext, size: Vector2UInt) {
	// Create instance
	instance_desc: WGPUInstanceDescriptor;
	wgpuContext.instance = wgpuCreateInstance(*instance_desc);
	assert(wgpuContext.instance != null, "Instance is not created correctly");

	// Request adapter without surface
	wgpuContext.adapter = request_adapter(wgpuContext.instance, null, powerPreference = .HighPerformance, headless = true);
	assert(wgpuContext.adapter != null, "Adapter is not created correctly");

	// Use a common format for off-screen rendering
	wgpuContext.preferred_texture_format = .RGBA8Unorm;

	wgpuContext.device = request_device(wgpuContext.adapter, size.x, size.y);
	assert(wgpuContext.device != null, "Device is not created correctly");

	wgpuContext.queue = wgpuDeviceGetQueue(wgpuContext.device);
	assert(wgpuContext.queue != null, "Queue is not created correctly");

	wgpuDeviceSetUncapturedErrorCallback(wgpuContext.device, (type: WGPUErrorType, msg: *u8, user_data: *void) #c_call {
		print_c("Uncaptured Error (%d), %s\n", type, to_string(msg));
	}, null);

	wgpuContext.surface_texture.texture = create_offscreen_texture(wgpuContext.device, size.x, size.y, wgpuContext.preferred_texture_format);

	wgpuContext.windowSize = size;
}

create_offscreen_texture :: (device: WGPUDevice, width: u32, height: u32, format: WGPUTextureFormat) -> WGPUTexture {
	texture_desc := WGPUTextureDescriptor.{
		size = .{
			width = width,
			height = height,
			depthOrArrayLayers = 1
		},
		mipLevelCount = 1,
		sampleCount = 1,
		dimension = ._2D,
		format = format,
		usage = xx (WGPUTextureUsage.RenderAttachment | WGPUTextureUsage.CopySrc),
	};

	return wgpuDeviceCreateTexture(device, *texture_desc);
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



