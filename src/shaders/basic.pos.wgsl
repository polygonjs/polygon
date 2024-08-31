struct VertexInput {
	@location(0) position: vec3<f32>,
	@location(1) color: vec3<f32>,
	@location(2) uv: vec2<f32>,
};

struct VertexOutput {
	@builtin(position) clip_position: vec4<f32>,
	@location(0) worldPos: vec3<f32>,
	@location(1) color: vec3<f32>,
	@location(2) uv: vec2<f32>,
};

struct ObjectUniforms {
	transformMatrix: mat4x4f,
};
struct CameraUniforms {
	time: vec4<f32>,
	worldPos: vec4<f32>,
	transformMatrixInverse: mat4x4f,
	projectionMatrix: mat4x4f,
};
struct SDFUniforms {
	offset: vec4<f32>,
};

@group(0) @binding(0) var<uniform> object: ObjectUniforms;
@group(1) @binding(0) var<uniform> camera: CameraUniforms;
@group(2) @binding(0) var<uniform> sdf: SDFUniforms;

@vertex
fn vertex(model: VertexInput) -> VertexOutput {
	var out: VertexOutput;
	var mvPosition = vec4<f32>(model.position+sdf.offset.xyz, 1.0);
	// out.clip_position = vec4<f32>(model.position, 1.0) * (object.transformMatrix);
	// out.clip_position = out.clip_position * camera.transformMatrixInverse;
	// out.clip_position = camera.projectionMatrix * out.clip_position;

	// out.clip_position = out.clip_position * (camera.projectionMatrix * camera.transformMatrixInverse);

	// out.clip_position = camera.projectionMatrix * ((vec4<f32>(model.position, 1.0) * (object.transformMatrix)) * cameraUniforms.transformMatrixInverse);

	var modelViewMatrix = camera.transformMatrixInverse * object.transformMatrix;
	var finalMatrix = camera.projectionMatrix * modelViewMatrix;
	out.clip_position = finalMatrix * mvPosition;

	out.worldPos = (object.transformMatrix * mvPosition).xyz;
	out.color = model.color;
	out.uv = model.uv;
	return out;
}

@fragment
fn fragment(in: VertexOutput) -> @location(0) vec4<f32> {
	// return vec4<f32>(in.uv.x, in.uv.y, 1.0, 1.0);
	// return vec4<f32>(in.color, 1.0);
	return vec4<f32>(abs(in.worldPos), 1.0);
	// return vec4<f32>(abs(in.worldPos - camera.worldPos.xyz), 1.0);
}
