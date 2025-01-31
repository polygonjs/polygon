// include uniforms


struct VertexInput {
	@location(0) position: vec3<f32>,
	@location(1) normal: vec3<f32>,
	// @location(2) color: vec3<f32>,
	@location(2) uv: vec2<f32>,
};

struct VertexOutput {
	@builtin(position) clip_position: vec4<f32>,
	@location(0) normal: vec3<f32>,
	@location(1) worldPos: vec3<f32>,
	@location(2) uv: vec2<f32>,
	// @location(3) color: vec4<f32>,
};

struct MaterialUniforms {
	color: vec4<f32>,
};
@group(3) @binding(0) var<uniform> material: MaterialUniforms;
@group(3) @binding(1) var mapSampler: sampler;
@group(3) @binding(2) var map: texture_2d<f32>;


@vertex
fn vertex(model: VertexInput) -> VertexOutput {
	var out: VertexOutput;
	var mvPosition = vec4<f32>(model.position, 1.0);
	// out.clip_position = vec4<f32>(model.position, 1.0) * (object.transformMatrix);
	// out.clip_position = out.clip_position * camera.transformMatrixInverse;
	// out.clip_position = camera.projectionMatrix * out.clip_position;

	// out.clip_position = out.clip_position * (camera.projectionMatrix * camera.transformMatrixInverse);

	// out.clip_position = camera.projectionMatrix * ((vec4<f32>(model.position, 1.0) * (object.transformMatrix)) * cameraUniforms.transformMatrixInverse);

	var modelViewMatrix = camera.transformMatrixInverse * object.transformMatrix;
	var finalMatrix = camera.projectionMatrix * modelViewMatrix;
	out.clip_position = finalMatrix * mvPosition;

	out.worldPos = (object.transformMatrix * mvPosition).xyz;
	out.normal = (object.transformMatrix * vec4<f32>(model.normal, 0.0)).xyz;
	// out.color = model.color;
	out.uv = model.uv;
	// out.color = material.color;
	return out;
}

@fragment
fn fragment(in: VertexOutput) -> @location(0) vec4<f32> {
	// return vec4<f32>(0.2, in.uv.x, 0.0, 0.0) + textureSample(map, mapSampler, in.uv);
	// return vec4<f32>(1.0, 0.0, 0.0, 1.2);
	return textureSample(map, mapSampler, in.uv);
}
