import { OrbitControls, orbitControlsCreate } from "./OrbitControls";

export const VERTEX_FLOATS_COUNT = 3 + 3 + 2;
export const FLOAT_SIZE = 4;
export interface SceneData {
	vertexBuffer: Float32Array;
	indexBuffer: Uint32Array;
	vertexLayout: GPUVertexBufferLayout;
	objectUniformBuffer: Float32Array;
	//
	cameraUniformBuffer: Float32Array;
	//
	orbitControlsBuffer: Float32Array;
	orbitControls: OrbitControls;
}
export const SCENE_DATA: SceneData = {
	vertexBuffer: new Float32Array(0),
	indexBuffer: new Uint32Array(0),
	vertexLayout: {
		arrayStride: 0,
		attributes: [],
	},
	objectUniformBuffer: new Float32Array(0),
	//
	cameraUniformBuffer: new Float32Array(0),
	//
	orbitControlsBuffer: new Float32Array(0),
	orbitControls: orbitControlsCreate(),
};

function createFormatByValue() {
	const formats: GPUVertexFormat[] = [];

	// take the enum from wgpu files
	formats[1] = "uint8x2";
	formats[2] = "uint8x4";
	formats[3] = "sint8x2";
	formats[4] = "sint8x4";
	formats[5] = "unorm8x2";
	formats[6] = "unorm8x4";
	formats[7] = "snorm8x2";
	formats[8] = "snorm8x4";
	formats[9] = "uint16x2";
	formats[10] = "uint16x4";
	formats[11] = "sint16x2";
	formats[12] = "sint16x4";
	formats[13] = "unorm16x2";
	formats[14] = "unorm16x4";
	formats[15] = "snorm16x2";
	formats[16] = "snorm16x4";
	formats[17] = "float16x2";
	formats[18] = "float16x4";
	formats[19] = "float32";
	formats[20] = "float32x2";
	formats[21] = "float32x3";
	formats[22] = "float32x4";
	formats[23] = "uint32";
	formats[24] = "uint32x2";
	formats[25] = "uint32x3";
	formats[26] = "uint32x4";
	formats[27] = "sint32";
	formats[28] = "sint32x2";
	formats[29] = "sint32x3";
	formats[30] = "sint32x4";

	return formats;
}
const FORMAT_BY_VALUE: GPUVertexFormat[] = createFormatByValue();
export function bufferToGPUVertexBufferLayout(
	buffer: Uint8Array
): GPUVertexBufferLayout {
	const layout: GPUVertexBufferLayout = {
		arrayStride: buffer[0],
		stepMode: buffer[1] == 0 ? "vertex" : "instance",
		attributes: [],
	};
	const attributesCount = buffer[2];
	const attributesStart = 3;
	const stride = 3;
	const attributes: GPUVertexAttribute[] = [];
	for (let i = 0; i < attributesCount; i++) {
		const shaderLocation = buffer[attributesStart + i * stride];
		const offset = buffer[attributesStart + i * stride + 1];
		const format = buffer[attributesStart + i * stride + 2];
		attributes.push({
			shaderLocation,
			offset,
			format: FORMAT_BY_VALUE[format],
		});
	}
	layout.attributes = attributes;
	return layout;
}

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
