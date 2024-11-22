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
	framesCount: FrameCount;
};
