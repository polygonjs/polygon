WGPUContext :: struct {
	device: WGPUDevice;
	queue:WGPUQueue;
	preferred_texture_format :WGPUTextureFormat;
	surface: WGPUSurface; // this is the canvas heapIndex in wasm
	#if WASM {
		surface_texture :WGPUSurfaceTexture;
	} else {
		instance: WGPUInstance;
		adapter: WGPUAdapter; // only useful to keep around when releasing it
		config: WGPUSurfaceConfiguration;
		surface_texture :WGPUSurfaceTexture;
	}
	//
	use_msaa: bool=true;
	use_depth_buffer: bool=true;
	bg_color :WGPUColor =.{0.1, 0.3, 0.72, 1.0};
	//
	multisample_texture_descriptor : WGPUTextureDescriptor;
	multisample_texture: WGPUTexture;
	multisample_texture_view: *WGPUTextureView;
	//
	depth_texture: WGPUTexture;
	depth_texture_view: *WGPUTextureView;
};
