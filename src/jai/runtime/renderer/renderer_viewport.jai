
// renderer_set_viewport :: (encoder: WGPURenderPassEncoder, x: float, y: float, width: float, height: float, min_depth: float = 0.0, max_depth: float = 1.0) {
// 	wgpuRenderPassEncoderSetViewport(encoder, x, y, width, height, min_depth, max_depth);
// 	wgpuRenderPassEncoderSetScissorRect(encoder, xx x, xx y, xx width, xx height);
// }
set_viewport :: (encoder: WGPURenderPassEncoder, x: float, y: float, width: float, height: float, min_depth: float = 0.0, max_depth: float = 1.0) {
	wgpuRenderPassEncoderSetViewport(encoder, x, y, width, height, min_depth, max_depth);
	// Removed: wgpuRenderPassEncoderSetScissorRect(encoder, xx x, xx y, xx width, xx height);
}

// Add a new function to set the scissor rect separately if needed
set_scissor_rect :: (encoder: WGPURenderPassEncoder, x: u32, y: u32, width: u32, height: u32) {
	wgpuRenderPassEncoderSetScissorRect(encoder, x, y, width, height);
}