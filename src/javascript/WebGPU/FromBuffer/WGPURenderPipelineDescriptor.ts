import { heapGet } from "../../WasmHeap";
import { _big, _label, _pointerValue } from "../../wasm/WasmUtils";
import { WGPURenderPipelineDescriptor } from "../utils/WGPUStructInfos";
import { WGPUDepthStencilStateFromBuffer } from "./WGPUDepthStencilState";
import { WGPUFragmentStateFromBuffer } from "./WGPUFragmentState";
import { WGPUMultisampleStateFromBuffer } from "./WGPUMultisampleState";
import { WGPUPrimitiveStateFromBuffer } from "./WGPUPrimitiveState";
import { WGPUVertexStateFromBuffer } from "./WGPUVertexState";

export function WGPURenderPipelineDescriptorFromBuffer(
	p: bigint
): GPURenderPipelineDescriptor {
	const m = WGPURenderPipelineDescriptor.members;
	//
	const label = _label(p, m);
	//
	const layout = heapGet<GPUPipelineLayout>(
		_pointerValue(p + m.layout.offset)
	);

	if (!layout) {
		throw new Error("layout is null");
	}
	//
	const vertex = WGPUVertexStateFromBuffer(p + m.vertex.offset);
	if (!vertex) {
		throw new Error("vertex is null");
	}
	const primitive = WGPUPrimitiveStateFromBuffer(p + m.primitive.offset);
	if (!primitive) {
		throw new Error("primitive is null");
	}
	// const depthStencilPointerIndex =
	// (pointer + offset.depthStencil) / WGPU_SIZE.u64;
	const depthStencilPointer = _big(p, m.depthStencil); //u64[Number(depthStencilPointerIndex)];
	const depthStencil = WGPUDepthStencilStateFromBuffer(depthStencilPointer);
	if (!depthStencil) {
		throw new Error("depthStencil is null");
	}
	const multisample = WGPUMultisampleStateFromBuffer(
		p + m.multisample.offset
	);
	if (!multisample) {
		throw new Error("multisample is null");
	}
	// const fragmentPointerIndex = (pointer + offset.fragment) / WGPU_SIZE.u64;
	const fragmentPointer = _big(p, m.fragment); //u64[Number(fragmentPointerIndex)];
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

