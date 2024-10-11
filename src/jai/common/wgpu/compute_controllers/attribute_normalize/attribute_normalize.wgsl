@group(1) @binding(0) var<storage, read_write> attributeInt_in: array<i32>;
@group(1) @binding(1) var<storage, read_write> attribute_out: array<f32>;

const stride: u32 = 3;

// include i32tof32

@compute
@workgroup_size(__WORK_GROUP_SIZE_X__, __WORK_GROUP_SIZE_Y__, __WORK_GROUP_SIZE_Z__)
fn attributeNormalize(@builtin(global_invocation_id) global_id: vec3<u32>) {
	let index = global_id.x;
	if (index < (arrayLength(&attribute_out)/stride)) {
		normalize_at_index(index * stride);
	}
	// storageBarrier();
	// workgroupBarrier();
}

fn normalize_at_index(index: u32) {
	let value = get_attribute(index);
	set_attribute(index, normalize(value));
}
fn get_attribute(index: u32) -> vec3<f32> {
	return vec3<f32>(
		fixedPointToFloat(attributeInt_in[index]),
		fixedPointToFloat(attributeInt_in[index + 1]),
		fixedPointToFloat(attributeInt_in[index + 2])
	);
}
fn set_attribute(index: u32, value: vec3<f32>) {
	attribute_out[index] = value.x;
	attribute_out[index+1] = value.y;
	attribute_out[index+2] = value.z;
	// attribute_out[index] = 1;
	// attribute_out[index+1] = 0;
	// attribute_out[index+2] = 0;
}