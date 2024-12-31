rendererTargetSize :: (renderer:*Renderer) -> Vector2UInt64 {
	if renderer.useReadback {
		return renderer.viewport.size;
	} else {
		width := wgpu_texture_get_width_surface(renderer.wgpuContext);
		height := wgpu_texture_get_height_surface(renderer.wgpuContext);
		return .{xx width, xx height};
	}
}

rendererSize :: (renderer:*Renderer) -> Vector2UInt64 {
	if renderer.fullScreen {
		width := wgpu_texture_get_width_surface(renderer.wgpuContext);
		height := wgpu_texture_get_height_surface(renderer.wgpuContext);
		return .{xx width, xx height};
	} else {
		return renderer.viewport.size;
	}
}
rendererSetSize :: (renderer:*Renderer, size: Vector2UInt64){
	renderer.viewport.size = size;

	if renderer.useReadback {
		createPixelReadbackResources(renderer);
	}
}
rendererCopySize :: (src:*Renderer, target: *Renderer){
	rendererSetSize(target, src.viewport.size);
}