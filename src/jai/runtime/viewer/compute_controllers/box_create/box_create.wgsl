// if this is set to <read>, I get the following error:
// Storage class Storage { access: StorageAccess(LOAD | STORE) } doesn't match the shader Storage { access: StorageAccess(LOAD) }
// and StorageAccess is not found in the bindings. TODO: check if it is in the source library https://github.com/gfx-rs/wgpu-native/

@group(0) @binding(0) var<storage, read_write> size: array<f32>;
// @group(0) @binding(1) var<storage, read_write> segments: array<f32>;
@group(1) @binding(0) var<storage, read_write> position: array<f32>;
// @group(2) @binding(0) var<storage, read_write> indices: array<f32>;

@compute @workgroup_size( __WORK_GROUP_SIZE_X__ , __WORK_GROUP_SIZE_Y__ , __WORK_GROUP_SIZE_Z__ ) fn boxCreate(
	// @builtin(workgroup_id) workgroup_id : vec3<u32>,
	// @builtin(local_invocation_id) local_invocation_id : vec3<u32>,
	// @builtin(global_invocation_id) global_invocation_id : vec3<u32>,
	// @builtin(local_invocation_index) local_invocation_index: u32,
	// @builtin(num_workgroups) num_workgroups: vec3<u32>
) {
	let stride:i32 = 3;//+3+3+2;
	let points_count:i32 = 8;
	

	var vertex_id:i32 = 0;
	for (var i = 0; i < points_count; i += 1) {
		for (var j = 0; j < stride; j += 1) {
			position[stride*i + j] = 0.8;//f32(vertex_id + j);
		}
	}
	workgroupBarrier();

	// position=.{-0.5, -0.5, 0.5}, color=.{1.0, 0.0, 0.0}, uv=.{0.0, 0.0}}
	vertex_id = 0;
	position[vertex_id + 0] = -0.5;
	position[vertex_id + 1] = -0.5;
	position[vertex_id + 2] = 0.5;
	// // array_add(*vertices, Vertex.{ position=.{0.5, -0.5, 0.5}, color=.{0.0, 1.0, 0.0}, uv=.{1.0, 0.0}});
	vertex_id += stride;
	position[vertex_id + 0] = 0.5;
	position[vertex_id + 1] = -0.5;
	position[vertex_id + 2] = 0.5;
	// array_add(*vertices, Vertex.{ position=.{0.5, 0.5, 0.5}, color=.{0.0, 0.0, 1.0}, uv=.{1.0, 1.0}});
	vertex_id += stride;
	position[vertex_id + 0] = 0.5;
	position[vertex_id + 1] = 0.5;
	position[vertex_id + 2] = 0.5;
	// array_add(*vertices, Vertex.{ position=.{-0.5, 0.5, 0.5}, color=.{1.0, 1.0, 0.0}, uv=.{0.0, 1.0}});
	vertex_id += stride;
	position[vertex_id + 0] = -0.5;
	position[vertex_id + 1] = 0.5;
	position[vertex_id + 2] = 0.5;

	// array_add(*vertices, Vertex.{ position=.{-0.5, -0.5, -0.5}, color=.{1.0, 0.0, 1.0}, uv=.{0.0, 0.0}});
	vertex_id += stride;
	position[vertex_id + 0] = -0.5;
	position[vertex_id + 1] = -0.5;
	position[vertex_id + 2] = -0.5;
	// array_add(*vertices, Vertex.{ position=.{0.5, -0.5, -0.5}, color=.{0.0, 1.0, 1.0}, uv=.{1.0, 0.0}});
	vertex_id += stride;
	position[vertex_id + 0] = 0.5;
	position[vertex_id + 1] = -0.5;
	position[vertex_id + 2] = -0.5;
	// array_add(*vertices, Vertex.{ position=.{0.5, 0.5, -0.5}, color=.{1.0, 1.0, 1.0}, uv=.{1.0, 1.0}});
	vertex_id += stride;
	position[vertex_id + 0] = 0.5;
	position[vertex_id + 1] = 0.5;
	position[vertex_id + 2] = -0.5;
	// array_add(*vertices, Vertex.{ position=.{-0.5, 0.5, -0.5}, color=.{0.5, 0.5, 0.5}, uv=.{0.0, 1.0}});
	vertex_id += stride;
	position[vertex_id + 0] = -0.5;
	position[vertex_id + 1] = 0.5;
	position[vertex_id + 2] = -0.5;

	workgroupBarrier();

	for (var k = 0; k < points_count; k += 1) {
		position[k*stride + 0] *= size[0];
		position[k*stride + 1] *= size[1];
		position[k*stride + 2] *= size[2];
	}

}