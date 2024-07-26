@group(0) @binding(0) var<storage, read> src: array<f32>;
@group(1) @binding(0) var<storage, write> dest: array<f32>;

@compute @workgroup_size(1) fn computeSomething(
	@builtin(global_invocation_id) id: vec3u
) {
	let i = id.x;
	dest[i] = src[i] + 2.*src[i-1];
}