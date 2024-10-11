@group(1) @binding(0) var<storage, read_write> position_in: array<f32>;
@group(1) @binding(1) var<storage, read_write> index_in: array<u32>;
@group(1) @binding(2) var<storage, read_write> normalInt_out: array<atomic<i32>>;

const stride: u32 = 3;

const SCALE_FACTOR: f32 = 1000.0;
fn floatToFixedPoint(value: f32) -> i32 { return i32(value * SCALE_FACTOR); }
fn fixedPointToFloat(value: i32) -> f32 { return f32(value) / SCALE_FACTOR; }

@compute
@workgroup_size(__WORK_GROUP_SIZE_X__, __WORK_GROUP_SIZE_Y__, __WORK_GROUP_SIZE_Z__)
fn computeNormals(@builtin(global_invocation_id) global_id: vec3<u32>) {
	let index = global_id.x;
	if (index < (arrayLength(&index_in)/stride)) {
		increment_normal(index*stride);
	}
	// storageBarrier();
	// workgroupBarrier();
}

fn increment_normal(index: u32) {
	let vertex_0 :u32= index_in[ index ];
	let vertex_1 :u32= index_in[ index + 1 ];
	let vertex_2 :u32= index_in[ index + 2 ];

	let position_0 = get_position(vertex_0);
	let position_1 = get_position(vertex_1);
	let position_2 = get_position(vertex_2);

	let cb = position_2 - position_1;
	let ab = position_0 - position_1;
	let cc = normalize(cross(normalize(cb), normalize(ab)));

	add_normal(vertex_0, cc);
	add_normal(vertex_1, cc);
	add_normal(vertex_2, cc);
}

fn get_position(index: u32) -> vec3<f32> {
	let base_index = index*stride;
	return vec3<f32>(
		position_in[base_index],
		position_in[base_index + 1],
		position_in[base_index + 2]
	);
}
fn add_normal(index: u32, increment: vec3<f32>) {
	let base_index = index*stride;
	// normal_out[base_index] += increment.x;
	// normal_out[base_index+1] += increment.y;
	// normal_out[base_index+2] += increment.z;
	atomicAdd(&normalInt_out[base_index], floatToFixedPoint(increment.x));
	atomicAdd(&normalInt_out[base_index+1], floatToFixedPoint(increment.y));
	atomicAdd(&normalInt_out[base_index+2], floatToFixedPoint(increment.z));
}
