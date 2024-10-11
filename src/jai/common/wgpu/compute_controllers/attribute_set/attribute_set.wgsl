@group(1) @binding(0) var<storage, read_write> attribute_out: array<f32>;

@compute
@workgroup_size(__WORK_GROUP_SIZE_X__, __WORK_GROUP_SIZE_Y__, __WORK_GROUP_SIZE_Z__)
fn attributeSet(@builtin(global_invocation_id) global_id: vec3<u32>) {
	let index = global_id.x;
	if (index < arrayLength(&attribute_out)) {
		attribute_out[index] = 0.0;//1.0-f32(index)/400.0;
	}
	// storageBarrier();
	// workgroupBarrier();
}
