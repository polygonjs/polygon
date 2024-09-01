@group(0) @binding(0) var<storage, read_write> offset: array<f32>;
@group(1) @binding(0) var<storage, read_write> vertex_buffer: array<f32>;

@compute @workgroup_size(__WORK_GROUP_SIZE_X__, __WORK_GROUP_SIZE_Y__, __WORK_GROUP_SIZE_Z__)
fn boxOffsetCompute() {
    let stride: i32 = 3+3+3+2;
    let points_count: i32 = 8;

    for (var i = 0; i < points_count; i += 1) {
        vertex_buffer[stride*i + 0] += offset[0];
        vertex_buffer[stride*i + 1] += offset[1];
        vertex_buffer[stride*i + 2] += offset[2];
    }
}