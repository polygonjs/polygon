struct SceneUniforms {
	time: vec4<f32>,
};
struct ObjectUniforms {
	transformMatrix: mat4x4f,
};
struct CameraUniforms {
	worldPos: vec4<f32>,
	transformMatrixInverse: mat4x4f,
	projectionMatrix: mat4x4f,
};


@group(0) @binding(0) var<uniform> scene: SceneUniforms;
@group(1) @binding(0) var<uniform> camera: CameraUniforms;
@group(2) @binding(0) var<uniform> object: ObjectUniforms;
