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
import { WGPU_SIZE, ENUM_SIZE } from "./WebGPUOffset";

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
	size: BigInt(12),
	members: {
		x: { size: WGPU_SIZE.u32, offset: BigInt(0), arrayView: getU32 },
		y: { size: WGPU_SIZE.u32, offset: BigInt(4), arrayView: getU32 },
		z: { size: WGPU_SIZE.u32, offset: BigInt(8), arrayView: getU32 },
	},
};

export const WGPUExtent3D: StructInfo<
	"width" | "height" | "depthOrArrayLayers"
> = {
	size: BigInt(12),
	members: {
		width: { size: WGPU_SIZE.u32, offset: BigInt(0), arrayView: getU32 },
		height: { size: WGPU_SIZE.u32, offset: BigInt(4), arrayView: getU32 },
		depthOrArrayLayers: {
			size: WGPU_SIZE.u32,
			offset: BigInt(8),
			arrayView: getU32,
		},
	},
};

export const WGPUBindGroupDescriptor: StructInfo<
	"nextInChain" | "label" | "layout" | "entryCount" | "entries"
> = {
	size: BigInt(40),
	members: {
		nextInChain: {
			size: WGPU_SIZE.u64,
			offset: BigInt(0),
			arrayView: getU64,
		},
		label: { size: WGPU_SIZE.u64, offset: BigInt(8), arrayView: getU64 },
		layout: { size: WGPU_SIZE.u64, offset: BigInt(16), arrayView: getU64 },
		entryCount: {
			size: WGPU_SIZE.u64,
			offset: BigInt(24),
			arrayView: getU64,
		},
		entries: { size: WGPU_SIZE.u64, offset: BigInt(32), arrayView: getU64 },
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
	size: BigInt(56),
	members: {
		nextInChain: {
			size: WGPU_SIZE.u64,
			offset: BigInt(0),
			arrayView: getU64,
		},
		binding: { size: WGPU_SIZE.u32, offset: BigInt(8), arrayView: getU32 },
		buffer: { size: WGPU_SIZE.u64, offset: BigInt(16), arrayView: getU64 },
		offset: { size: WGPU_SIZE.u64, offset: BigInt(24), arrayView: getU64 },
		size: { size: WGPU_SIZE.u64, offset: BigInt(32), arrayView: getU64 },
		sampler: { size: WGPU_SIZE.u64, offset: BigInt(40), arrayView: getU64 },
		textureView: {
			size: WGPU_SIZE.u64,
			offset: BigInt(48),
			arrayView: getU64,
		},
	},
};

export const WGPUSamplerBindingLayout: StructInfo<"nextInChain" | "type"> = {
	size: BigInt(16),
	members: {
		nextInChain: {
			size: WGPU_SIZE.u64,
			offset: BigInt(0),
			arrayView: getU64,
		},
		type: { size: ENUM_SIZE, offset: BigInt(8), arrayView: getU32 },
	},
};

export const WGPUTextureBindingLayout: StructInfo<
	"nextInChain" | "sampleType" | "viewDimension" | "multisampled"
> = {
	size: BigInt(24),
	members: {
		nextInChain: {
			size: WGPU_SIZE.u64,
			offset: BigInt(0),
			arrayView: getU64,
		},
		sampleType: { size: ENUM_SIZE, offset: BigInt(8), arrayView: getU32 },
		viewDimension: {
			size: ENUM_SIZE,
			offset: BigInt(12),
			arrayView: getU32,
		},
		multisampled: {
			size: WGPU_SIZE.u32,
			offset: BigInt(16),
			arrayView: getU32,
		},
	},
};

export const WGPUStorageTextureBindingLayout: StructInfo<
	"nextInChain" | "access" | "format" | "viewDimension"
> = {
	size: BigInt(24),
	members: {
		nextInChain: {
			size: WGPU_SIZE.u64,
			offset: BigInt(0),
			arrayView: getU64,
		},
		access: { size: ENUM_SIZE, offset: BigInt(8), arrayView: getU32 },
		format: { size: ENUM_SIZE, offset: BigInt(12), arrayView: getU32 },
		viewDimension: {
			size: ENUM_SIZE,
			offset: BigInt(16),
			arrayView: getU32,
		},
	},
};

export const WGPUBufferBindingLayout: StructInfo<
	"nextInChain" | "type" | "hasDynamicOffset" | "minBindingSize"
> = {
	size: BigInt(24),
	members: {
		nextInChain: {
			size: WGPU_SIZE.u64,
			offset: BigInt(0),
			arrayView: getU64,
		},
		type: { size: ENUM_SIZE, offset: BigInt(8), arrayView: getU32 },
		hasDynamicOffset: {
			size: WGPU_SIZE.u32,
			offset: BigInt(12),
			arrayView: getU32,
		},
		minBindingSize: {
			size: WGPU_SIZE.u64,
			offset: BigInt(16),
			arrayView: getU64,
		},
	},
};

export const WGPUBufferDescriptor: StructInfo<
	"nextInChain" | "label" | "usage" | "size" | "mappedAtCreation"
> = {
	size: BigInt(40),
	members: {
		nextInChain: {
			size: WGPU_SIZE.u64,
			offset: BigInt(0),
			arrayView: getU64,
		},
		label: { size: WGPU_SIZE.u64, offset: BigInt(8), arrayView: getU64 },
		usage: { size: WGPU_SIZE.u32, offset: BigInt(16), arrayView: getU32 },
		size: { size: WGPU_SIZE.u64, offset: BigInt(24), arrayView: getU64 },
		mappedAtCreation: {
			size: WGPU_SIZE.u32,
			offset: BigInt(32),
			arrayView: getU32,
		},
	},
};

export const WGPUBindGroupLayoutDescriptor: StructInfo<
	"nextInChain" | "label" | "entryCount" | "entries"
> = {
	size: BigInt(32),
	members: {
		nextInChain: {
			size: WGPU_SIZE.u64,
			offset: BigInt(0),
			arrayView: getU64,
		},
		label: { size: WGPU_SIZE.u64, offset: BigInt(8), arrayView: getU64 },
		entryCount: {
			size: WGPU_SIZE.u64,
			offset: BigInt(16),
			arrayView: getU64,
		},
		entries: { size: WGPU_SIZE.u64, offset: BigInt(24), arrayView: getU64 },
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
	size: BigInt(104),
	members: {
		nextInChain: {
			size: WGPU_SIZE.u64,
			offset: BigInt(0),
			arrayView: getU64,
		},
		binding: { size: WGPU_SIZE.u32, offset: BigInt(8), arrayView: getU32 },
		visibility: {
			size: WGPU_SIZE.u32,
			offset: BigInt(12),
			arrayView: getU32,
		},
		buffer: {
			size: WGPUBufferBindingLayout.size,
			offset: BigInt(16),
			arrayView: getU8,
		},
		sampler: {
			size: WGPUSamplerBindingLayout.size,
			offset: BigInt(40),
			arrayView: getU8,
		},
		texture: {
			size: WGPUTextureBindingLayout.size,
			offset: BigInt(56),
			arrayView: getU8,
		},
		storageTexture: {
			size: WGPUStorageTextureBindingLayout.size,
			offset: BigInt(80),
			arrayView: getU8,
		},
	},
};

export const WGPUBlendComponent: StructInfo<
	"operation" | "srcFactor" | "dstFactor"
> = {
	size: BigInt(12),
	members: {
		operation: { size: ENUM_SIZE, offset: BigInt(0), arrayView: getU32 },
		srcFactor: { size: ENUM_SIZE, offset: BigInt(4), arrayView: getU32 },
		dstFactor: { size: ENUM_SIZE, offset: BigInt(8), arrayView: getU32 },
	},
};

export const WGPUBlendState: StructInfo<"color" | "alpha"> = {
	size: BigInt(24),
	members: {
		color: {
			size: WGPUBlendComponent.size,
			offset: BigInt(0),
			arrayView: getU8,
		},
		alpha: {
			size: WGPUBlendComponent.size,
			offset: BigInt(12),
			arrayView: getU8,
		},
	},
};

export const WGPUColor: StructInfo<"r" | "g" | "b" | "a"> = {
	size: BigInt(32),
	members: {
		r: {
			size: WGPU_SIZE.float64,
			offset: BigInt(0),
			arrayView: getFLOAT64,
		},
		g: {
			size: WGPU_SIZE.float64,
			offset: BigInt(8),
			arrayView: getFLOAT64,
		},
		b: {
			size: WGPU_SIZE.float64,
			offset: BigInt(16),
			arrayView: getFLOAT64,
		},
		a: {
			size: WGPU_SIZE.float64,
			offset: BigInt(24),
			arrayView: getFLOAT64,
		},
	},
};

export const WGPUColorTargetState: StructInfo<
	"nextInChain" | "format" | "blend" | "writeMask"
> = {
	size: BigInt(32),
	members: {
		nextInChain: {
			size: WGPU_SIZE.u64,
			offset: BigInt(0),
			arrayView: getU64,
		},
		format: { size: ENUM_SIZE, offset: BigInt(8), arrayView: getU32 },
		blend: { size: WGPU_SIZE.u64, offset: BigInt(16), arrayView: getU64 },
		writeMask: {
			size: WGPU_SIZE.u32,
			offset: BigInt(24),
			arrayView: getU32,
		},
	},
};

export const WGPUProgrammableStageDescriptor: StructInfo<
	"nextInChain" | "module" | "entryPoint" | "constantCount" | "constants"
> = {
	size: BigInt(40),
	members: {
		nextInChain: {
			size: WGPU_SIZE.u64,
			offset: BigInt(0),
			arrayView: getU64,
		},
		module: { size: WGPU_SIZE.u64, offset: BigInt(8), arrayView: getU64 },
		entryPoint: {
			size: WGPU_SIZE.u64,
			offset: BigInt(16),
			arrayView: getU64,
		},
		constantCount: {
			size: WGPU_SIZE.u64,
			offset: BigInt(24),
			arrayView: getU64,
		},
		constants: {
			size: WGPU_SIZE.u64,
			offset: BigInt(32),
			arrayView: getU64,
		},
	},
};

export const WGPUStencilFaceState: StructInfo<
	"compare" | "failOp" | "depthFailOp" | "passOp"
> = {
	size: BigInt(16),
	members: {
		compare: { size: ENUM_SIZE, offset: BigInt(0), arrayView: getU32 },
		failOp: { size: ENUM_SIZE, offset: BigInt(4), arrayView: getU32 },
		depthFailOp: { size: ENUM_SIZE, offset: BigInt(8), arrayView: getU32 },
		passOp: { size: ENUM_SIZE, offset: BigInt(12), arrayView: getU32 },
	},
};

export const WGPUCommandBufferDescriptor: StructInfo<"nextInChain" | "label"> =
	{
		size: BigInt(16),
		members: {
			nextInChain: {
				size: WGPU_SIZE.u64,
				offset: BigInt(0),
				arrayView: getU64,
			},
			label: {
				size: WGPU_SIZE.u64,
				offset: BigInt(8),
				arrayView: getU64,
			},
		},
	};

export const WGPUCommandEncoderDescriptor: StructInfo<"nextInChain" | "label"> =
	{
		size: BigInt(16),
		members: {
			nextInChain: {
				size: WGPU_SIZE.u64,
				offset: BigInt(0),
				arrayView: getU64,
			},
			label: {
				size: WGPU_SIZE.u64,
				offset: BigInt(8),
				arrayView: getU64,
			},
		},
	};

export const WGPUComputePassDescriptor: StructInfo<
	"nextInChain" | "label" | "timestampWrites"
> = {
	size: BigInt(24),
	members: {
		nextInChain: {
			size: WGPU_SIZE.u64,
			offset: BigInt(0),
			arrayView: getU64,
		},
		label: { size: WGPU_SIZE.u64, offset: BigInt(8), arrayView: getU64 },
		timestampWrites: {
			size: WGPU_SIZE.u64,
			offset: BigInt(16),
			arrayView: getU64,
		},
	},
};

export const WGPUComputePipelineDescriptor: StructInfo<
	"nextInChain" | "label" | "layout" | "compute"
> = {
	size: BigInt(64),
	members: {
		nextInChain: {
			size: WGPU_SIZE.u64,
			offset: BigInt(0),
			arrayView: getU64,
		},
		label: { size: WGPU_SIZE.u64, offset: BigInt(8), arrayView: getU64 },
		layout: { size: WGPU_SIZE.u64, offset: BigInt(16), arrayView: getU64 },
		compute: {
			size: WGPUProgrammableStageDescriptor.size,
			offset: BigInt(24),
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
	size: BigInt(72),
	members: {
		nextInChain: {
			size: WGPU_SIZE.u64,
			offset: BigInt(0),
			arrayView: getU64,
		},
		format: { size: ENUM_SIZE, offset: BigInt(8), arrayView: getU32 },
		depthWriteEnabled: {
			size: WGPU_SIZE.u32,
			offset: BigInt(12),
			arrayView: getU32,
		},
		depthCompare: {
			size: ENUM_SIZE,
			offset: BigInt(16),
			arrayView: getU32,
		},
		stencilFront: {
			size: WGPUStencilFaceState.size,
			offset: BigInt(20),
			arrayView: getU8,
		},
		stencilBack: {
			size: WGPUStencilFaceState.size,
			offset: BigInt(36),
			arrayView: getU8,
		},
		stencilReadMask: {
			size: WGPU_SIZE.u32,
			offset: BigInt(52),
			arrayView: getU32,
		},
		stencilWriteMask: {
			size: WGPU_SIZE.u32,
			offset: BigInt(56),
			arrayView: getU32,
		},
		depthBias: {
			size: WGPU_SIZE.s32,
			offset: BigInt(60),
			arrayView: getS32,
		},
		depthBiasSlopeScale: {
			size: WGPU_SIZE.float32,
			offset: BigInt(64),
			arrayView: getFLOAT32,
		},
		depthBiasClamp: {
			size: WGPU_SIZE.float32,
			offset: BigInt(68),
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
	size: BigInt(56),
	members: {
		nextInChain: {
			size: WGPU_SIZE.u64,
			offset: BigInt(0),
			arrayView: getU64,
		},
		module: { size: WGPU_SIZE.u64, offset: BigInt(8), arrayView: getU64 },
		entryPoint: {
			size: WGPU_SIZE.u64,
			offset: BigInt(16),
			arrayView: getU64,
		},
		constantCount: {
			size: WGPU_SIZE.u64,
			offset: BigInt(24),
			arrayView: getU64,
		},
		constants: {
			size: WGPU_SIZE.u64,
			offset: BigInt(32),
			arrayView: getU64,
		},
		targetCount: {
			size: WGPU_SIZE.u64,
			offset: BigInt(40),
			arrayView: getU64,
		},
		targets: { size: WGPU_SIZE.u64, offset: BigInt(48), arrayView: getU64 },
	},
};

export const WGPUImageCopyTexture: StructInfo<
	"nextInChain" | "texture" | "mipLevel" | "origin" | "aspect"
> = {
	size: BigInt(40),
	members: {
		nextInChain: {
			size: WGPU_SIZE.u64,
			offset: BigInt(0),
			arrayView: getU64,
		},
		texture: { size: WGPU_SIZE.u64, offset: BigInt(8), arrayView: getU64 },
		mipLevel: {
			size: WGPU_SIZE.u32,
			offset: BigInt(16),
			arrayView: getU32,
		},
		origin: {
			size: WGPUOrigin3D.size,
			offset: BigInt(20),
			arrayView: getU8,
		},
		aspect: { size: ENUM_SIZE, offset: BigInt(32), arrayView: getU32 },
	},
};

export const WGPUMultisampleState: StructInfo<
	"nextInChain" | "count" | "mask" | "alphaToCoverageEnabled"
> = {
	size: BigInt(24),
	members: {
		nextInChain: {
			size: WGPU_SIZE.u64,
			offset: BigInt(0),
			arrayView: getU64,
		},
		count: { size: WGPU_SIZE.u32, offset: BigInt(8), arrayView: getU32 },
		mask: { size: WGPU_SIZE.u32, offset: BigInt(12), arrayView: getU32 },
		alphaToCoverageEnabled: {
			size: WGPU_SIZE.u32,
			offset: BigInt(16),
			arrayView: getU32,
		},
	},
};

export const WGPUPipelineLayoutDescriptor: StructInfo<
	"nextInChain" | "label" | "bindGroupLayoutCount" | "bindGroupLayouts"
> = {
	size: BigInt(32),
	members: {
		nextInChain: {
			size: WGPU_SIZE.u64,
			offset: BigInt(0),
			arrayView: getU64,
		},
		label: { size: WGPU_SIZE.u64, offset: BigInt(8), arrayView: getU64 },
		bindGroupLayoutCount: {
			size: WGPU_SIZE.u64,
			offset: BigInt(16),
			arrayView: getU64,
		},
		bindGroupLayouts: {
			size: WGPU_SIZE.u64,
			offset: BigInt(24),
			arrayView: getU64,
		},
	},
};

export const WGPUPrimitiveState: StructInfo<
	"nextInChain" | "topology" | "stripIndexFormat" | "frontFace" | "cullMode"
> = {
	size: BigInt(24),
	members: {
		nextInChain: {
			size: WGPU_SIZE.u64,
			offset: BigInt(0),
			arrayView: getU64,
		},
		topology: { size: ENUM_SIZE, offset: BigInt(8), arrayView: getU32 },
		stripIndexFormat: {
			size: ENUM_SIZE,
			offset: BigInt(12),
			arrayView: getU32,
		},
		frontFace: { size: ENUM_SIZE, offset: BigInt(16), arrayView: getU32 },
		cullMode: { size: ENUM_SIZE, offset: BigInt(20), arrayView: getU32 },
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
	size: BigInt(64),
	members: {
		nextInChain: {
			size: WGPU_SIZE.u64,
			offset: BigInt(0),
			arrayView: getU64,
		},
		view: { size: WGPU_SIZE.u64, offset: BigInt(8), arrayView: getU64 },
		resolveTarget: {
			size: WGPU_SIZE.u64,
			offset: BigInt(16),
			arrayView: getU64,
		},
		loadOp: { size: ENUM_SIZE, offset: BigInt(24), arrayView: getU32 },
		storeOp: { size: ENUM_SIZE, offset: BigInt(28), arrayView: getU32 },
		clearValue: {
			size: WGPUColor.size,
			offset: BigInt(32),
			arrayView: getU8,
		},
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
	size: BigInt(40),
	members: {
		view: { size: WGPU_SIZE.u64, offset: BigInt(0), arrayView: getU64 },
		depthLoadOp: { size: ENUM_SIZE, offset: BigInt(8), arrayView: getU32 },
		depthStoreOp: {
			size: ENUM_SIZE,
			offset: BigInt(12),
			arrayView: getU32,
		},
		depthClearValue: {
			size: WGPU_SIZE.float32,
			offset: BigInt(16),
			arrayView: getFLOAT32,
		},
		depthReadOnly: {
			size: WGPU_SIZE.u32,
			offset: BigInt(20),
			arrayView: getU32,
		},
		stencilLoadOp: {
			size: ENUM_SIZE,
			offset: BigInt(24),
			arrayView: getU32,
		},
		stencilStoreOp: {
			size: ENUM_SIZE,
			offset: BigInt(28),
			arrayView: getU32,
		},
		stencilClearValue: {
			size: WGPU_SIZE.u32,
			offset: BigInt(32),
			arrayView: getU32,
		},
		stencilReadOnly: {
			size: WGPU_SIZE.u32,
			offset: BigInt(36),
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
	size: BigInt(56),
	members: {
		nextInChain: {
			size: WGPU_SIZE.u64,
			offset: BigInt(0),
			arrayView: getU64,
		},
		label: { size: WGPU_SIZE.u64, offset: BigInt(8), arrayView: getU64 },
		colorAttachmentCount: {
			size: WGPU_SIZE.u64,
			offset: BigInt(16),
			arrayView: getU64,
		},
		colorAttachments: {
			size: WGPU_SIZE.u64,
			offset: BigInt(24),
			arrayView: getU64,
		},
		depthStencilAttachment: {
			size: WGPU_SIZE.u64,
			offset: BigInt(32),
			arrayView: getU64,
		},
		occlusionQuerySet: {
			size: WGPU_SIZE.u64,
			offset: BigInt(40),
			arrayView: getU64,
		},
		timestampWrites: {
			size: WGPU_SIZE.u64,
			offset: BigInt(48),
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
	size: BigInt(56),
	members: {
		nextInChain: {
			size: WGPU_SIZE.u64,
			offset: BigInt(0),
			arrayView: getU64,
		},
		module: { size: WGPU_SIZE.u64, offset: BigInt(8), arrayView: getU64 },
		entryPoint: {
			size: WGPU_SIZE.u64,
			offset: BigInt(16),
			arrayView: getU64,
		},
		constantCount: {
			size: WGPU_SIZE.u64,
			offset: BigInt(24),
			arrayView: getU64,
		},
		constants: {
			size: WGPU_SIZE.u64,
			offset: BigInt(32),
			arrayView: getU64,
		},
		bufferCount: {
			size: WGPU_SIZE.u64,
			offset: BigInt(40),
			arrayView: getU64,
		},
		buffers: { size: WGPU_SIZE.u64, offset: BigInt(48), arrayView: getU64 },
	},
};

export const WGPUChainedStruct: StructInfo<"next" | "sType"> = {
	size: BigInt(16),
	members: {
		next: { size: WGPU_SIZE.u64, offset: BigInt(0), arrayView: getU64 },
		sType: { size: ENUM_SIZE, offset: BigInt(8), arrayView: getU32 },
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
	size: BigInt(144),
	members: {
		nextInChain: {
			size: WGPU_SIZE.u64,
			offset: BigInt(0),
			arrayView: getU64,
		},
		label: { size: WGPU_SIZE.u64, offset: BigInt(8), arrayView: getU64 },
		layout: { size: WGPU_SIZE.u64, offset: BigInt(16), arrayView: getU64 },
		vertex: {
			size: WGPUVertexState.size,
			offset: BigInt(24),
			arrayView: getU8,
		},
		primitive: {
			size: WGPUPrimitiveState.size,
			offset: BigInt(80),
			arrayView: getU8,
		},
		depthStencil: {
			size: WGPU_SIZE.u64,
			offset: BigInt(104),
			arrayView: getU64,
		},
		multisample: {
			size: WGPUMultisampleState.size,
			offset: BigInt(112),
			arrayView: getU8,
		},
		fragment: {
			size: WGPU_SIZE.u64,
			offset: BigInt(136),
			arrayView: getU64,
		},
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
	size: BigInt(56),
	members: {
		nextInChain: {
			size: WGPU_SIZE.u64,
			offset: BigInt(0),
			arrayView: getU64,
		},
		label: { size: WGPU_SIZE.u64, offset: BigInt(8), arrayView: getU64 },
		addressModeU: {
			size: ENUM_SIZE,
			offset: BigInt(16),
			arrayView: getU32,
		},
		addressModeV: {
			size: ENUM_SIZE,
			offset: BigInt(20),
			arrayView: getU32,
		},
		addressModeW: {
			size: ENUM_SIZE,
			offset: BigInt(24),
			arrayView: getU32,
		},
		magFilter: { size: ENUM_SIZE, offset: BigInt(28), arrayView: getU32 },
		minFilter: { size: ENUM_SIZE, offset: BigInt(32), arrayView: getU32 },
		mipmapFilter: {
			size: ENUM_SIZE,
			offset: BigInt(36),
			arrayView: getU32,
		},
		lodMinClamp: {
			size: WGPU_SIZE.float32,
			offset: BigInt(40),
			arrayView: getFLOAT32,
		},
		lodMaxClamp: {
			size: WGPU_SIZE.float32,
			offset: BigInt(44),
			arrayView: getFLOAT32,
		},
		compare: { size: ENUM_SIZE, offset: BigInt(48), arrayView: getU32 },
		maxAnisotropy: {
			size: WGPU_SIZE.u16,
			offset: BigInt(52),
			arrayView: getU16,
		},
	},
};

export const WGPUShaderModuleDescriptor: StructInfo<
	"nextInChain" | "label" | "hintCount" | "hints"
> = {
	size: BigInt(32),
	members: {
		nextInChain: {
			size: WGPU_SIZE.u64,
			offset: BigInt(0),
			arrayView: getU64,
		},
		label: { size: WGPU_SIZE.u64, offset: BigInt(8), arrayView: getU64 },
		hintCount: {
			size: WGPU_SIZE.u64,
			offset: BigInt(16),
			arrayView: getU64,
		},
		hints: { size: WGPU_SIZE.u64, offset: BigInt(24), arrayView: getU64 },
	},
};

export const WGPUShaderModuleWGSLDescriptor: StructInfo<"chain" | "code"> = {
	size: BigInt(24),
	members: {
		chain: {
			size: WGPUChainedStruct.size,
			offset: BigInt(0),
			arrayView: getU8,
		},
		code: { size: WGPU_SIZE.u64, offset: BigInt(16), arrayView: getU64 },
	},
};

export const WGPUTextureDataLayout: StructInfo<
	"nextInChain" | "offset" | "bytesPerRow" | "rowsPerImage"
> = {
	size: BigInt(24),
	members: {
		nextInChain: {
			size: WGPU_SIZE.u64,
			offset: BigInt(0),
			arrayView: getU64,
		},
		offset: { size: WGPU_SIZE.u64, offset: BigInt(8), arrayView: getU64 },
		bytesPerRow: {
			size: WGPU_SIZE.u32,
			offset: BigInt(16),
			arrayView: getU32,
		},
		rowsPerImage: {
			size: WGPU_SIZE.u32,
			offset: BigInt(20),
			arrayView: getU32,
		},
	},
};

export const WGPUImageCopyBuffer: StructInfo<
	"nextInChain" | "layout" | "buffer"
> = {
	size: BigInt(40),
	members: {
		nextInChain: {
			size: WGPU_SIZE.u64,
			offset: BigInt(0),
			arrayView: getU64,
		},
		layout: {
			size: WGPUTextureDataLayout.size,
			offset: BigInt(8),
			arrayView: getU8,
		},
		buffer: { size: WGPU_SIZE.u64, offset: BigInt(32), arrayView: getU64 },
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
	size: BigInt(64),
	members: {
		nextInChain: {
			size: WGPU_SIZE.u64,
			offset: BigInt(0),
			arrayView: getU64,
		},
		label: { size: WGPU_SIZE.u64, offset: BigInt(8), arrayView: getU64 },
		usage: { size: WGPU_SIZE.u32, offset: BigInt(16), arrayView: getU32 },
		dimension: { size: ENUM_SIZE, offset: BigInt(20), arrayView: getU32 },
		size: { size: WGPUExtent3D.size, offset: BigInt(24), arrayView: getU8 },
		format: { size: ENUM_SIZE, offset: BigInt(36), arrayView: getU32 },
		mipLevelCount: {
			size: WGPU_SIZE.u32,
			offset: BigInt(40),
			arrayView: getU32,
		},
		sampleCount: {
			size: WGPU_SIZE.u32,
			offset: BigInt(44),
			arrayView: getU32,
		},
		viewFormatCount: {
			size: WGPU_SIZE.u64,
			offset: BigInt(48),
			arrayView: getU64,
		},
		viewFormats: {
			size: WGPU_SIZE.u64,
			offset: BigInt(56),
			arrayView: getU64,
		},
	},
};

export const WGPUVertexAttribute: StructInfo<
	"format" | "offset" | "shaderLocation"
> = {
	size: BigInt(24),
	members: {
		format: { size: ENUM_SIZE, offset: BigInt(0), arrayView: getU32 },
		offset: { size: WGPU_SIZE.u64, offset: BigInt(8), arrayView: getU64 },
		shaderLocation: {
			size: WGPU_SIZE.u32,
			offset: BigInt(16),
			arrayView: getU32,
		},
	},
};

export const WGPUVertexBufferLayout: StructInfo<
	"arrayStride" | "stepMode" | "attributeCount" | "attributes"
> = {
	size: BigInt(32),
	members: {
		arrayStride: {
			size: WGPU_SIZE.u64,
			offset: BigInt(0),
			arrayView: getU64,
		},
		stepMode: { size: ENUM_SIZE, offset: BigInt(8), arrayView: getU32 },
		attributeCount: {
			size: WGPU_SIZE.u64,
			offset: BigInt(16),
			arrayView: getU64,
		},
		attributes: {
			size: WGPU_SIZE.u64,
			offset: BigInt(24),
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
	size: BigInt(48),
	members: {
		nextInChain: {
			size: WGPU_SIZE.u64,
			offset: BigInt(0),
			arrayView: getU64,
		},
		label: { size: WGPU_SIZE.u64, offset: BigInt(8), arrayView: getU64 },
		format: { size: ENUM_SIZE, offset: BigInt(16), arrayView: getU32 },
		dimension: { size: ENUM_SIZE, offset: BigInt(20), arrayView: getU32 },
		baseMipLevel: {
			size: WGPU_SIZE.u32,
			offset: BigInt(24),
			arrayView: getU32,
		},
		mipLevelCount: {
			size: WGPU_SIZE.u32,
			offset: BigInt(28),
			arrayView: getU32,
		},
		baseArrayLayer: {
			size: WGPU_SIZE.u32,
			offset: BigInt(32),
			arrayView: getU32,
		},
		arrayLayerCount: {
			size: WGPU_SIZE.u32,
			offset: BigInt(36),
			arrayView: getU32,
		},
		aspect: { size: ENUM_SIZE, offset: BigInt(40), arrayView: getU32 },
	},
};

