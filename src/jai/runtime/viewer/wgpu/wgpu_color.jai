WGPUColor32 :: struct {
	r: float;
	g: float;
	b: float;
	a: float;
}

wgpu_color_32_create :: (color:Color)->WGPUColor32 {
	return .{
		r = xx color.r,
		g = xx color.g,
		b = xx color.b,
		a = xx color.a,
	};
}
wgpu_color_create :: (color:Color)->WGPUColor {
	return .{
		r = xx color.r,
		g = xx color.g,
		b = xx color.b,
		a = xx color.a,
	};
}
color_set_from_wgpu_color_32 :: (target:*Color, wgpu_color:*WGPUColor32) {
	target.r = clamp(wgpu_color.r, 0.0, 1.0);
	target.g = clamp(wgpu_color.g, 0.0, 1.0);
	target.b = clamp(wgpu_color.b, 0.0, 1.0);
	target.a = clamp(wgpu_color.a, 0.0, 1.0);
}