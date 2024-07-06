export interface Vector3 {
	x: number;
	y: number;
	z: number;
}
const VECTOR3_SIZE = 4 * 3;
export interface Vertex {
	position: Vector3;
	color: Vector3;
}
const VERTEX_SIZE = VECTOR3_SIZE * 2;
export const VERTICES: Vertex[] = [
	{
		position: { x: 0.0, y: 0.5, z: 0.0 },
		color: { x: 1.0, y: 0.0, z: 0.0 },
	},
	{
		position: { x: -0.5, y: -0.5, z: 0.0 },
		color: { x: 0.0, y: 1.0, z: 0.0 },
	},
	{
		position: { x: 0.5, y: -0.5, z: 0.0 },
		color: { x: 0.0, y: 0.0, z: 1.0 },
	},
];

export interface VertexArrayToBufferResult {
	buffer: GPUBuffer;
	size: number;
	data: Float32Array;
}
export function vertexArrayToBuffer(
	device: GPUDevice,
	vertices: Vertex[]
): VertexArrayToBufferResult | undefined {
	// size := cast(u64) vertices.count * size_of(Vertex);
	const size = VERTEX_SIZE * vertices.length;
	const data = new Float32Array(size / 4);

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
		size,
		data,
	};
	return result;
}

export function updateVertexArrayToBuffer(
	device: GPUDevice,
	vertices: Vertex[],
	data: VertexArrayToBufferResult
) {
	for (let i = 0; i < vertices.length; i++) {
		const vertex = vertices[i];
		const offset = (i * VERTEX_SIZE) / 4;
		data.data[offset + 0] = vertex.position.x;
		data.data[offset + 1] = vertex.position.y;
		data.data[offset + 2] = vertex.position.z;
		data.data[offset + 3] = vertex.color.x;
		data.data[offset + 4] = vertex.color.y;
		data.data[offset + 5] = vertex.color.z;
	}
	device.queue.writeBuffer(data.buffer, 0, data.data);
}
