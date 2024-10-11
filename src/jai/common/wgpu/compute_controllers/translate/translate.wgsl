
@group(0) @binding(0) var<storage, read_write> offset: vec3<f32>;
@group(1) @binding(0) var<storage, read_write> position_in: array<f32>;
@group(1) @binding(1) var<storage, read_write> position_out: array<f32>;

const stride: u32 = 3;

@compute
@workgroup_size(__WORK_GROUP_SIZE_X__, __WORK_GROUP_SIZE_Y__, __WORK_GROUP_SIZE_Z__)
fn translate(@builtin(global_invocation_id) global_id: vec3<u32>) {
	let index = global_id.x;
	if (index < arrayLength(&position_in)) {

		vec3_add(stride * index);
	}
}

fn vec3_add(index: u32) {
	position_out[index + 0] = position_in[index + 0] + offset.x;
	position_out[index + 1] = position_in[index + 1] + offset.y;
	position_out[index + 2] = position_in[index + 2] + offset.z;
}