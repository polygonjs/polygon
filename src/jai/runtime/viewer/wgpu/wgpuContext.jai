WGPUContextMode :: enum u8 {
	UNSET :: 0;
	SURFACE :: 1;
	HEADLESS :: 2;
};

WGPUContext :: struct {
	device: WGPUDevice;
	queue:WGPUQueue;
	preferred_texture_format :WGPUTextureFormat;
	surface: WGPUSurface; // this is the canvas heapIndex in wasm
	surface_texture :WGPUSurfaceTexture;
	framesCount: FrameCount;
	#if WASM == false {
		mode: WGPUContextMode = .UNSET;
		instance: WGPUInstance;
		adapter: WGPUAdapter; // only useful to keep around when releasing it
		config: WGPUSurfaceConfiguration;
	}
	windowSize: Vector2UInt;
};
