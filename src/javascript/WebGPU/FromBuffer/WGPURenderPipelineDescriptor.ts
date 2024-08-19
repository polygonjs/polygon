import { WGPU_OFFSET, WGPU_SIZE } from "../utils/WebGPUOffset";
import { heapGetItemFromOffset, labelFromBuffer } from "../utils/WebGPUUtils";
import { WGPUDepthStencilStateFromBuffer } from "./WGPUDepthStencilState";
import { WGPUFragmentStateFromBuffer } from "./WGPUFragmentState";
import { WGPUMultisampleStateFromBuffer } from "./WGPUMultisampleState";
import { WGPUPrimitiveStateFromBuffer } from "./WGPUPrimitiveState";
import { WGPUVertexStateFromBuffer } from "./WGPUVertexState";

export function WGPURenderPipelineDescriptorFromBuffer(
	pointer: bigint
): GPURenderPipelineDescriptor {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u32 = new Uint32Array(buffer);
	const u64 = new BigUint64Array(buffer);
	//
	const offset = WGPU_OFFSET.WGPURenderPipelineDescriptor;
	//
	const label = labelFromBuffer(pointer, offset, u64);
	//
	const layout = heapGetItemFromOffset<GPUPipelineLayout>(
		u64,
		pointer,
		offset.layout
	);

	if (!layout) {
		throw new Error("layout is null");
	}
	//
	const vertex = WGPUVertexStateFromBuffer(pointer + offset.vertex);
	if (!vertex) {
		throw new Error("vertex is null");
	}
	const primitive = WGPUPrimitiveStateFromBuffer(
		pointer + offset.primitive,
		u32
	);
	if (!primitive) {
		throw new Error("primitive is null");
	}
	const depthStencilPointerIndex =
		(pointer + offset.depthStencil) / WGPU_SIZE.u64;
	const depthStencilPointer = u64[Number(depthStencilPointerIndex)];
	const depthStencil = WGPUDepthStencilStateFromBuffer(
		depthStencilPointer,
		u32
	);
	if (!depthStencil) {
		throw new Error("depthStencil is null");
	}
	const multisample = WGPUMultisampleStateFromBuffer(
		pointer + offset.multisample,
		u32
	);
	if (!multisample) {
		throw new Error("multisample is null");
	}
	const fragmentPointerIndex = (pointer + offset.fragment) / WGPU_SIZE.u64;
	const fragmentPointer = u64[Number(fragmentPointerIndex)];
	const fragment = WGPUFragmentStateFromBuffer(fragmentPointer);
	if (!fragment) {
		throw new Error("fragment is null");
	}

	//
	const pipelineDescriptor: GPURenderPipelineDescriptor = {
		label,
		layout,
		vertex,
		primitive,
		depthStencil: depthStencil.format != null ? depthStencil : undefined,
		multisample,
		fragment,
	};

	return pipelineDescriptor;
}

