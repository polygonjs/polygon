// export interface Vector3 {
// 	x: number;
// 	y: number;
// 	z: number;
// }
// const VECTOR3_SIZE = 4 * 3;
// export interface Vertex {
// 	position: Vector3;
// 	color: Vector3;
// }
// const VERTEX_SIZE = VECTOR3_SIZE * 2;
export const VERTEX_FLOATS_COUNT = 3 + 3 + 2;
export const FLOAT_SIZE = 4;
interface SceneData {
	vertexBuffer: Float32Array;
	indexBuffer: Uint32Array;
}
export const SCENE_DATA: SceneData = {
	vertexBuffer: new Float32Array(0),
	indexBuffer: new Uint32Array(0),
};

export const VERTEX_BUFFER_LAYOUT: GPUVertexBufferLayout = {
	arrayStride: VERTEX_FLOATS_COUNT * FLOAT_SIZE,
	attributes: [
		// position
		{ shaderLocation: 0, offset: 0, format: "float32x3" },
		// color
		{
			shaderLocation: 1,
			offset: 3 * FLOAT_SIZE,
			format: "float32x3",
		},
		// uv
		{
			shaderLocation: 2,
			offset: (3 + 3) * FLOAT_SIZE,
			format: "float32x2",
		},
	],
};

// export const VERTICES: Vertex[] = [
// 	{
// 		position: { x: 0.0, y: 0.5, z: 0.0 },
// 		color: { x: 1.0, y: 0.0, z: 0.0 },
// 	},
// 	{
// 		position: { x: -0.5, y: -0.5, z: 0.0 },
// 		color: { x: 0.0, y: 1.0, z: 0.0 },
// 	},
// 	{
// 		position: { x: 0.5, y: -0.5, z: 0.0 },
// 		color: { x: 0.0, y: 0.0, z: 1.0 },
// 	},
// ];

export interface VertexArrayToBufferResult {
	buffer: GPUBuffer;
	size: number;
	data: Float32Array;
}
export interface IndexArrayToBufferResult {
	buffer: GPUBuffer;
	size: number;
	data: Uint32Array;
}
export function vertexArrayToBuffer(
	device: GPUDevice,
	data: Float32Array
): VertexArrayToBufferResult | undefined {
	const buffer = device.createBuffer({
		size: data.byteLength,
		usage: GPUBufferUsage.VERTEX | GPUBufferUsage.COPY_DST,
	});
	if (buffer == null) {
		console.error("buffer is null");
		return;
	}
	device.queue.writeBuffer(buffer, 0, data);

	const result: VertexArrayToBufferResult = {
		buffer,
		size: data.byteLength,
		data,
	};
	return result;
}
export function indexArrayToBuffer(
	device: GPUDevice,
	data: Uint32Array
): IndexArrayToBufferResult | undefined {
	const buffer = device.createBuffer({
		size: data.byteLength,
		usage: GPUBufferUsage.INDEX | GPUBufferUsage.COPY_DST,
	});
	if (buffer == null) {
		console.error("buffer is null");
		return;
	}

	device.queue.writeBuffer(buffer, 0, data);

	const result: IndexArrayToBufferResult = {
		buffer,
		size: data.byteLength,
		data,
	};
	return result;
}

export function updateVertexArrayToBuffer(
	device: GPUDevice,
	data: VertexArrayToBufferResult
) {
	device.queue.writeBuffer(data.buffer, 0, data.data);
}
