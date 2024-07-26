// if this is set to <read>, I get the following error:
// Storage class Storage { access: StorageAccess(LOAD | STORE) } doesn't match the shader Storage { access: StorageAccess(LOAD) }
// and StorageAccess is not found in the bindings. TODO: check if it is in the source library https://github.com/gfx-rs/wgpu-native/

@group(0) @binding(0) var<storage, read_write> size: array<f32>;
@group(1) @binding(0) var<storage, read_write> vertexBuffer: array<f32>;
// @group(2) @binding(0) var<storage, read_write> indices: array<f32>;

@compute @workgroup_size( __WORK_GROUP_SIZE_X__ , __WORK_GROUP_SIZE_Y__ , __WORK_GROUP_SIZE_Z__ ) fn boxCompute(
	// @builtin(workgroup_id) workgroup_id : vec3<u32>,
	// @builtin(local_invocation_id) local_invocation_id : vec3<u32>,
	// @builtin(global_invocation_id) global_invocation_id : vec3<u32>,
	// @builtin(local_invocation_index) local_invocation_index: u32,
	// @builtin(num_workgroups) num_workgroups: vec3<u32>
) {
	let stride:i32 = 3+3+2;
	// let invocation_id:u32 = id.x*id.y*id.z;
	// vertexBuffer[0] = f32(num_workgroups.x*num_workgroups.y*num_workgroups.z);

	// let workgroup_index =  
	// 	workgroup_id.x +
	// 	workgroup_id.y * num_workgroups.x +
	// 	workgroup_id.z * num_workgroups.x * num_workgroups.y;

	// let global_invocation_index =
	// 	workgroup_index * __WORK_GROUP_COUNT__ +
	// 	local_invocation_index;

	// vertexBuffer[global_invocation_index] = f32(local_invocation_index);
	// vertexBuffer[global_invocation_index] = 2.+f32(global_invocation_index);

	// vertexBuffer[1+local_invocation_index] = f32(local_invocation_index);
	// vertexBuffer[num_workgroups.x+0] = f32(num_workgroups.x);
	// vertexBuffer[num_workgroups.x+1] = f32(num_workgroups.y);
	// vertexBuffer[num_workgroups.x+2] = f32(num_workgroups.z);
	let a = size[0];
	// vertex
	// vertexBuffer[vertex_id + 0] = 2.;
	// vertexBuffer[vertex_id + 0] = size[0] * (f32(id.x % 2)-0.5);
	// vertexBuffer[vertex_id + 1] = size[1] * (f32(id.y % 2)-0.5);
	// vertexBuffer[vertex_id + 2] = size[2] * (f32(id.z % 2)-0.5);
	// color
	// vertexBuffer[vertex_id + 3] = 1.;//f32(id.x % 2);
	// vertexBuffer[vertex_id + 4] = 1.;//f32(id.y % 2);
	// vertexBuffer[vertex_id + 5] = 1.;//f32(id.z % 2);
	// uv
	// vertexBuffer[vertex_id + 6] = 1.;//f32(id.x % 2);
	// vertexBuffer[vertex_id + 7] = 1.;//f32(id.y % 2);

	//let i = id.x;
	//dest1[i*2] = src[i]*2.;
	//dest1[i*2+1] = src[i]*4.;
	// dest2[i*4] = src[i]*16.;

	var vertex_id:i32 = 0;
	for (var i = 0; i < 8; i += 1) {
		for (var j = 0; j < 8; j += 1) {
			vertexBuffer[8*i + j] = 0.8;//f32(vertex_id + j);
		}
	}
	workgroupBarrier();

	// position=.{-0.5, -0.5, 0.5}, color=.{1.0, 0.0, 0.0}, uv=.{0.0, 0.0}}
	vertex_id = 0;
	vertexBuffer[vertex_id + 0] = -0.5;
	vertexBuffer[vertex_id + 1] = -0.5;
	vertexBuffer[vertex_id + 2] = 0.5;
	// // array_add(*vertices, Vertex.{ position=.{0.5, -0.5, 0.5}, color=.{0.0, 1.0, 0.0}, uv=.{1.0, 0.0}});
	vertex_id += stride;
	vertexBuffer[vertex_id + 0] = 0.5;
	vertexBuffer[vertex_id + 1] = -0.5;
	vertexBuffer[vertex_id + 2] = 0.5;
	// array_add(*vertices, Vertex.{ position=.{0.5, 0.5, 0.5}, color=.{0.0, 0.0, 1.0}, uv=.{1.0, 1.0}});
	vertex_id += stride;
	vertexBuffer[vertex_id + 0] = 0.5;
	vertexBuffer[vertex_id + 1] = 0.5;
	vertexBuffer[vertex_id + 2] = 0.5;
	// array_add(*vertices, Vertex.{ position=.{-0.5, 0.5, 0.5}, color=.{1.0, 1.0, 0.0}, uv=.{0.0, 1.0}});
	vertex_id += stride;
	vertexBuffer[vertex_id + 0] = -0.5;
	vertexBuffer[vertex_id + 1] = 0.5;
	vertexBuffer[vertex_id + 2] = 0.5;

	// array_add(*vertices, Vertex.{ position=.{-0.5, -0.5, -0.5}, color=.{1.0, 0.0, 1.0}, uv=.{0.0, 0.0}});
	vertex_id += stride;
	vertexBuffer[vertex_id + 0] = -0.5;
	vertexBuffer[vertex_id + 1] = -0.5;
	vertexBuffer[vertex_id + 2] = -0.5;
	// array_add(*vertices, Vertex.{ position=.{0.5, -0.5, -0.5}, color=.{0.0, 1.0, 1.0}, uv=.{1.0, 0.0}});
	vertex_id += stride;
	vertexBuffer[vertex_id + 0] = 0.5;
	vertexBuffer[vertex_id + 1] = -0.5;
	vertexBuffer[vertex_id + 2] = -0.5;
	// array_add(*vertices, Vertex.{ position=.{0.5, 0.5, -0.5}, color=.{1.0, 1.0, 1.0}, uv=.{1.0, 1.0}});
	vertex_id += stride;
	vertexBuffer[vertex_id + 0] = 0.5;
	vertexBuffer[vertex_id + 1] = 0.5;
	vertexBuffer[vertex_id + 2] = -0.5;
	// array_add(*vertices, Vertex.{ position=.{-0.5, 0.5, -0.5}, color=.{0.5, 0.5, 0.5}, uv=.{0.0, 1.0}});
	vertex_id += stride;
	vertexBuffer[vertex_id + 0] = -0.5;
	vertexBuffer[vertex_id + 1] = 0.5;
	vertexBuffer[vertex_id + 2] = -0.5;

	workgroupBarrier();

	for (var k = 0; k < 8; k += 1) {
		vertexBuffer[k*stride + 0] *= size[0];
		vertexBuffer[k*stride + 1] *= size[1];
		vertexBuffer[k*stride + 2] *= size[2];
	}

}