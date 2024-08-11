const GPU_BUFFER_BINDING_TYPES: GPUBufferBindingType[] = [
	"uniform",
	"storage",
	"read-only-storage",
];
export function bufferTypeIntToGPUBufferBindingType(
	i: number
): GPUBufferBindingType {
	return GPU_BUFFER_BINDING_TYPES[i - 1]; // in linux.jai, we have the undefined entry at index 0
}
const GPU_VERTEX_STEP_MODES: GPUVertexStepMode[] = ["vertex", "instance"];
export function stepModeIntToGPUVertexStepMode(i: number): GPUVertexStepMode {
	return GPU_VERTEX_STEP_MODES[i];
}
const GPU_VERTEX_FORMATS: GPUVertexFormat[] = [
	"uint8x2",
	"uint8x4",
	"sint8x2",
	"sint8x4",
	"unorm8x2",
	"unorm8x4",
	"snorm8x2",
	"snorm8x4",
	"uint16x2",
	"uint16x4",
	"sint16x2",
	"sint16x4",
	"unorm16x2",
	"unorm16x4",
	"snorm16x2",
	"snorm16x4",
	"float16x2",
	"float16x4",
	"float32",
	"float32x2",
	"float32x3",
	"float32x4",
	"uint32",
	"uint32x2",
	"uint32x3",
	"uint32x4",
	"sint32",
	"sint32x2",
	"sint32x3",
	"sint32x4",
	"unorm10-10-10-2",
];
export function vertexFormatIntToGPUVertexFormat(i: number): GPUVertexFormat {
	return GPU_VERTEX_FORMATS[i - 1]; // in linux.jai, we have the undefined entry at index 0
}
const GPU_PRIMITIVE_TOPOLOGIES: GPUPrimitiveTopology[] = [
	"point-list",
	"line-list",
	"line-strip",
	"triangle-list",
	"triangle-strip",
];
export function topologyIntToGPUPrimitiveTopology(
	i: number
): GPUPrimitiveTopology {
	return GPU_PRIMITIVE_TOPOLOGIES[i];
}
const GPU_INDEX_FORMATS: GPUIndexFormat[] = ["uint16", "uint32"];
export function indexFormatIntToGPUIndexFormat(i: number): GPUIndexFormat {
	return GPU_INDEX_FORMATS[i - 1]; // in linux.jai, we have the undefined entry at index 0
}

const GPU_FRONT_FACES: GPUFrontFace[] = ["ccw", "cw"];
export function frontFaceIntToGPUFrontFace(i: number): GPUFrontFace {
	return GPU_FRONT_FACES[i];
}
const GPU_CULL_MODES: GPUCullMode[] = ["none", "front", "back"];
export function cullModeIntToGPUCullMode(i: number): GPUCullMode {
	return GPU_CULL_MODES[i];
}

const GPU_TEXTURE_FORMATS: GPUTextureFormat[] = [
	"r8unorm",
	"r8snorm",
	"r8uint",
	"r8sint",
	"r16uint",
	"r16sint",
	"r16float",
	"rg8unorm",
	"rg8snorm",
	"rg8uint",
	"rg8sint",
	"r32uint",
	"r32sint",
	"r32float",
	"rg16uint",
	"rg16sint",
	"rg16float",
	"rgba8unorm",
	"rgba8unorm-srgb",
	"rgba8snorm",
	"rgba8uint",
	"rgba8sint",
	"bgra8unorm",
	"bgra8unorm-srgb",
	"rgb9e5ufloat",
	"rgb10a2uint",
	"rgb10a2unorm",
	"rg11b10ufloat",
	"rg32uint",
	"rg32sint",
	"rg32float",
	"rgba16uint",
	"rgba16sint",
	"rgba16float",
	"rgba32uint",
	"rgba32sint",
	"rgba32float",
	"stencil8",
	"depth16unorm",
	"depth24plus",
	"depth24plus-stencil8",
	"depth32float",
	"depth32float-stencil8",
	"bc1-rgba-unorm",
	"bc1-rgba-unorm-srgb",
	"bc2-rgba-unorm",
	"bc2-rgba-unorm-srgb",
	"bc3-rgba-unorm",
	"bc3-rgba-unorm-srgb",
	"bc4-r-unorm",
	"bc4-r-snorm",
	"bc5-rg-unorm",
	"bc5-rg-snorm",
	"bc6h-rgb-ufloat",
	"bc6h-rgb-float",
	"bc7-rgba-unorm",
	"bc7-rgba-unorm-srgb",
	"etc2-rgb8unorm",
	"etc2-rgb8unorm-srgb",
	"etc2-rgb8a1unorm",
	"etc2-rgb8a1unorm-srgb",
	"etc2-rgba8unorm",
	"etc2-rgba8unorm-srgb",
	"eac-r11unorm",
	"eac-r11snorm",
	"eac-rg11unorm",
	"eac-rg11snorm",
	"astc-4x4-unorm",
	"astc-4x4-unorm-srgb",
	"astc-5x4-unorm",
	"astc-5x4-unorm-srgb",
	"astc-5x5-unorm",
	"astc-5x5-unorm-srgb",
	"astc-6x5-unorm",
	"astc-6x5-unorm-srgb",
	"astc-6x6-unorm",
	"astc-6x6-unorm-srgb",
	"astc-8x5-unorm",
	"astc-8x5-unorm-srgb",
	"astc-8x6-unorm",
	"astc-8x6-unorm-srgb",
	"astc-8x8-unorm",
	"astc-8x8-unorm-srgb",
	"astc-10x5-unorm",
	"astc-10x5-unorm-srgb",
	"astc-10x6-unorm",
	"astc-10x6-unorm-srgb",
	"astc-10x8-unorm",
	"astc-10x8-unorm-srgb",
	"astc-10x10-unorm",
	"astc-10x10-unorm-srgb",
	"astc-12x10-unorm",
	"astc-12x10-unorm-srgb",
	"astc-12x12-unorm",
	"astc-12x12-unorm-srgb",
];

export function textureFormatIntToGPUTextureFormat(
	i: number
): GPUTextureFormat {
	return GPU_TEXTURE_FORMATS[i - 1]; // in linux.jai, we have the undefined entry at index 0
}
export function textureFormatIndex(format: GPUTextureFormat): number {
	return GPU_TEXTURE_FORMATS.indexOf(format) + 1; // in linux.jai, we have the undefined entry at index 0
}

const GPU_DEPTH_COMPARE_FUNCTIONS: GPUCompareFunction[] = [
	"never",
	"less",
	"equal",
	"less-equal",
	"greater",
	"not-equal",
	"greater-equal",
	"always",
];
export function compareFunctionIntToGPUCompareFunction(
	i: number
): GPUCompareFunction {
	return GPU_DEPTH_COMPARE_FUNCTIONS[i - 1]; // in linux.jai, we have the undefined entry at index 0
}

const GPU_STENCIL_OPERATIONS: GPUStencilOperation[] = [
	"keep",
	"zero",
	"replace",
	"invert",
	"increment-clamp",
	"decrement-clamp",
	"increment-wrap",
	"decrement-wrap",
];
export function stencilOperationIntToGPUStencilOperation(
	i: number
): GPUStencilOperation {
	return GPU_STENCIL_OPERATIONS[i];
}
const GPU_BLEND_OPERATION: GPUBlendOperation[] = [
	"add",
	"subtract",
	"reverse-subtract",
	"min",
	"max",
];

export function blendOperationIntToGPUBlendOperation(
	i: number
): GPUBlendOperation {
	return GPU_BLEND_OPERATION[i];
}
const GPU_BLEND_FACTORS: GPUBlendFactor[] = [
	"zero",
	"one",
	"src",
	"one-minus-src",
	"src-alpha",
	"one-minus-src-alpha",
	"dst",
	"one-minus-dst",
	"dst-alpha",
	"one-minus-dst-alpha",
	"src-alpha-saturated",
	"constant",
	"one-minus-constant",
	"src1",
	"one-minus-src1",
	"src1-alpha",
	"one-minus-src1-alpha",
];
export function blendFactorIntToGPUBlendFactor(i: number): GPUBlendFactor {
	return GPU_BLEND_FACTORS[i];
}

export const GPU_LOAD_OPS: GPULoadOp[] = ["load", "clear"];
export function loadOpIntToGPULoadOp(i: number): GPULoadOp {
	return GPU_LOAD_OPS[i - 1]; // in linux.jai, we have the undefined entry at index 0
}

export const GPU_STORE_OPS: GPUStoreOp[] = ["store", "discard"];
export function storeOpIntToGPUStoreOp(i: number): GPUStoreOp {
	return GPU_STORE_OPS[i - 1]; // in linux.jai, we have the undefined entry at index 0
}

export const GPU_TEXTURE_VIEW_DIMENSIONS: GPUTextureViewDimension[] = [
	"1d",
	"2d",
	"2d-array",
	"cube",
	"cube-array",
	"3d",
];
export function textureViewDimentionIntToGPUTextureViewDimension(
	i: number
): GPUTextureViewDimension {
	return GPU_TEXTURE_VIEW_DIMENSIONS[i - 1]; // in linux.jai, we have the undefined entry at index 0
}

export const GPU_TEXTURE_ASPECTS: GPUTextureAspect[] = [
	"all",
	"stencil-only",
	"depth-only",
];
export function textureAspectIntToGPUTextureAspect(
	i: number
): GPUTextureAspect {
	return GPU_TEXTURE_ASPECTS[i];
}

export const GPU_TEXTURE_DIMENSIONS: GPUTextureDimension[] = ["1d", "2d", "3d"];
export function textureDimensionIntToGPUTextureDimension(
	i: number
): GPUTextureDimension {
	return GPU_TEXTURE_DIMENSIONS[i];
}

export const GPU_ADDRESS_MODES: GPUAddressMode[] = [
	// note that the order here is different than the one in typescript
	"repeat",
	"mirror-repeat",
	"clamp-to-edge",
];
export function addressModeIntToGPUAddressMode(i: number): GPUAddressMode {
	return GPU_ADDRESS_MODES[i];
}

export const GPU_FILTER_MODES: GPUFilterMode[] = ["nearest", "linear"];
export function filterModeIntToGPUFilterMode(i: number): GPUFilterMode {
	return GPU_FILTER_MODES[i];
}

export const GPU_MIPMAP_FILTER_MODES: GPUMipmapFilterMode[] = [
	"nearest",
	"linear",
];
export function mipmapFilterModeIntToGPUMipmapFilterMode(
	i: number
): GPUMipmapFilterMode {
	return GPU_MIPMAP_FILTER_MODES[i];
}

export const GPU_SAMPLER_BINDING_TYPES: GPUSamplerBindingType[] = [
	"filtering",
	"non-filtering",
	"comparison",
];
export function samplerBindingTypeIntToGPUSamplerBindingType(
	i: number
): GPUSamplerBindingType {
	return GPU_SAMPLER_BINDING_TYPES[i - 1]; // in linux.jai, we have the undefined entry at index 0
}

export const GPU_TEXTURE_SAMPLE_TYPES: GPUTextureSampleType[] = [
	"float",
	"unfilterable-float",
	"depth",
	"sint",
	"uint",
];
export function textureSampleTypeIntToGPUTextureSampleType(
	i: number
): GPUTextureSampleType {
	return GPU_TEXTURE_SAMPLE_TYPES[i - 1]; // in linux.jai, we have the undefined entry at index 0
}

export const GPU_STORAGE_TEXTURE_ACCESS: GPUStorageTextureAccess[] = [
	"write-only",
	"read-only",
	"read-write",
];
export function storageTextureAccessIntToGPUStorageTextureAccess(
	i: number
): GPUStorageTextureAccess {
	return GPU_STORAGE_TEXTURE_ACCESS[i - 1]; // in linux.jai, we have the undefined entry at index 0
}
