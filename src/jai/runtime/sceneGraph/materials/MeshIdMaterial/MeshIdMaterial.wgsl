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
	id: vec4<u32>,
};
@group(3) @binding(0) var<uniform> material: MaterialUniforms;


@vertex
fn vertex(model: VertexInput) -> VertexOutput {
	var out: VertexOutput;
	var mvPosition = vec4<f32>(model.position, 1.0);

	var modelViewMatrix = camera.transformMatrixInverse * object.transformMatrix;
	var finalMatrix = camera.projectionMatrix * modelViewMatrix;
	out.clip_position = finalMatrix * mvPosition;

	out.worldPos = (object.transformMatrix * mvPosition).xyz;
	out.normal = (object.transformMatrix * vec4<f32>(model.normal, 0.0)).xyz;
	out.uv = model.uv;
	return out;
}

@fragment
fn fragment(in: VertexOutput) -> @location(0) vec4<f32> {
	let r = f32((material.id.x >> 16u) & 255u) / 255.0;
	let g = f32((material.id.x >> 8u) & 255u) / 255.0;
	let b = f32(material.id.x & 255u) / 255.0;
	return vec4<f32>(r, g, b, 1.0);
}
