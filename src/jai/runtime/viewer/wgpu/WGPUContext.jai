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
	//
	multisampleTexture: WGPUTexture;
	multisampleTextureView: WGPUTextureView=null;
	//
	depthTextureStencilAttachment: WGPURenderPassDepthStencilAttachment;
	depthTexture: WGPUTexture;
	depthTextureView: WGPUTextureView=null;
	//
	capturedError:string;
	#if WASM {
		onPopErrorScopeCompleted: OnPopErrorScopeCompletedCallback = DEFAULT_ON_POP_ERROR_SCOPE_COMPLETED;
	}

};


wgpuContextReset :: (wgpuContext:*WGPUContext){
	wgpuContext.capturedError = "";
}

#if WASM {
	OnPopErrorScopeCompletedCallback :: #type (errorSize: u64);
	DEFAULT_ON_POP_ERROR_SCOPE_COMPLETED :OnPopErrorScopeCompletedCallback: (errorSize: u64) {}
}

