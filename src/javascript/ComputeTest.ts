import { VertexArrayToBufferResult } from "./SceneData";

interface ComputeTestOptions {
	device: GPUDevice;
}

export async function computeTest(options: ComputeTestOptions) {
	const { device } = options;

	const inputSize = new Float32Array([1, 1, 1]);
	const verticesSize = new Float32Array(64).byteLength;
	const indicesSize = new Float32Array(64).byteLength;
	const workGroupsCountX = 2;
	const workGroupsCountY = 2;
	const workGroupsCountZ = 2;
	const workGroupsCount =
		workGroupsCountX * workGroupsCountY * workGroupsCountZ;
	console.log(workGroupsCount ** 2);

	const module = device.createShaderModule({
		label: "doubling compute module",
		// code: `
		//   @group(0) @binding(0) var<storage, read_write> data: array<f32>;

		//   @compute @workgroup_size(1) fn computeSomething(
		// 	@builtin(global_invocation_id) id: vec3u
		//   ) {
		// 	let i = id.x;
		// 	data[i] = data[i] + data[i-1];
		//   }
		// `,
		code: `
		  @group(0) @binding(0) var<storage, read> size: array<f32>;
		  @group(1) @binding(0) var<storage, read_write> vertexBuffer: array<f32>;
		  @group(2) @binding(0) var<storage, read_write> indices: array<f32>;
	 
		  @compute @workgroup_size(${workGroupsCountX},${workGroupsCountY},${workGroupsCountZ}) fn computeSomething(
			@builtin(workgroup_id) workgroup_id : vec3<u32>,
			@builtin(local_invocation_id) local_invocation_id : vec3<u32>,
			@builtin(global_invocation_id) global_invocation_id : vec3<u32>,
			@builtin(local_invocation_index) local_invocation_index: u32,
			@builtin(num_workgroups) num_workgroups: vec3<u32>
		  ) {
			const stride:i32 = 3+3+2;
			// let invocation_id:u32 = id.x*id.y*id.z;
			// vertexBuffer[0] = f32(num_workgroups.x*num_workgroups.y*num_workgroups.z);

			// let workgroup_index =  
			// 	workgroup_id.x +
			// 	workgroup_id.y * num_workgroups.x +
			// 	workgroup_id.z * num_workgroups.x * num_workgroups.y;

			// let global_invocation_index =
			// 	workgroup_index * ${workGroupsCount} +
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
		`,
	});

	const pipeline = device.createComputePipeline({
		label: "doubling compute pipeline",
		layout: "auto",
		compute: {
			module,
		},
	});

	// create a buffer on the GPU to hold our computation
	// input and output
	const inputSizeBuffer = device.createBuffer({
		label: "inputSizeBuffer",
		size: inputSize.byteLength,
		usage: GPUBufferUsage.STORAGE | GPUBufferUsage.COPY_DST,
	});
	// Copy our input data to that buffer
	device.queue.writeBuffer(inputSizeBuffer, 0, inputSize);

	// create a buffer on the GPU to get a copy of the results
	const verticesBufferMap = device.createBuffer({
		label: "verticesBufferMap1",
		size: verticesSize,
		usage: GPUBufferUsage.MAP_READ | GPUBufferUsage.COPY_DST,
	});
	const verticesBuffer = device.createBuffer({
		label: "verticesBuffer",
		size: verticesSize,
		usage:
			GPUBufferUsage.STORAGE |
			GPUBufferUsage.COPY_SRC |
			GPUBufferUsage.VERTEX,
	});
	const indicesBufferMap = device.createBuffer({
		label: "indicesBufferMap",
		size: indicesSize,
		usage: GPUBufferUsage.MAP_READ | GPUBufferUsage.COPY_DST,
	});
	const indicesBuffer = device.createBuffer({
		label: "indicesBuffer2",
		size: indicesSize,
		usage: GPUBufferUsage.STORAGE | GPUBufferUsage.COPY_SRC,
	});

	// Setup a bindGroup to tell the shader which
	// buffer to use for the computation
	const bindGroupInputSize = device.createBindGroup({
		label: "bindGroupInputSize",
		layout: pipeline.getBindGroupLayout(0),
		entries: [
			{
				binding: 0,
				resource: { buffer: inputSizeBuffer },
			},
		],
	});
	const bindGroupVertices = device.createBindGroup({
		label: "bindGroupVertices",
		layout: pipeline.getBindGroupLayout(1),
		entries: [
			{
				binding: 0,
				resource: { buffer: verticesBuffer },
			},
		],
	});
	const bindGroupIndices = device.createBindGroup({
		label: "bindGroupIndices",
		layout: pipeline.getBindGroupLayout(2),
		entries: [
			{
				binding: 0,
				resource: { buffer: indicesBuffer },
			},
		],
	});

	// Encode commands to do the computation
	const encoder = device.createCommandEncoder({
		label: "doubling encoder",
	});
	const pass = encoder.beginComputePass({
		label: "doubling compute pass",
	});
	pass.setPipeline(pipeline);
	pass.setBindGroup(0, bindGroupInputSize);
	pass.setBindGroup(1, bindGroupVertices);
	pass.setBindGroup(2, bindGroupIndices);
	pass.dispatchWorkgroups(
		workGroupsCountX,
		workGroupsCountY,
		workGroupsCountZ
	);
	pass.end();

	// Encode a command to copy the results to a mappable buffer.
	encoder.copyBufferToBuffer(
		verticesBuffer,
		0,
		verticesBufferMap,
		0,
		verticesBufferMap.size
	);
	encoder.copyBufferToBuffer(
		indicesBuffer,
		0,
		indicesBufferMap,
		0,
		indicesBufferMap.size
	);

	// Finish encoding and submit the commands
	const commandBuffer = encoder.finish();
	device.queue.submit([commandBuffer]);

	// Read the results
	// console.log("input", inputSize);
	// {
	await verticesBufferMap.mapAsync(GPUMapMode.READ);
	const verticesBufferRead = new Float32Array(
		verticesBufferMap.getMappedRange()
	);

	console.log("verticesBufferRead", verticesBufferRead);

	// resultBufferMap1.unmap();
	// }
	// {
	await indicesBufferMap.mapAsync(GPUMapMode.READ);
	const indicesBufferRead = new Float32Array(
		indicesBufferMap.getMappedRange()
	);

	// console.log("indicesBufferRead", indicesBufferRead);

	indicesBufferMap.unmap();
	// }
	const verticesBufferResult: VertexArrayToBufferResult = {
		buffer: verticesBuffer,
		size: verticesSize,
		data: verticesBufferRead,
	};

	return { verticesBufferResult, verticesBufferRead };
}
