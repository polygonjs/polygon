EmptyUniforms :: struct {};
Material :: struct($UniformType: Type) {
	name: string;
	shader: string;
	uniforms: UniformType;
}

// EMPTY_UNIFORMS:EmptyUniforms = .{};
MATERIAL_BASIC :Material(EmptyUniforms) = .{
	name = "basic",
	shader = SHADER_RENDER_BASIC,
	// uniforms = EMPTY_UNIFORMS,
};
// SDF_UNIFORMS:SDFUniforms;
MATERIAL_RAYMARCHING :Material(SDFUniforms) = .{
	name = "raymarching",
	shader = SHADER_RENDER_RAYMARCHING,
	// uniforms = SDF_UNIFORMS,
};