// Auto-generated struct information for WebGPU bindings

import {
	GetArrayFunction,
	getU8,
	getU16,
	getU32,
	getU64,
	getS32,
	getFLOAT32,
	getFLOAT64,
} from "../../Common";
import { WASM_DATA_SIZE, ENUM_SIZE } from "../../wasm/WasmDataSize";

export interface MemberInfo {
	size: bigint;
	offset: bigint;
	arrayView: GetArrayFunction;
}

export interface StructInfo<T extends string> {
	size: bigint;
	members: Record<T, MemberInfo>;
}

export const WGPUOrigin3D: StructInfo<"x" | "y" | "z"> = {
	size: 12n,
	members: {
		x: { size: WASM_DATA_SIZE.u32, offset: 0n, arrayView: getU32 },
		y: { size: WASM_DATA_SIZE.u32, offset: 4n, arrayView: getU32 },
		z: { size: WASM_DATA_SIZE.u32, offset: 8n, arrayView: getU32 },
	},
};

export const WGPUExtent3D: StructInfo<
	"width" | "height" | "depthOrArrayLayers"
> = {
	size: 12n,
	members: {
		width: { size: WASM_DATA_SIZE.u32, offset: 0n, arrayView: getU32 },
		height: { size: WASM_DATA_SIZE.u32, offset: 4n, arrayView: getU32 },
		depthOrArrayLayers: {
			size: WASM_DATA_SIZE.u32,
			offset: 8n,
			arrayView: getU32,
		},
	},
};

export const WGPUBindGroupDescriptor: StructInfo<
	"nextInChain" | "label" | "layout" | "entryCount" | "entries"
> = {
	size: 40n,
	members: {
		nextInChain: {
			size: WASM_DATA_SIZE.u64,
			offset: 0n,
			arrayView: getU64,
		},
		label: { size: WASM_DATA_SIZE.u64, offset: 8n, arrayView: getU64 },
		layout: { size: WASM_DATA_SIZE.u64, offset: 16n, arrayView: getU64 },
		entryCount: {
			size: WASM_DATA_SIZE.u64,
			offset: 24n,
			arrayView: getU64,
		},
		entries: { size: WASM_DATA_SIZE.u64, offset: 32n, arrayView: getU64 },
	},
};

export const WGPUBindGroupEntry: StructInfo<
	| "nextInChain"
	| "binding"
	| "buffer"
	| "offset"
	| "size"
	| "sampler"
	| "textureView"
> = {
	size: 56n,
	members: {
		nextInChain: {
			size: WASM_DATA_SIZE.u64,
			offset: 0n,
			arrayView: getU64,
		},
		binding: { size: WASM_DATA_SIZE.u32, offset: 8n, arrayView: getU32 },
		buffer: { size: WASM_DATA_SIZE.u64, offset: 16n, arrayView: getU64 },
		offset: { size: WASM_DATA_SIZE.u64, offset: 24n, arrayView: getU64 },
		size: { size: WASM_DATA_SIZE.u64, offset: 32n, arrayView: getU64 },
		sampler: { size: WASM_DATA_SIZE.u64, offset: 40n, arrayView: getU64 },
		textureView: {
			size: WASM_DATA_SIZE.u64,
			offset: 48n,
			arrayView: getU64,
		},
	},
};

export const WGPUSamplerBindingLayout: StructInfo<"nextInChain" | "type"> = {
	size: 16n,
	members: {
		nextInChain: {
			size: WASM_DATA_SIZE.u64,
			offset: 0n,
			arrayView: getU64,
		},
		type: { size: ENUM_SIZE, offset: 8n, arrayView: getU32 },
	},
};

export const WGPUTextureBindingLayout: StructInfo<
	"nextInChain" | "sampleType" | "viewDimension" | "multisampled"
> = {
	size: 24n,
	members: {
		nextInChain: {
			size: WASM_DATA_SIZE.u64,
			offset: 0n,
			arrayView: getU64,
		},
		sampleType: { size: ENUM_SIZE, offset: 8n, arrayView: getU32 },
		viewDimension: { size: ENUM_SIZE, offset: 12n, arrayView: getU32 },
		multisampled: {
			size: WASM_DATA_SIZE.u32,
			offset: 16n,
			arrayView: getU32,
		},
	},
};

export const WGPUStorageTextureBindingLayout: StructInfo<
	"nextInChain" | "access" | "format" | "viewDimension"
> = {
	size: 24n,
	members: {
		nextInChain: {
			size: WASM_DATA_SIZE.u64,
			offset: 0n,
			arrayView: getU64,
		},
		access: { size: ENUM_SIZE, offset: 8n, arrayView: getU32 },
		format: { size: ENUM_SIZE, offset: 12n, arrayView: getU32 },
		viewDimension: { size: ENUM_SIZE, offset: 16n, arrayView: getU32 },
	},
};

export const WGPUBufferBindingLayout: StructInfo<
	"nextInChain" | "type" | "hasDynamicOffset" | "minBindingSize"
> = {
	size: 24n,
	members: {
		nextInChain: {
			size: WASM_DATA_SIZE.u64,
			offset: 0n,
			arrayView: getU64,
		},
		type: { size: ENUM_SIZE, offset: 8n, arrayView: getU32 },
		hasDynamicOffset: {
			size: WASM_DATA_SIZE.u32,
			offset: 12n,
			arrayView: getU32,
		},
		minBindingSize: {
			size: WASM_DATA_SIZE.u64,
			offset: 16n,
			arrayView: getU64,
		},
	},
};

export const WGPUBufferDescriptor: StructInfo<
	"nextInChain" | "label" | "usage" | "size" | "mappedAtCreation"
> = {
	size: 40n,
	members: {
		nextInChain: {
			size: WASM_DATA_SIZE.u64,
			offset: 0n,
			arrayView: getU64,
		},
		label: { size: WASM_DATA_SIZE.u64, offset: 8n, arrayView: getU64 },
		usage: { size: WASM_DATA_SIZE.u32, offset: 16n, arrayView: getU32 },
		size: { size: WASM_DATA_SIZE.u64, offset: 24n, arrayView: getU64 },
		mappedAtCreation: {
			size: WASM_DATA_SIZE.u32,
			offset: 32n,
			arrayView: getU32,
		},
	},
};

export const WGPUBindGroupLayoutDescriptor: StructInfo<
	"nextInChain" | "label" | "entryCount" | "entries"
> = {
	size: 32n,
	members: {
		nextInChain: {
			size: WASM_DATA_SIZE.u64,
			offset: 0n,
			arrayView: getU64,
		},
		label: { size: WASM_DATA_SIZE.u64, offset: 8n, arrayView: getU64 },
		entryCount: {
			size: WASM_DATA_SIZE.u64,
			offset: 16n,
			arrayView: getU64,
		},
		entries: { size: WASM_DATA_SIZE.u64, offset: 24n, arrayView: getU64 },
	},
};

export const WGPUBindGroupLayoutEntry: StructInfo<
	| "nextInChain"
	| "binding"
	| "visibility"
	| "buffer"
	| "sampler"
	| "texture"
	| "storageTexture"
> = {
	size: 104n,
	members: {
		nextInChain: {
			size: WASM_DATA_SIZE.u64,
			offset: 0n,
			arrayView: getU64,
		},
		binding: { size: WASM_DATA_SIZE.u32, offset: 8n, arrayView: getU32 },
		visibility: {
			size: WASM_DATA_SIZE.u32,
			offset: 12n,
			arrayView: getU32,
		},
		buffer: {
			size: WGPUBufferBindingLayout.size,
			offset: 16n,
			arrayView: getU8,
		},
		sampler: {
			size: WGPUSamplerBindingLayout.size,
			offset: 40n,
			arrayView: getU8,
		},
		texture: {
			size: WGPUTextureBindingLayout.size,
			offset: 56n,
			arrayView: getU8,
		},
		storageTexture: {
			size: WGPUStorageTextureBindingLayout.size,
			offset: 80n,
			arrayView: getU8,
		},
	},
};

export const WGPUBlendComponent: StructInfo<
	"operation" | "srcFactor" | "dstFactor"
> = {
	size: 12n,
	members: {
		operation: { size: ENUM_SIZE, offset: 0n, arrayView: getU32 },
		srcFactor: { size: ENUM_SIZE, offset: 4n, arrayView: getU32 },
		dstFactor: { size: ENUM_SIZE, offset: 8n, arrayView: getU32 },
	},
};

export const WGPUBlendState: StructInfo<"color" | "alpha"> = {
	size: 24n,
	members: {
		color: { size: WGPUBlendComponent.size, offset: 0n, arrayView: getU8 },
		alpha: { size: WGPUBlendComponent.size, offset: 12n, arrayView: getU8 },
	},
};

export const WGPUColor: StructInfo<"r" | "g" | "b" | "a"> = {
	size: 32n,
	members: {
		r: { size: WASM_DATA_SIZE.float64, offset: 0n, arrayView: getFLOAT64 },
		g: { size: WASM_DATA_SIZE.float64, offset: 8n, arrayView: getFLOAT64 },
		b: { size: WASM_DATA_SIZE.float64, offset: 16n, arrayView: getFLOAT64 },
		a: { size: WASM_DATA_SIZE.float64, offset: 24n, arrayView: getFLOAT64 },
	},
};

export const WGPUColorTargetState: StructInfo<
	"nextInChain" | "format" | "blend" | "writeMask"
> = {
	size: 32n,
	members: {
		nextInChain: {
			size: WASM_DATA_SIZE.u64,
			offset: 0n,
			arrayView: getU64,
		},
		format: { size: ENUM_SIZE, offset: 8n, arrayView: getU32 },
		blend: { size: WASM_DATA_SIZE.u64, offset: 16n, arrayView: getU64 },
		writeMask: { size: WASM_DATA_SIZE.u32, offset: 24n, arrayView: getU32 },
	},
};

export const WGPUProgrammableStageDescriptor: StructInfo<
	"nextInChain" | "module" | "entryPoint" | "constantCount" | "constants"
> = {
	size: 40n,
	members: {
		nextInChain: {
			size: WASM_DATA_SIZE.u64,
			offset: 0n,
			arrayView: getU64,
		},
		module: { size: WASM_DATA_SIZE.u64, offset: 8n, arrayView: getU64 },
		entryPoint: {
			size: WASM_DATA_SIZE.u64,
			offset: 16n,
			arrayView: getU64,
		},
		constantCount: {
			size: WASM_DATA_SIZE.u64,
			offset: 24n,
			arrayView: getU64,
		},
		constants: { size: WASM_DATA_SIZE.u64, offset: 32n, arrayView: getU64 },
	},
};

export const WGPUStencilFaceState: StructInfo<
	"compare" | "failOp" | "depthFailOp" | "passOp"
> = {
	size: 16n,
	members: {
		compare: { size: ENUM_SIZE, offset: 0n, arrayView: getU32 },
		failOp: { size: ENUM_SIZE, offset: 4n, arrayView: getU32 },
		depthFailOp: { size: ENUM_SIZE, offset: 8n, arrayView: getU32 },
		passOp: { size: ENUM_SIZE, offset: 12n, arrayView: getU32 },
	},
};

export const WGPUCommandBufferDescriptor: StructInfo<"nextInChain" | "label"> =
	{
		size: 16n,
		members: {
			nextInChain: {
				size: WASM_DATA_SIZE.u64,
				offset: 0n,
				arrayView: getU64,
			},
			label: { size: WASM_DATA_SIZE.u64, offset: 8n, arrayView: getU64 },
		},
	};

export const WGPUCommandEncoderDescriptor: StructInfo<"nextInChain" | "label"> =
	{
		size: 16n,
		members: {
			nextInChain: {
				size: WASM_DATA_SIZE.u64,
				offset: 0n,
				arrayView: getU64,
			},
			label: { size: WASM_DATA_SIZE.u64, offset: 8n, arrayView: getU64 },
		},
	};

export const WGPUComputePassDescriptor: StructInfo<
	"nextInChain" | "label" | "timestampWrites"
> = {
	size: 24n,
	members: {
		nextInChain: {
			size: WASM_DATA_SIZE.u64,
			offset: 0n,
			arrayView: getU64,
		},
		label: { size: WASM_DATA_SIZE.u64, offset: 8n, arrayView: getU64 },
		timestampWrites: {
			size: WASM_DATA_SIZE.u64,
			offset: 16n,
			arrayView: getU64,
		},
	},
};

export const WGPUComputePipelineDescriptor: StructInfo<
	"nextInChain" | "label" | "layout" | "compute"
> = {
	size: 64n,
	members: {
		nextInChain: {
			size: WASM_DATA_SIZE.u64,
			offset: 0n,
			arrayView: getU64,
		},
		label: { size: WASM_DATA_SIZE.u64, offset: 8n, arrayView: getU64 },
		layout: { size: WASM_DATA_SIZE.u64, offset: 16n, arrayView: getU64 },
		compute: {
			size: WGPUProgrammableStageDescriptor.size,
			offset: 24n,
			arrayView: getU8,
		},
	},
};

export const WGPUDepthStencilState: StructInfo<
	| "nextInChain"
	| "format"
	| "depthWriteEnabled"
	| "depthCompare"
	| "stencilFront"
	| "stencilBack"
	| "stencilReadMask"
	| "stencilWriteMask"
	| "depthBias"
	| "depthBiasSlopeScale"
	| "depthBiasClamp"
> = {
	size: 72n,
	members: {
		nextInChain: {
			size: WASM_DATA_SIZE.u64,
			offset: 0n,
			arrayView: getU64,
		},
		format: { size: ENUM_SIZE, offset: 8n, arrayView: getU32 },
		depthWriteEnabled: {
			size: WASM_DATA_SIZE.u32,
			offset: 12n,
			arrayView: getU32,
		},
		depthCompare: { size: ENUM_SIZE, offset: 16n, arrayView: getU32 },
		stencilFront: {
			size: WGPUStencilFaceState.size,
			offset: 20n,
			arrayView: getU8,
		},
		stencilBack: {
			size: WGPUStencilFaceState.size,
			offset: 36n,
			arrayView: getU8,
		},
		stencilReadMask: {
			size: WASM_DATA_SIZE.u32,
			offset: 52n,
			arrayView: getU32,
		},
		stencilWriteMask: {
			size: WASM_DATA_SIZE.u32,
			offset: 56n,
			arrayView: getU32,
		},
		depthBias: { size: WASM_DATA_SIZE.s32, offset: 60n, arrayView: getS32 },
		depthBiasSlopeScale: {
			size: WASM_DATA_SIZE.float32,
			offset: 64n,
			arrayView: getFLOAT32,
		},
		depthBiasClamp: {
			size: WASM_DATA_SIZE.float32,
			offset: 68n,
			arrayView: getFLOAT32,
		},
	},
};

export const WGPUFragmentState: StructInfo<
	| "nextInChain"
	| "module"
	| "entryPoint"
	| "constantCount"
	| "constants"
	| "targetCount"
	| "targets"
> = {
	size: 56n,
	members: {
		nextInChain: {
			size: WASM_DATA_SIZE.u64,
			offset: 0n,
			arrayView: getU64,
		},
		module: { size: WASM_DATA_SIZE.u64, offset: 8n, arrayView: getU64 },
		entryPoint: {
			size: WASM_DATA_SIZE.u64,
			offset: 16n,
			arrayView: getU64,
		},
		constantCount: {
			size: WASM_DATA_SIZE.u64,
			offset: 24n,
			arrayView: getU64,
		},
		constants: { size: WASM_DATA_SIZE.u64, offset: 32n, arrayView: getU64 },
		targetCount: {
			size: WASM_DATA_SIZE.u64,
			offset: 40n,
			arrayView: getU64,
		},
		targets: { size: WASM_DATA_SIZE.u64, offset: 48n, arrayView: getU64 },
	},
};

export const WGPUImageCopyTexture: StructInfo<
	"nextInChain" | "texture" | "mipLevel" | "origin" | "aspect"
> = {
	size: 40n,
	members: {
		nextInChain: {
			size: WASM_DATA_SIZE.u64,
			offset: 0n,
			arrayView: getU64,
		},
		texture: { size: WASM_DATA_SIZE.u64, offset: 8n, arrayView: getU64 },
		mipLevel: { size: WASM_DATA_SIZE.u32, offset: 16n, arrayView: getU32 },
		origin: { size: WGPUOrigin3D.size, offset: 20n, arrayView: getU8 },
		aspect: { size: ENUM_SIZE, offset: 32n, arrayView: getU32 },
	},
};

export const WGPUMultisampleState: StructInfo<
	"nextInChain" | "count" | "mask" | "alphaToCoverageEnabled"
> = {
	size: 24n,
	members: {
		nextInChain: {
			size: WASM_DATA_SIZE.u64,
			offset: 0n,
			arrayView: getU64,
		},
		count: { size: WASM_DATA_SIZE.u32, offset: 8n, arrayView: getU32 },
		mask: { size: WASM_DATA_SIZE.u32, offset: 12n, arrayView: getU32 },
		alphaToCoverageEnabled: {
			size: WASM_DATA_SIZE.u32,
			offset: 16n,
			arrayView: getU32,
		},
	},
};

export const WGPUPipelineLayoutDescriptor: StructInfo<
	"nextInChain" | "label" | "bindGroupLayoutCount" | "bindGroupLayouts"
> = {
	size: 32n,
	members: {
		nextInChain: {
			size: WASM_DATA_SIZE.u64,
			offset: 0n,
			arrayView: getU64,
		},
		label: { size: WASM_DATA_SIZE.u64, offset: 8n, arrayView: getU64 },
		bindGroupLayoutCount: {
			size: WASM_DATA_SIZE.u64,
			offset: 16n,
			arrayView: getU64,
		},
		bindGroupLayouts: {
			size: WASM_DATA_SIZE.u64,
			offset: 24n,
			arrayView: getU64,
		},
	},
};

export const WGPUPrimitiveState: StructInfo<
	"nextInChain" | "topology" | "stripIndexFormat" | "frontFace" | "cullMode"
> = {
	size: 24n,
	members: {
		nextInChain: {
			size: WASM_DATA_SIZE.u64,
			offset: 0n,
			arrayView: getU64,
		},
		topology: { size: ENUM_SIZE, offset: 8n, arrayView: getU32 },
		stripIndexFormat: { size: ENUM_SIZE, offset: 12n, arrayView: getU32 },
		frontFace: { size: ENUM_SIZE, offset: 16n, arrayView: getU32 },
		cullMode: { size: ENUM_SIZE, offset: 20n, arrayView: getU32 },
	},
};

export const WGPURenderPassColorAttachment: StructInfo<
	| "nextInChain"
	| "view"
	| "resolveTarget"
	| "loadOp"
	| "storeOp"
	| "clearValue"
> = {
	size: 64n,
	members: {
		nextInChain: {
			size: WASM_DATA_SIZE.u64,
			offset: 0n,
			arrayView: getU64,
		},
		view: { size: WASM_DATA_SIZE.u64, offset: 8n, arrayView: getU64 },
		resolveTarget: {
			size: WASM_DATA_SIZE.u64,
			offset: 16n,
			arrayView: getU64,
		},
		loadOp: { size: ENUM_SIZE, offset: 24n, arrayView: getU32 },
		storeOp: { size: ENUM_SIZE, offset: 28n, arrayView: getU32 },
		clearValue: { size: WGPUColor.size, offset: 32n, arrayView: getU8 },
	},
};

export const WGPURenderPassDepthStencilAttachment: StructInfo<
	| "view"
	| "depthLoadOp"
	| "depthStoreOp"
	| "depthClearValue"
	| "depthReadOnly"
	| "stencilLoadOp"
	| "stencilStoreOp"
	| "stencilClearValue"
	| "stencilReadOnly"
> = {
	size: 40n,
	members: {
		view: { size: WASM_DATA_SIZE.u64, offset: 0n, arrayView: getU64 },
		depthLoadOp: { size: ENUM_SIZE, offset: 8n, arrayView: getU32 },
		depthStoreOp: { size: ENUM_SIZE, offset: 12n, arrayView: getU32 },
		depthClearValue: {
			size: WASM_DATA_SIZE.float32,
			offset: 16n,
			arrayView: getFLOAT32,
		},
		depthReadOnly: {
			size: WASM_DATA_SIZE.u32,
			offset: 20n,
			arrayView: getU32,
		},
		stencilLoadOp: { size: ENUM_SIZE, offset: 24n, arrayView: getU32 },
		stencilStoreOp: { size: ENUM_SIZE, offset: 28n, arrayView: getU32 },
		stencilClearValue: {
			size: WASM_DATA_SIZE.u32,
			offset: 32n,
			arrayView: getU32,
		},
		stencilReadOnly: {
			size: WASM_DATA_SIZE.u32,
			offset: 36n,
			arrayView: getU32,
		},
	},
};

export const WGPURenderPassDescriptor: StructInfo<
	| "nextInChain"
	| "label"
	| "colorAttachmentCount"
	| "colorAttachments"
	| "depthStencilAttachment"
	| "occlusionQuerySet"
	| "timestampWrites"
> = {
	size: 56n,
	members: {
		nextInChain: {
			size: WASM_DATA_SIZE.u64,
			offset: 0n,
			arrayView: getU64,
		},
		label: { size: WASM_DATA_SIZE.u64, offset: 8n, arrayView: getU64 },
		colorAttachmentCount: {
			size: WASM_DATA_SIZE.u64,
			offset: 16n,
			arrayView: getU64,
		},
		colorAttachments: {
			size: WASM_DATA_SIZE.u64,
			offset: 24n,
			arrayView: getU64,
		},
		depthStencilAttachment: {
			size: WASM_DATA_SIZE.u64,
			offset: 32n,
			arrayView: getU64,
		},
		occlusionQuerySet: {
			size: WASM_DATA_SIZE.u64,
			offset: 40n,
			arrayView: getU64,
		},
		timestampWrites: {
			size: WASM_DATA_SIZE.u64,
			offset: 48n,
			arrayView: getU64,
		},
	},
};

export const WGPUVertexState: StructInfo<
	| "nextInChain"
	| "module"
	| "entryPoint"
	| "constantCount"
	| "constants"
	| "bufferCount"
	| "buffers"
> = {
	size: 56n,
	members: {
		nextInChain: {
			size: WASM_DATA_SIZE.u64,
			offset: 0n,
			arrayView: getU64,
		},
		module: { size: WASM_DATA_SIZE.u64, offset: 8n, arrayView: getU64 },
		entryPoint: {
			size: WASM_DATA_SIZE.u64,
			offset: 16n,
			arrayView: getU64,
		},
		constantCount: {
			size: WASM_DATA_SIZE.u64,
			offset: 24n,
			arrayView: getU64,
		},
		constants: { size: WASM_DATA_SIZE.u64, offset: 32n, arrayView: getU64 },
		bufferCount: {
			size: WASM_DATA_SIZE.u64,
			offset: 40n,
			arrayView: getU64,
		},
		buffers: { size: WASM_DATA_SIZE.u64, offset: 48n, arrayView: getU64 },
	},
};

export const WGPUChainedStruct: StructInfo<"next" | "sType"> = {
	size: 16n,
	members: {
		next: { size: WASM_DATA_SIZE.u64, offset: 0n, arrayView: getU64 },
		sType: { size: ENUM_SIZE, offset: 8n, arrayView: getU32 },
	},
};

export const WGPURenderPipelineDescriptor: StructInfo<
	| "nextInChain"
	| "label"
	| "layout"
	| "vertex"
	| "primitive"
	| "depthStencil"
	| "multisample"
	| "fragment"
> = {
	size: 144n,
	members: {
		nextInChain: {
			size: WASM_DATA_SIZE.u64,
			offset: 0n,
			arrayView: getU64,
		},
		label: { size: WASM_DATA_SIZE.u64, offset: 8n, arrayView: getU64 },
		layout: { size: WASM_DATA_SIZE.u64, offset: 16n, arrayView: getU64 },
		vertex: { size: WGPUVertexState.size, offset: 24n, arrayView: getU8 },
		primitive: {
			size: WGPUPrimitiveState.size,
			offset: 80n,
			arrayView: getU8,
		},
		depthStencil: {
			size: WASM_DATA_SIZE.u64,
			offset: 104n,
			arrayView: getU64,
		},
		multisample: {
			size: WGPUMultisampleState.size,
			offset: 112n,
			arrayView: getU8,
		},
		fragment: { size: WASM_DATA_SIZE.u64, offset: 136n, arrayView: getU64 },
	},
};

export const WGPUSamplerDescriptor: StructInfo<
	| "nextInChain"
	| "label"
	| "addressModeU"
	| "addressModeV"
	| "addressModeW"
	| "magFilter"
	| "minFilter"
	| "mipmapFilter"
	| "lodMinClamp"
	| "lodMaxClamp"
	| "compare"
	| "maxAnisotropy"
> = {
	size: 56n,
	members: {
		nextInChain: {
			size: WASM_DATA_SIZE.u64,
			offset: 0n,
			arrayView: getU64,
		},
		label: { size: WASM_DATA_SIZE.u64, offset: 8n, arrayView: getU64 },
		addressModeU: { size: ENUM_SIZE, offset: 16n, arrayView: getU32 },
		addressModeV: { size: ENUM_SIZE, offset: 20n, arrayView: getU32 },
		addressModeW: { size: ENUM_SIZE, offset: 24n, arrayView: getU32 },
		magFilter: { size: ENUM_SIZE, offset: 28n, arrayView: getU32 },
		minFilter: { size: ENUM_SIZE, offset: 32n, arrayView: getU32 },
		mipmapFilter: { size: ENUM_SIZE, offset: 36n, arrayView: getU32 },
		lodMinClamp: {
			size: WASM_DATA_SIZE.float32,
			offset: 40n,
			arrayView: getFLOAT32,
		},
		lodMaxClamp: {
			size: WASM_DATA_SIZE.float32,
			offset: 44n,
			arrayView: getFLOAT32,
		},
		compare: { size: ENUM_SIZE, offset: 48n, arrayView: getU32 },
		maxAnisotropy: {
			size: WASM_DATA_SIZE.u16,
			offset: 52n,
			arrayView: getU16,
		},
	},
};

export const WGPUShaderModuleDescriptor: StructInfo<
	"nextInChain" | "label" | "hintCount" | "hints"
> = {
	size: 32n,
	members: {
		nextInChain: {
			size: WASM_DATA_SIZE.u64,
			offset: 0n,
			arrayView: getU64,
		},
		label: { size: WASM_DATA_SIZE.u64, offset: 8n, arrayView: getU64 },
		hintCount: { size: WASM_DATA_SIZE.u64, offset: 16n, arrayView: getU64 },
		hints: { size: WASM_DATA_SIZE.u64, offset: 24n, arrayView: getU64 },
	},
};

export const WGPUShaderModuleWGSLDescriptor: StructInfo<"chain" | "code"> = {
	size: 24n,
	members: {
		chain: { size: WGPUChainedStruct.size, offset: 0n, arrayView: getU8 },
		code: { size: WASM_DATA_SIZE.u64, offset: 16n, arrayView: getU64 },
	},
};

export const WGPUTextureDataLayout: StructInfo<
	"nextInChain" | "offset" | "bytesPerRow" | "rowsPerImage"
> = {
	size: 24n,
	members: {
		nextInChain: {
			size: WASM_DATA_SIZE.u64,
			offset: 0n,
			arrayView: getU64,
		},
		offset: { size: WASM_DATA_SIZE.u64, offset: 8n, arrayView: getU64 },
		bytesPerRow: {
			size: WASM_DATA_SIZE.u32,
			offset: 16n,
			arrayView: getU32,
		},
		rowsPerImage: {
			size: WASM_DATA_SIZE.u32,
			offset: 20n,
			arrayView: getU32,
		},
	},
};

export const WGPUImageCopyBuffer: StructInfo<
	"nextInChain" | "layout" | "buffer"
> = {
	size: 40n,
	members: {
		nextInChain: {
			size: WASM_DATA_SIZE.u64,
			offset: 0n,
			arrayView: getU64,
		},
		layout: {
			size: WGPUTextureDataLayout.size,
			offset: 8n,
			arrayView: getU8,
		},
		buffer: { size: WASM_DATA_SIZE.u64, offset: 32n, arrayView: getU64 },
	},
};

export const WGPUTextureDescriptor: StructInfo<
	| "nextInChain"
	| "label"
	| "usage"
	| "dimension"
	| "size"
	| "format"
	| "mipLevelCount"
	| "sampleCount"
	| "viewFormatCount"
	| "viewFormats"
> = {
	size: 64n,
	members: {
		nextInChain: {
			size: WASM_DATA_SIZE.u64,
			offset: 0n,
			arrayView: getU64,
		},
		label: { size: WASM_DATA_SIZE.u64, offset: 8n, arrayView: getU64 },
		usage: { size: WASM_DATA_SIZE.u32, offset: 16n, arrayView: getU32 },
		dimension: { size: ENUM_SIZE, offset: 20n, arrayView: getU32 },
		size: { size: WGPUExtent3D.size, offset: 24n, arrayView: getU8 },
		format: { size: ENUM_SIZE, offset: 36n, arrayView: getU32 },
		mipLevelCount: {
			size: WASM_DATA_SIZE.u32,
			offset: 40n,
			arrayView: getU32,
		},
		sampleCount: {
			size: WASM_DATA_SIZE.u32,
			offset: 44n,
			arrayView: getU32,
		},
		viewFormatCount: {
			size: WASM_DATA_SIZE.u64,
			offset: 48n,
			arrayView: getU64,
		},
		viewFormats: {
			size: WASM_DATA_SIZE.u64,
			offset: 56n,
			arrayView: getU64,
		},
	},
};

export const WGPUVertexAttribute: StructInfo<
	"format" | "offset" | "shaderLocation"
> = {
	size: 24n,
	members: {
		format: { size: ENUM_SIZE, offset: 0n, arrayView: getU32 },
		offset: { size: WASM_DATA_SIZE.u64, offset: 8n, arrayView: getU64 },
		shaderLocation: {
			size: WASM_DATA_SIZE.u32,
			offset: 16n,
			arrayView: getU32,
		},
	},
};

export const WGPUVertexBufferLayout: StructInfo<
	"arrayStride" | "stepMode" | "attributeCount" | "attributes"
> = {
	size: 32n,
	members: {
		arrayStride: {
			size: WASM_DATA_SIZE.u64,
			offset: 0n,
			arrayView: getU64,
		},
		stepMode: { size: ENUM_SIZE, offset: 8n, arrayView: getU32 },
		attributeCount: {
			size: WASM_DATA_SIZE.u64,
			offset: 16n,
			arrayView: getU64,
		},
		attributes: {
			size: WASM_DATA_SIZE.u64,
			offset: 24n,
			arrayView: getU64,
		},
	},
};

export const WGPUTextureViewDescriptor: StructInfo<
	| "nextInChain"
	| "label"
	| "format"
	| "dimension"
	| "baseMipLevel"
	| "mipLevelCount"
	| "baseArrayLayer"
	| "arrayLayerCount"
	| "aspect"
> = {
	size: 48n,
	members: {
		nextInChain: {
			size: WASM_DATA_SIZE.u64,
			offset: 0n,
			arrayView: getU64,
		},
		label: { size: WASM_DATA_SIZE.u64, offset: 8n, arrayView: getU64 },
		format: { size: ENUM_SIZE, offset: 16n, arrayView: getU32 },
		dimension: { size: ENUM_SIZE, offset: 20n, arrayView: getU32 },
		baseMipLevel: {
			size: WASM_DATA_SIZE.u32,
			offset: 24n,
			arrayView: getU32,
		},
		mipLevelCount: {
			size: WASM_DATA_SIZE.u32,
			offset: 28n,
			arrayView: getU32,
		},
		baseArrayLayer: {
			size: WASM_DATA_SIZE.u32,
			offset: 32n,
			arrayView: getU32,
		},
		arrayLayerCount: {
			size: WASM_DATA_SIZE.u32,
			offset: 36n,
			arrayView: getU32,
		},
		aspect: { size: ENUM_SIZE, offset: 40n, arrayView: getU32 },
	},
};

