pipeline_controller_create_fragment_state_init :: (fragment_state: *WGPUFragmentState, color_target_state: *WGPUColorTargetState, shader: WGPUShaderModule, format:WGPUTextureFormat ){

	color_target_state.format = format;
	if format == WGPUTextureFormat.RGBA32Uint {
		color_target_state.blend = null;
	}else {
		color_target_state.blend = *(WGPUBlendState.{
			color = .{ srcFactor = .One, dstFactor = .Zero, operation = .Add },
			alpha = .{ srcFactor = .One, dstFactor = .Zero, operation = .Add },
		});
	}
	color_target_state.writeMask = xx WGPUColorWriteMask.All;

	fragment_state.module = shader;
	fragment_state.entryPoint = "fragment";
	fragment_state.targetCount = 1;
	fragment_state.targets = color_target_state;
}