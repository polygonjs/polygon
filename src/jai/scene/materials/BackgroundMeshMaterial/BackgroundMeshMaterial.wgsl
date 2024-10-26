// include uniforms


struct VertexInput {
	@location(0) position: vec3<f32>,
	@location(1) normal: vec3<f32>,
	@location(2) uv: vec2<f32>,
};

struct VertexOutput {
	@builtin(position) clip_position: vec4<f32>,
	@location(0) normal: vec3<f32>,
	@location(1) worldPos: vec3<f32>,
	@location(2) uv: vec2<f32>,
};

struct MaterialUniforms {
	color: vec4<f32>,
};
@group(3) @binding(0) var<uniform> material: MaterialUniforms;


@vertex
fn vertex(model: VertexInput) -> VertexOutput {
	var out: VertexOutput;
	out.clip_position = vec4<f32>(model.position.xy, 0.99, 1.0);
	out.uv = model.uv;
	return out;
}

@fragment
fn fragment(in: VertexOutput) -> @location(0) vec4<f32> {
	return material.color;
}
