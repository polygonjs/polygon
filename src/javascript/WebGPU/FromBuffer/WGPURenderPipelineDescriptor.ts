import { WGPU_OFFSET } from "../utils/WebGPUOffset";
import {
	heapGetItemFromOffset,
	labelFromBuffer,
	u64Create,
} from "../utils/WebGPUUtils";
import { WGPUDepthStencilStateFromBuffer } from "./WGPUDepthStencilState";
import { WGPUFragmentStateFromBuffer } from "./WGPUFragmentState";
import { WGPUMultisampleStateFromBuffer } from "./WGPUMultisampleState";
import { WGPUPrimitiveStateFromBuffer } from "./WGPUPrimitiveState";
import { WGPUVertexStateFromBuffer } from "./WGPUVertexState";

export function WGPURenderPipelineDescriptorFromBuffer(
	pointer: bigint
): GPURenderPipelineDescriptor {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u64 = new BigUint64Array(buffer);
	const _u64 = u64Create(u64, pointer);
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
	const primitive = WGPUPrimitiveStateFromBuffer(pointer + offset.primitive);
	if (!primitive) {
		throw new Error("primitive is null");
	}
	// const depthStencilPointerIndex =
	// (pointer + offset.depthStencil) / WGPU_SIZE.u64;
	const depthStencilPointer = _u64(offset.depthStencil); //u64[Number(depthStencilPointerIndex)];
	const depthStencil = WGPUDepthStencilStateFromBuffer(depthStencilPointer);
	if (!depthStencil) {
		throw new Error("depthStencil is null");
	}
	const multisample = WGPUMultisampleStateFromBuffer(
		pointer + offset.multisample
	);
	if (!multisample) {
		throw new Error("multisample is null");
	}
	// const fragmentPointerIndex = (pointer + offset.fragment) / WGPU_SIZE.u64;
	const fragmentPointer = _u64(offset.fragment); //u64[Number(fragmentPointerIndex)];
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

