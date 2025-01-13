onCapturedError:WGPUErrorCallback = (type: WGPUErrorType, msg: *u8, userdata: *void)->void #c_call {
	wgpuContext := cast(*WGPUContext) userdata;
	wgpuContext.capturedError = to_string(msg);
}


onUncapturedError :WGPUErrorCallback: (type: WGPUErrorType, msg: *u8, user_data: *void) #c_call {
	print_c("Uncaptured Error (type=%), message=%\n", type, to_string(msg));
	push_context {
		assert(false, "we have an uncaptured wgpu error");
	}
}

#if WASM {
	onCapturedErrorWasm :: (errorSize:u64, wgpuContext:*WGPUContext){
		wgpuContext.capturedError.count = xx errorSize;
		wgpuContext.onPopErrorScopeCompleted(errorSize);
	}
	setOnPopErrorScopeCompletedCallback :: (wgpuContext:*WGPUContext, callback:OnPopErrorScopeCompletedCallback){
		wgpuContext.onPopErrorScopeCompleted = callback;
	}
}

