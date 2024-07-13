//
// This file was auto-generated using the following command:
//
// jai generate.jai
//



WGPU_ARRAY_LAYER_COUNT_UNDEFINED :: 0xffffffff;
WGPU_COPY_STRIDE_UNDEFINED :: 0xffffffff;
WGPU_LIMIT_U32_UNDEFINED :: 0xffffffff;
WGPU_LIMIT_U64_UNDEFINED :: 0xffffffffffffffff;
WGPU_MIP_LEVEL_COUNT_UNDEFINED :: 0xffffffff;
WGPU_QUERY_SET_INDEX_UNDEFINED :: 0xffffffff;

WGPU_WHOLE_SIZE :: 0xffffffffffffffff;

Flags :: u32;
Bool :: u32;

AdapterImpl :: struct {}
Adapter :: *AdapterImpl;
BindGroupImpl :: struct {}
BindGroup :: *BindGroupImpl;
BindGroupLayoutImpl :: struct {}
BindGroupLayout :: *BindGroupLayoutImpl;
BufferImpl :: struct {}
Buffer :: *BufferImpl;
CommandBufferImpl :: struct {}
CommandBuffer :: *CommandBufferImpl;
CommandEncoderImpl :: struct {}
CommandEncoder :: *CommandEncoderImpl;
ComputePassEncoderImpl :: struct {}
ComputePassEncoder :: *ComputePassEncoderImpl;
ComputePipelineImpl :: struct {}
ComputePipeline :: *ComputePipelineImpl;
DeviceImpl :: struct {}
Device :: *DeviceImpl;
InstanceImpl :: struct {}
Instance :: *InstanceImpl;
PipelineLayoutImpl :: struct {}
PipelineLayout :: *PipelineLayoutImpl;
QuerySetImpl :: struct {}
QuerySet :: *QuerySetImpl;
QueueImpl :: struct {}
Queue :: *QueueImpl;
RenderBundleImpl :: struct {}
RenderBundle :: *RenderBundleImpl;
RenderBundleEncoderImpl :: struct {}
RenderBundleEncoder :: *RenderBundleEncoderImpl;
RenderPassEncoderImpl :: struct {}
RenderPassEncoder :: *RenderPassEncoderImpl;
RenderPipelineImpl :: struct {}
RenderPipeline :: *RenderPipelineImpl;
SamplerImpl :: struct {}
Sampler :: *SamplerImpl;
ShaderModuleImpl :: struct {}
ShaderModule :: *ShaderModuleImpl;
SurfaceImpl :: struct {}
Surface :: *SurfaceImpl;
TextureImpl :: struct {}
Texture :: *TextureImpl;
TextureViewImpl :: struct {}
TextureView :: *TextureViewImpl;

AdapterType :: enum u32 {
    DiscreteGPU   :: 0;
    IntegratedGPU :: 1;
    CPU           :: 2;
    Unknown       :: 3;
    Force32       :: 2147483647;

    WGPUAdapterType_DiscreteGPU   :: DiscreteGPU;
    WGPUAdapterType_IntegratedGPU :: IntegratedGPU;
    WGPUAdapterType_CPU           :: CPU;
    WGPUAdapterType_Unknown       :: Unknown;
    WGPUAdapterType_Force32       :: Force32;
}

AddressMode :: enum u32 {
    Repeat       :: 0;
    MirrorRepeat :: 1;
    ClampToEdge  :: 2;
    Force32      :: 2147483647;

    WGPUAddressMode_Repeat       :: Repeat;
    WGPUAddressMode_MirrorRepeat :: MirrorRepeat;
    WGPUAddressMode_ClampToEdge  :: ClampToEdge;
    WGPUAddressMode_Force32      :: Force32;
}

BackendType :: enum u32 {
    Undefined :: 0;
    Null      :: 1;
    WebGPU    :: 2;
    D3D11     :: 3;
    D3D12     :: 4;
    Metal     :: 5;
    Vulkan    :: 6;
    OpenGL    :: 7;
    OpenGLES  :: 8;
    Force32   :: 2147483647;

    WGPUBackendType_Undefined :: Undefined;
    WGPUBackendType_Null      :: Null;
    WGPUBackendType_WebGPU    :: WebGPU;
    WGPUBackendType_D3D11     :: D3D11;
    WGPUBackendType_D3D12     :: D3D12;
    WGPUBackendType_Metal     :: Metal;
    WGPUBackendType_Vulkan    :: Vulkan;
    WGPUBackendType_OpenGL    :: OpenGL;
    WGPUBackendType_OpenGLES  :: OpenGLES;
    WGPUBackendType_Force32   :: Force32;
}

BlendFactor :: enum u32 {
    Zero              :: 0;
    One               :: 1;
    Src               :: 2;
    OneMinusSrc       :: 3;
    SrcAlpha          :: 4;
    OneMinusSrcAlpha  :: 5;
    Dst               :: 6;
    OneMinusDst       :: 7;
    DstAlpha          :: 8;
    OneMinusDstAlpha  :: 9;
    SrcAlphaSaturated :: 10;
    Constant          :: 11;
    OneMinusConstant  :: 12;
    Force32           :: 2147483647;

    WGPUBlendFactor_Zero              :: Zero;
    WGPUBlendFactor_One               :: One;
    WGPUBlendFactor_Src               :: Src;
    WGPUBlendFactor_OneMinusSrc       :: OneMinusSrc;
    WGPUBlendFactor_SrcAlpha          :: SrcAlpha;
    WGPUBlendFactor_OneMinusSrcAlpha  :: OneMinusSrcAlpha;
    WGPUBlendFactor_Dst               :: Dst;
    WGPUBlendFactor_OneMinusDst       :: OneMinusDst;
    WGPUBlendFactor_DstAlpha          :: DstAlpha;
    WGPUBlendFactor_OneMinusDstAlpha  :: OneMinusDstAlpha;
    WGPUBlendFactor_SrcAlphaSaturated :: SrcAlphaSaturated;
    WGPUBlendFactor_Constant          :: Constant;
    WGPUBlendFactor_OneMinusConstant  :: OneMinusConstant;
    WGPUBlendFactor_Force32           :: Force32;
}

BlendOperation :: enum u32 {
    Add             :: 0;
    Subtract        :: 1;
    ReverseSubtract :: 2;
    Min             :: 3;
    Max             :: 4;
    Force32         :: 2147483647;

    WGPUBlendOperation_Add             :: Add;
    WGPUBlendOperation_Subtract        :: Subtract;
    WGPUBlendOperation_ReverseSubtract :: ReverseSubtract;
    WGPUBlendOperation_Min             :: Min;
    WGPUBlendOperation_Max             :: Max;
    WGPUBlendOperation_Force32         :: Force32;
}

BufferBindingType :: enum u32 {
    Undefined       :: 0;
    Uniform         :: 1;
    Storage         :: 2;
    ReadOnlyStorage :: 3;
    Force32         :: 2147483647;

    WGPUBufferBindingType_Undefined       :: Undefined;
    WGPUBufferBindingType_Uniform         :: Uniform;
    WGPUBufferBindingType_Storage         :: Storage;
    WGPUBufferBindingType_ReadOnlyStorage :: ReadOnlyStorage;
    WGPUBufferBindingType_Force32         :: Force32;
}

BufferMapAsyncStatus :: enum u32 {
    Success                 :: 0;
    ValidationError         :: 1;
    Unknown                 :: 2;
    DeviceLost              :: 3;
    DestroyedBeforeCallback :: 4;
    UnmappedBeforeCallback  :: 5;
    MappingAlreadyPending   :: 6;
    OffsetOutOfRange        :: 7;
    SizeOutOfRange          :: 8;
    Force32                 :: 2147483647;

    WGPUBufferMapAsyncStatus_Success                 :: Success;
    WGPUBufferMapAsyncStatus_ValidationError         :: ValidationError;
    WGPUBufferMapAsyncStatus_Unknown                 :: Unknown;
    WGPUBufferMapAsyncStatus_DeviceLost              :: DeviceLost;
    WGPUBufferMapAsyncStatus_DestroyedBeforeCallback :: DestroyedBeforeCallback;
    WGPUBufferMapAsyncStatus_UnmappedBeforeCallback  :: UnmappedBeforeCallback;
    WGPUBufferMapAsyncStatus_MappingAlreadyPending   :: MappingAlreadyPending;
    WGPUBufferMapAsyncStatus_OffsetOutOfRange        :: OffsetOutOfRange;
    WGPUBufferMapAsyncStatus_SizeOutOfRange          :: SizeOutOfRange;
    WGPUBufferMapAsyncStatus_Force32                 :: Force32;
}

BufferMapState :: enum u32 {
    Unmapped :: 0;
    Pending  :: 1;
    Mapped   :: 2;
    Force32  :: 2147483647;

    WGPUBufferMapState_Unmapped :: Unmapped;
    WGPUBufferMapState_Pending  :: Pending;
    WGPUBufferMapState_Mapped   :: Mapped;
    WGPUBufferMapState_Force32  :: Force32;
}

CompareFunction :: enum u32 {
    Undefined    :: 0;
    Never        :: 1;
    Less         :: 2;
    LessEqual    :: 3;
    Greater      :: 4;
    GreaterEqual :: 5;
    Equal        :: 6;
    NotEqual     :: 7;
    Always       :: 8;
    Force32      :: 2147483647;

    WGPUCompareFunction_Undefined    :: Undefined;
    WGPUCompareFunction_Never        :: Never;
    WGPUCompareFunction_Less         :: Less;
    WGPUCompareFunction_LessEqual    :: LessEqual;
    WGPUCompareFunction_Greater      :: Greater;
    WGPUCompareFunction_GreaterEqual :: GreaterEqual;
    WGPUCompareFunction_Equal        :: Equal;
    WGPUCompareFunction_NotEqual     :: NotEqual;
    WGPUCompareFunction_Always       :: Always;
    WGPUCompareFunction_Force32      :: Force32;
}

CompilationInfoRequestStatus :: enum u32 {
    Success    :: 0;
    Error      :: 1;
    DeviceLost :: 2;
    Unknown    :: 3;
    Force32    :: 2147483647;

    WGPUCompilationInfoRequestStatus_Success    :: Success;
    WGPUCompilationInfoRequestStatus_Error      :: Error;
    WGPUCompilationInfoRequestStatus_DeviceLost :: DeviceLost;
    WGPUCompilationInfoRequestStatus_Unknown    :: Unknown;
    WGPUCompilationInfoRequestStatus_Force32    :: Force32;
}

CompilationMessageType :: enum u32 {
    Error   :: 0;
    Warning :: 1;
    Info    :: 2;
    Force32 :: 2147483647;

    WGPUCompilationMessageType_Error   :: Error;
    WGPUCompilationMessageType_Warning :: Warning;
    WGPUCompilationMessageType_Info    :: Info;
    WGPUCompilationMessageType_Force32 :: Force32;
}

CompositeAlphaMode :: enum u32 {
    Auto            :: 0;
    Opaque          :: 1;
    Premultiplied   :: 2;
    Unpremultiplied :: 3;
    Inherit         :: 4;
    Force32         :: 2147483647;

    WGPUCompositeAlphaMode_Auto            :: Auto;
    WGPUCompositeAlphaMode_Opaque          :: Opaque;
    WGPUCompositeAlphaMode_Premultiplied   :: Premultiplied;
    WGPUCompositeAlphaMode_Unpremultiplied :: Unpremultiplied;
    WGPUCompositeAlphaMode_Inherit         :: Inherit;
    WGPUCompositeAlphaMode_Force32         :: Force32;
}

CreatePipelineAsyncStatus :: enum u32 {
    Success         :: 0;
    ValidationError :: 1;
    InternalError   :: 2;
    DeviceLost      :: 3;
    DeviceDestroyed :: 4;
    Unknown         :: 5;
    Force32         :: 2147483647;

    WGPUCreatePipelineAsyncStatus_Success         :: Success;
    WGPUCreatePipelineAsyncStatus_ValidationError :: ValidationError;
    WGPUCreatePipelineAsyncStatus_InternalError   :: InternalError;
    WGPUCreatePipelineAsyncStatus_DeviceLost      :: DeviceLost;
    WGPUCreatePipelineAsyncStatus_DeviceDestroyed :: DeviceDestroyed;
    WGPUCreatePipelineAsyncStatus_Unknown         :: Unknown;
    WGPUCreatePipelineAsyncStatus_Force32         :: Force32;
}

CullMode :: enum u32 {
    None    :: 0;
    Front   :: 1;
    Back    :: 2;
    Force32 :: 2147483647;

    WGPUCullMode_None    :: None;
    WGPUCullMode_Front   :: Front;
    WGPUCullMode_Back    :: Back;
    WGPUCullMode_Force32 :: Force32;
}

DeviceLostReason :: enum u32 {
    Undefined :: 0;
    Destroyed :: 1;
    Force32   :: 2147483647;

    WGPUDeviceLostReason_Undefined :: Undefined;
    WGPUDeviceLostReason_Destroyed :: Destroyed;
    WGPUDeviceLostReason_Force32   :: Force32;
}

ErrorFilter :: enum u32 {
    Validation  :: 0;
    OutOfMemory :: 1;
    Internal    :: 2;
    Force32     :: 2147483647;

    WGPUErrorFilter_Validation  :: Validation;
    WGPUErrorFilter_OutOfMemory :: OutOfMemory;
    WGPUErrorFilter_Internal    :: Internal;
    WGPUErrorFilter_Force32     :: Force32;
}

ErrorType :: enum u32 {
    NoError     :: 0;
    Validation  :: 1;
    OutOfMemory :: 2;
    Internal    :: 3;
    Unknown     :: 4;
    DeviceLost  :: 5;
    Force32     :: 2147483647;

    WGPUErrorType_NoError     :: NoError;
    WGPUErrorType_Validation  :: Validation;
    WGPUErrorType_OutOfMemory :: OutOfMemory;
    WGPUErrorType_Internal    :: Internal;
    WGPUErrorType_Unknown     :: Unknown;
    WGPUErrorType_DeviceLost  :: DeviceLost;
    WGPUErrorType_Force32     :: Force32;
}

FeatureName :: enum u32 {
    Undefined               :: 0;
    DepthClipControl        :: 1;
    Depth32FloatStencil8    :: 2;
    TimestampQuery          :: 3;
    TextureCompressionBC    :: 4;
    TextureCompressionETC2  :: 5;
    TextureCompressionASTC  :: 6;
    IndirectFirstInstance   :: 7;
    ShaderF16               :: 8;
    RG11B10UfloatRenderable :: 9;
    BGRA8UnormStorage       :: 10;
    Float32Filterable       :: 11;
    Force32                 :: 2147483647;

    WGPUFeatureName_Undefined               :: Undefined;
    WGPUFeatureName_DepthClipControl        :: DepthClipControl;
    WGPUFeatureName_Depth32FloatStencil8    :: Depth32FloatStencil8;
    WGPUFeatureName_TimestampQuery          :: TimestampQuery;
    WGPUFeatureName_TextureCompressionBC    :: TextureCompressionBC;
    WGPUFeatureName_TextureCompressionETC2  :: TextureCompressionETC2;
    WGPUFeatureName_TextureCompressionASTC  :: TextureCompressionASTC;
    WGPUFeatureName_IndirectFirstInstance   :: IndirectFirstInstance;
    WGPUFeatureName_ShaderF16               :: ShaderF16;
    WGPUFeatureName_RG11B10UfloatRenderable :: RG11B10UfloatRenderable;
    WGPUFeatureName_BGRA8UnormStorage       :: BGRA8UnormStorage;
    WGPUFeatureName_Float32Filterable       :: Float32Filterable;
    WGPUFeatureName_Force32                 :: Force32;
}

FilterMode :: enum u32 {
    Nearest :: 0;
    Linear  :: 1;
    Force32 :: 2147483647;

    WGPUFilterMode_Nearest :: Nearest;
    WGPUFilterMode_Linear  :: Linear;
    WGPUFilterMode_Force32 :: Force32;
}

FrontFace :: enum u32 {
    CCW     :: 0;
    CW      :: 1;
    Force32 :: 2147483647;

    WGPUFrontFace_CCW     :: CCW;
    WGPUFrontFace_CW      :: CW;
    WGPUFrontFace_Force32 :: Force32;
}

IndexFormat :: enum u32 {
    Undefined :: 0;
    Uint16    :: 1;
    Uint32    :: 2;
    Force32   :: 2147483647;

    WGPUIndexFormat_Undefined :: Undefined;
    WGPUIndexFormat_Uint16    :: Uint16;
    WGPUIndexFormat_Uint32    :: Uint32;
    WGPUIndexFormat_Force32   :: Force32;
}

LoadOp :: enum u32 {
    Undefined :: 0;
    Clear     :: 1;
    Load      :: 2;
    Force32   :: 2147483647;

    WGPULoadOp_Undefined :: Undefined;
    WGPULoadOp_Clear     :: Clear;
    WGPULoadOp_Load      :: Load;
    WGPULoadOp_Force32   :: Force32;
}

MipmapFilterMode :: enum u32 {
    Nearest :: 0;
    Linear  :: 1;
    Force32 :: 2147483647;

    WGPUMipmapFilterMode_Nearest :: Nearest;
    WGPUMipmapFilterMode_Linear  :: Linear;
    WGPUMipmapFilterMode_Force32 :: Force32;
}

PowerPreference :: enum u32 {
    Undefined       :: 0;
    LowPower        :: 1;
    HighPerformance :: 2;
    Force32         :: 2147483647;

    WGPUPowerPreference_Undefined       :: Undefined;
    WGPUPowerPreference_LowPower        :: LowPower;
    WGPUPowerPreference_HighPerformance :: HighPerformance;
    WGPUPowerPreference_Force32         :: Force32;
}

PresentMode :: enum u32 {
    Fifo        :: 0;
    FifoRelaxed :: 1;
    Immediate   :: 2;
    Mailbox     :: 3;
    Force32     :: 2147483647;

    WGPUPresentMode_Fifo        :: Fifo;
    WGPUPresentMode_FifoRelaxed :: FifoRelaxed;
    WGPUPresentMode_Immediate   :: Immediate;
    WGPUPresentMode_Mailbox     :: Mailbox;
    WGPUPresentMode_Force32     :: Force32;
}

PrimitiveTopology :: enum u32 {
    PointList     :: 0;
    LineList      :: 1;
    LineStrip     :: 2;
    TriangleList  :: 3;
    TriangleStrip :: 4;
    Force32       :: 2147483647;

    WGPUPrimitiveTopology_PointList     :: PointList;
    WGPUPrimitiveTopology_LineList      :: LineList;
    WGPUPrimitiveTopology_LineStrip     :: LineStrip;
    WGPUPrimitiveTopology_TriangleList  :: TriangleList;
    WGPUPrimitiveTopology_TriangleStrip :: TriangleStrip;
    WGPUPrimitiveTopology_Force32       :: Force32;
}

QueryType :: enum u32 {
    Occlusion :: 0;
    Timestamp :: 1;
    Force32   :: 2147483647;

    WGPUQueryType_Occlusion :: Occlusion;
    WGPUQueryType_Timestamp :: Timestamp;
    WGPUQueryType_Force32   :: Force32;
}

QueueWorkDoneStatus :: enum u32 {
    Success    :: 0;
    Error      :: 1;
    Unknown    :: 2;
    DeviceLost :: 3;
    Force32    :: 2147483647;

    WGPUQueueWorkDoneStatus_Success    :: Success;
    WGPUQueueWorkDoneStatus_Error      :: Error;
    WGPUQueueWorkDoneStatus_Unknown    :: Unknown;
    WGPUQueueWorkDoneStatus_DeviceLost :: DeviceLost;
    WGPUQueueWorkDoneStatus_Force32    :: Force32;
}

RequestAdapterStatus :: enum u32 {
    Success     :: 0;
    Unavailable :: 1;
    Error       :: 2;
    Unknown     :: 3;
    Force32     :: 2147483647;

    WGPURequestAdapterStatus_Success     :: Success;
    WGPURequestAdapterStatus_Unavailable :: Unavailable;
    WGPURequestAdapterStatus_Error       :: Error;
    WGPURequestAdapterStatus_Unknown     :: Unknown;
    WGPURequestAdapterStatus_Force32     :: Force32;
}

RequestDeviceStatus :: enum u32 {
    Success :: 0;
    Error   :: 1;
    Unknown :: 2;
    Force32 :: 2147483647;

    WGPURequestDeviceStatus_Success :: Success;
    WGPURequestDeviceStatus_Error   :: Error;
    WGPURequestDeviceStatus_Unknown :: Unknown;
    WGPURequestDeviceStatus_Force32 :: Force32;
}

SType :: enum u32 {
    Invalid                                  :: 0;
    SurfaceDescriptorFromMetalLayer          :: 1;
    SurfaceDescriptorFromWindowsHWND         :: 2;
    SurfaceDescriptorFromXlibWindow          :: 3;
    SurfaceDescriptorFromCanvasHTMLSelector  :: 4;
    ShaderModuleSPIRVDescriptor              :: 5;
    ShaderModuleWGSLDescriptor               :: 6;
    PrimitiveDepthClipControl                :: 7;
    SurfaceDescriptorFromWaylandSurface      :: 8;
    SurfaceDescriptorFromAndroidNativeWindow :: 9;
    SurfaceDescriptorFromXcbWindow           :: 10;
    RenderPassDescriptorMaxDrawCount         :: 15;
    Force32                                  :: 2147483647;

    WGPUSType_Invalid                                  :: Invalid;
    WGPUSType_SurfaceDescriptorFromMetalLayer          :: SurfaceDescriptorFromMetalLayer;
    WGPUSType_SurfaceDescriptorFromWindowsHWND         :: SurfaceDescriptorFromWindowsHWND;
    WGPUSType_SurfaceDescriptorFromXlibWindow          :: SurfaceDescriptorFromXlibWindow;
    WGPUSType_SurfaceDescriptorFromCanvasHTMLSelector  :: SurfaceDescriptorFromCanvasHTMLSelector;
    WGPUSType_ShaderModuleSPIRVDescriptor              :: ShaderModuleSPIRVDescriptor;
    WGPUSType_ShaderModuleWGSLDescriptor               :: ShaderModuleWGSLDescriptor;
    WGPUSType_PrimitiveDepthClipControl                :: PrimitiveDepthClipControl;
    WGPUSType_SurfaceDescriptorFromWaylandSurface      :: SurfaceDescriptorFromWaylandSurface;
    WGPUSType_SurfaceDescriptorFromAndroidNativeWindow :: SurfaceDescriptorFromAndroidNativeWindow;
    WGPUSType_SurfaceDescriptorFromXcbWindow           :: SurfaceDescriptorFromXcbWindow;
    WGPUSType_RenderPassDescriptorMaxDrawCount         :: RenderPassDescriptorMaxDrawCount;
    WGPUSType_Force32                                  :: Force32;
}

SamplerBindingType :: enum u32 {
    Undefined    :: 0;
    Filtering    :: 1;
    NonFiltering :: 2;
    Comparison   :: 3;
    Force32      :: 2147483647;

    WGPUSamplerBindingType_Undefined    :: Undefined;
    WGPUSamplerBindingType_Filtering    :: Filtering;
    WGPUSamplerBindingType_NonFiltering :: NonFiltering;
    WGPUSamplerBindingType_Comparison   :: Comparison;
    WGPUSamplerBindingType_Force32      :: Force32;
}

StencilOperation :: enum u32 {
    Keep           :: 0;
    Zero           :: 1;
    Replace        :: 2;
    Invert         :: 3;
    IncrementClamp :: 4;
    DecrementClamp :: 5;
    IncrementWrap  :: 6;
    DecrementWrap  :: 7;
    Force32        :: 2147483647;

    WGPUStencilOperation_Keep           :: Keep;
    WGPUStencilOperation_Zero           :: Zero;
    WGPUStencilOperation_Replace        :: Replace;
    WGPUStencilOperation_Invert         :: Invert;
    WGPUStencilOperation_IncrementClamp :: IncrementClamp;
    WGPUStencilOperation_DecrementClamp :: DecrementClamp;
    WGPUStencilOperation_IncrementWrap  :: IncrementWrap;
    WGPUStencilOperation_DecrementWrap  :: DecrementWrap;
    WGPUStencilOperation_Force32        :: Force32;
}

StorageTextureAccess :: enum u32 {
    Undefined :: 0;
    WriteOnly :: 1;
    ReadOnly  :: 2;
    ReadWrite :: 3;
    Force32   :: 2147483647;

    WGPUStorageTextureAccess_Undefined :: Undefined;
    WGPUStorageTextureAccess_WriteOnly :: WriteOnly;
    WGPUStorageTextureAccess_ReadOnly  :: ReadOnly;
    WGPUStorageTextureAccess_ReadWrite :: ReadWrite;
    WGPUStorageTextureAccess_Force32   :: Force32;
}

StoreOp :: enum u32 {
    Undefined :: 0;
    Store     :: 1;
    Discard   :: 2;
    Force32   :: 2147483647;

    WGPUStoreOp_Undefined :: Undefined;
    WGPUStoreOp_Store     :: Store;
    WGPUStoreOp_Discard   :: Discard;
    WGPUStoreOp_Force32   :: Force32;
}

SurfaceGetCurrentTextureStatus :: enum u32 {
    Success     :: 0;
    Timeout     :: 1;
    Outdated    :: 2;
    Lost        :: 3;
    OutOfMemory :: 4;
    DeviceLost  :: 5;
    Force32     :: 2147483647;

    WGPUSurfaceGetCurrentTextureStatus_Success     :: Success;
    WGPUSurfaceGetCurrentTextureStatus_Timeout     :: Timeout;
    WGPUSurfaceGetCurrentTextureStatus_Outdated    :: Outdated;
    WGPUSurfaceGetCurrentTextureStatus_Lost        :: Lost;
    WGPUSurfaceGetCurrentTextureStatus_OutOfMemory :: OutOfMemory;
    WGPUSurfaceGetCurrentTextureStatus_DeviceLost  :: DeviceLost;
    WGPUSurfaceGetCurrentTextureStatus_Force32     :: Force32;
}

TextureAspect :: enum u32 {
    All         :: 0;
    StencilOnly :: 1;
    DepthOnly   :: 2;
    Force32     :: 2147483647;

    WGPUTextureAspect_All         :: All;
    WGPUTextureAspect_StencilOnly :: StencilOnly;
    WGPUTextureAspect_DepthOnly   :: DepthOnly;
    WGPUTextureAspect_Force32     :: Force32;
}

TextureDimension :: enum u32 {
    _1D     :: 0;
    _2D     :: 1;
    _3D     :: 2;
    Force32 :: 2147483647;

    WGPUTextureDimension_1D      :: _1D;
    WGPUTextureDimension_2D      :: _2D;
    WGPUTextureDimension_3D      :: _3D;
    WGPUTextureDimension_Force32 :: Force32;
}

TextureFormat :: enum u32 {
    Undefined            :: 0;
    R8Unorm              :: 1;
    R8Snorm              :: 2;
    R8Uint               :: 3;
    R8Sint               :: 4;
    R16Uint              :: 5;
    R16Sint              :: 6;
    R16Float             :: 7;
    RG8Unorm             :: 8;
    RG8Snorm             :: 9;
    RG8Uint              :: 10;
    RG8Sint              :: 11;
    R32Float             :: 12;
    R32Uint              :: 13;
    R32Sint              :: 14;
    RG16Uint             :: 15;
    RG16Sint             :: 16;
    RG16Float            :: 17;
    RGBA8Unorm           :: 18;
    RGBA8UnormSrgb       :: 19;
    RGBA8Snorm           :: 20;
    RGBA8Uint            :: 21;
    RGBA8Sint            :: 22;
    BGRA8Unorm           :: 23;
    BGRA8UnormSrgb       :: 24;
    RGB10A2Uint          :: 25;
    RGB10A2Unorm         :: 26;
    RG11B10Ufloat        :: 27;
    RGB9E5Ufloat         :: 28;
    RG32Float            :: 29;
    RG32Uint             :: 30;
    RG32Sint             :: 31;
    RGBA16Uint           :: 32;
    RGBA16Sint           :: 33;
    RGBA16Float          :: 34;
    RGBA32Float          :: 35;
    RGBA32Uint           :: 36;
    RGBA32Sint           :: 37;
    Stencil8             :: 38;
    Depth16Unorm         :: 39;
    Depth24Plus          :: 40;
    Depth24PlusStencil8  :: 41;
    Depth32Float         :: 42;
    Depth32FloatStencil8 :: 43;
    BC1RGBAUnorm         :: 44;
    BC1RGBAUnormSrgb     :: 45;
    BC2RGBAUnorm         :: 46;
    BC2RGBAUnormSrgb     :: 47;
    BC3RGBAUnorm         :: 48;
    BC3RGBAUnormSrgb     :: 49;
    BC4RUnorm            :: 50;
    BC4RSnorm            :: 51;
    BC5RGUnorm           :: 52;
    BC5RGSnorm           :: 53;
    BC6HRGBUfloat        :: 54;
    BC6HRGBFloat         :: 55;
    BC7RGBAUnorm         :: 56;
    BC7RGBAUnormSrgb     :: 57;
    ETC2RGB8Unorm        :: 58;
    ETC2RGB8UnormSrgb    :: 59;
    ETC2RGB8A1Unorm      :: 60;
    ETC2RGB8A1UnormSrgb  :: 61;
    ETC2RGBA8Unorm       :: 62;
    ETC2RGBA8UnormSrgb   :: 63;
    EACR11Unorm          :: 64;
    EACR11Snorm          :: 65;
    EACRG11Unorm         :: 66;
    EACRG11Snorm         :: 67;
    ASTC4x4Unorm         :: 68;
    ASTC4x4UnormSrgb     :: 69;
    ASTC5x4Unorm         :: 70;
    ASTC5x4UnormSrgb     :: 71;
    ASTC5x5Unorm         :: 72;
    ASTC5x5UnormSrgb     :: 73;
    ASTC6x5Unorm         :: 74;
    ASTC6x5UnormSrgb     :: 75;
    ASTC6x6Unorm         :: 76;
    ASTC6x6UnormSrgb     :: 77;
    ASTC8x5Unorm         :: 78;
    ASTC8x5UnormSrgb     :: 79;
    ASTC8x6Unorm         :: 80;
    ASTC8x6UnormSrgb     :: 81;
    ASTC8x8Unorm         :: 82;
    ASTC8x8UnormSrgb     :: 83;
    ASTC10x5Unorm        :: 84;
    ASTC10x5UnormSrgb    :: 85;
    ASTC10x6Unorm        :: 86;
    ASTC10x6UnormSrgb    :: 87;
    ASTC10x8Unorm        :: 88;
    ASTC10x8UnormSrgb    :: 89;
    ASTC10x10Unorm       :: 90;
    ASTC10x10UnormSrgb   :: 91;
    ASTC12x10Unorm       :: 92;
    ASTC12x10UnormSrgb   :: 93;
    ASTC12x12Unorm       :: 94;
    ASTC12x12UnormSrgb   :: 95;
    Force32              :: 2147483647;

    WGPUTextureFormat_Undefined            :: Undefined;
    WGPUTextureFormat_R8Unorm              :: R8Unorm;
    WGPUTextureFormat_R8Snorm              :: R8Snorm;
    WGPUTextureFormat_R8Uint               :: R8Uint;
    WGPUTextureFormat_R8Sint               :: R8Sint;
    WGPUTextureFormat_R16Uint              :: R16Uint;
    WGPUTextureFormat_R16Sint              :: R16Sint;
    WGPUTextureFormat_R16Float             :: R16Float;
    WGPUTextureFormat_RG8Unorm             :: RG8Unorm;
    WGPUTextureFormat_RG8Snorm             :: RG8Snorm;
    WGPUTextureFormat_RG8Uint              :: RG8Uint;
    WGPUTextureFormat_RG8Sint              :: RG8Sint;
    WGPUTextureFormat_R32Float             :: R32Float;
    WGPUTextureFormat_R32Uint              :: R32Uint;
    WGPUTextureFormat_R32Sint              :: R32Sint;
    WGPUTextureFormat_RG16Uint             :: RG16Uint;
    WGPUTextureFormat_RG16Sint             :: RG16Sint;
    WGPUTextureFormat_RG16Float            :: RG16Float;
    WGPUTextureFormat_RGBA8Unorm           :: RGBA8Unorm;
    WGPUTextureFormat_RGBA8UnormSrgb       :: RGBA8UnormSrgb;
    WGPUTextureFormat_RGBA8Snorm           :: RGBA8Snorm;
    WGPUTextureFormat_RGBA8Uint            :: RGBA8Uint;
    WGPUTextureFormat_RGBA8Sint            :: RGBA8Sint;
    WGPUTextureFormat_BGRA8Unorm           :: BGRA8Unorm;
    WGPUTextureFormat_BGRA8UnormSrgb       :: BGRA8UnormSrgb;
    WGPUTextureFormat_RGB10A2Uint          :: RGB10A2Uint;
    WGPUTextureFormat_RGB10A2Unorm         :: RGB10A2Unorm;
    WGPUTextureFormat_RG11B10Ufloat        :: RG11B10Ufloat;
    WGPUTextureFormat_RGB9E5Ufloat         :: RGB9E5Ufloat;
    WGPUTextureFormat_RG32Float            :: RG32Float;
    WGPUTextureFormat_RG32Uint             :: RG32Uint;
    WGPUTextureFormat_RG32Sint             :: RG32Sint;
    WGPUTextureFormat_RGBA16Uint           :: RGBA16Uint;
    WGPUTextureFormat_RGBA16Sint           :: RGBA16Sint;
    WGPUTextureFormat_RGBA16Float          :: RGBA16Float;
    WGPUTextureFormat_RGBA32Float          :: RGBA32Float;
    WGPUTextureFormat_RGBA32Uint           :: RGBA32Uint;
    WGPUTextureFormat_RGBA32Sint           :: RGBA32Sint;
    WGPUTextureFormat_Stencil8             :: Stencil8;
    WGPUTextureFormat_Depth16Unorm         :: Depth16Unorm;
    WGPUTextureFormat_Depth24Plus          :: Depth24Plus;
    WGPUTextureFormat_Depth24PlusStencil8  :: Depth24PlusStencil8;
    WGPUTextureFormat_Depth32Float         :: Depth32Float;
    WGPUTextureFormat_Depth32FloatStencil8 :: Depth32FloatStencil8;
    WGPUTextureFormat_BC1RGBAUnorm         :: BC1RGBAUnorm;
    WGPUTextureFormat_BC1RGBAUnormSrgb     :: BC1RGBAUnormSrgb;
    WGPUTextureFormat_BC2RGBAUnorm         :: BC2RGBAUnorm;
    WGPUTextureFormat_BC2RGBAUnormSrgb     :: BC2RGBAUnormSrgb;
    WGPUTextureFormat_BC3RGBAUnorm         :: BC3RGBAUnorm;
    WGPUTextureFormat_BC3RGBAUnormSrgb     :: BC3RGBAUnormSrgb;
    WGPUTextureFormat_BC4RUnorm            :: BC4RUnorm;
    WGPUTextureFormat_BC4RSnorm            :: BC4RSnorm;
    WGPUTextureFormat_BC5RGUnorm           :: BC5RGUnorm;
    WGPUTextureFormat_BC5RGSnorm           :: BC5RGSnorm;
    WGPUTextureFormat_BC6HRGBUfloat        :: BC6HRGBUfloat;
    WGPUTextureFormat_BC6HRGBFloat         :: BC6HRGBFloat;
    WGPUTextureFormat_BC7RGBAUnorm         :: BC7RGBAUnorm;
    WGPUTextureFormat_BC7RGBAUnormSrgb     :: BC7RGBAUnormSrgb;
    WGPUTextureFormat_ETC2RGB8Unorm        :: ETC2RGB8Unorm;
    WGPUTextureFormat_ETC2RGB8UnormSrgb    :: ETC2RGB8UnormSrgb;
    WGPUTextureFormat_ETC2RGB8A1Unorm      :: ETC2RGB8A1Unorm;
    WGPUTextureFormat_ETC2RGB8A1UnormSrgb  :: ETC2RGB8A1UnormSrgb;
    WGPUTextureFormat_ETC2RGBA8Unorm       :: ETC2RGBA8Unorm;
    WGPUTextureFormat_ETC2RGBA8UnormSrgb   :: ETC2RGBA8UnormSrgb;
    WGPUTextureFormat_EACR11Unorm          :: EACR11Unorm;
    WGPUTextureFormat_EACR11Snorm          :: EACR11Snorm;
    WGPUTextureFormat_EACRG11Unorm         :: EACRG11Unorm;
    WGPUTextureFormat_EACRG11Snorm         :: EACRG11Snorm;
    WGPUTextureFormat_ASTC4x4Unorm         :: ASTC4x4Unorm;
    WGPUTextureFormat_ASTC4x4UnormSrgb     :: ASTC4x4UnormSrgb;
    WGPUTextureFormat_ASTC5x4Unorm         :: ASTC5x4Unorm;
    WGPUTextureFormat_ASTC5x4UnormSrgb     :: ASTC5x4UnormSrgb;
    WGPUTextureFormat_ASTC5x5Unorm         :: ASTC5x5Unorm;
    WGPUTextureFormat_ASTC5x5UnormSrgb     :: ASTC5x5UnormSrgb;
    WGPUTextureFormat_ASTC6x5Unorm         :: ASTC6x5Unorm;
    WGPUTextureFormat_ASTC6x5UnormSrgb     :: ASTC6x5UnormSrgb;
    WGPUTextureFormat_ASTC6x6Unorm         :: ASTC6x6Unorm;
    WGPUTextureFormat_ASTC6x6UnormSrgb     :: ASTC6x6UnormSrgb;
    WGPUTextureFormat_ASTC8x5Unorm         :: ASTC8x5Unorm;
    WGPUTextureFormat_ASTC8x5UnormSrgb     :: ASTC8x5UnormSrgb;
    WGPUTextureFormat_ASTC8x6Unorm         :: ASTC8x6Unorm;
    WGPUTextureFormat_ASTC8x6UnormSrgb     :: ASTC8x6UnormSrgb;
    WGPUTextureFormat_ASTC8x8Unorm         :: ASTC8x8Unorm;
    WGPUTextureFormat_ASTC8x8UnormSrgb     :: ASTC8x8UnormSrgb;
    WGPUTextureFormat_ASTC10x5Unorm        :: ASTC10x5Unorm;
    WGPUTextureFormat_ASTC10x5UnormSrgb    :: ASTC10x5UnormSrgb;
    WGPUTextureFormat_ASTC10x6Unorm        :: ASTC10x6Unorm;
    WGPUTextureFormat_ASTC10x6UnormSrgb    :: ASTC10x6UnormSrgb;
    WGPUTextureFormat_ASTC10x8Unorm        :: ASTC10x8Unorm;
    WGPUTextureFormat_ASTC10x8UnormSrgb    :: ASTC10x8UnormSrgb;
    WGPUTextureFormat_ASTC10x10Unorm       :: ASTC10x10Unorm;
    WGPUTextureFormat_ASTC10x10UnormSrgb   :: ASTC10x10UnormSrgb;
    WGPUTextureFormat_ASTC12x10Unorm       :: ASTC12x10Unorm;
    WGPUTextureFormat_ASTC12x10UnormSrgb   :: ASTC12x10UnormSrgb;
    WGPUTextureFormat_ASTC12x12Unorm       :: ASTC12x12Unorm;
    WGPUTextureFormat_ASTC12x12UnormSrgb   :: ASTC12x12UnormSrgb;
    WGPUTextureFormat_Force32              :: Force32;
}

TextureSampleType :: enum u32 {
    Undefined         :: 0;
    Float             :: 1;
    UnfilterableFloat :: 2;
    Depth             :: 3;
    Sint              :: 4;
    Uint              :: 5;
    Force32           :: 2147483647;

    WGPUTextureSampleType_Undefined         :: Undefined;
    WGPUTextureSampleType_Float             :: Float;
    WGPUTextureSampleType_UnfilterableFloat :: UnfilterableFloat;
    WGPUTextureSampleType_Depth             :: Depth;
    WGPUTextureSampleType_Sint              :: Sint;
    WGPUTextureSampleType_Uint              :: Uint;
    WGPUTextureSampleType_Force32           :: Force32;
}

TextureViewDimension :: enum u32 {
    Undefined :: 0;
    _1D       :: 1;
    _2D       :: 2;
    _2DArray  :: 3;
    Cube      :: 4;
    CubeArray :: 5;
    _3D       :: 6;
    Force32   :: 2147483647;

    WGPUTextureViewDimension_Undefined :: Undefined;
    WGPUTextureViewDimension_1D        :: _1D;
    WGPUTextureViewDimension_2D        :: _2D;
    WGPUTextureViewDimension_2DArray   :: _2DArray;
    WGPUTextureViewDimension_Cube      :: Cube;
    WGPUTextureViewDimension_CubeArray :: CubeArray;
    WGPUTextureViewDimension_3D        :: _3D;
    WGPUTextureViewDimension_Force32   :: Force32;
}

VertexFormat :: enum u32 {
    Undefined :: 0;
    Uint8x2   :: 1;
    Uint8x4   :: 2;
    Sint8x2   :: 3;
    Sint8x4   :: 4;
    Unorm8x2  :: 5;
    Unorm8x4  :: 6;
    Snorm8x2  :: 7;
    Snorm8x4  :: 8;
    Uint16x2  :: 9;
    Uint16x4  :: 10;
    Sint16x2  :: 11;
    Sint16x4  :: 12;
    Unorm16x2 :: 13;
    Unorm16x4 :: 14;
    Snorm16x2 :: 15;
    Snorm16x4 :: 16;
    Float16x2 :: 17;
    Float16x4 :: 18;
    Float32   :: 19;
    Float32x2 :: 20;
    Float32x3 :: 21;
    Float32x4 :: 22;
    Uint32    :: 23;
    Uint32x2  :: 24;
    Uint32x3  :: 25;
    Uint32x4  :: 26;
    Sint32    :: 27;
    Sint32x2  :: 28;
    Sint32x3  :: 29;
    Sint32x4  :: 30;
    Force32   :: 2147483647;

    WGPUVertexFormat_Undefined :: Undefined;
    WGPUVertexFormat_Uint8x2   :: Uint8x2;
    WGPUVertexFormat_Uint8x4   :: Uint8x4;
    WGPUVertexFormat_Sint8x2   :: Sint8x2;
    WGPUVertexFormat_Sint8x4   :: Sint8x4;
    WGPUVertexFormat_Unorm8x2  :: Unorm8x2;
    WGPUVertexFormat_Unorm8x4  :: Unorm8x4;
    WGPUVertexFormat_Snorm8x2  :: Snorm8x2;
    WGPUVertexFormat_Snorm8x4  :: Snorm8x4;
    WGPUVertexFormat_Uint16x2  :: Uint16x2;
    WGPUVertexFormat_Uint16x4  :: Uint16x4;
    WGPUVertexFormat_Sint16x2  :: Sint16x2;
    WGPUVertexFormat_Sint16x4  :: Sint16x4;
    WGPUVertexFormat_Unorm16x2 :: Unorm16x2;
    WGPUVertexFormat_Unorm16x4 :: Unorm16x4;
    WGPUVertexFormat_Snorm16x2 :: Snorm16x2;
    WGPUVertexFormat_Snorm16x4 :: Snorm16x4;
    WGPUVertexFormat_Float16x2 :: Float16x2;
    WGPUVertexFormat_Float16x4 :: Float16x4;
    WGPUVertexFormat_Float32   :: Float32;
    WGPUVertexFormat_Float32x2 :: Float32x2;
    WGPUVertexFormat_Float32x3 :: Float32x3;
    WGPUVertexFormat_Float32x4 :: Float32x4;
    WGPUVertexFormat_Uint32    :: Uint32;
    WGPUVertexFormat_Uint32x2  :: Uint32x2;
    WGPUVertexFormat_Uint32x3  :: Uint32x3;
    WGPUVertexFormat_Uint32x4  :: Uint32x4;
    WGPUVertexFormat_Sint32    :: Sint32;
    WGPUVertexFormat_Sint32x2  :: Sint32x2;
    WGPUVertexFormat_Sint32x3  :: Sint32x3;
    WGPUVertexFormat_Sint32x4  :: Sint32x4;
    WGPUVertexFormat_Force32   :: Force32;
}

VertexStepMode :: enum u32 {
    Vertex              :: 0;
    Instance            :: 1;
    VertexBufferNotUsed :: 2;
    Force32             :: 2147483647;

    WGPUVertexStepMode_Vertex              :: Vertex;
    WGPUVertexStepMode_Instance            :: Instance;
    WGPUVertexStepMode_VertexBufferNotUsed :: VertexBufferNotUsed;
    WGPUVertexStepMode_Force32             :: Force32;
}

BufferUsage :: enum u32 {
    None         :: 0;
    MapRead      :: 1;
    MapWrite     :: 2;
    CopySrc      :: 4;
    CopyDst      :: 8;
    Index        :: 16;
    Vertex       :: 32;
    Uniform      :: 64;
    Storage      :: 128;
    Indirect     :: 256;
    QueryResolve :: 512;
    Force32      :: 2147483647;

    WGPUBufferUsage_None         :: None;
    WGPUBufferUsage_MapRead      :: MapRead;
    WGPUBufferUsage_MapWrite     :: MapWrite;
    WGPUBufferUsage_CopySrc      :: CopySrc;
    WGPUBufferUsage_CopyDst      :: CopyDst;
    WGPUBufferUsage_Index        :: Index;
    WGPUBufferUsage_Vertex       :: Vertex;
    WGPUBufferUsage_Uniform      :: Uniform;
    WGPUBufferUsage_Storage      :: Storage;
    WGPUBufferUsage_Indirect     :: Indirect;
    WGPUBufferUsage_QueryResolve :: QueryResolve;
    WGPUBufferUsage_Force32      :: Force32;
}

BufferUsageFlags :: Flags;

ColorWriteMask :: enum u32 {
    None    :: 0;
    Red     :: 1;
    Green   :: 2;
    Blue    :: 4;
    Alpha   :: 8;
    All     :: 15;
    Force32 :: 2147483647;

    WGPUColorWriteMask_None    :: None;
    WGPUColorWriteMask_Red     :: Red;
    WGPUColorWriteMask_Green   :: Green;
    WGPUColorWriteMask_Blue    :: Blue;
    WGPUColorWriteMask_Alpha   :: Alpha;
    WGPUColorWriteMask_All     :: All;
    WGPUColorWriteMask_Force32 :: Force32;
}

ColorWriteMaskFlags :: Flags;

MapMode :: enum u32 {
    None    :: 0;
    Read    :: 1;
    Write   :: 2;
    Force32 :: 2147483647;

    WGPUMapMode_None    :: None;
    WGPUMapMode_Read    :: Read;
    WGPUMapMode_Write   :: Write;
    WGPUMapMode_Force32 :: Force32;
}

MapModeFlags :: Flags;

ShaderStage :: enum u32 {
    None     :: 0;
    Vertex   :: 1;
    Fragment :: 2;
    Compute  :: 4;
    Force32  :: 2147483647;

    WGPUShaderStage_None     :: None;
    WGPUShaderStage_Vertex   :: Vertex;
    WGPUShaderStage_Fragment :: Fragment;
    WGPUShaderStage_Compute  :: Compute;
    WGPUShaderStage_Force32  :: Force32;
}

ShaderStageFlags :: Flags;

TextureUsage :: enum u32 {
    None             :: 0;
    CopySrc          :: 1;
    CopyDst          :: 2;
    TextureBinding   :: 4;
    StorageBinding   :: 8;
    RenderAttachment :: 16;
    Force32          :: 2147483647;

    WGPUTextureUsage_None             :: None;
    WGPUTextureUsage_CopySrc          :: CopySrc;
    WGPUTextureUsage_CopyDst          :: CopyDst;
    WGPUTextureUsage_TextureBinding   :: TextureBinding;
    WGPUTextureUsage_StorageBinding   :: StorageBinding;
    WGPUTextureUsage_RenderAttachment :: RenderAttachment;
    WGPUTextureUsage_Force32          :: Force32;
}

TextureUsageFlags :: Flags;

BufferMapCallback :: #type (status: BufferMapAsyncStatus, userdata: *void) -> void #c_call;
CompilationInfoCallback :: #type (status: CompilationInfoRequestStatus, compilationInfo: *CompilationInfo, userdata: *void) -> void #c_call;
CreateComputePipelineAsyncCallback :: #type (status: CreatePipelineAsyncStatus, pipeline: ComputePipeline, message: *u8, userdata: *void) -> void #c_call;
CreateRenderPipelineAsyncCallback :: #type (status: CreatePipelineAsyncStatus, pipeline: RenderPipeline, message: *u8, userdata: *void) -> void #c_call;
DeviceLostCallback :: #type (reason: DeviceLostReason, message: *u8, userdata: *void) -> void #c_call;
ErrorCallback :: #type (type: ErrorType, message: *u8, userdata: *void) -> void #c_call;
Proc :: #type () -> void #c_call;
QueueWorkDoneCallback :: #type (status: QueueWorkDoneStatus, userdata: *void) -> void #c_call;
RequestAdapterCallback :: #type (status: RequestAdapterStatus, adapter: Adapter, message: *u8, userdata: *void) -> void #c_call;
RequestDeviceCallback :: #type (status: RequestDeviceStatus, device: Device, message: *u8, userdata: *void) -> void #c_call;

ChainedStruct :: struct {
    next:  *ChainedStruct;
    sType: SType;
}

ChainedStructOut :: struct {
    next:  *ChainedStructOut;
    sType: SType;
}

// Structure forward declarations
AdapterProperties :: struct {
    nextInChain:       *ChainedStructOut;
    vendorID:          u32;
    vendorName:        *u8;
    architecture:      *u8;
    deviceID:          u32;
    name:              *u8;
    driverDescription: *u8;
    adapterType:       AdapterType;
    backendType:       BackendType;
}

BindGroupEntry :: struct {
    nextInChain: *ChainedStruct;
    binding:     u32;
    buffer:      Buffer;
    offset:      u64;
    size:        u64;
    sampler:     Sampler;
    textureView: TextureView;
}

BlendComponent :: struct {
    operation: BlendOperation;
    srcFactor: BlendFactor;
    dstFactor: BlendFactor;
}

BufferBindingLayout :: struct {
    nextInChain:      *ChainedStruct;
    type:             BufferBindingType;
    hasDynamicOffset: Bool;
    minBindingSize:   u64;
}

BufferDescriptor :: struct {
    nextInChain:      *ChainedStruct;
    label:            *u8;
    usage:            BufferUsageFlags;
    size:             u64;
    mappedAtCreation: Bool;
}

Color :: struct {
    r: float64;
    g: float64;
    b: float64;
    a: float64;
}

CommandBufferDescriptor :: struct {
    nextInChain: *ChainedStruct;
    label:       *u8;
}

CommandEncoderDescriptor :: struct {
    nextInChain: *ChainedStruct;
    label:       *u8;
}

CompilationMessage :: struct {
    nextInChain:  *ChainedStruct;
    message:      *u8;
    type:         CompilationMessageType;
    lineNum:      u64;
    linePos:      u64;
    offset:       u64;
    length:       u64;
    utf16LinePos: u64;
    utf16Offset:  u64;
    utf16Length:  u64;
}

ComputePassTimestampWrites :: struct {
    querySet:                  QuerySet;
    beginningOfPassWriteIndex: u32;
    endOfPassWriteIndex:       u32;
}

ConstantEntry :: struct {
    nextInChain: *ChainedStruct;
    key:         *u8;
    value:       float64;
}

Extent3D :: struct {
    width:              u32;
    height:             u32;
    depthOrArrayLayers: u32;
}

InstanceDescriptor :: struct {
    nextInChain: *ChainedStruct;
}

Limits :: struct {
    maxTextureDimension1D:                     u32;
    maxTextureDimension2D:                     u32;
    maxTextureDimension3D:                     u32;
    maxTextureArrayLayers:                     u32;
    maxBindGroups:                             u32;
    maxBindGroupsPlusVertexBuffers:            u32;
    maxBindingsPerBindGroup:                   u32;
    maxDynamicUniformBuffersPerPipelineLayout: u32;
    maxDynamicStorageBuffersPerPipelineLayout: u32;
    maxSampledTexturesPerShaderStage:          u32;
    maxSamplersPerShaderStage:                 u32;
    maxStorageBuffersPerShaderStage:           u32;
    maxStorageTexturesPerShaderStage:          u32;
    maxUniformBuffersPerShaderStage:           u32;
    maxUniformBufferBindingSize:               u64;
    maxStorageBufferBindingSize:               u64;
    minUniformBufferOffsetAlignment:           u32;
    minStorageBufferOffsetAlignment:           u32;
    maxVertexBuffers:                          u32;
    maxBufferSize:                             u64;
    maxVertexAttributes:                       u32;
    maxVertexBufferArrayStride:                u32;
    maxInterStageShaderComponents:             u32;
    maxInterStageShaderVariables:              u32;
    maxColorAttachments:                       u32;
    maxColorAttachmentBytesPerSample:          u32;
    maxComputeWorkgroupStorageSize:            u32;
    maxComputeInvocationsPerWorkgroup:         u32;
    maxComputeWorkgroupSizeX:                  u32;
    maxComputeWorkgroupSizeY:                  u32;
    maxComputeWorkgroupSizeZ:                  u32;
    maxComputeWorkgroupsPerDimension:          u32;
}

MultisampleState :: struct {
    nextInChain:            *ChainedStruct;
    count:                  u32;
    mask:                   u32;
    alphaToCoverageEnabled: Bool;
}

Origin3D :: struct {
    x: u32;
    y: u32;
    z: u32;
}

PipelineLayoutDescriptor :: struct {
    nextInChain:          *ChainedStruct;
    label:                *u8;
    bindGroupLayoutCount: u64;
    bindGroupLayouts:     *BindGroupLayout;
}

// Can be chained in WGPUPrimitiveState
PrimitiveDepthClipControl :: struct {
    chain:          ChainedStruct;
    unclippedDepth: Bool;
}

PrimitiveState :: struct {
    nextInChain:      *ChainedStruct;
    topology:         PrimitiveTopology;
    stripIndexFormat: IndexFormat;
    frontFace:        FrontFace;
    cullMode:         CullMode;
}

QuerySetDescriptor :: struct {
    nextInChain: *ChainedStruct;
    label:       *u8;
    type:        QueryType;
    count:       u32;
}

QueueDescriptor :: struct {
    nextInChain: *ChainedStruct;
    label:       *u8;
}

RenderBundleDescriptor :: struct {
    nextInChain: *ChainedStruct;
    label:       *u8;
}

RenderBundleEncoderDescriptor :: struct {
    nextInChain:        *ChainedStruct;
    label:              *u8;
    colorFormatCount:   u64;
    colorFormats:       *TextureFormat;
    depthStencilFormat: TextureFormat;
    sampleCount:        u32;
    depthReadOnly:      Bool;
    stencilReadOnly:    Bool;
}

RenderPassDepthStencilAttachment :: struct {
    view:              TextureView;
    depthLoadOp:       LoadOp;
    depthStoreOp:      StoreOp;
    depthClearValue:   float;
    depthReadOnly:     Bool;
    stencilLoadOp:     LoadOp;
    stencilStoreOp:    StoreOp;
    stencilClearValue: u32;
    stencilReadOnly:   Bool;
}

// Can be chained in WGPURenderPassDescriptor
RenderPassDescriptorMaxDrawCount :: struct {
    chain:        ChainedStruct;
    maxDrawCount: u64;
}

RenderPassTimestampWrites :: struct {
    querySet:                  QuerySet;
    beginningOfPassWriteIndex: u32;
    endOfPassWriteIndex:       u32;
}

RequestAdapterOptions :: struct {
    nextInChain:          *ChainedStruct;
    compatibleSurface:    Surface;
    powerPreference:      PowerPreference;
    backendType:          BackendType;
    forceFallbackAdapter: Bool;
}

SamplerBindingLayout :: struct {
    nextInChain: *ChainedStruct;
    type:        SamplerBindingType;
}

SamplerDescriptor :: struct {
    nextInChain:   *ChainedStruct;
    label:         *u8;
    addressModeU:  AddressMode;
    addressModeV:  AddressMode;
    addressModeW:  AddressMode;
    magFilter:     FilterMode;
    minFilter:     FilterMode;
    mipmapFilter:  MipmapFilterMode;
    lodMinClamp:   float;
    lodMaxClamp:   float;
    compare:       CompareFunction;
    maxAnisotropy: u16;
}

ShaderModuleCompilationHint :: struct {
    nextInChain: *ChainedStruct;
    entryPoint:  *u8;
    layout:      PipelineLayout;
}

// Can be chained in WGPUShaderModuleDescriptor
ShaderModuleSPIRVDescriptor :: struct {
    chain:    ChainedStruct;
    codeSize: u32;
    code:     *u32;
}

// Can be chained in WGPUShaderModuleDescriptor
ShaderModuleWGSLDescriptor :: struct {
    chain: ChainedStruct;
    code:  *u8;
}

StencilFaceState :: struct {
    compare:     CompareFunction;
    failOp:      StencilOperation;
    depthFailOp: StencilOperation;
    passOp:      StencilOperation;
}

StorageTextureBindingLayout :: struct {
    nextInChain:   *ChainedStruct;
    access:        StorageTextureAccess;
    format:        TextureFormat;
    viewDimension: TextureViewDimension;
}

SurfaceCapabilities :: struct {
    nextInChain:      *ChainedStructOut;
    formatCount:      u64;
    formats:          *TextureFormat;
    presentModeCount: u64;
    presentModes:     *PresentMode;
    alphaModeCount:   u64;
    alphaModes:       *CompositeAlphaMode;
}

SurfaceConfiguration :: struct {
    nextInChain:     *ChainedStruct;
    device:          Device;
    format:          TextureFormat;
    usage:           TextureUsageFlags;
    viewFormatCount: u64;
    viewFormats:     *TextureFormat;
    alphaMode:       CompositeAlphaMode;
    width:           u32;
    height:          u32;
    presentMode:     PresentMode;
}

SurfaceDescriptor :: struct {
    nextInChain: *ChainedStruct;
    label:       *u8;
}

// Can be chained in WGPUSurfaceDescriptor
SurfaceDescriptorFromAndroidNativeWindow :: struct {
    chain:  ChainedStruct;
    window: *void;
}

// Can be chained in WGPUSurfaceDescriptor
SurfaceDescriptorFromCanvasHTMLSelector :: struct {
    chain:    ChainedStruct;
    selector: *u8;
}

// Can be chained in WGPUSurfaceDescriptor
SurfaceDescriptorFromMetalLayer :: struct {
    chain: ChainedStruct;
    layer: *void;
}

// Can be chained in WGPUSurfaceDescriptor
SurfaceDescriptorFromWaylandSurface :: struct {
    chain:   ChainedStruct;
    display: *void;
    surface: *void;
}

// Can be chained in WGPUSurfaceDescriptor
SurfaceDescriptorFromWindowsHWND :: struct {
    chain:     ChainedStruct;
    hinstance: *void;
    hwnd:      *void;
}

// Can be chained in WGPUSurfaceDescriptor
SurfaceDescriptorFromXcbWindow :: struct {
    chain:      ChainedStruct;
    connection: *void;
    window:     u32;
}

// Can be chained in WGPUSurfaceDescriptor
SurfaceDescriptorFromXlibWindow :: struct {
    chain:   ChainedStruct;
    display: *void;
    window:  u64;
}

SurfaceTexture :: struct {
    texture:    Texture;
    suboptimal: Bool;
    status:     SurfaceGetCurrentTextureStatus;
}

TextureBindingLayout :: struct {
    nextInChain:   *ChainedStruct;
    sampleType:    TextureSampleType;
    viewDimension: TextureViewDimension;
    multisampled:  Bool;
}

TextureDataLayout :: struct {
    nextInChain:  *ChainedStruct;
    offset:       u64;
    bytesPerRow:  u32;
    rowsPerImage: u32;
}

TextureViewDescriptor :: struct {
    nextInChain:     *ChainedStruct;
    label:           *u8;
    format:          TextureFormat;
    dimension:       TextureViewDimension;
    baseMipLevel:    u32;
    mipLevelCount:   u32;
    baseArrayLayer:  u32;
    arrayLayerCount: u32;
    aspect:          TextureAspect;
}

VertexAttribute :: struct {
    format:         VertexFormat;
    offset:         u64;
    shaderLocation: u32;
}

BindGroupDescriptor :: struct {
    nextInChain: *ChainedStruct;
    label:       *u8;
    layout:      BindGroupLayout;
    entryCount:  u64;
    entries:     *BindGroupEntry;
}

BindGroupLayoutEntry :: struct {
    nextInChain:    *ChainedStruct;
    binding:        u32;
    visibility:     ShaderStageFlags;
    buffer:         BufferBindingLayout;
    sampler:        SamplerBindingLayout;
    texture:        TextureBindingLayout;
    storageTexture: StorageTextureBindingLayout;
}

BlendState :: struct {
    color: BlendComponent;
    alpha: BlendComponent;
}

CompilationInfo :: struct {
    nextInChain:  *ChainedStruct;
    messageCount: u64;
    messages:     *CompilationMessage;
}

ComputePassDescriptor :: struct {
    nextInChain:     *ChainedStruct;
    label:           *u8;
    timestampWrites: *ComputePassTimestampWrites;
}

DepthStencilState :: struct {
    nextInChain:         *ChainedStruct;
    format:              TextureFormat;
    depthWriteEnabled:   Bool;
    depthCompare:        CompareFunction;
    stencilFront:        StencilFaceState;
    stencilBack:         StencilFaceState;
    stencilReadMask:     u32;
    stencilWriteMask:    u32;
    depthBias:           s32;
    depthBiasSlopeScale: float;
    depthBiasClamp:      float;
}

ImageCopyBuffer :: struct {
    nextInChain: *ChainedStruct;
    layout:      TextureDataLayout;
    buffer:      Buffer;
}

ImageCopyTexture :: struct {
    nextInChain: *ChainedStruct;
    texture:     Texture;
    mipLevel:    u32;
    origin:      Origin3D;
    aspect:      TextureAspect;
}

ProgrammableStageDescriptor :: struct {
    nextInChain:   *ChainedStruct;
    module:        ShaderModule;
    entryPoint:    *u8;
    constantCount: u64;
    constants:     *ConstantEntry;
}

RenderPassColorAttachment :: struct {
    nextInChain:   *ChainedStruct;
    view:          TextureView;
    resolveTarget: TextureView;
    loadOp:        LoadOp;
    storeOp:       StoreOp;
    clearValue:    Color;
}

RequiredLimits :: struct {
    nextInChain: *ChainedStruct;
    limits:      Limits;
}

ShaderModuleDescriptor :: struct {
    nextInChain: *ChainedStruct;
    label:       *u8;
    hintCount:   u64;
    hints:       *ShaderModuleCompilationHint;
}

SupportedLimits :: struct {
    nextInChain: *ChainedStructOut;
    limits:      Limits;
}

TextureDescriptor :: struct {
    nextInChain:     *ChainedStruct;
    label:           *u8;
    usage:           TextureUsageFlags;
    dimension:       TextureDimension;
    size:            Extent3D;
    format:          TextureFormat;
    mipLevelCount:   u32;
    sampleCount:     u32;
    viewFormatCount: u64;
    viewFormats:     *TextureFormat;
}

VertexBufferLayout :: struct {
    arrayStride:    u64;
    stepMode:       VertexStepMode;
    attributeCount: u64;
    attributes:     *VertexAttribute;
}

BindGroupLayoutDescriptor :: struct {
    nextInChain: *ChainedStruct;
    label:       *u8;
    entryCount:  u64;
    entries:     *BindGroupLayoutEntry;
}

ColorTargetState :: struct {
    nextInChain: *ChainedStruct;
    format:      TextureFormat;
    blend:       *BlendState;
    writeMask:   ColorWriteMaskFlags;
}

ComputePipelineDescriptor :: struct {
    nextInChain: *ChainedStruct;
    label:       *u8;
    layout:      PipelineLayout;
    compute:     ProgrammableStageDescriptor;
}

DeviceDescriptor :: struct {
    nextInChain:          *ChainedStruct;
    label:                *u8;
    requiredFeatureCount: u64;
    requiredFeatures:     *FeatureName;
    requiredLimits:       *RequiredLimits;
    defaultQueue:         QueueDescriptor;
    deviceLostCallback:   DeviceLostCallback;
    deviceLostUserdata:   *void;
}

RenderPassDescriptor :: struct {
    nextInChain:            *ChainedStruct;
    label:                  *u8;
    colorAttachmentCount:   u64;
    colorAttachments:       *RenderPassColorAttachment;
    depthStencilAttachment: *RenderPassDepthStencilAttachment;
    occlusionQuerySet:      QuerySet;
    timestampWrites:        *RenderPassTimestampWrites;
}

VertexState :: struct {
    nextInChain:   *ChainedStruct;
    module:        ShaderModule;
    entryPoint:    *u8;
    constantCount: u64;
    constants:     *ConstantEntry;
    bufferCount:   u64;
    buffers:       *VertexBufferLayout;
}

FragmentState :: struct {
    nextInChain:   *ChainedStruct;
    module:        ShaderModule;
    entryPoint:    *u8;
    constantCount: u64;
    constants:     *ConstantEntry;
    targetCount:   u64;
    targets:       *ColorTargetState;
}

RenderPipelineDescriptor :: struct {
    nextInChain:  *ChainedStruct;
    label:        *u8;
    layout:       PipelineLayout;
    vertex:       VertexState;
    primitive:    PrimitiveState;
    depthStencil: *DepthStencilState;
    multisample:  MultisampleState;
    fragment:     *FragmentState;
}

ProcCreateInstance :: #type (descriptor: *InstanceDescriptor) -> Instance #c_call;
ProcGetProcAddress :: #type (device: Device, procName: *u8) -> Proc #c_call;

// Procs of Adapter
ProcAdapterEnumerateFeatures :: #type (adapter: Adapter, features: *FeatureName) -> u64 #c_call;
ProcAdapterGetLimits :: #type (adapter: Adapter, limits: *SupportedLimits) -> Bool #c_call;
ProcAdapterGetProperties :: #type (adapter: Adapter, properties: *AdapterProperties) -> void #c_call;
ProcAdapterHasFeature :: #type (adapter: Adapter, feature: FeatureName) -> Bool #c_call;
ProcAdapterRequestDevice :: #type (adapter: Adapter, descriptor: *DeviceDescriptor, callback: RequestDeviceCallback, userdata: *void) -> void #c_call;
ProcAdapterReference :: #type (adapter: Adapter) -> void #c_call;
ProcAdapterRelease :: #type (adapter: Adapter) -> void #c_call;

// Procs of BindGroup
ProcBindGroupSetLabel :: #type (bindGroup: BindGroup, label: *u8) -> void #c_call;
ProcBindGroupReference :: #type (bindGroup: BindGroup) -> void #c_call;
ProcBindGroupRelease :: #type (bindGroup: BindGroup) -> void #c_call;

// Procs of BindGroupLayout
ProcBindGroupLayoutSetLabel :: #type (bindGroupLayout: BindGroupLayout, label: *u8) -> void #c_call;
ProcBindGroupLayoutReference :: #type (bindGroupLayout: BindGroupLayout) -> void #c_call;
ProcBindGroupLayoutRelease :: #type (bindGroupLayout: BindGroupLayout) -> void #c_call;

// Procs of Buffer
ProcBufferDestroy :: #type (buffer: Buffer) -> void #c_call;
ProcBufferGetConstMappedRange :: #type (buffer: Buffer, offset: u64, size: u64) -> *void #c_call;
ProcBufferGetMapState :: #type (buffer: Buffer) -> BufferMapState #c_call;
ProcBufferGetMappedRange :: #type (buffer: Buffer, offset: u64, size: u64) -> *void #c_call;
ProcBufferGetSize :: #type (buffer: Buffer) -> u64 #c_call;
ProcBufferGetUsage :: #type (buffer: Buffer) -> BufferUsageFlags #c_call;
ProcBufferMapAsync :: #type (buffer: Buffer, mode: MapModeFlags, offset: u64, size: u64, callback: BufferMapCallback, userdata: *void) -> void #c_call;
ProcBufferSetLabel :: #type (buffer: Buffer, label: *u8) -> void #c_call;
ProcBufferUnmap :: #type (buffer: Buffer) -> void #c_call;
ProcBufferReference :: #type (buffer: Buffer) -> void #c_call;
ProcBufferRelease :: #type (buffer: Buffer) -> void #c_call;

// Procs of CommandBuffer
ProcCommandBufferSetLabel :: #type (commandBuffer: CommandBuffer, label: *u8) -> void #c_call;
ProcCommandBufferReference :: #type (commandBuffer: CommandBuffer) -> void #c_call;
ProcCommandBufferRelease :: #type (commandBuffer: CommandBuffer) -> void #c_call;

// Procs of CommandEncoder
ProcCommandEncoderBeginComputePass :: #type (commandEncoder: CommandEncoder, descriptor: *ComputePassDescriptor) -> ComputePassEncoder #c_call;
ProcCommandEncoderBeginRenderPass :: #type (commandEncoder: CommandEncoder, descriptor: *RenderPassDescriptor) -> RenderPassEncoder #c_call;
ProcCommandEncoderClearBuffer :: #type (commandEncoder: CommandEncoder, buffer: Buffer, offset: u64, size: u64) -> void #c_call;
ProcCommandEncoderCopyBufferToBuffer :: #type (commandEncoder: CommandEncoder, source: Buffer, sourceOffset: u64, destination: Buffer, destinationOffset: u64, size: u64) -> void #c_call;
ProcCommandEncoderCopyBufferToTexture :: #type (commandEncoder: CommandEncoder, source: *ImageCopyBuffer, destination: *ImageCopyTexture, copySize: *Extent3D) -> void #c_call;
ProcCommandEncoderCopyTextureToBuffer :: #type (commandEncoder: CommandEncoder, source: *ImageCopyTexture, destination: *ImageCopyBuffer, copySize: *Extent3D) -> void #c_call;
ProcCommandEncoderCopyTextureToTexture :: #type (commandEncoder: CommandEncoder, source: *ImageCopyTexture, destination: *ImageCopyTexture, copySize: *Extent3D) -> void #c_call;
ProcCommandEncoderFinish :: #type (commandEncoder: CommandEncoder, descriptor: *CommandBufferDescriptor) -> CommandBuffer #c_call;
ProcCommandEncoderInsertDebugMarker :: #type (commandEncoder: CommandEncoder, markerLabel: *u8) -> void #c_call;
ProcCommandEncoderPopDebugGroup :: #type (commandEncoder: CommandEncoder) -> void #c_call;
ProcCommandEncoderPushDebugGroup :: #type (commandEncoder: CommandEncoder, groupLabel: *u8) -> void #c_call;
ProcCommandEncoderResolveQuerySet :: #type (commandEncoder: CommandEncoder, querySet: QuerySet, firstQuery: u32, queryCount: u32, destination: Buffer, destinationOffset: u64) -> void #c_call;
ProcCommandEncoderSetLabel :: #type (commandEncoder: CommandEncoder, label: *u8) -> void #c_call;
ProcCommandEncoderWriteTimestamp :: #type (commandEncoder: CommandEncoder, querySet: QuerySet, queryIndex: u32) -> void #c_call;
ProcCommandEncoderReference :: #type (commandEncoder: CommandEncoder) -> void #c_call;
ProcCommandEncoderRelease :: #type (commandEncoder: CommandEncoder) -> void #c_call;

// Procs of ComputePassEncoder
ProcComputePassEncoderDispatchWorkgroups :: #type (computePassEncoder: ComputePassEncoder, workgroupCountX: u32, workgroupCountY: u32, workgroupCountZ: u32) -> void #c_call;
ProcComputePassEncoderDispatchWorkgroupsIndirect :: #type (computePassEncoder: ComputePassEncoder, indirectBuffer: Buffer, indirectOffset: u64) -> void #c_call;
ProcComputePassEncoderEnd :: #type (computePassEncoder: ComputePassEncoder) -> void #c_call;
ProcComputePassEncoderInsertDebugMarker :: #type (computePassEncoder: ComputePassEncoder, markerLabel: *u8) -> void #c_call;
ProcComputePassEncoderPopDebugGroup :: #type (computePassEncoder: ComputePassEncoder) -> void #c_call;
ProcComputePassEncoderPushDebugGroup :: #type (computePassEncoder: ComputePassEncoder, groupLabel: *u8) -> void #c_call;
ProcComputePassEncoderSetBindGroup :: #type (computePassEncoder: ComputePassEncoder, groupIndex: u32, group: BindGroup, dynamicOffsetCount: u64, dynamicOffsets: *u32) -> void #c_call;
ProcComputePassEncoderSetLabel :: #type (computePassEncoder: ComputePassEncoder, label: *u8) -> void #c_call;
ProcComputePassEncoderSetPipeline :: #type (computePassEncoder: ComputePassEncoder, pipeline: ComputePipeline) -> void #c_call;
ProcComputePassEncoderReference :: #type (computePassEncoder: ComputePassEncoder) -> void #c_call;
ProcComputePassEncoderRelease :: #type (computePassEncoder: ComputePassEncoder) -> void #c_call;

// Procs of ComputePipeline
ProcComputePipelineGetBindGroupLayout :: #type (computePipeline: ComputePipeline, groupIndex: u32) -> BindGroupLayout #c_call;
ProcComputePipelineSetLabel :: #type (computePipeline: ComputePipeline, label: *u8) -> void #c_call;
ProcComputePipelineReference :: #type (computePipeline: ComputePipeline) -> void #c_call;
ProcComputePipelineRelease :: #type (computePipeline: ComputePipeline) -> void #c_call;

// Procs of Device
ProcDeviceCreateBindGroup :: #type (device: Device, descriptor: *BindGroupDescriptor) -> BindGroup #c_call;
ProcDeviceCreateBindGroupLayout :: #type (device: Device, descriptor: *BindGroupLayoutDescriptor) -> BindGroupLayout #c_call;
ProcDeviceCreateBuffer :: #type (device: Device, descriptor: *BufferDescriptor) -> Buffer #c_call;
ProcDeviceCreateCommandEncoder :: #type (device: Device, descriptor: *CommandEncoderDescriptor) -> CommandEncoder #c_call;
ProcDeviceCreateComputePipeline :: #type (device: Device, descriptor: *ComputePipelineDescriptor) -> ComputePipeline #c_call;
ProcDeviceCreateComputePipelineAsync :: #type (device: Device, descriptor: *ComputePipelineDescriptor, callback: CreateComputePipelineAsyncCallback, userdata: *void) -> void #c_call;
ProcDeviceCreatePipelineLayout :: #type (device: Device, descriptor: *PipelineLayoutDescriptor) -> PipelineLayout #c_call;
ProcDeviceCreateQuerySet :: #type (device: Device, descriptor: *QuerySetDescriptor) -> QuerySet #c_call;
ProcDeviceCreateRenderBundleEncoder :: #type (device: Device, descriptor: *RenderBundleEncoderDescriptor) -> RenderBundleEncoder #c_call;
ProcDeviceCreateRenderPipeline :: #type (device: Device, descriptor: *RenderPipelineDescriptor) -> RenderPipeline #c_call;
ProcDeviceCreateRenderPipelineAsync :: #type (device: Device, descriptor: *RenderPipelineDescriptor, callback: CreateRenderPipelineAsyncCallback, userdata: *void) -> void #c_call;
ProcDeviceCreateSampler :: #type (device: Device, descriptor: *SamplerDescriptor) -> Sampler #c_call;
ProcDeviceCreateShaderModule :: #type (device: Device, descriptor: *ShaderModuleDescriptor) -> ShaderModule #c_call;
ProcDeviceCreateTexture :: #type (device: Device, descriptor: *TextureDescriptor) -> Texture #c_call;
ProcDeviceDestroy :: #type (device: Device) -> void #c_call;
ProcDeviceEnumerateFeatures :: #type (device: Device, features: *FeatureName) -> u64 #c_call;
ProcDeviceGetLimits :: #type (device: Device, limits: *SupportedLimits) -> Bool #c_call;
ProcDeviceGetQueue :: #type (device: Device) -> Queue #c_call;
ProcDeviceHasFeature :: #type (device: Device, feature: FeatureName) -> Bool #c_call;
ProcDevicePopErrorScope :: #type (device: Device, callback: ErrorCallback, userdata: *void) -> void #c_call;
ProcDevicePushErrorScope :: #type (device: Device, filter: ErrorFilter) -> void #c_call;
ProcDeviceSetLabel :: #type (device: Device, label: *u8) -> void #c_call;
ProcDeviceSetUncapturedErrorCallback :: #type (device: Device, callback: ErrorCallback, userdata: *void) -> void #c_call;
ProcDeviceReference :: #type (device: Device) -> void #c_call;
ProcDeviceRelease :: #type (device: Device) -> void #c_call;

// Procs of Instance
ProcInstanceCreateSurface :: #type (instance: Instance, descriptor: *SurfaceDescriptor) -> Surface #c_call;
ProcInstanceProcessEvents :: #type (instance: Instance) -> void #c_call;
ProcInstanceRequestAdapter :: #type (instance: Instance, options: *RequestAdapterOptions, callback: RequestAdapterCallback, userdata: *void) -> void #c_call;
ProcInstanceReference :: #type (instance: Instance) -> void #c_call;
ProcInstanceRelease :: #type (instance: Instance) -> void #c_call;

// Procs of PipelineLayout
ProcPipelineLayoutSetLabel :: #type (pipelineLayout: PipelineLayout, label: *u8) -> void #c_call;
ProcPipelineLayoutReference :: #type (pipelineLayout: PipelineLayout) -> void #c_call;
ProcPipelineLayoutRelease :: #type (pipelineLayout: PipelineLayout) -> void #c_call;

// Procs of QuerySet
ProcQuerySetDestroy :: #type (querySet: QuerySet) -> void #c_call;
ProcQuerySetGetCount :: #type (querySet: QuerySet) -> u32 #c_call;
ProcQuerySetGetType :: #type (querySet: QuerySet) -> QueryType #c_call;
ProcQuerySetSetLabel :: #type (querySet: QuerySet, label: *u8) -> void #c_call;
ProcQuerySetReference :: #type (querySet: QuerySet) -> void #c_call;
ProcQuerySetRelease :: #type (querySet: QuerySet) -> void #c_call;

// Procs of Queue
ProcQueueOnSubmittedWorkDone :: #type (queue: Queue, callback: QueueWorkDoneCallback, userdata: *void) -> void #c_call;
ProcQueueSetLabel :: #type (queue: Queue, label: *u8) -> void #c_call;
ProcQueueSubmit :: #type (queue: Queue, commandCount: u64, commands: *CommandBuffer) -> void #c_call;
ProcQueueWriteBuffer :: #type (queue: Queue, buffer: Buffer, bufferOffset: u64, data: *void, size: u64) -> void #c_call;
ProcQueueWriteTexture :: #type (queue: Queue, destination: *ImageCopyTexture, data: *void, dataSize: u64, dataLayout: *TextureDataLayout, writeSize: *Extent3D) -> void #c_call;
ProcQueueReference :: #type (queue: Queue) -> void #c_call;
ProcQueueRelease :: #type (queue: Queue) -> void #c_call;

// Procs of RenderBundle
ProcRenderBundleSetLabel :: #type (renderBundle: RenderBundle, label: *u8) -> void #c_call;
ProcRenderBundleReference :: #type (renderBundle: RenderBundle) -> void #c_call;
ProcRenderBundleRelease :: #type (renderBundle: RenderBundle) -> void #c_call;

// Procs of RenderBundleEncoder
ProcRenderBundleEncoderDraw :: #type (renderBundleEncoder: RenderBundleEncoder, vertexCount: u32, instanceCount: u32, firstVertex: u32, firstInstance: u32) -> void #c_call;
ProcRenderBundleEncoderDrawIndexed :: #type (renderBundleEncoder: RenderBundleEncoder, indexCount: u32, instanceCount: u32, firstIndex: u32, baseVertex: s32, firstInstance: u32) -> void #c_call;
ProcRenderBundleEncoderDrawIndexedIndirect :: #type (renderBundleEncoder: RenderBundleEncoder, indirectBuffer: Buffer, indirectOffset: u64) -> void #c_call;
ProcRenderBundleEncoderDrawIndirect :: #type (renderBundleEncoder: RenderBundleEncoder, indirectBuffer: Buffer, indirectOffset: u64) -> void #c_call;
ProcRenderBundleEncoderFinish :: #type (renderBundleEncoder: RenderBundleEncoder, descriptor: *RenderBundleDescriptor) -> RenderBundle #c_call;
ProcRenderBundleEncoderInsertDebugMarker :: #type (renderBundleEncoder: RenderBundleEncoder, markerLabel: *u8) -> void #c_call;
ProcRenderBundleEncoderPopDebugGroup :: #type (renderBundleEncoder: RenderBundleEncoder) -> void #c_call;
ProcRenderBundleEncoderPushDebugGroup :: #type (renderBundleEncoder: RenderBundleEncoder, groupLabel: *u8) -> void #c_call;
ProcRenderBundleEncoderSetBindGroup :: #type (renderBundleEncoder: RenderBundleEncoder, groupIndex: u32, group: BindGroup, dynamicOffsetCount: u64, dynamicOffsets: *u32) -> void #c_call;
ProcRenderBundleEncoderSetIndexBuffer :: #type (renderBundleEncoder: RenderBundleEncoder, buffer: Buffer, format: IndexFormat, offset: u64, size: u64) -> void #c_call;
ProcRenderBundleEncoderSetLabel :: #type (renderBundleEncoder: RenderBundleEncoder, label: *u8) -> void #c_call;
ProcRenderBundleEncoderSetPipeline :: #type (renderBundleEncoder: RenderBundleEncoder, pipeline: RenderPipeline) -> void #c_call;
ProcRenderBundleEncoderSetVertexBuffer :: #type (renderBundleEncoder: RenderBundleEncoder, slot: u32, buffer: Buffer, offset: u64, size: u64) -> void #c_call;
ProcRenderBundleEncoderReference :: #type (renderBundleEncoder: RenderBundleEncoder) -> void #c_call;
ProcRenderBundleEncoderRelease :: #type (renderBundleEncoder: RenderBundleEncoder) -> void #c_call;

// Procs of RenderPassEncoder
ProcRenderPassEncoderBeginOcclusionQuery :: #type (renderPassEncoder: RenderPassEncoder, queryIndex: u32) -> void #c_call;
ProcRenderPassEncoderDraw :: #type (renderPassEncoder: RenderPassEncoder, vertexCount: u32, instanceCount: u32, firstVertex: u32, firstInstance: u32) -> void #c_call;
ProcRenderPassEncoderDrawIndexed :: #type (renderPassEncoder: RenderPassEncoder, indexCount: u32, instanceCount: u32, firstIndex: u32, baseVertex: s32, firstInstance: u32) -> void #c_call;
ProcRenderPassEncoderDrawIndexedIndirect :: #type (renderPassEncoder: RenderPassEncoder, indirectBuffer: Buffer, indirectOffset: u64) -> void #c_call;
ProcRenderPassEncoderDrawIndirect :: #type (renderPassEncoder: RenderPassEncoder, indirectBuffer: Buffer, indirectOffset: u64) -> void #c_call;
ProcRenderPassEncoderEnd :: #type (renderPassEncoder: RenderPassEncoder) -> void #c_call;
ProcRenderPassEncoderEndOcclusionQuery :: #type (renderPassEncoder: RenderPassEncoder) -> void #c_call;
ProcRenderPassEncoderExecuteBundles :: #type (renderPassEncoder: RenderPassEncoder, bundleCount: u64, bundles: *RenderBundle) -> void #c_call;
ProcRenderPassEncoderInsertDebugMarker :: #type (renderPassEncoder: RenderPassEncoder, markerLabel: *u8) -> void #c_call;
ProcRenderPassEncoderPopDebugGroup :: #type (renderPassEncoder: RenderPassEncoder) -> void #c_call;
ProcRenderPassEncoderPushDebugGroup :: #type (renderPassEncoder: RenderPassEncoder, groupLabel: *u8) -> void #c_call;
ProcRenderPassEncoderSetBindGroup :: #type (renderPassEncoder: RenderPassEncoder, groupIndex: u32, group: BindGroup, dynamicOffsetCount: u64, dynamicOffsets: *u32) -> void #c_call;
ProcRenderPassEncoderSetBlendConstant :: #type (renderPassEncoder: RenderPassEncoder, color: *Color) -> void #c_call;
ProcRenderPassEncoderSetIndexBuffer :: #type (renderPassEncoder: RenderPassEncoder, buffer: Buffer, format: IndexFormat, offset: u64, size: u64) -> void #c_call;
ProcRenderPassEncoderSetLabel :: #type (renderPassEncoder: RenderPassEncoder, label: *u8) -> void #c_call;
ProcRenderPassEncoderSetPipeline :: #type (renderPassEncoder: RenderPassEncoder, pipeline: RenderPipeline) -> void #c_call;
ProcRenderPassEncoderSetScissorRect :: #type (renderPassEncoder: RenderPassEncoder, x: u32, y: u32, width: u32, height: u32) -> void #c_call;
ProcRenderPassEncoderSetStencilReference :: #type (renderPassEncoder: RenderPassEncoder, reference: u32) -> void #c_call;
ProcRenderPassEncoderSetVertexBuffer :: #type (renderPassEncoder: RenderPassEncoder, slot: u32, buffer: Buffer, offset: u64, size: u64) -> void #c_call;
ProcRenderPassEncoderSetViewport :: #type (renderPassEncoder: RenderPassEncoder, x: float, y: float, width: float, height: float, minDepth: float, maxDepth: float) -> void #c_call;
ProcRenderPassEncoderReference :: #type (renderPassEncoder: RenderPassEncoder) -> void #c_call;
ProcRenderPassEncoderRelease :: #type (renderPassEncoder: RenderPassEncoder) -> void #c_call;

// Procs of RenderPipeline
ProcRenderPipelineGetBindGroupLayout :: #type (renderPipeline: RenderPipeline, groupIndex: u32) -> BindGroupLayout #c_call;
ProcRenderPipelineSetLabel :: #type (renderPipeline: RenderPipeline, label: *u8) -> void #c_call;
ProcRenderPipelineReference :: #type (renderPipeline: RenderPipeline) -> void #c_call;
ProcRenderPipelineRelease :: #type (renderPipeline: RenderPipeline) -> void #c_call;

// Procs of Sampler
ProcSamplerSetLabel :: #type (sampler: Sampler, label: *u8) -> void #c_call;
ProcSamplerReference :: #type (sampler: Sampler) -> void #c_call;
ProcSamplerRelease :: #type (sampler: Sampler) -> void #c_call;

// Procs of ShaderModule
ProcShaderModuleGetCompilationInfo :: #type (shaderModule: ShaderModule, callback: CompilationInfoCallback, userdata: *void) -> void #c_call;
ProcShaderModuleSetLabel :: #type (shaderModule: ShaderModule, label: *u8) -> void #c_call;
ProcShaderModuleReference :: #type (shaderModule: ShaderModule) -> void #c_call;
ProcShaderModuleRelease :: #type (shaderModule: ShaderModule) -> void #c_call;

// Procs of Surface
ProcSurfaceConfigure :: #type (surface: Surface, config: *SurfaceConfiguration) -> void #c_call;
ProcSurfaceGetCapabilities :: #type (surface: Surface, adapter: Adapter, capabilities: *SurfaceCapabilities) -> void #c_call;
ProcSurfaceGetCurrentTexture :: #type (surface: Surface, surfaceTexture: *SurfaceTexture) -> void #c_call;
ProcSurfaceGetPreferredFormat :: #type (surface: Surface, adapter: Adapter) -> TextureFormat #c_call;
ProcSurfacePresent :: #type (surface: Surface) -> void #c_call;
ProcSurfaceUnconfigure :: #type (surface: Surface) -> void #c_call;
ProcSurfaceReference :: #type (surface: Surface) -> void #c_call;
ProcSurfaceRelease :: #type (surface: Surface) -> void #c_call;

// Procs of SurfaceCapabilities
ProcSurfaceCapabilitiesFreeMembers :: #type (capabilities: SurfaceCapabilities) -> void #c_call;

// Procs of Texture
ProcTextureCreateView :: #type (texture: Texture, descriptor: *TextureViewDescriptor) -> TextureView #c_call;
ProcTextureDestroy :: #type (texture: Texture) -> void #c_call;
ProcTextureGetDepthOrArrayLayers :: #type (texture: Texture) -> u32 #c_call;
ProcTextureGetDimension :: #type (texture: Texture) -> TextureDimension #c_call;
ProcTextureGetFormat :: #type (texture: Texture) -> TextureFormat #c_call;
ProcTextureGetHeight :: #type (texture: Texture) -> u32 #c_call;
ProcTextureGetMipLevelCount :: #type (texture: Texture) -> u32 #c_call;
ProcTextureGetSampleCount :: #type (texture: Texture) -> u32 #c_call;
ProcTextureGetUsage :: #type (texture: Texture) -> TextureUsageFlags #c_call;
ProcTextureGetWidth :: #type (texture: Texture) -> u32 #c_call;
ProcTextureSetLabel :: #type (texture: Texture, label: *u8) -> void #c_call;
ProcTextureReference :: #type (texture: Texture) -> void #c_call;
ProcTextureRelease :: #type (texture: Texture) -> void #c_call;

// Procs of TextureView
ProcTextureViewSetLabel :: #type (textureView: TextureView, label: *u8) -> void #c_call;
ProcTextureViewReference :: #type (textureView: TextureView) -> void #c_call;
ProcTextureViewRelease :: #type (textureView: TextureView) -> void #c_call;

CreateInstance :: (descriptor: *InstanceDescriptor) -> Instance #foreign libwgpu_native "wgpuCreateInstance";
GetProcAddress :: (device: Device, procName: *u8) -> Proc #foreign libwgpu_native "wgpuGetProcAddress";

// Methods of Adapter
AdapterEnumerateFeatures :: (adapter: Adapter, features: *FeatureName) -> u64 #foreign libwgpu_native "wgpuAdapterEnumerateFeatures";
AdapterGetLimits :: (adapter: Adapter, limits: *SupportedLimits) -> Bool #foreign libwgpu_native "wgpuAdapterGetLimits";
AdapterGetProperties :: (adapter: Adapter, properties: *AdapterProperties) -> void #foreign libwgpu_native "wgpuAdapterGetProperties";
AdapterHasFeature :: (adapter: Adapter, feature: FeatureName) -> Bool #foreign libwgpu_native "wgpuAdapterHasFeature";
AdapterRequestDevice :: (adapter: Adapter, descriptor: *DeviceDescriptor, callback: RequestDeviceCallback, userdata: *void) -> void #foreign libwgpu_native "wgpuAdapterRequestDevice";
AdapterReference :: (adapter: Adapter) -> void #foreign libwgpu_native "wgpuAdapterReference";
AdapterRelease :: (adapter: Adapter) -> void #foreign libwgpu_native "wgpuAdapterRelease";

// Methods of BindGroup
BindGroupSetLabel :: (bindGroup: BindGroup, label: *u8) -> void #foreign libwgpu_native "wgpuBindGroupSetLabel";
BindGroupReference :: (bindGroup: BindGroup) -> void #foreign libwgpu_native "wgpuBindGroupReference";
BindGroupRelease :: (bindGroup: BindGroup) -> void #foreign libwgpu_native "wgpuBindGroupRelease";

// Methods of BindGroupLayout
BindGroupLayoutSetLabel :: (bindGroupLayout: BindGroupLayout, label: *u8) -> void #foreign libwgpu_native "wgpuBindGroupLayoutSetLabel";
BindGroupLayoutReference :: (bindGroupLayout: BindGroupLayout) -> void #foreign libwgpu_native "wgpuBindGroupLayoutReference";
BindGroupLayoutRelease :: (bindGroupLayout: BindGroupLayout) -> void #foreign libwgpu_native "wgpuBindGroupLayoutRelease";

// Methods of Buffer
BufferDestroy :: (buffer: Buffer) -> void #foreign libwgpu_native "wgpuBufferDestroy";
BufferGetConstMappedRange :: (buffer: Buffer, offset: u64, size: u64) -> *void #foreign libwgpu_native "wgpuBufferGetConstMappedRange";
BufferGetMapState :: (buffer: Buffer) -> BufferMapState #foreign libwgpu_native "wgpuBufferGetMapState";
BufferGetMappedRange :: (buffer: Buffer, offset: u64, size: u64) -> *void #foreign libwgpu_native "wgpuBufferGetMappedRange";
BufferGetSize :: (buffer: Buffer) -> u64 #foreign libwgpu_native "wgpuBufferGetSize";
BufferGetUsage :: (buffer: Buffer) -> BufferUsageFlags #foreign libwgpu_native "wgpuBufferGetUsage";
BufferMapAsync :: (buffer: Buffer, mode: MapModeFlags, offset: u64, size: u64, callback: BufferMapCallback, userdata: *void) -> void #foreign libwgpu_native "wgpuBufferMapAsync";
BufferSetLabel :: (buffer: Buffer, label: *u8) -> void #foreign libwgpu_native "wgpuBufferSetLabel";
BufferUnmap :: (buffer: Buffer) -> void #foreign libwgpu_native "wgpuBufferUnmap";
BufferReference :: (buffer: Buffer) -> void #foreign libwgpu_native "wgpuBufferReference";
BufferRelease :: (buffer: Buffer) -> void #foreign libwgpu_native "wgpuBufferRelease";

// Methods of CommandBuffer
CommandBufferSetLabel :: (commandBuffer: CommandBuffer, label: *u8) -> void #foreign libwgpu_native "wgpuCommandBufferSetLabel";
CommandBufferReference :: (commandBuffer: CommandBuffer) -> void #foreign libwgpu_native "wgpuCommandBufferReference";
CommandBufferRelease :: (commandBuffer: CommandBuffer) -> void #foreign libwgpu_native "wgpuCommandBufferRelease";

// Methods of CommandEncoder
CommandEncoderBeginComputePass :: (commandEncoder: CommandEncoder, descriptor: *ComputePassDescriptor) -> ComputePassEncoder #foreign libwgpu_native "wgpuCommandEncoderBeginComputePass";
CommandEncoderBeginRenderPass :: (commandEncoder: CommandEncoder, descriptor: *RenderPassDescriptor) -> RenderPassEncoder #foreign libwgpu_native "wgpuCommandEncoderBeginRenderPass";
CommandEncoderClearBuffer :: (commandEncoder: CommandEncoder, buffer: Buffer, offset: u64, size: u64) -> void #foreign libwgpu_native "wgpuCommandEncoderClearBuffer";
CommandEncoderCopyBufferToBuffer :: (commandEncoder: CommandEncoder, source: Buffer, sourceOffset: u64, destination: Buffer, destinationOffset: u64, size: u64) -> void #foreign libwgpu_native "wgpuCommandEncoderCopyBufferToBuffer";
CommandEncoderCopyBufferToTexture :: (commandEncoder: CommandEncoder, source: *ImageCopyBuffer, destination: *ImageCopyTexture, copySize: *Extent3D) -> void #foreign libwgpu_native "wgpuCommandEncoderCopyBufferToTexture";
CommandEncoderCopyTextureToBuffer :: (commandEncoder: CommandEncoder, source: *ImageCopyTexture, destination: *ImageCopyBuffer, copySize: *Extent3D) -> void #foreign libwgpu_native "wgpuCommandEncoderCopyTextureToBuffer";
CommandEncoderCopyTextureToTexture :: (commandEncoder: CommandEncoder, source: *ImageCopyTexture, destination: *ImageCopyTexture, copySize: *Extent3D) -> void #foreign libwgpu_native "wgpuCommandEncoderCopyTextureToTexture";
CommandEncoderFinish :: (commandEncoder: CommandEncoder, descriptor: *CommandBufferDescriptor) -> CommandBuffer #foreign libwgpu_native "wgpuCommandEncoderFinish";
CommandEncoderInsertDebugMarker :: (commandEncoder: CommandEncoder, markerLabel: *u8) -> void #foreign libwgpu_native "wgpuCommandEncoderInsertDebugMarker";
CommandEncoderPopDebugGroup :: (commandEncoder: CommandEncoder) -> void #foreign libwgpu_native "wgpuCommandEncoderPopDebugGroup";
CommandEncoderPushDebugGroup :: (commandEncoder: CommandEncoder, groupLabel: *u8) -> void #foreign libwgpu_native "wgpuCommandEncoderPushDebugGroup";
CommandEncoderResolveQuerySet :: (commandEncoder: CommandEncoder, querySet: QuerySet, firstQuery: u32, queryCount: u32, destination: Buffer, destinationOffset: u64) -> void #foreign libwgpu_native "wgpuCommandEncoderResolveQuerySet";
CommandEncoderSetLabel :: (commandEncoder: CommandEncoder, label: *u8) -> void #foreign libwgpu_native "wgpuCommandEncoderSetLabel";
CommandEncoderWriteTimestamp :: (commandEncoder: CommandEncoder, querySet: QuerySet, queryIndex: u32) -> void #foreign libwgpu_native "wgpuCommandEncoderWriteTimestamp";
CommandEncoderReference :: (commandEncoder: CommandEncoder) -> void #foreign libwgpu_native "wgpuCommandEncoderReference";
CommandEncoderRelease :: (commandEncoder: CommandEncoder) -> void #foreign libwgpu_native "wgpuCommandEncoderRelease";

// Methods of ComputePassEncoder
ComputePassEncoderDispatchWorkgroups :: (computePassEncoder: ComputePassEncoder, workgroupCountX: u32, workgroupCountY: u32, workgroupCountZ: u32) -> void #foreign libwgpu_native "wgpuComputePassEncoderDispatchWorkgroups";
ComputePassEncoderDispatchWorkgroupsIndirect :: (computePassEncoder: ComputePassEncoder, indirectBuffer: Buffer, indirectOffset: u64) -> void #foreign libwgpu_native "wgpuComputePassEncoderDispatchWorkgroupsIndirect";
ComputePassEncoderEnd :: (computePassEncoder: ComputePassEncoder) -> void #foreign libwgpu_native "wgpuComputePassEncoderEnd";
ComputePassEncoderInsertDebugMarker :: (computePassEncoder: ComputePassEncoder, markerLabel: *u8) -> void #foreign libwgpu_native "wgpuComputePassEncoderInsertDebugMarker";
ComputePassEncoderPopDebugGroup :: (computePassEncoder: ComputePassEncoder) -> void #foreign libwgpu_native "wgpuComputePassEncoderPopDebugGroup";
ComputePassEncoderPushDebugGroup :: (computePassEncoder: ComputePassEncoder, groupLabel: *u8) -> void #foreign libwgpu_native "wgpuComputePassEncoderPushDebugGroup";
ComputePassEncoderSetBindGroup :: (computePassEncoder: ComputePassEncoder, groupIndex: u32, group: BindGroup, dynamicOffsetCount: u64, dynamicOffsets: *u32) -> void #foreign libwgpu_native "wgpuComputePassEncoderSetBindGroup";
ComputePassEncoderSetLabel :: (computePassEncoder: ComputePassEncoder, label: *u8) -> void #foreign libwgpu_native "wgpuComputePassEncoderSetLabel";
ComputePassEncoderSetPipeline :: (computePassEncoder: ComputePassEncoder, pipeline: ComputePipeline) -> void #foreign libwgpu_native "wgpuComputePassEncoderSetPipeline";
ComputePassEncoderReference :: (computePassEncoder: ComputePassEncoder) -> void #foreign libwgpu_native "wgpuComputePassEncoderReference";
ComputePassEncoderRelease :: (computePassEncoder: ComputePassEncoder) -> void #foreign libwgpu_native "wgpuComputePassEncoderRelease";

// Methods of ComputePipeline
ComputePipelineGetBindGroupLayout :: (computePipeline: ComputePipeline, groupIndex: u32) -> BindGroupLayout #foreign libwgpu_native "wgpuComputePipelineGetBindGroupLayout";
ComputePipelineSetLabel :: (computePipeline: ComputePipeline, label: *u8) -> void #foreign libwgpu_native "wgpuComputePipelineSetLabel";
ComputePipelineReference :: (computePipeline: ComputePipeline) -> void #foreign libwgpu_native "wgpuComputePipelineReference";
ComputePipelineRelease :: (computePipeline: ComputePipeline) -> void #foreign libwgpu_native "wgpuComputePipelineRelease";

// Methods of Device
DeviceCreateBindGroup :: (device: Device, descriptor: *BindGroupDescriptor) -> BindGroup #foreign libwgpu_native "wgpuDeviceCreateBindGroup";
DeviceCreateBindGroupLayout :: (device: Device, descriptor: *BindGroupLayoutDescriptor) -> BindGroupLayout #foreign libwgpu_native "wgpuDeviceCreateBindGroupLayout";
DeviceCreateBuffer :: (device: Device, descriptor: *BufferDescriptor) -> Buffer #foreign libwgpu_native "wgpuDeviceCreateBuffer";
DeviceCreateCommandEncoder :: (device: Device, descriptor: *CommandEncoderDescriptor) -> CommandEncoder #foreign libwgpu_native "wgpuDeviceCreateCommandEncoder";
DeviceCreateComputePipeline :: (device: Device, descriptor: *ComputePipelineDescriptor) -> ComputePipeline #foreign libwgpu_native "wgpuDeviceCreateComputePipeline";
DeviceCreateComputePipelineAsync :: (device: Device, descriptor: *ComputePipelineDescriptor, callback: CreateComputePipelineAsyncCallback, userdata: *void) -> void #foreign libwgpu_native "wgpuDeviceCreateComputePipelineAsync";
DeviceCreatePipelineLayout :: (device: Device, descriptor: *PipelineLayoutDescriptor) -> PipelineLayout #foreign libwgpu_native "wgpuDeviceCreatePipelineLayout";
DeviceCreateQuerySet :: (device: Device, descriptor: *QuerySetDescriptor) -> QuerySet #foreign libwgpu_native "wgpuDeviceCreateQuerySet";
DeviceCreateRenderBundleEncoder :: (device: Device, descriptor: *RenderBundleEncoderDescriptor) -> RenderBundleEncoder #foreign libwgpu_native "wgpuDeviceCreateRenderBundleEncoder";
DeviceCreateRenderPipeline :: (device: Device, descriptor: *RenderPipelineDescriptor) -> RenderPipeline #foreign libwgpu_native "wgpuDeviceCreateRenderPipeline";
DeviceCreateRenderPipelineAsync :: (device: Device, descriptor: *RenderPipelineDescriptor, callback: CreateRenderPipelineAsyncCallback, userdata: *void) -> void #foreign libwgpu_native "wgpuDeviceCreateRenderPipelineAsync";
DeviceCreateSampler :: (device: Device, descriptor: *SamplerDescriptor) -> Sampler #foreign libwgpu_native "wgpuDeviceCreateSampler";
DeviceCreateShaderModule :: (device: Device, descriptor: *ShaderModuleDescriptor) -> ShaderModule #foreign libwgpu_native "wgpuDeviceCreateShaderModule";
DeviceCreateTexture :: (device: Device, descriptor: *TextureDescriptor) -> Texture #foreign libwgpu_native "wgpuDeviceCreateTexture";
DeviceDestroy :: (device: Device) -> void #foreign libwgpu_native "wgpuDeviceDestroy";
DeviceEnumerateFeatures :: (device: Device, features: *FeatureName) -> u64 #foreign libwgpu_native "wgpuDeviceEnumerateFeatures";
DeviceGetLimits :: (device: Device, limits: *SupportedLimits) -> Bool #foreign libwgpu_native "wgpuDeviceGetLimits";
DeviceGetQueue :: (device: Device) -> Queue #foreign libwgpu_native "wgpuDeviceGetQueue";
DeviceHasFeature :: (device: Device, feature: FeatureName) -> Bool #foreign libwgpu_native "wgpuDeviceHasFeature";
DevicePopErrorScope :: (device: Device, callback: ErrorCallback, userdata: *void) -> void #foreign libwgpu_native "wgpuDevicePopErrorScope";
DevicePushErrorScope :: (device: Device, filter: ErrorFilter) -> void #foreign libwgpu_native "wgpuDevicePushErrorScope";
DeviceSetLabel :: (device: Device, label: *u8) -> void #foreign libwgpu_native "wgpuDeviceSetLabel";
DeviceSetUncapturedErrorCallback :: (device: Device, callback: ErrorCallback, userdata: *void) -> void #foreign libwgpu_native "wgpuDeviceSetUncapturedErrorCallback";
DeviceReference :: (device: Device) -> void #foreign libwgpu_native "wgpuDeviceReference";
DeviceRelease :: (device: Device) -> void #foreign libwgpu_native "wgpuDeviceRelease";

// Methods of Instance
InstanceCreateSurface :: (instance: Instance, descriptor: *SurfaceDescriptor) -> Surface #foreign libwgpu_native "wgpuInstanceCreateSurface";
InstanceProcessEvents :: (instance: Instance) -> void #foreign libwgpu_native "wgpuInstanceProcessEvents";
InstanceRequestAdapter :: (instance: Instance, options: *RequestAdapterOptions, callback: RequestAdapterCallback, userdata: *void) -> void #foreign libwgpu_native "wgpuInstanceRequestAdapter";
InstanceReference :: (instance: Instance) -> void #foreign libwgpu_native "wgpuInstanceReference";
InstanceRelease :: (instance: Instance) -> void #foreign libwgpu_native "wgpuInstanceRelease";

// Methods of PipelineLayout
PipelineLayoutSetLabel :: (pipelineLayout: PipelineLayout, label: *u8) -> void #foreign libwgpu_native "wgpuPipelineLayoutSetLabel";
PipelineLayoutReference :: (pipelineLayout: PipelineLayout) -> void #foreign libwgpu_native "wgpuPipelineLayoutReference";
PipelineLayoutRelease :: (pipelineLayout: PipelineLayout) -> void #foreign libwgpu_native "wgpuPipelineLayoutRelease";

// Methods of QuerySet
QuerySetDestroy :: (querySet: QuerySet) -> void #foreign libwgpu_native "wgpuQuerySetDestroy";
QuerySetGetCount :: (querySet: QuerySet) -> u32 #foreign libwgpu_native "wgpuQuerySetGetCount";
QuerySetGetType :: (querySet: QuerySet) -> QueryType #foreign libwgpu_native "wgpuQuerySetGetType";
QuerySetSetLabel :: (querySet: QuerySet, label: *u8) -> void #foreign libwgpu_native "wgpuQuerySetSetLabel";
QuerySetReference :: (querySet: QuerySet) -> void #foreign libwgpu_native "wgpuQuerySetReference";
QuerySetRelease :: (querySet: QuerySet) -> void #foreign libwgpu_native "wgpuQuerySetRelease";

// Methods of Queue
QueueOnSubmittedWorkDone :: (queue: Queue, callback: QueueWorkDoneCallback, userdata: *void) -> void #foreign libwgpu_native "wgpuQueueOnSubmittedWorkDone";
QueueSetLabel :: (queue: Queue, label: *u8) -> void #foreign libwgpu_native "wgpuQueueSetLabel";
QueueSubmit :: (queue: Queue, commandCount: u64, commands: *CommandBuffer) -> void #foreign libwgpu_native "wgpuQueueSubmit";
QueueWriteBuffer :: (queue: Queue, buffer: Buffer, bufferOffset: u64, data: *void, size: u64) -> void #foreign libwgpu_native "wgpuQueueWriteBuffer";
QueueWriteTexture :: (queue: Queue, destination: *ImageCopyTexture, data: *void, dataSize: u64, dataLayout: *TextureDataLayout, writeSize: *Extent3D) -> void #foreign libwgpu_native "wgpuQueueWriteTexture";
QueueReference :: (queue: Queue) -> void #foreign libwgpu_native "wgpuQueueReference";
QueueRelease :: (queue: Queue) -> void #foreign libwgpu_native "wgpuQueueRelease";

// Methods of RenderBundle
RenderBundleSetLabel :: (renderBundle: RenderBundle, label: *u8) -> void #foreign libwgpu_native "wgpuRenderBundleSetLabel";
RenderBundleReference :: (renderBundle: RenderBundle) -> void #foreign libwgpu_native "wgpuRenderBundleReference";
RenderBundleRelease :: (renderBundle: RenderBundle) -> void #foreign libwgpu_native "wgpuRenderBundleRelease";

// Methods of RenderBundleEncoder
RenderBundleEncoderDraw :: (renderBundleEncoder: RenderBundleEncoder, vertexCount: u32, instanceCount: u32, firstVertex: u32, firstInstance: u32) -> void #foreign libwgpu_native "wgpuRenderBundleEncoderDraw";
RenderBundleEncoderDrawIndexed :: (renderBundleEncoder: RenderBundleEncoder, indexCount: u32, instanceCount: u32, firstIndex: u32, baseVertex: s32, firstInstance: u32) -> void #foreign libwgpu_native "wgpuRenderBundleEncoderDrawIndexed";
RenderBundleEncoderDrawIndexedIndirect :: (renderBundleEncoder: RenderBundleEncoder, indirectBuffer: Buffer, indirectOffset: u64) -> void #foreign libwgpu_native "wgpuRenderBundleEncoderDrawIndexedIndirect";
RenderBundleEncoderDrawIndirect :: (renderBundleEncoder: RenderBundleEncoder, indirectBuffer: Buffer, indirectOffset: u64) -> void #foreign libwgpu_native "wgpuRenderBundleEncoderDrawIndirect";
RenderBundleEncoderFinish :: (renderBundleEncoder: RenderBundleEncoder, descriptor: *RenderBundleDescriptor) -> RenderBundle #foreign libwgpu_native "wgpuRenderBundleEncoderFinish";
RenderBundleEncoderInsertDebugMarker :: (renderBundleEncoder: RenderBundleEncoder, markerLabel: *u8) -> void #foreign libwgpu_native "wgpuRenderBundleEncoderInsertDebugMarker";
RenderBundleEncoderPopDebugGroup :: (renderBundleEncoder: RenderBundleEncoder) -> void #foreign libwgpu_native "wgpuRenderBundleEncoderPopDebugGroup";
RenderBundleEncoderPushDebugGroup :: (renderBundleEncoder: RenderBundleEncoder, groupLabel: *u8) -> void #foreign libwgpu_native "wgpuRenderBundleEncoderPushDebugGroup";
RenderBundleEncoderSetBindGroup :: (renderBundleEncoder: RenderBundleEncoder, groupIndex: u32, group: BindGroup, dynamicOffsetCount: u64, dynamicOffsets: *u32) -> void #foreign libwgpu_native "wgpuRenderBundleEncoderSetBindGroup";
RenderBundleEncoderSetIndexBuffer :: (renderBundleEncoder: RenderBundleEncoder, buffer: Buffer, format: IndexFormat, offset: u64, size: u64) -> void #foreign libwgpu_native "wgpuRenderBundleEncoderSetIndexBuffer";
RenderBundleEncoderSetLabel :: (renderBundleEncoder: RenderBundleEncoder, label: *u8) -> void #foreign libwgpu_native "wgpuRenderBundleEncoderSetLabel";
RenderBundleEncoderSetPipeline :: (renderBundleEncoder: RenderBundleEncoder, pipeline: RenderPipeline) -> void #foreign libwgpu_native "wgpuRenderBundleEncoderSetPipeline";
RenderBundleEncoderSetVertexBuffer :: (renderBundleEncoder: RenderBundleEncoder, slot: u32, buffer: Buffer, offset: u64, size: u64) -> void #foreign libwgpu_native "wgpuRenderBundleEncoderSetVertexBuffer";
RenderBundleEncoderReference :: (renderBundleEncoder: RenderBundleEncoder) -> void #foreign libwgpu_native "wgpuRenderBundleEncoderReference";
RenderBundleEncoderRelease :: (renderBundleEncoder: RenderBundleEncoder) -> void #foreign libwgpu_native "wgpuRenderBundleEncoderRelease";

// Methods of RenderPassEncoder
RenderPassEncoderBeginOcclusionQuery :: (renderPassEncoder: RenderPassEncoder, queryIndex: u32) -> void #foreign libwgpu_native "wgpuRenderPassEncoderBeginOcclusionQuery";
RenderPassEncoderDraw :: (renderPassEncoder: RenderPassEncoder, vertexCount: u32, instanceCount: u32, firstVertex: u32, firstInstance: u32) -> void #foreign libwgpu_native "wgpuRenderPassEncoderDraw";
RenderPassEncoderDrawIndexed :: (renderPassEncoder: RenderPassEncoder, indexCount: u32, instanceCount: u32, firstIndex: u32, baseVertex: s32, firstInstance: u32) -> void #foreign libwgpu_native "wgpuRenderPassEncoderDrawIndexed";
RenderPassEncoderDrawIndexedIndirect :: (renderPassEncoder: RenderPassEncoder, indirectBuffer: Buffer, indirectOffset: u64) -> void #foreign libwgpu_native "wgpuRenderPassEncoderDrawIndexedIndirect";
RenderPassEncoderDrawIndirect :: (renderPassEncoder: RenderPassEncoder, indirectBuffer: Buffer, indirectOffset: u64) -> void #foreign libwgpu_native "wgpuRenderPassEncoderDrawIndirect";
RenderPassEncoderEnd :: (renderPassEncoder: RenderPassEncoder) -> void #foreign libwgpu_native "wgpuRenderPassEncoderEnd";
RenderPassEncoderEndOcclusionQuery :: (renderPassEncoder: RenderPassEncoder) -> void #foreign libwgpu_native "wgpuRenderPassEncoderEndOcclusionQuery";
RenderPassEncoderExecuteBundles :: (renderPassEncoder: RenderPassEncoder, bundleCount: u64, bundles: *RenderBundle) -> void #foreign libwgpu_native "wgpuRenderPassEncoderExecuteBundles";
RenderPassEncoderInsertDebugMarker :: (renderPassEncoder: RenderPassEncoder, markerLabel: *u8) -> void #foreign libwgpu_native "wgpuRenderPassEncoderInsertDebugMarker";
RenderPassEncoderPopDebugGroup :: (renderPassEncoder: RenderPassEncoder) -> void #foreign libwgpu_native "wgpuRenderPassEncoderPopDebugGroup";
RenderPassEncoderPushDebugGroup :: (renderPassEncoder: RenderPassEncoder, groupLabel: *u8) -> void #foreign libwgpu_native "wgpuRenderPassEncoderPushDebugGroup";
RenderPassEncoderSetBindGroup :: (renderPassEncoder: RenderPassEncoder, groupIndex: u32, group: BindGroup, dynamicOffsetCount: u64, dynamicOffsets: *u32) -> void #foreign libwgpu_native "wgpuRenderPassEncoderSetBindGroup";
RenderPassEncoderSetBlendConstant :: (renderPassEncoder: RenderPassEncoder, color: *Color) -> void #foreign libwgpu_native "wgpuRenderPassEncoderSetBlendConstant";
RenderPassEncoderSetIndexBuffer :: (renderPassEncoder: RenderPassEncoder, buffer: Buffer, format: IndexFormat, offset: u64, size: u64) -> void #foreign libwgpu_native "wgpuRenderPassEncoderSetIndexBuffer";
RenderPassEncoderSetLabel :: (renderPassEncoder: RenderPassEncoder, label: *u8) -> void #foreign libwgpu_native "wgpuRenderPassEncoderSetLabel";
RenderPassEncoderSetPipeline :: (renderPassEncoder: RenderPassEncoder, pipeline: RenderPipeline) -> void #foreign libwgpu_native "wgpuRenderPassEncoderSetPipeline";
RenderPassEncoderSetScissorRect :: (renderPassEncoder: RenderPassEncoder, x: u32, y: u32, width: u32, height: u32) -> void #foreign libwgpu_native "wgpuRenderPassEncoderSetScissorRect";
RenderPassEncoderSetStencilReference :: (renderPassEncoder: RenderPassEncoder, reference: u32) -> void #foreign libwgpu_native "wgpuRenderPassEncoderSetStencilReference";
RenderPassEncoderSetVertexBuffer :: (renderPassEncoder: RenderPassEncoder, slot: u32, buffer: Buffer, offset: u64, size: u64) -> void #foreign libwgpu_native "wgpuRenderPassEncoderSetVertexBuffer";
RenderPassEncoderSetViewport :: (renderPassEncoder: RenderPassEncoder, x: float, y: float, width: float, height: float, minDepth: float, maxDepth: float) -> void #foreign libwgpu_native "wgpuRenderPassEncoderSetViewport";
RenderPassEncoderReference :: (renderPassEncoder: RenderPassEncoder) -> void #foreign libwgpu_native "wgpuRenderPassEncoderReference";
RenderPassEncoderRelease :: (renderPassEncoder: RenderPassEncoder) -> void #foreign libwgpu_native "wgpuRenderPassEncoderRelease";

// Methods of RenderPipeline
RenderPipelineGetBindGroupLayout :: (renderPipeline: RenderPipeline, groupIndex: u32) -> BindGroupLayout #foreign libwgpu_native "wgpuRenderPipelineGetBindGroupLayout";
RenderPipelineSetLabel :: (renderPipeline: RenderPipeline, label: *u8) -> void #foreign libwgpu_native "wgpuRenderPipelineSetLabel";
RenderPipelineReference :: (renderPipeline: RenderPipeline) -> void #foreign libwgpu_native "wgpuRenderPipelineReference";
RenderPipelineRelease :: (renderPipeline: RenderPipeline) -> void #foreign libwgpu_native "wgpuRenderPipelineRelease";

// Methods of Sampler
SamplerSetLabel :: (sampler: Sampler, label: *u8) -> void #foreign libwgpu_native "wgpuSamplerSetLabel";
SamplerReference :: (sampler: Sampler) -> void #foreign libwgpu_native "wgpuSamplerReference";
SamplerRelease :: (sampler: Sampler) -> void #foreign libwgpu_native "wgpuSamplerRelease";

// Methods of ShaderModule
ShaderModuleGetCompilationInfo :: (shaderModule: ShaderModule, callback: CompilationInfoCallback, userdata: *void) -> void #foreign libwgpu_native "wgpuShaderModuleGetCompilationInfo";
ShaderModuleSetLabel :: (shaderModule: ShaderModule, label: *u8) -> void #foreign libwgpu_native "wgpuShaderModuleSetLabel";
ShaderModuleReference :: (shaderModule: ShaderModule) -> void #foreign libwgpu_native "wgpuShaderModuleReference";
ShaderModuleRelease :: (shaderModule: ShaderModule) -> void #foreign libwgpu_native "wgpuShaderModuleRelease";

// Methods of Surface
SurfaceConfigure :: (surface: Surface, config: *SurfaceConfiguration) -> void #foreign libwgpu_native "wgpuSurfaceConfigure";
SurfaceGetCapabilities :: (surface: Surface, adapter: Adapter, capabilities: *SurfaceCapabilities) -> void #foreign libwgpu_native "wgpuSurfaceGetCapabilities";
SurfaceGetCurrentTexture :: (surface: Surface, surfaceTexture: *SurfaceTexture) -> void #foreign libwgpu_native "wgpuSurfaceGetCurrentTexture";
SurfaceGetPreferredFormat :: (surface: Surface, adapter: Adapter) -> TextureFormat #foreign libwgpu_native "wgpuSurfaceGetPreferredFormat";
SurfacePresent :: (surface: Surface) -> void #foreign libwgpu_native "wgpuSurfacePresent";
SurfaceUnconfigure :: (surface: Surface) -> void #foreign libwgpu_native "wgpuSurfaceUnconfigure";
SurfaceReference :: (surface: Surface) -> void #foreign libwgpu_native "wgpuSurfaceReference";
SurfaceRelease :: (surface: Surface) -> void #foreign libwgpu_native "wgpuSurfaceRelease";

// Methods of SurfaceCapabilities
SurfaceCapabilitiesFreeMembers :: (capabilities: SurfaceCapabilities) -> void #foreign libwgpu_native "wgpuSurfaceCapabilitiesFreeMembers";

// Methods of Texture
TextureCreateView :: (texture: Texture, descriptor: *TextureViewDescriptor) -> TextureView #foreign libwgpu_native "wgpuTextureCreateView";
TextureDestroy :: (texture: Texture) -> void #foreign libwgpu_native "wgpuTextureDestroy";
TextureGetDepthOrArrayLayers :: (texture: Texture) -> u32 #foreign libwgpu_native "wgpuTextureGetDepthOrArrayLayers";
TextureGetDimension :: (texture: Texture) -> TextureDimension #foreign libwgpu_native "wgpuTextureGetDimension";
TextureGetFormat :: (texture: Texture) -> TextureFormat #foreign libwgpu_native "wgpuTextureGetFormat";
TextureGetHeight :: (texture: Texture) -> u32 #foreign libwgpu_native "wgpuTextureGetHeight";
TextureGetMipLevelCount :: (texture: Texture) -> u32 #foreign libwgpu_native "wgpuTextureGetMipLevelCount";
TextureGetSampleCount :: (texture: Texture) -> u32 #foreign libwgpu_native "wgpuTextureGetSampleCount";
TextureGetUsage :: (texture: Texture) -> TextureUsageFlags #foreign libwgpu_native "wgpuTextureGetUsage";
TextureGetWidth :: (texture: Texture) -> u32 #foreign libwgpu_native "wgpuTextureGetWidth";
TextureSetLabel :: (texture: Texture, label: *u8) -> void #foreign libwgpu_native "wgpuTextureSetLabel";
TextureReference :: (texture: Texture) -> void #foreign libwgpu_native "wgpuTextureReference";
TextureRelease :: (texture: Texture) -> void #foreign libwgpu_native "wgpuTextureRelease";

// Methods of TextureView
TextureViewSetLabel :: (textureView: TextureView, label: *u8) -> void #foreign libwgpu_native "wgpuTextureViewSetLabel";
TextureViewReference :: (textureView: TextureView) -> void #foreign libwgpu_native "wgpuTextureViewReference";
TextureViewRelease :: (textureView: TextureView) -> void #foreign libwgpu_native "wgpuTextureViewRelease";

NativeSType :: enum u32 {
    SType_DeviceExtras               :: 196609;
    SType_RequiredLimitsExtras       :: 196610;
    SType_PipelineLayoutExtras       :: 196611;
    SType_ShaderModuleGLSLDescriptor :: 196612;
    SType_SupportedLimitsExtras      :: 196613;
    SType_InstanceExtras             :: 196614;
    SType_BindGroupEntryExtras       :: 196615;
    SType_BindGroupLayoutEntryExtras :: 196616;
    SType_QuerySetDescriptorExtras   :: 196617;
    SType_SurfaceConfigurationExtras :: 196618;
    Force32                          :: 2147483647;

    WGPUSType_DeviceExtras               :: SType_DeviceExtras;
    WGPUSType_RequiredLimitsExtras       :: SType_RequiredLimitsExtras;
    WGPUSType_PipelineLayoutExtras       :: SType_PipelineLayoutExtras;
    WGPUSType_ShaderModuleGLSLDescriptor :: SType_ShaderModuleGLSLDescriptor;
    WGPUSType_SupportedLimitsExtras      :: SType_SupportedLimitsExtras;
    WGPUSType_InstanceExtras             :: SType_InstanceExtras;
    WGPUSType_BindGroupEntryExtras       :: SType_BindGroupEntryExtras;
    WGPUSType_BindGroupLayoutEntryExtras :: SType_BindGroupLayoutEntryExtras;
    WGPUSType_QuerySetDescriptorExtras   :: SType_QuerySetDescriptorExtras;
    WGPUSType_SurfaceConfigurationExtras :: SType_SurfaceConfigurationExtras;
    WGPUNativeSType_Force32              :: Force32;
}

NativeFeature :: enum u32 {
    PushConstants                                         :: 196609;
    TextureAdapterSpecificFormatFeatures                  :: 196610;
    MultiDrawIndirect                                     :: 196611;
    MultiDrawIndirectCount                                :: 196612;
    VertexWritableStorage                                 :: 196613;
    TextureBindingArray                                   :: 196614;
    SampledTextureAndStorageBufferArrayNonUniformIndexing :: 196615;
    PipelineStatisticsQuery                               :: 196616;
    StorageResourceBindingArray                           :: 196617;
    PartiallyBoundBindingArray                            :: 196618;
    Force32                                               :: 2147483647;

    WGPUNativeFeature_PushConstants                                         :: PushConstants;
    WGPUNativeFeature_TextureAdapterSpecificFormatFeatures                  :: TextureAdapterSpecificFormatFeatures;
    WGPUNativeFeature_MultiDrawIndirect                                     :: MultiDrawIndirect;
    WGPUNativeFeature_MultiDrawIndirectCount                                :: MultiDrawIndirectCount;
    WGPUNativeFeature_VertexWritableStorage                                 :: VertexWritableStorage;
    WGPUNativeFeature_TextureBindingArray                                   :: TextureBindingArray;
    WGPUNativeFeature_SampledTextureAndStorageBufferArrayNonUniformIndexing :: SampledTextureAndStorageBufferArrayNonUniformIndexing;
    WGPUNativeFeature_PipelineStatisticsQuery                               :: PipelineStatisticsQuery;
    WGPUNativeFeature_StorageResourceBindingArray                           :: StorageResourceBindingArray;
    WGPUNativeFeature_PartiallyBoundBindingArray                            :: PartiallyBoundBindingArray;
    WGPUNativeFeature_Force32                                               :: Force32;
}

LogLevel :: enum u32 {
    Off     :: 0;
    Error   :: 1;
    Warn    :: 2;
    Info    :: 3;
    Debug   :: 4;
    Trace   :: 5;
    Force32 :: 2147483647;

    WGPULogLevel_Off     :: Off;
    WGPULogLevel_Error   :: Error;
    WGPULogLevel_Warn    :: Warn;
    WGPULogLevel_Info    :: Info;
    WGPULogLevel_Debug   :: Debug;
    WGPULogLevel_Trace   :: Trace;
    WGPULogLevel_Force32 :: Force32;
}

InstanceBackend :: enum u32 {
    All           :: 0;
    Vulkan        :: 1;
    GL            :: 2;
    Metal         :: 4;
    DX12          :: 8;
    DX11          :: 16;
    BrowserWebGPU :: 32;
    Primary       :: 45;

    Secondary     :: 18;
    Force32       :: 2147483647;

    WGPUInstanceBackend_All           :: All;
    WGPUInstanceBackend_Vulkan        :: Vulkan;
    WGPUInstanceBackend_GL            :: GL;
    WGPUInstanceBackend_Metal         :: Metal;
    WGPUInstanceBackend_DX12          :: DX12;
    WGPUInstanceBackend_DX11          :: DX11;
    WGPUInstanceBackend_BrowserWebGPU :: BrowserWebGPU;
    WGPUInstanceBackend_Primary       :: Primary;

    WGPUInstanceBackend_Secondary     :: Secondary;
    WGPUInstanceBackend_Force32       :: Force32;
}

InstanceBackendFlags :: Flags;

InstanceFlag :: enum u32 {
    Default          :: 0;
    Debug            :: 1;
    Validation       :: 2;
    DiscardHalLabels :: 4;
    Force32          :: 2147483647;

    WGPUInstanceFlag_Default          :: Default;
    WGPUInstanceFlag_Debug            :: Debug;
    WGPUInstanceFlag_Validation       :: Validation;
    WGPUInstanceFlag_DiscardHalLabels :: DiscardHalLabels;
    WGPUInstanceFlag_Force32          :: Force32;
}

InstanceFlags :: Flags;

Dx12Compiler :: enum u32 {
    Undefined :: 0;
    Fxc       :: 1;
    Dxc       :: 2;
    Force32   :: 2147483647;

    WGPUDx12Compiler_Undefined :: Undefined;
    WGPUDx12Compiler_Fxc       :: Fxc;
    WGPUDx12Compiler_Dxc       :: Dxc;
    WGPUDx12Compiler_Force32   :: Force32;
}

Gles3MinorVersion :: enum u32 {
    Automatic :: 0;
    Version0  :: 1;
    Version1  :: 2;
    Version2  :: 3;
    Force32   :: 2147483647;

    WGPUGles3MinorVersion_Automatic :: Automatic;
    WGPUGles3MinorVersion_Version0  :: Version0;
    WGPUGles3MinorVersion_Version1  :: Version1;
    WGPUGles3MinorVersion_Version2  :: Version2;
    WGPUGles3MinorVersion_Force32   :: Force32;
}

PipelineStatisticName :: enum u32 {
    VertexShaderInvocations   :: 0;
    ClipperInvocations        :: 1;
    ClipperPrimitivesOut      :: 2;
    FragmentShaderInvocations :: 3;
    ComputeShaderInvocations  :: 4;
    Force32                   :: 2147483647;

    WGPUPipelineStatisticName_VertexShaderInvocations   :: VertexShaderInvocations;
    WGPUPipelineStatisticName_ClipperInvocations        :: ClipperInvocations;
    WGPUPipelineStatisticName_ClipperPrimitivesOut      :: ClipperPrimitivesOut;
    WGPUPipelineStatisticName_FragmentShaderInvocations :: FragmentShaderInvocations;
    WGPUPipelineStatisticName_ComputeShaderInvocations  :: ComputeShaderInvocations;
    WGPUPipelineStatisticName_Force32                   :: Force32;
}

NativeQueryType :: enum u32 {
    PipelineStatistics :: 196608;
    Force32            :: 2147483647;

    WGPUNativeQueryType_PipelineStatistics :: PipelineStatistics;
    WGPUNativeQueryType_Force32            :: Force32;
}

InstanceExtras :: struct {
    chain:              ChainedStruct;
    backends:           InstanceBackendFlags;
    flags:              InstanceFlags;
    dx12ShaderCompiler: Dx12Compiler;
    gles3MinorVersion:  Gles3MinorVersion;
    dxilPath:           *u8;
    dxcPath:            *u8;
}

DeviceExtras :: struct {
    chain:     ChainedStruct;
    tracePath: *u8;
}

NativeLimits :: struct {
    maxPushConstantSize:   u32;
    maxNonSamplerBindings: u32;
}

RequiredLimitsExtras :: struct {
    chain:  ChainedStruct;
    limits: NativeLimits;
}

SupportedLimitsExtras :: struct {
    chain:  ChainedStructOut;
    limits: NativeLimits;
}

PushConstantRange :: struct {
    stages: ShaderStageFlags;
    start:  u32;
    end:    u32;
}

PipelineLayoutExtras :: struct {
    chain:                  ChainedStruct;
    pushConstantRangeCount: u64;
    pushConstantRanges:     *PushConstantRange;
}

SubmissionIndex :: u64;

WrappedSubmissionIndex :: struct {
    queue:           Queue;
    submissionIndex: SubmissionIndex;
}

ShaderDefine :: struct {
    name:  *u8;
    value: *u8;
}

ShaderModuleGLSLDescriptor :: struct {
    chain:       ChainedStruct;
    stage:       ShaderStage;
    code:        *u8;
    defineCount: u32;
    defines:     *ShaderDefine;
}

RegistryReport :: struct {
    numAllocated:        u64;
    numKeptFromUser:     u64;
    numReleasedFromUser: u64;
    numError:            u64;
    elementSize:         u64;
}

HubReport :: struct {
    adapters:         RegistryReport;
    devices:          RegistryReport;
    queues:           RegistryReport;
    pipelineLayouts:  RegistryReport;
    shaderModules:    RegistryReport;
    bindGroupLayouts: RegistryReport;
    bindGroups:       RegistryReport;
    commandBuffers:   RegistryReport;
    renderBundles:    RegistryReport;
    renderPipelines:  RegistryReport;
    computePipelines: RegistryReport;
    querySets:        RegistryReport;
    buffers:          RegistryReport;
    textures:         RegistryReport;
    textureViews:     RegistryReport;
    samplers:         RegistryReport;
}

GlobalReport :: struct {
    surfaces:    RegistryReport;
    backendType: BackendType;
    vulkan:      HubReport;
    metal:       HubReport;
    dx12:        HubReport;
    gl:          HubReport;
}

InstanceEnumerateAdapterOptions :: struct {
    nextInChain: *ChainedStruct;
    backends:    InstanceBackendFlags;
}

BindGroupEntryExtras :: struct {
    chain:            ChainedStruct;
    buffers:          *Buffer;
    bufferCount:      u64;
    samplers:         *Sampler;
    samplerCount:     u64;
    textureViews:     *TextureView;
    textureViewCount: u64;
}

BindGroupLayoutEntryExtras :: struct {
    chain: ChainedStruct;
    count: u32;
}

QuerySetDescriptorExtras :: struct {
    chain:                  ChainedStruct;
    pipelineStatistics:     *PipelineStatisticName;
    pipelineStatisticCount: u64;
}

SurfaceConfigurationExtras :: struct {
    chain:                      ChainedStruct;
    desiredMaximumFrameLatency: Bool;
}

LogCallback :: #type (level: LogLevel, message: *u8, userdata: *void) -> void #c_call;

GenerateReport :: (instance: Instance, report: *GlobalReport) -> void #foreign libwgpu_native "wgpuGenerateReport";
InstanceEnumerateAdapters :: (instance: Instance, options: *InstanceEnumerateAdapterOptions, adapters: *Adapter) -> u64 #foreign libwgpu_native "wgpuInstanceEnumerateAdapters";

QueueSubmitForIndex :: (queue: Queue, commandCount: u64, commands: *CommandBuffer) -> SubmissionIndex #foreign libwgpu_native "wgpuQueueSubmitForIndex";

// Returns true if the queue is empty, or false if there are more queue submissions still in flight.
DevicePoll :: (device: Device, wait: Bool, wrappedSubmissionIndex: *WrappedSubmissionIndex) -> Bool #foreign libwgpu_native "wgpuDevicePoll";

SetLogCallback :: (callback: LogCallback, userdata: *void) -> void #foreign libwgpu_native "wgpuSetLogCallback";

SetLogLevel :: (level: LogLevel) -> void #foreign libwgpu_native "wgpuSetLogLevel";

GetVersion :: () -> u32 #foreign libwgpu_native "wgpuGetVersion";

RenderPassEncoderSetPushConstants :: (encoder: RenderPassEncoder, stages: ShaderStageFlags, offset: u32, sizeBytes: u32, data: *void) -> void #foreign libwgpu_native "wgpuRenderPassEncoderSetPushConstants";

RenderPassEncoderMultiDrawIndirect :: (encoder: RenderPassEncoder, buffer: Buffer, offset: u64, count: u32) -> void #foreign libwgpu_native "wgpuRenderPassEncoderMultiDrawIndirect";
RenderPassEncoderMultiDrawIndexedIndirect :: (encoder: RenderPassEncoder, buffer: Buffer, offset: u64, count: u32) -> void #foreign libwgpu_native "wgpuRenderPassEncoderMultiDrawIndexedIndirect";

RenderPassEncoderMultiDrawIndirectCount :: (encoder: RenderPassEncoder, buffer: Buffer, offset: u64, count_buffer: Buffer, count_buffer_offset: u64, max_count: u32) -> void #foreign libwgpu_native "wgpuRenderPassEncoderMultiDrawIndirectCount";
RenderPassEncoderMultiDrawIndexedIndirectCount :: (encoder: RenderPassEncoder, buffer: Buffer, offset: u64, count_buffer: Buffer, count_buffer_offset: u64, max_count: u32) -> void #foreign libwgpu_native "wgpuRenderPassEncoderMultiDrawIndexedIndirectCount";

ComputePassEncoderBeginPipelineStatisticsQuery :: (computePassEncoder: ComputePassEncoder, querySet: QuerySet, queryIndex: u32) -> void #foreign libwgpu_native "wgpuComputePassEncoderBeginPipelineStatisticsQuery";
ComputePassEncoderEndPipelineStatisticsQuery :: (computePassEncoder: ComputePassEncoder) -> void #foreign libwgpu_native "wgpuComputePassEncoderEndPipelineStatisticsQuery";
RenderPassEncoderBeginPipelineStatisticsQuery :: (renderPassEncoder: RenderPassEncoder, querySet: QuerySet, queryIndex: u32) -> void #foreign libwgpu_native "wgpuRenderPassEncoderBeginPipelineStatisticsQuery";
RenderPassEncoderEndPipelineStatisticsQuery :: (renderPassEncoder: RenderPassEncoder) -> void #foreign libwgpu_native "wgpuRenderPassEncoderEndPipelineStatisticsQuery";

#scope_file

#import "Basic"; // For assert

libwgpu_native :: #library "./linux/libwgpu_native";

#run {
    {
        instance: ChainedStruct;
        assert(((cast(*void)(*instance.next)) - cast(*void)(*instance)) == 0, "ChainedStruct.next has unexpected offset % instead of 0", ((cast(*void)(*instance.next)) - cast(*void)(*instance)));
        assert(size_of(type_of(ChainedStruct.next)) == 8, "ChainedStruct.next has unexpected size % instead of 8", size_of(type_of(ChainedStruct.next)));
        assert(((cast(*void)(*instance.sType)) - cast(*void)(*instance)) == 8, "ChainedStruct.sType has unexpected offset % instead of 8", ((cast(*void)(*instance.sType)) - cast(*void)(*instance)));
        assert(size_of(type_of(ChainedStruct.sType)) == 4, "ChainedStruct.sType has unexpected size % instead of 4", size_of(type_of(ChainedStruct.sType)));
        assert(size_of(ChainedStruct) == 16, "ChainedStruct has size % instead of 16", size_of(ChainedStruct));
    }

    {
        instance: ChainedStructOut;
        assert(((cast(*void)(*instance.next)) - cast(*void)(*instance)) == 0, "ChainedStructOut.next has unexpected offset % instead of 0", ((cast(*void)(*instance.next)) - cast(*void)(*instance)));
        assert(size_of(type_of(ChainedStructOut.next)) == 8, "ChainedStructOut.next has unexpected size % instead of 8", size_of(type_of(ChainedStructOut.next)));
        assert(((cast(*void)(*instance.sType)) - cast(*void)(*instance)) == 8, "ChainedStructOut.sType has unexpected offset % instead of 8", ((cast(*void)(*instance.sType)) - cast(*void)(*instance)));
        assert(size_of(type_of(ChainedStructOut.sType)) == 4, "ChainedStructOut.sType has unexpected size % instead of 4", size_of(type_of(ChainedStructOut.sType)));
        assert(size_of(ChainedStructOut) == 16, "ChainedStructOut has size % instead of 16", size_of(ChainedStructOut));
    }

    {
        instance: AdapterProperties;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "AdapterProperties.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(AdapterProperties.nextInChain)) == 8, "AdapterProperties.nextInChain has unexpected size % instead of 8", size_of(type_of(AdapterProperties.nextInChain)));
        assert(((cast(*void)(*instance.vendorID)) - cast(*void)(*instance)) == 8, "AdapterProperties.vendorID has unexpected offset % instead of 8", ((cast(*void)(*instance.vendorID)) - cast(*void)(*instance)));
        assert(size_of(type_of(AdapterProperties.vendorID)) == 4, "AdapterProperties.vendorID has unexpected size % instead of 4", size_of(type_of(AdapterProperties.vendorID)));
        assert(((cast(*void)(*instance.vendorName)) - cast(*void)(*instance)) == 16, "AdapterProperties.vendorName has unexpected offset % instead of 16", ((cast(*void)(*instance.vendorName)) - cast(*void)(*instance)));
        assert(size_of(type_of(AdapterProperties.vendorName)) == 8, "AdapterProperties.vendorName has unexpected size % instead of 8", size_of(type_of(AdapterProperties.vendorName)));
        assert(((cast(*void)(*instance.architecture)) - cast(*void)(*instance)) == 24, "AdapterProperties.architecture has unexpected offset % instead of 24", ((cast(*void)(*instance.architecture)) - cast(*void)(*instance)));
        assert(size_of(type_of(AdapterProperties.architecture)) == 8, "AdapterProperties.architecture has unexpected size % instead of 8", size_of(type_of(AdapterProperties.architecture)));
        assert(((cast(*void)(*instance.deviceID)) - cast(*void)(*instance)) == 32, "AdapterProperties.deviceID has unexpected offset % instead of 32", ((cast(*void)(*instance.deviceID)) - cast(*void)(*instance)));
        assert(size_of(type_of(AdapterProperties.deviceID)) == 4, "AdapterProperties.deviceID has unexpected size % instead of 4", size_of(type_of(AdapterProperties.deviceID)));
        assert(((cast(*void)(*instance.name)) - cast(*void)(*instance)) == 40, "AdapterProperties.name has unexpected offset % instead of 40", ((cast(*void)(*instance.name)) - cast(*void)(*instance)));
        assert(size_of(type_of(AdapterProperties.name)) == 8, "AdapterProperties.name has unexpected size % instead of 8", size_of(type_of(AdapterProperties.name)));
        assert(((cast(*void)(*instance.driverDescription)) - cast(*void)(*instance)) == 48, "AdapterProperties.driverDescription has unexpected offset % instead of 48", ((cast(*void)(*instance.driverDescription)) - cast(*void)(*instance)));
        assert(size_of(type_of(AdapterProperties.driverDescription)) == 8, "AdapterProperties.driverDescription has unexpected size % instead of 8", size_of(type_of(AdapterProperties.driverDescription)));
        assert(((cast(*void)(*instance.adapterType)) - cast(*void)(*instance)) == 56, "AdapterProperties.adapterType has unexpected offset % instead of 56", ((cast(*void)(*instance.adapterType)) - cast(*void)(*instance)));
        assert(size_of(type_of(AdapterProperties.adapterType)) == 4, "AdapterProperties.adapterType has unexpected size % instead of 4", size_of(type_of(AdapterProperties.adapterType)));
        assert(((cast(*void)(*instance.backendType)) - cast(*void)(*instance)) == 60, "AdapterProperties.backendType has unexpected offset % instead of 60", ((cast(*void)(*instance.backendType)) - cast(*void)(*instance)));
        assert(size_of(type_of(AdapterProperties.backendType)) == 4, "AdapterProperties.backendType has unexpected size % instead of 4", size_of(type_of(AdapterProperties.backendType)));
        assert(size_of(AdapterProperties) == 64, "AdapterProperties has size % instead of 64", size_of(AdapterProperties));
    }

    {
        instance: BindGroupEntry;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "BindGroupEntry.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(BindGroupEntry.nextInChain)) == 8, "BindGroupEntry.nextInChain has unexpected size % instead of 8", size_of(type_of(BindGroupEntry.nextInChain)));
        assert(((cast(*void)(*instance.binding)) - cast(*void)(*instance)) == 8, "BindGroupEntry.binding has unexpected offset % instead of 8", ((cast(*void)(*instance.binding)) - cast(*void)(*instance)));
        assert(size_of(type_of(BindGroupEntry.binding)) == 4, "BindGroupEntry.binding has unexpected size % instead of 4", size_of(type_of(BindGroupEntry.binding)));
        assert(((cast(*void)(*instance.buffer)) - cast(*void)(*instance)) == 16, "BindGroupEntry.buffer has unexpected offset % instead of 16", ((cast(*void)(*instance.buffer)) - cast(*void)(*instance)));
        assert(size_of(type_of(BindGroupEntry.buffer)) == 8, "BindGroupEntry.buffer has unexpected size % instead of 8", size_of(type_of(BindGroupEntry.buffer)));
        assert(((cast(*void)(*instance.offset)) - cast(*void)(*instance)) == 24, "BindGroupEntry.offset has unexpected offset % instead of 24", ((cast(*void)(*instance.offset)) - cast(*void)(*instance)));
        assert(size_of(type_of(BindGroupEntry.offset)) == 8, "BindGroupEntry.offset has unexpected size % instead of 8", size_of(type_of(BindGroupEntry.offset)));
        assert(((cast(*void)(*instance.size)) - cast(*void)(*instance)) == 32, "BindGroupEntry.size has unexpected offset % instead of 32", ((cast(*void)(*instance.size)) - cast(*void)(*instance)));
        assert(size_of(type_of(BindGroupEntry.size)) == 8, "BindGroupEntry.size has unexpected size % instead of 8", size_of(type_of(BindGroupEntry.size)));
        assert(((cast(*void)(*instance.sampler)) - cast(*void)(*instance)) == 40, "BindGroupEntry.sampler has unexpected offset % instead of 40", ((cast(*void)(*instance.sampler)) - cast(*void)(*instance)));
        assert(size_of(type_of(BindGroupEntry.sampler)) == 8, "BindGroupEntry.sampler has unexpected size % instead of 8", size_of(type_of(BindGroupEntry.sampler)));
        assert(((cast(*void)(*instance.textureView)) - cast(*void)(*instance)) == 48, "BindGroupEntry.textureView has unexpected offset % instead of 48", ((cast(*void)(*instance.textureView)) - cast(*void)(*instance)));
        assert(size_of(type_of(BindGroupEntry.textureView)) == 8, "BindGroupEntry.textureView has unexpected size % instead of 8", size_of(type_of(BindGroupEntry.textureView)));
        assert(size_of(BindGroupEntry) == 56, "BindGroupEntry has size % instead of 56", size_of(BindGroupEntry));
    }

    {
        instance: BlendComponent;
        assert(((cast(*void)(*instance.operation)) - cast(*void)(*instance)) == 0, "BlendComponent.operation has unexpected offset % instead of 0", ((cast(*void)(*instance.operation)) - cast(*void)(*instance)));
        assert(size_of(type_of(BlendComponent.operation)) == 4, "BlendComponent.operation has unexpected size % instead of 4", size_of(type_of(BlendComponent.operation)));
        assert(((cast(*void)(*instance.srcFactor)) - cast(*void)(*instance)) == 4, "BlendComponent.srcFactor has unexpected offset % instead of 4", ((cast(*void)(*instance.srcFactor)) - cast(*void)(*instance)));
        assert(size_of(type_of(BlendComponent.srcFactor)) == 4, "BlendComponent.srcFactor has unexpected size % instead of 4", size_of(type_of(BlendComponent.srcFactor)));
        assert(((cast(*void)(*instance.dstFactor)) - cast(*void)(*instance)) == 8, "BlendComponent.dstFactor has unexpected offset % instead of 8", ((cast(*void)(*instance.dstFactor)) - cast(*void)(*instance)));
        assert(size_of(type_of(BlendComponent.dstFactor)) == 4, "BlendComponent.dstFactor has unexpected size % instead of 4", size_of(type_of(BlendComponent.dstFactor)));
        assert(size_of(BlendComponent) == 12, "BlendComponent has size % instead of 12", size_of(BlendComponent));
    }

    {
        instance: BufferBindingLayout;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "BufferBindingLayout.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(BufferBindingLayout.nextInChain)) == 8, "BufferBindingLayout.nextInChain has unexpected size % instead of 8", size_of(type_of(BufferBindingLayout.nextInChain)));
        assert(((cast(*void)(*instance.type)) - cast(*void)(*instance)) == 8, "BufferBindingLayout.type has unexpected offset % instead of 8", ((cast(*void)(*instance.type)) - cast(*void)(*instance)));
        assert(size_of(type_of(BufferBindingLayout.type)) == 4, "BufferBindingLayout.type has unexpected size % instead of 4", size_of(type_of(BufferBindingLayout.type)));
        assert(((cast(*void)(*instance.hasDynamicOffset)) - cast(*void)(*instance)) == 12, "BufferBindingLayout.hasDynamicOffset has unexpected offset % instead of 12", ((cast(*void)(*instance.hasDynamicOffset)) - cast(*void)(*instance)));
        assert(size_of(type_of(BufferBindingLayout.hasDynamicOffset)) == 4, "BufferBindingLayout.hasDynamicOffset has unexpected size % instead of 4", size_of(type_of(BufferBindingLayout.hasDynamicOffset)));
        assert(((cast(*void)(*instance.minBindingSize)) - cast(*void)(*instance)) == 16, "BufferBindingLayout.minBindingSize has unexpected offset % instead of 16", ((cast(*void)(*instance.minBindingSize)) - cast(*void)(*instance)));
        assert(size_of(type_of(BufferBindingLayout.minBindingSize)) == 8, "BufferBindingLayout.minBindingSize has unexpected size % instead of 8", size_of(type_of(BufferBindingLayout.minBindingSize)));
        assert(size_of(BufferBindingLayout) == 24, "BufferBindingLayout has size % instead of 24", size_of(BufferBindingLayout));
    }

    {
        instance: BufferDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "BufferDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(BufferDescriptor.nextInChain)) == 8, "BufferDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(BufferDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "BufferDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(BufferDescriptor.label)) == 8, "BufferDescriptor.label has unexpected size % instead of 8", size_of(type_of(BufferDescriptor.label)));
        assert(((cast(*void)(*instance.usage)) - cast(*void)(*instance)) == 16, "BufferDescriptor.usage has unexpected offset % instead of 16", ((cast(*void)(*instance.usage)) - cast(*void)(*instance)));
        assert(size_of(type_of(BufferDescriptor.usage)) == 4, "BufferDescriptor.usage has unexpected size % instead of 4", size_of(type_of(BufferDescriptor.usage)));
        assert(((cast(*void)(*instance.size)) - cast(*void)(*instance)) == 24, "BufferDescriptor.size has unexpected offset % instead of 24", ((cast(*void)(*instance.size)) - cast(*void)(*instance)));
        assert(size_of(type_of(BufferDescriptor.size)) == 8, "BufferDescriptor.size has unexpected size % instead of 8", size_of(type_of(BufferDescriptor.size)));
        assert(((cast(*void)(*instance.mappedAtCreation)) - cast(*void)(*instance)) == 32, "BufferDescriptor.mappedAtCreation has unexpected offset % instead of 32", ((cast(*void)(*instance.mappedAtCreation)) - cast(*void)(*instance)));
        assert(size_of(type_of(BufferDescriptor.mappedAtCreation)) == 4, "BufferDescriptor.mappedAtCreation has unexpected size % instead of 4", size_of(type_of(BufferDescriptor.mappedAtCreation)));
        assert(size_of(BufferDescriptor) == 40, "BufferDescriptor has size % instead of 40", size_of(BufferDescriptor));
    }

    {
        instance: Color;
        assert(((cast(*void)(*instance.r)) - cast(*void)(*instance)) == 0, "Color.r has unexpected offset % instead of 0", ((cast(*void)(*instance.r)) - cast(*void)(*instance)));
        assert(size_of(type_of(Color.r)) == 8, "Color.r has unexpected size % instead of 8", size_of(type_of(Color.r)));
        assert(((cast(*void)(*instance.g)) - cast(*void)(*instance)) == 8, "Color.g has unexpected offset % instead of 8", ((cast(*void)(*instance.g)) - cast(*void)(*instance)));
        assert(size_of(type_of(Color.g)) == 8, "Color.g has unexpected size % instead of 8", size_of(type_of(Color.g)));
        assert(((cast(*void)(*instance.b)) - cast(*void)(*instance)) == 16, "Color.b has unexpected offset % instead of 16", ((cast(*void)(*instance.b)) - cast(*void)(*instance)));
        assert(size_of(type_of(Color.b)) == 8, "Color.b has unexpected size % instead of 8", size_of(type_of(Color.b)));
        assert(((cast(*void)(*instance.a)) - cast(*void)(*instance)) == 24, "Color.a has unexpected offset % instead of 24", ((cast(*void)(*instance.a)) - cast(*void)(*instance)));
        assert(size_of(type_of(Color.a)) == 8, "Color.a has unexpected size % instead of 8", size_of(type_of(Color.a)));
        assert(size_of(Color) == 32, "Color has size % instead of 32", size_of(Color));
    }

    {
        instance: CommandBufferDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "CommandBufferDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(CommandBufferDescriptor.nextInChain)) == 8, "CommandBufferDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(CommandBufferDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "CommandBufferDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(CommandBufferDescriptor.label)) == 8, "CommandBufferDescriptor.label has unexpected size % instead of 8", size_of(type_of(CommandBufferDescriptor.label)));
        assert(size_of(CommandBufferDescriptor) == 16, "CommandBufferDescriptor has size % instead of 16", size_of(CommandBufferDescriptor));
    }

    {
        instance: CommandEncoderDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "CommandEncoderDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(CommandEncoderDescriptor.nextInChain)) == 8, "CommandEncoderDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(CommandEncoderDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "CommandEncoderDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(CommandEncoderDescriptor.label)) == 8, "CommandEncoderDescriptor.label has unexpected size % instead of 8", size_of(type_of(CommandEncoderDescriptor.label)));
        assert(size_of(CommandEncoderDescriptor) == 16, "CommandEncoderDescriptor has size % instead of 16", size_of(CommandEncoderDescriptor));
    }

    {
        instance: CompilationMessage;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "CompilationMessage.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(CompilationMessage.nextInChain)) == 8, "CompilationMessage.nextInChain has unexpected size % instead of 8", size_of(type_of(CompilationMessage.nextInChain)));
        assert(((cast(*void)(*instance.message)) - cast(*void)(*instance)) == 8, "CompilationMessage.message has unexpected offset % instead of 8", ((cast(*void)(*instance.message)) - cast(*void)(*instance)));
        assert(size_of(type_of(CompilationMessage.message)) == 8, "CompilationMessage.message has unexpected size % instead of 8", size_of(type_of(CompilationMessage.message)));
        assert(((cast(*void)(*instance.type)) - cast(*void)(*instance)) == 16, "CompilationMessage.type has unexpected offset % instead of 16", ((cast(*void)(*instance.type)) - cast(*void)(*instance)));
        assert(size_of(type_of(CompilationMessage.type)) == 4, "CompilationMessage.type has unexpected size % instead of 4", size_of(type_of(CompilationMessage.type)));
        assert(((cast(*void)(*instance.lineNum)) - cast(*void)(*instance)) == 24, "CompilationMessage.lineNum has unexpected offset % instead of 24", ((cast(*void)(*instance.lineNum)) - cast(*void)(*instance)));
        assert(size_of(type_of(CompilationMessage.lineNum)) == 8, "CompilationMessage.lineNum has unexpected size % instead of 8", size_of(type_of(CompilationMessage.lineNum)));
        assert(((cast(*void)(*instance.linePos)) - cast(*void)(*instance)) == 32, "CompilationMessage.linePos has unexpected offset % instead of 32", ((cast(*void)(*instance.linePos)) - cast(*void)(*instance)));
        assert(size_of(type_of(CompilationMessage.linePos)) == 8, "CompilationMessage.linePos has unexpected size % instead of 8", size_of(type_of(CompilationMessage.linePos)));
        assert(((cast(*void)(*instance.offset)) - cast(*void)(*instance)) == 40, "CompilationMessage.offset has unexpected offset % instead of 40", ((cast(*void)(*instance.offset)) - cast(*void)(*instance)));
        assert(size_of(type_of(CompilationMessage.offset)) == 8, "CompilationMessage.offset has unexpected size % instead of 8", size_of(type_of(CompilationMessage.offset)));
        assert(((cast(*void)(*instance.length)) - cast(*void)(*instance)) == 48, "CompilationMessage.length has unexpected offset % instead of 48", ((cast(*void)(*instance.length)) - cast(*void)(*instance)));
        assert(size_of(type_of(CompilationMessage.length)) == 8, "CompilationMessage.length has unexpected size % instead of 8", size_of(type_of(CompilationMessage.length)));
        assert(((cast(*void)(*instance.utf16LinePos)) - cast(*void)(*instance)) == 56, "CompilationMessage.utf16LinePos has unexpected offset % instead of 56", ((cast(*void)(*instance.utf16LinePos)) - cast(*void)(*instance)));
        assert(size_of(type_of(CompilationMessage.utf16LinePos)) == 8, "CompilationMessage.utf16LinePos has unexpected size % instead of 8", size_of(type_of(CompilationMessage.utf16LinePos)));
        assert(((cast(*void)(*instance.utf16Offset)) - cast(*void)(*instance)) == 64, "CompilationMessage.utf16Offset has unexpected offset % instead of 64", ((cast(*void)(*instance.utf16Offset)) - cast(*void)(*instance)));
        assert(size_of(type_of(CompilationMessage.utf16Offset)) == 8, "CompilationMessage.utf16Offset has unexpected size % instead of 8", size_of(type_of(CompilationMessage.utf16Offset)));
        assert(((cast(*void)(*instance.utf16Length)) - cast(*void)(*instance)) == 72, "CompilationMessage.utf16Length has unexpected offset % instead of 72", ((cast(*void)(*instance.utf16Length)) - cast(*void)(*instance)));
        assert(size_of(type_of(CompilationMessage.utf16Length)) == 8, "CompilationMessage.utf16Length has unexpected size % instead of 8", size_of(type_of(CompilationMessage.utf16Length)));
        assert(size_of(CompilationMessage) == 80, "CompilationMessage has size % instead of 80", size_of(CompilationMessage));
    }

    {
        instance: ComputePassTimestampWrites;
        assert(((cast(*void)(*instance.querySet)) - cast(*void)(*instance)) == 0, "ComputePassTimestampWrites.querySet has unexpected offset % instead of 0", ((cast(*void)(*instance.querySet)) - cast(*void)(*instance)));
        assert(size_of(type_of(ComputePassTimestampWrites.querySet)) == 8, "ComputePassTimestampWrites.querySet has unexpected size % instead of 8", size_of(type_of(ComputePassTimestampWrites.querySet)));
        assert(((cast(*void)(*instance.beginningOfPassWriteIndex)) - cast(*void)(*instance)) == 8, "ComputePassTimestampWrites.beginningOfPassWriteIndex has unexpected offset % instead of 8", ((cast(*void)(*instance.beginningOfPassWriteIndex)) - cast(*void)(*instance)));
        assert(size_of(type_of(ComputePassTimestampWrites.beginningOfPassWriteIndex)) == 4, "ComputePassTimestampWrites.beginningOfPassWriteIndex has unexpected size % instead of 4", size_of(type_of(ComputePassTimestampWrites.beginningOfPassWriteIndex)));
        assert(((cast(*void)(*instance.endOfPassWriteIndex)) - cast(*void)(*instance)) == 12, "ComputePassTimestampWrites.endOfPassWriteIndex has unexpected offset % instead of 12", ((cast(*void)(*instance.endOfPassWriteIndex)) - cast(*void)(*instance)));
        assert(size_of(type_of(ComputePassTimestampWrites.endOfPassWriteIndex)) == 4, "ComputePassTimestampWrites.endOfPassWriteIndex has unexpected size % instead of 4", size_of(type_of(ComputePassTimestampWrites.endOfPassWriteIndex)));
        assert(size_of(ComputePassTimestampWrites) == 16, "ComputePassTimestampWrites has size % instead of 16", size_of(ComputePassTimestampWrites));
    }

    {
        instance: ConstantEntry;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "ConstantEntry.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(ConstantEntry.nextInChain)) == 8, "ConstantEntry.nextInChain has unexpected size % instead of 8", size_of(type_of(ConstantEntry.nextInChain)));
        assert(((cast(*void)(*instance.key)) - cast(*void)(*instance)) == 8, "ConstantEntry.key has unexpected offset % instead of 8", ((cast(*void)(*instance.key)) - cast(*void)(*instance)));
        assert(size_of(type_of(ConstantEntry.key)) == 8, "ConstantEntry.key has unexpected size % instead of 8", size_of(type_of(ConstantEntry.key)));
        assert(((cast(*void)(*instance.value)) - cast(*void)(*instance)) == 16, "ConstantEntry.value has unexpected offset % instead of 16", ((cast(*void)(*instance.value)) - cast(*void)(*instance)));
        assert(size_of(type_of(ConstantEntry.value)) == 8, "ConstantEntry.value has unexpected size % instead of 8", size_of(type_of(ConstantEntry.value)));
        assert(size_of(ConstantEntry) == 24, "ConstantEntry has size % instead of 24", size_of(ConstantEntry));
    }

    {
        instance: Extent3D;
        assert(((cast(*void)(*instance.width)) - cast(*void)(*instance)) == 0, "Extent3D.width has unexpected offset % instead of 0", ((cast(*void)(*instance.width)) - cast(*void)(*instance)));
        assert(size_of(type_of(Extent3D.width)) == 4, "Extent3D.width has unexpected size % instead of 4", size_of(type_of(Extent3D.width)));
        assert(((cast(*void)(*instance.height)) - cast(*void)(*instance)) == 4, "Extent3D.height has unexpected offset % instead of 4", ((cast(*void)(*instance.height)) - cast(*void)(*instance)));
        assert(size_of(type_of(Extent3D.height)) == 4, "Extent3D.height has unexpected size % instead of 4", size_of(type_of(Extent3D.height)));
        assert(((cast(*void)(*instance.depthOrArrayLayers)) - cast(*void)(*instance)) == 8, "Extent3D.depthOrArrayLayers has unexpected offset % instead of 8", ((cast(*void)(*instance.depthOrArrayLayers)) - cast(*void)(*instance)));
        assert(size_of(type_of(Extent3D.depthOrArrayLayers)) == 4, "Extent3D.depthOrArrayLayers has unexpected size % instead of 4", size_of(type_of(Extent3D.depthOrArrayLayers)));
        assert(size_of(Extent3D) == 12, "Extent3D has size % instead of 12", size_of(Extent3D));
    }

    {
        instance: InstanceDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "InstanceDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(InstanceDescriptor.nextInChain)) == 8, "InstanceDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(InstanceDescriptor.nextInChain)));
        assert(size_of(InstanceDescriptor) == 8, "InstanceDescriptor has size % instead of 8", size_of(InstanceDescriptor));
    }

    {
        instance: Limits;
        assert(((cast(*void)(*instance.maxTextureDimension1D)) - cast(*void)(*instance)) == 0, "Limits.maxTextureDimension1D has unexpected offset % instead of 0", ((cast(*void)(*instance.maxTextureDimension1D)) - cast(*void)(*instance)));
        assert(size_of(type_of(Limits.maxTextureDimension1D)) == 4, "Limits.maxTextureDimension1D has unexpected size % instead of 4", size_of(type_of(Limits.maxTextureDimension1D)));
        assert(((cast(*void)(*instance.maxTextureDimension2D)) - cast(*void)(*instance)) == 4, "Limits.maxTextureDimension2D has unexpected offset % instead of 4", ((cast(*void)(*instance.maxTextureDimension2D)) - cast(*void)(*instance)));
        assert(size_of(type_of(Limits.maxTextureDimension2D)) == 4, "Limits.maxTextureDimension2D has unexpected size % instead of 4", size_of(type_of(Limits.maxTextureDimension2D)));
        assert(((cast(*void)(*instance.maxTextureDimension3D)) - cast(*void)(*instance)) == 8, "Limits.maxTextureDimension3D has unexpected offset % instead of 8", ((cast(*void)(*instance.maxTextureDimension3D)) - cast(*void)(*instance)));
        assert(size_of(type_of(Limits.maxTextureDimension3D)) == 4, "Limits.maxTextureDimension3D has unexpected size % instead of 4", size_of(type_of(Limits.maxTextureDimension3D)));
        assert(((cast(*void)(*instance.maxTextureArrayLayers)) - cast(*void)(*instance)) == 12, "Limits.maxTextureArrayLayers has unexpected offset % instead of 12", ((cast(*void)(*instance.maxTextureArrayLayers)) - cast(*void)(*instance)));
        assert(size_of(type_of(Limits.maxTextureArrayLayers)) == 4, "Limits.maxTextureArrayLayers has unexpected size % instead of 4", size_of(type_of(Limits.maxTextureArrayLayers)));
        assert(((cast(*void)(*instance.maxBindGroups)) - cast(*void)(*instance)) == 16, "Limits.maxBindGroups has unexpected offset % instead of 16", ((cast(*void)(*instance.maxBindGroups)) - cast(*void)(*instance)));
        assert(size_of(type_of(Limits.maxBindGroups)) == 4, "Limits.maxBindGroups has unexpected size % instead of 4", size_of(type_of(Limits.maxBindGroups)));
        assert(((cast(*void)(*instance.maxBindGroupsPlusVertexBuffers)) - cast(*void)(*instance)) == 20, "Limits.maxBindGroupsPlusVertexBuffers has unexpected offset % instead of 20", ((cast(*void)(*instance.maxBindGroupsPlusVertexBuffers)) - cast(*void)(*instance)));
        assert(size_of(type_of(Limits.maxBindGroupsPlusVertexBuffers)) == 4, "Limits.maxBindGroupsPlusVertexBuffers has unexpected size % instead of 4", size_of(type_of(Limits.maxBindGroupsPlusVertexBuffers)));
        assert(((cast(*void)(*instance.maxBindingsPerBindGroup)) - cast(*void)(*instance)) == 24, "Limits.maxBindingsPerBindGroup has unexpected offset % instead of 24", ((cast(*void)(*instance.maxBindingsPerBindGroup)) - cast(*void)(*instance)));
        assert(size_of(type_of(Limits.maxBindingsPerBindGroup)) == 4, "Limits.maxBindingsPerBindGroup has unexpected size % instead of 4", size_of(type_of(Limits.maxBindingsPerBindGroup)));
        assert(((cast(*void)(*instance.maxDynamicUniformBuffersPerPipelineLayout)) - cast(*void)(*instance)) == 28, "Limits.maxDynamicUniformBuffersPerPipelineLayout has unexpected offset % instead of 28", ((cast(*void)(*instance.maxDynamicUniformBuffersPerPipelineLayout)) - cast(*void)(*instance)));
        assert(size_of(type_of(Limits.maxDynamicUniformBuffersPerPipelineLayout)) == 4, "Limits.maxDynamicUniformBuffersPerPipelineLayout has unexpected size % instead of 4", size_of(type_of(Limits.maxDynamicUniformBuffersPerPipelineLayout)));
        assert(((cast(*void)(*instance.maxDynamicStorageBuffersPerPipelineLayout)) - cast(*void)(*instance)) == 32, "Limits.maxDynamicStorageBuffersPerPipelineLayout has unexpected offset % instead of 32", ((cast(*void)(*instance.maxDynamicStorageBuffersPerPipelineLayout)) - cast(*void)(*instance)));
        assert(size_of(type_of(Limits.maxDynamicStorageBuffersPerPipelineLayout)) == 4, "Limits.maxDynamicStorageBuffersPerPipelineLayout has unexpected size % instead of 4", size_of(type_of(Limits.maxDynamicStorageBuffersPerPipelineLayout)));
        assert(((cast(*void)(*instance.maxSampledTexturesPerShaderStage)) - cast(*void)(*instance)) == 36, "Limits.maxSampledTexturesPerShaderStage has unexpected offset % instead of 36", ((cast(*void)(*instance.maxSampledTexturesPerShaderStage)) - cast(*void)(*instance)));
        assert(size_of(type_of(Limits.maxSampledTexturesPerShaderStage)) == 4, "Limits.maxSampledTexturesPerShaderStage has unexpected size % instead of 4", size_of(type_of(Limits.maxSampledTexturesPerShaderStage)));
        assert(((cast(*void)(*instance.maxSamplersPerShaderStage)) - cast(*void)(*instance)) == 40, "Limits.maxSamplersPerShaderStage has unexpected offset % instead of 40", ((cast(*void)(*instance.maxSamplersPerShaderStage)) - cast(*void)(*instance)));
        assert(size_of(type_of(Limits.maxSamplersPerShaderStage)) == 4, "Limits.maxSamplersPerShaderStage has unexpected size % instead of 4", size_of(type_of(Limits.maxSamplersPerShaderStage)));
        assert(((cast(*void)(*instance.maxStorageBuffersPerShaderStage)) - cast(*void)(*instance)) == 44, "Limits.maxStorageBuffersPerShaderStage has unexpected offset % instead of 44", ((cast(*void)(*instance.maxStorageBuffersPerShaderStage)) - cast(*void)(*instance)));
        assert(size_of(type_of(Limits.maxStorageBuffersPerShaderStage)) == 4, "Limits.maxStorageBuffersPerShaderStage has unexpected size % instead of 4", size_of(type_of(Limits.maxStorageBuffersPerShaderStage)));
        assert(((cast(*void)(*instance.maxStorageTexturesPerShaderStage)) - cast(*void)(*instance)) == 48, "Limits.maxStorageTexturesPerShaderStage has unexpected offset % instead of 48", ((cast(*void)(*instance.maxStorageTexturesPerShaderStage)) - cast(*void)(*instance)));
        assert(size_of(type_of(Limits.maxStorageTexturesPerShaderStage)) == 4, "Limits.maxStorageTexturesPerShaderStage has unexpected size % instead of 4", size_of(type_of(Limits.maxStorageTexturesPerShaderStage)));
        assert(((cast(*void)(*instance.maxUniformBuffersPerShaderStage)) - cast(*void)(*instance)) == 52, "Limits.maxUniformBuffersPerShaderStage has unexpected offset % instead of 52", ((cast(*void)(*instance.maxUniformBuffersPerShaderStage)) - cast(*void)(*instance)));
        assert(size_of(type_of(Limits.maxUniformBuffersPerShaderStage)) == 4, "Limits.maxUniformBuffersPerShaderStage has unexpected size % instead of 4", size_of(type_of(Limits.maxUniformBuffersPerShaderStage)));
        assert(((cast(*void)(*instance.maxUniformBufferBindingSize)) - cast(*void)(*instance)) == 56, "Limits.maxUniformBufferBindingSize has unexpected offset % instead of 56", ((cast(*void)(*instance.maxUniformBufferBindingSize)) - cast(*void)(*instance)));
        assert(size_of(type_of(Limits.maxUniformBufferBindingSize)) == 8, "Limits.maxUniformBufferBindingSize has unexpected size % instead of 8", size_of(type_of(Limits.maxUniformBufferBindingSize)));
        assert(((cast(*void)(*instance.maxStorageBufferBindingSize)) - cast(*void)(*instance)) == 64, "Limits.maxStorageBufferBindingSize has unexpected offset % instead of 64", ((cast(*void)(*instance.maxStorageBufferBindingSize)) - cast(*void)(*instance)));
        assert(size_of(type_of(Limits.maxStorageBufferBindingSize)) == 8, "Limits.maxStorageBufferBindingSize has unexpected size % instead of 8", size_of(type_of(Limits.maxStorageBufferBindingSize)));
        assert(((cast(*void)(*instance.minUniformBufferOffsetAlignment)) - cast(*void)(*instance)) == 72, "Limits.minUniformBufferOffsetAlignment has unexpected offset % instead of 72", ((cast(*void)(*instance.minUniformBufferOffsetAlignment)) - cast(*void)(*instance)));
        assert(size_of(type_of(Limits.minUniformBufferOffsetAlignment)) == 4, "Limits.minUniformBufferOffsetAlignment has unexpected size % instead of 4", size_of(type_of(Limits.minUniformBufferOffsetAlignment)));
        assert(((cast(*void)(*instance.minStorageBufferOffsetAlignment)) - cast(*void)(*instance)) == 76, "Limits.minStorageBufferOffsetAlignment has unexpected offset % instead of 76", ((cast(*void)(*instance.minStorageBufferOffsetAlignment)) - cast(*void)(*instance)));
        assert(size_of(type_of(Limits.minStorageBufferOffsetAlignment)) == 4, "Limits.minStorageBufferOffsetAlignment has unexpected size % instead of 4", size_of(type_of(Limits.minStorageBufferOffsetAlignment)));
        assert(((cast(*void)(*instance.maxVertexBuffers)) - cast(*void)(*instance)) == 80, "Limits.maxVertexBuffers has unexpected offset % instead of 80", ((cast(*void)(*instance.maxVertexBuffers)) - cast(*void)(*instance)));
        assert(size_of(type_of(Limits.maxVertexBuffers)) == 4, "Limits.maxVertexBuffers has unexpected size % instead of 4", size_of(type_of(Limits.maxVertexBuffers)));
        assert(((cast(*void)(*instance.maxBufferSize)) - cast(*void)(*instance)) == 88, "Limits.maxBufferSize has unexpected offset % instead of 88", ((cast(*void)(*instance.maxBufferSize)) - cast(*void)(*instance)));
        assert(size_of(type_of(Limits.maxBufferSize)) == 8, "Limits.maxBufferSize has unexpected size % instead of 8", size_of(type_of(Limits.maxBufferSize)));
        assert(((cast(*void)(*instance.maxVertexAttributes)) - cast(*void)(*instance)) == 96, "Limits.maxVertexAttributes has unexpected offset % instead of 96", ((cast(*void)(*instance.maxVertexAttributes)) - cast(*void)(*instance)));
        assert(size_of(type_of(Limits.maxVertexAttributes)) == 4, "Limits.maxVertexAttributes has unexpected size % instead of 4", size_of(type_of(Limits.maxVertexAttributes)));
        assert(((cast(*void)(*instance.maxVertexBufferArrayStride)) - cast(*void)(*instance)) == 100, "Limits.maxVertexBufferArrayStride has unexpected offset % instead of 100", ((cast(*void)(*instance.maxVertexBufferArrayStride)) - cast(*void)(*instance)));
        assert(size_of(type_of(Limits.maxVertexBufferArrayStride)) == 4, "Limits.maxVertexBufferArrayStride has unexpected size % instead of 4", size_of(type_of(Limits.maxVertexBufferArrayStride)));
        assert(((cast(*void)(*instance.maxInterStageShaderComponents)) - cast(*void)(*instance)) == 104, "Limits.maxInterStageShaderComponents has unexpected offset % instead of 104", ((cast(*void)(*instance.maxInterStageShaderComponents)) - cast(*void)(*instance)));
        assert(size_of(type_of(Limits.maxInterStageShaderComponents)) == 4, "Limits.maxInterStageShaderComponents has unexpected size % instead of 4", size_of(type_of(Limits.maxInterStageShaderComponents)));
        assert(((cast(*void)(*instance.maxInterStageShaderVariables)) - cast(*void)(*instance)) == 108, "Limits.maxInterStageShaderVariables has unexpected offset % instead of 108", ((cast(*void)(*instance.maxInterStageShaderVariables)) - cast(*void)(*instance)));
        assert(size_of(type_of(Limits.maxInterStageShaderVariables)) == 4, "Limits.maxInterStageShaderVariables has unexpected size % instead of 4", size_of(type_of(Limits.maxInterStageShaderVariables)));
        assert(((cast(*void)(*instance.maxColorAttachments)) - cast(*void)(*instance)) == 112, "Limits.maxColorAttachments has unexpected offset % instead of 112", ((cast(*void)(*instance.maxColorAttachments)) - cast(*void)(*instance)));
        assert(size_of(type_of(Limits.maxColorAttachments)) == 4, "Limits.maxColorAttachments has unexpected size % instead of 4", size_of(type_of(Limits.maxColorAttachments)));
        assert(((cast(*void)(*instance.maxColorAttachmentBytesPerSample)) - cast(*void)(*instance)) == 116, "Limits.maxColorAttachmentBytesPerSample has unexpected offset % instead of 116", ((cast(*void)(*instance.maxColorAttachmentBytesPerSample)) - cast(*void)(*instance)));
        assert(size_of(type_of(Limits.maxColorAttachmentBytesPerSample)) == 4, "Limits.maxColorAttachmentBytesPerSample has unexpected size % instead of 4", size_of(type_of(Limits.maxColorAttachmentBytesPerSample)));
        assert(((cast(*void)(*instance.maxComputeWorkgroupStorageSize)) - cast(*void)(*instance)) == 120, "Limits.maxComputeWorkgroupStorageSize has unexpected offset % instead of 120", ((cast(*void)(*instance.maxComputeWorkgroupStorageSize)) - cast(*void)(*instance)));
        assert(size_of(type_of(Limits.maxComputeWorkgroupStorageSize)) == 4, "Limits.maxComputeWorkgroupStorageSize has unexpected size % instead of 4", size_of(type_of(Limits.maxComputeWorkgroupStorageSize)));
        assert(((cast(*void)(*instance.maxComputeInvocationsPerWorkgroup)) - cast(*void)(*instance)) == 124, "Limits.maxComputeInvocationsPerWorkgroup has unexpected offset % instead of 124", ((cast(*void)(*instance.maxComputeInvocationsPerWorkgroup)) - cast(*void)(*instance)));
        assert(size_of(type_of(Limits.maxComputeInvocationsPerWorkgroup)) == 4, "Limits.maxComputeInvocationsPerWorkgroup has unexpected size % instead of 4", size_of(type_of(Limits.maxComputeInvocationsPerWorkgroup)));
        assert(((cast(*void)(*instance.maxComputeWorkgroupSizeX)) - cast(*void)(*instance)) == 128, "Limits.maxComputeWorkgroupSizeX has unexpected offset % instead of 128", ((cast(*void)(*instance.maxComputeWorkgroupSizeX)) - cast(*void)(*instance)));
        assert(size_of(type_of(Limits.maxComputeWorkgroupSizeX)) == 4, "Limits.maxComputeWorkgroupSizeX has unexpected size % instead of 4", size_of(type_of(Limits.maxComputeWorkgroupSizeX)));
        assert(((cast(*void)(*instance.maxComputeWorkgroupSizeY)) - cast(*void)(*instance)) == 132, "Limits.maxComputeWorkgroupSizeY has unexpected offset % instead of 132", ((cast(*void)(*instance.maxComputeWorkgroupSizeY)) - cast(*void)(*instance)));
        assert(size_of(type_of(Limits.maxComputeWorkgroupSizeY)) == 4, "Limits.maxComputeWorkgroupSizeY has unexpected size % instead of 4", size_of(type_of(Limits.maxComputeWorkgroupSizeY)));
        assert(((cast(*void)(*instance.maxComputeWorkgroupSizeZ)) - cast(*void)(*instance)) == 136, "Limits.maxComputeWorkgroupSizeZ has unexpected offset % instead of 136", ((cast(*void)(*instance.maxComputeWorkgroupSizeZ)) - cast(*void)(*instance)));
        assert(size_of(type_of(Limits.maxComputeWorkgroupSizeZ)) == 4, "Limits.maxComputeWorkgroupSizeZ has unexpected size % instead of 4", size_of(type_of(Limits.maxComputeWorkgroupSizeZ)));
        assert(((cast(*void)(*instance.maxComputeWorkgroupsPerDimension)) - cast(*void)(*instance)) == 140, "Limits.maxComputeWorkgroupsPerDimension has unexpected offset % instead of 140", ((cast(*void)(*instance.maxComputeWorkgroupsPerDimension)) - cast(*void)(*instance)));
        assert(size_of(type_of(Limits.maxComputeWorkgroupsPerDimension)) == 4, "Limits.maxComputeWorkgroupsPerDimension has unexpected size % instead of 4", size_of(type_of(Limits.maxComputeWorkgroupsPerDimension)));
        assert(size_of(Limits) == 144, "Limits has size % instead of 144", size_of(Limits));
    }

    {
        instance: MultisampleState;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "MultisampleState.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(MultisampleState.nextInChain)) == 8, "MultisampleState.nextInChain has unexpected size % instead of 8", size_of(type_of(MultisampleState.nextInChain)));
        assert(((cast(*void)(*instance.count)) - cast(*void)(*instance)) == 8, "MultisampleState.count has unexpected offset % instead of 8", ((cast(*void)(*instance.count)) - cast(*void)(*instance)));
        assert(size_of(type_of(MultisampleState.count)) == 4, "MultisampleState.count has unexpected size % instead of 4", size_of(type_of(MultisampleState.count)));
        assert(((cast(*void)(*instance.mask)) - cast(*void)(*instance)) == 12, "MultisampleState.mask has unexpected offset % instead of 12", ((cast(*void)(*instance.mask)) - cast(*void)(*instance)));
        assert(size_of(type_of(MultisampleState.mask)) == 4, "MultisampleState.mask has unexpected size % instead of 4", size_of(type_of(MultisampleState.mask)));
        assert(((cast(*void)(*instance.alphaToCoverageEnabled)) - cast(*void)(*instance)) == 16, "MultisampleState.alphaToCoverageEnabled has unexpected offset % instead of 16", ((cast(*void)(*instance.alphaToCoverageEnabled)) - cast(*void)(*instance)));
        assert(size_of(type_of(MultisampleState.alphaToCoverageEnabled)) == 4, "MultisampleState.alphaToCoverageEnabled has unexpected size % instead of 4", size_of(type_of(MultisampleState.alphaToCoverageEnabled)));
        assert(size_of(MultisampleState) == 24, "MultisampleState has size % instead of 24", size_of(MultisampleState));
    }

    {
        instance: Origin3D;
        assert(((cast(*void)(*instance.x)) - cast(*void)(*instance)) == 0, "Origin3D.x has unexpected offset % instead of 0", ((cast(*void)(*instance.x)) - cast(*void)(*instance)));
        assert(size_of(type_of(Origin3D.x)) == 4, "Origin3D.x has unexpected size % instead of 4", size_of(type_of(Origin3D.x)));
        assert(((cast(*void)(*instance.y)) - cast(*void)(*instance)) == 4, "Origin3D.y has unexpected offset % instead of 4", ((cast(*void)(*instance.y)) - cast(*void)(*instance)));
        assert(size_of(type_of(Origin3D.y)) == 4, "Origin3D.y has unexpected size % instead of 4", size_of(type_of(Origin3D.y)));
        assert(((cast(*void)(*instance.z)) - cast(*void)(*instance)) == 8, "Origin3D.z has unexpected offset % instead of 8", ((cast(*void)(*instance.z)) - cast(*void)(*instance)));
        assert(size_of(type_of(Origin3D.z)) == 4, "Origin3D.z has unexpected size % instead of 4", size_of(type_of(Origin3D.z)));
        assert(size_of(Origin3D) == 12, "Origin3D has size % instead of 12", size_of(Origin3D));
    }

    {
        instance: PipelineLayoutDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "PipelineLayoutDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(PipelineLayoutDescriptor.nextInChain)) == 8, "PipelineLayoutDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(PipelineLayoutDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "PipelineLayoutDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(PipelineLayoutDescriptor.label)) == 8, "PipelineLayoutDescriptor.label has unexpected size % instead of 8", size_of(type_of(PipelineLayoutDescriptor.label)));
        assert(((cast(*void)(*instance.bindGroupLayoutCount)) - cast(*void)(*instance)) == 16, "PipelineLayoutDescriptor.bindGroupLayoutCount has unexpected offset % instead of 16", ((cast(*void)(*instance.bindGroupLayoutCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(PipelineLayoutDescriptor.bindGroupLayoutCount)) == 8, "PipelineLayoutDescriptor.bindGroupLayoutCount has unexpected size % instead of 8", size_of(type_of(PipelineLayoutDescriptor.bindGroupLayoutCount)));
        assert(((cast(*void)(*instance.bindGroupLayouts)) - cast(*void)(*instance)) == 24, "PipelineLayoutDescriptor.bindGroupLayouts has unexpected offset % instead of 24", ((cast(*void)(*instance.bindGroupLayouts)) - cast(*void)(*instance)));
        assert(size_of(type_of(PipelineLayoutDescriptor.bindGroupLayouts)) == 8, "PipelineLayoutDescriptor.bindGroupLayouts has unexpected size % instead of 8", size_of(type_of(PipelineLayoutDescriptor.bindGroupLayouts)));
        assert(size_of(PipelineLayoutDescriptor) == 32, "PipelineLayoutDescriptor has size % instead of 32", size_of(PipelineLayoutDescriptor));
    }

    {
        instance: PrimitiveDepthClipControl;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "PrimitiveDepthClipControl.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(PrimitiveDepthClipControl.chain)) == 16, "PrimitiveDepthClipControl.chain has unexpected size % instead of 16", size_of(type_of(PrimitiveDepthClipControl.chain)));
        assert(((cast(*void)(*instance.unclippedDepth)) - cast(*void)(*instance)) == 16, "PrimitiveDepthClipControl.unclippedDepth has unexpected offset % instead of 16", ((cast(*void)(*instance.unclippedDepth)) - cast(*void)(*instance)));
        assert(size_of(type_of(PrimitiveDepthClipControl.unclippedDepth)) == 4, "PrimitiveDepthClipControl.unclippedDepth has unexpected size % instead of 4", size_of(type_of(PrimitiveDepthClipControl.unclippedDepth)));
        assert(size_of(PrimitiveDepthClipControl) == 24, "PrimitiveDepthClipControl has size % instead of 24", size_of(PrimitiveDepthClipControl));
    }

    {
        instance: PrimitiveState;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "PrimitiveState.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(PrimitiveState.nextInChain)) == 8, "PrimitiveState.nextInChain has unexpected size % instead of 8", size_of(type_of(PrimitiveState.nextInChain)));
        assert(((cast(*void)(*instance.topology)) - cast(*void)(*instance)) == 8, "PrimitiveState.topology has unexpected offset % instead of 8", ((cast(*void)(*instance.topology)) - cast(*void)(*instance)));
        assert(size_of(type_of(PrimitiveState.topology)) == 4, "PrimitiveState.topology has unexpected size % instead of 4", size_of(type_of(PrimitiveState.topology)));
        assert(((cast(*void)(*instance.stripIndexFormat)) - cast(*void)(*instance)) == 12, "PrimitiveState.stripIndexFormat has unexpected offset % instead of 12", ((cast(*void)(*instance.stripIndexFormat)) - cast(*void)(*instance)));
        assert(size_of(type_of(PrimitiveState.stripIndexFormat)) == 4, "PrimitiveState.stripIndexFormat has unexpected size % instead of 4", size_of(type_of(PrimitiveState.stripIndexFormat)));
        assert(((cast(*void)(*instance.frontFace)) - cast(*void)(*instance)) == 16, "PrimitiveState.frontFace has unexpected offset % instead of 16", ((cast(*void)(*instance.frontFace)) - cast(*void)(*instance)));
        assert(size_of(type_of(PrimitiveState.frontFace)) == 4, "PrimitiveState.frontFace has unexpected size % instead of 4", size_of(type_of(PrimitiveState.frontFace)));
        assert(((cast(*void)(*instance.cullMode)) - cast(*void)(*instance)) == 20, "PrimitiveState.cullMode has unexpected offset % instead of 20", ((cast(*void)(*instance.cullMode)) - cast(*void)(*instance)));
        assert(size_of(type_of(PrimitiveState.cullMode)) == 4, "PrimitiveState.cullMode has unexpected size % instead of 4", size_of(type_of(PrimitiveState.cullMode)));
        assert(size_of(PrimitiveState) == 24, "PrimitiveState has size % instead of 24", size_of(PrimitiveState));
    }

    {
        instance: QuerySetDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "QuerySetDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(QuerySetDescriptor.nextInChain)) == 8, "QuerySetDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(QuerySetDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "QuerySetDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(QuerySetDescriptor.label)) == 8, "QuerySetDescriptor.label has unexpected size % instead of 8", size_of(type_of(QuerySetDescriptor.label)));
        assert(((cast(*void)(*instance.type)) - cast(*void)(*instance)) == 16, "QuerySetDescriptor.type has unexpected offset % instead of 16", ((cast(*void)(*instance.type)) - cast(*void)(*instance)));
        assert(size_of(type_of(QuerySetDescriptor.type)) == 4, "QuerySetDescriptor.type has unexpected size % instead of 4", size_of(type_of(QuerySetDescriptor.type)));
        assert(((cast(*void)(*instance.count)) - cast(*void)(*instance)) == 20, "QuerySetDescriptor.count has unexpected offset % instead of 20", ((cast(*void)(*instance.count)) - cast(*void)(*instance)));
        assert(size_of(type_of(QuerySetDescriptor.count)) == 4, "QuerySetDescriptor.count has unexpected size % instead of 4", size_of(type_of(QuerySetDescriptor.count)));
        assert(size_of(QuerySetDescriptor) == 24, "QuerySetDescriptor has size % instead of 24", size_of(QuerySetDescriptor));
    }

    {
        instance: QueueDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "QueueDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(QueueDescriptor.nextInChain)) == 8, "QueueDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(QueueDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "QueueDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(QueueDescriptor.label)) == 8, "QueueDescriptor.label has unexpected size % instead of 8", size_of(type_of(QueueDescriptor.label)));
        assert(size_of(QueueDescriptor) == 16, "QueueDescriptor has size % instead of 16", size_of(QueueDescriptor));
    }

    {
        instance: RenderBundleDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "RenderBundleDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderBundleDescriptor.nextInChain)) == 8, "RenderBundleDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(RenderBundleDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "RenderBundleDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderBundleDescriptor.label)) == 8, "RenderBundleDescriptor.label has unexpected size % instead of 8", size_of(type_of(RenderBundleDescriptor.label)));
        assert(size_of(RenderBundleDescriptor) == 16, "RenderBundleDescriptor has size % instead of 16", size_of(RenderBundleDescriptor));
    }

    {
        instance: RenderBundleEncoderDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "RenderBundleEncoderDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderBundleEncoderDescriptor.nextInChain)) == 8, "RenderBundleEncoderDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(RenderBundleEncoderDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "RenderBundleEncoderDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderBundleEncoderDescriptor.label)) == 8, "RenderBundleEncoderDescriptor.label has unexpected size % instead of 8", size_of(type_of(RenderBundleEncoderDescriptor.label)));
        assert(((cast(*void)(*instance.colorFormatCount)) - cast(*void)(*instance)) == 16, "RenderBundleEncoderDescriptor.colorFormatCount has unexpected offset % instead of 16", ((cast(*void)(*instance.colorFormatCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderBundleEncoderDescriptor.colorFormatCount)) == 8, "RenderBundleEncoderDescriptor.colorFormatCount has unexpected size % instead of 8", size_of(type_of(RenderBundleEncoderDescriptor.colorFormatCount)));
        assert(((cast(*void)(*instance.colorFormats)) - cast(*void)(*instance)) == 24, "RenderBundleEncoderDescriptor.colorFormats has unexpected offset % instead of 24", ((cast(*void)(*instance.colorFormats)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderBundleEncoderDescriptor.colorFormats)) == 8, "RenderBundleEncoderDescriptor.colorFormats has unexpected size % instead of 8", size_of(type_of(RenderBundleEncoderDescriptor.colorFormats)));
        assert(((cast(*void)(*instance.depthStencilFormat)) - cast(*void)(*instance)) == 32, "RenderBundleEncoderDescriptor.depthStencilFormat has unexpected offset % instead of 32", ((cast(*void)(*instance.depthStencilFormat)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderBundleEncoderDescriptor.depthStencilFormat)) == 4, "RenderBundleEncoderDescriptor.depthStencilFormat has unexpected size % instead of 4", size_of(type_of(RenderBundleEncoderDescriptor.depthStencilFormat)));
        assert(((cast(*void)(*instance.sampleCount)) - cast(*void)(*instance)) == 36, "RenderBundleEncoderDescriptor.sampleCount has unexpected offset % instead of 36", ((cast(*void)(*instance.sampleCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderBundleEncoderDescriptor.sampleCount)) == 4, "RenderBundleEncoderDescriptor.sampleCount has unexpected size % instead of 4", size_of(type_of(RenderBundleEncoderDescriptor.sampleCount)));
        assert(((cast(*void)(*instance.depthReadOnly)) - cast(*void)(*instance)) == 40, "RenderBundleEncoderDescriptor.depthReadOnly has unexpected offset % instead of 40", ((cast(*void)(*instance.depthReadOnly)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderBundleEncoderDescriptor.depthReadOnly)) == 4, "RenderBundleEncoderDescriptor.depthReadOnly has unexpected size % instead of 4", size_of(type_of(RenderBundleEncoderDescriptor.depthReadOnly)));
        assert(((cast(*void)(*instance.stencilReadOnly)) - cast(*void)(*instance)) == 44, "RenderBundleEncoderDescriptor.stencilReadOnly has unexpected offset % instead of 44", ((cast(*void)(*instance.stencilReadOnly)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderBundleEncoderDescriptor.stencilReadOnly)) == 4, "RenderBundleEncoderDescriptor.stencilReadOnly has unexpected size % instead of 4", size_of(type_of(RenderBundleEncoderDescriptor.stencilReadOnly)));
        assert(size_of(RenderBundleEncoderDescriptor) == 48, "RenderBundleEncoderDescriptor has size % instead of 48", size_of(RenderBundleEncoderDescriptor));
    }

    {
        instance: RenderPassDepthStencilAttachment;
        assert(((cast(*void)(*instance.view)) - cast(*void)(*instance)) == 0, "RenderPassDepthStencilAttachment.view has unexpected offset % instead of 0", ((cast(*void)(*instance.view)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderPassDepthStencilAttachment.view)) == 8, "RenderPassDepthStencilAttachment.view has unexpected size % instead of 8", size_of(type_of(RenderPassDepthStencilAttachment.view)));
        assert(((cast(*void)(*instance.depthLoadOp)) - cast(*void)(*instance)) == 8, "RenderPassDepthStencilAttachment.depthLoadOp has unexpected offset % instead of 8", ((cast(*void)(*instance.depthLoadOp)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderPassDepthStencilAttachment.depthLoadOp)) == 4, "RenderPassDepthStencilAttachment.depthLoadOp has unexpected size % instead of 4", size_of(type_of(RenderPassDepthStencilAttachment.depthLoadOp)));
        assert(((cast(*void)(*instance.depthStoreOp)) - cast(*void)(*instance)) == 12, "RenderPassDepthStencilAttachment.depthStoreOp has unexpected offset % instead of 12", ((cast(*void)(*instance.depthStoreOp)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderPassDepthStencilAttachment.depthStoreOp)) == 4, "RenderPassDepthStencilAttachment.depthStoreOp has unexpected size % instead of 4", size_of(type_of(RenderPassDepthStencilAttachment.depthStoreOp)));
        assert(((cast(*void)(*instance.depthClearValue)) - cast(*void)(*instance)) == 16, "RenderPassDepthStencilAttachment.depthClearValue has unexpected offset % instead of 16", ((cast(*void)(*instance.depthClearValue)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderPassDepthStencilAttachment.depthClearValue)) == 4, "RenderPassDepthStencilAttachment.depthClearValue has unexpected size % instead of 4", size_of(type_of(RenderPassDepthStencilAttachment.depthClearValue)));
        assert(((cast(*void)(*instance.depthReadOnly)) - cast(*void)(*instance)) == 20, "RenderPassDepthStencilAttachment.depthReadOnly has unexpected offset % instead of 20", ((cast(*void)(*instance.depthReadOnly)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderPassDepthStencilAttachment.depthReadOnly)) == 4, "RenderPassDepthStencilAttachment.depthReadOnly has unexpected size % instead of 4", size_of(type_of(RenderPassDepthStencilAttachment.depthReadOnly)));
        assert(((cast(*void)(*instance.stencilLoadOp)) - cast(*void)(*instance)) == 24, "RenderPassDepthStencilAttachment.stencilLoadOp has unexpected offset % instead of 24", ((cast(*void)(*instance.stencilLoadOp)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderPassDepthStencilAttachment.stencilLoadOp)) == 4, "RenderPassDepthStencilAttachment.stencilLoadOp has unexpected size % instead of 4", size_of(type_of(RenderPassDepthStencilAttachment.stencilLoadOp)));
        assert(((cast(*void)(*instance.stencilStoreOp)) - cast(*void)(*instance)) == 28, "RenderPassDepthStencilAttachment.stencilStoreOp has unexpected offset % instead of 28", ((cast(*void)(*instance.stencilStoreOp)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderPassDepthStencilAttachment.stencilStoreOp)) == 4, "RenderPassDepthStencilAttachment.stencilStoreOp has unexpected size % instead of 4", size_of(type_of(RenderPassDepthStencilAttachment.stencilStoreOp)));
        assert(((cast(*void)(*instance.stencilClearValue)) - cast(*void)(*instance)) == 32, "RenderPassDepthStencilAttachment.stencilClearValue has unexpected offset % instead of 32", ((cast(*void)(*instance.stencilClearValue)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderPassDepthStencilAttachment.stencilClearValue)) == 4, "RenderPassDepthStencilAttachment.stencilClearValue has unexpected size % instead of 4", size_of(type_of(RenderPassDepthStencilAttachment.stencilClearValue)));
        assert(((cast(*void)(*instance.stencilReadOnly)) - cast(*void)(*instance)) == 36, "RenderPassDepthStencilAttachment.stencilReadOnly has unexpected offset % instead of 36", ((cast(*void)(*instance.stencilReadOnly)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderPassDepthStencilAttachment.stencilReadOnly)) == 4, "RenderPassDepthStencilAttachment.stencilReadOnly has unexpected size % instead of 4", size_of(type_of(RenderPassDepthStencilAttachment.stencilReadOnly)));
        assert(size_of(RenderPassDepthStencilAttachment) == 40, "RenderPassDepthStencilAttachment has size % instead of 40", size_of(RenderPassDepthStencilAttachment));
    }

    {
        instance: RenderPassDescriptorMaxDrawCount;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "RenderPassDescriptorMaxDrawCount.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderPassDescriptorMaxDrawCount.chain)) == 16, "RenderPassDescriptorMaxDrawCount.chain has unexpected size % instead of 16", size_of(type_of(RenderPassDescriptorMaxDrawCount.chain)));
        assert(((cast(*void)(*instance.maxDrawCount)) - cast(*void)(*instance)) == 16, "RenderPassDescriptorMaxDrawCount.maxDrawCount has unexpected offset % instead of 16", ((cast(*void)(*instance.maxDrawCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderPassDescriptorMaxDrawCount.maxDrawCount)) == 8, "RenderPassDescriptorMaxDrawCount.maxDrawCount has unexpected size % instead of 8", size_of(type_of(RenderPassDescriptorMaxDrawCount.maxDrawCount)));
        assert(size_of(RenderPassDescriptorMaxDrawCount) == 24, "RenderPassDescriptorMaxDrawCount has size % instead of 24", size_of(RenderPassDescriptorMaxDrawCount));
    }

    {
        instance: RenderPassTimestampWrites;
        assert(((cast(*void)(*instance.querySet)) - cast(*void)(*instance)) == 0, "RenderPassTimestampWrites.querySet has unexpected offset % instead of 0", ((cast(*void)(*instance.querySet)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderPassTimestampWrites.querySet)) == 8, "RenderPassTimestampWrites.querySet has unexpected size % instead of 8", size_of(type_of(RenderPassTimestampWrites.querySet)));
        assert(((cast(*void)(*instance.beginningOfPassWriteIndex)) - cast(*void)(*instance)) == 8, "RenderPassTimestampWrites.beginningOfPassWriteIndex has unexpected offset % instead of 8", ((cast(*void)(*instance.beginningOfPassWriteIndex)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderPassTimestampWrites.beginningOfPassWriteIndex)) == 4, "RenderPassTimestampWrites.beginningOfPassWriteIndex has unexpected size % instead of 4", size_of(type_of(RenderPassTimestampWrites.beginningOfPassWriteIndex)));
        assert(((cast(*void)(*instance.endOfPassWriteIndex)) - cast(*void)(*instance)) == 12, "RenderPassTimestampWrites.endOfPassWriteIndex has unexpected offset % instead of 12", ((cast(*void)(*instance.endOfPassWriteIndex)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderPassTimestampWrites.endOfPassWriteIndex)) == 4, "RenderPassTimestampWrites.endOfPassWriteIndex has unexpected size % instead of 4", size_of(type_of(RenderPassTimestampWrites.endOfPassWriteIndex)));
        assert(size_of(RenderPassTimestampWrites) == 16, "RenderPassTimestampWrites has size % instead of 16", size_of(RenderPassTimestampWrites));
    }

    {
        instance: RequestAdapterOptions;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "RequestAdapterOptions.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(RequestAdapterOptions.nextInChain)) == 8, "RequestAdapterOptions.nextInChain has unexpected size % instead of 8", size_of(type_of(RequestAdapterOptions.nextInChain)));
        assert(((cast(*void)(*instance.compatibleSurface)) - cast(*void)(*instance)) == 8, "RequestAdapterOptions.compatibleSurface has unexpected offset % instead of 8", ((cast(*void)(*instance.compatibleSurface)) - cast(*void)(*instance)));
        assert(size_of(type_of(RequestAdapterOptions.compatibleSurface)) == 8, "RequestAdapterOptions.compatibleSurface has unexpected size % instead of 8", size_of(type_of(RequestAdapterOptions.compatibleSurface)));
        assert(((cast(*void)(*instance.powerPreference)) - cast(*void)(*instance)) == 16, "RequestAdapterOptions.powerPreference has unexpected offset % instead of 16", ((cast(*void)(*instance.powerPreference)) - cast(*void)(*instance)));
        assert(size_of(type_of(RequestAdapterOptions.powerPreference)) == 4, "RequestAdapterOptions.powerPreference has unexpected size % instead of 4", size_of(type_of(RequestAdapterOptions.powerPreference)));
        assert(((cast(*void)(*instance.backendType)) - cast(*void)(*instance)) == 20, "RequestAdapterOptions.backendType has unexpected offset % instead of 20", ((cast(*void)(*instance.backendType)) - cast(*void)(*instance)));
        assert(size_of(type_of(RequestAdapterOptions.backendType)) == 4, "RequestAdapterOptions.backendType has unexpected size % instead of 4", size_of(type_of(RequestAdapterOptions.backendType)));
        assert(((cast(*void)(*instance.forceFallbackAdapter)) - cast(*void)(*instance)) == 24, "RequestAdapterOptions.forceFallbackAdapter has unexpected offset % instead of 24", ((cast(*void)(*instance.forceFallbackAdapter)) - cast(*void)(*instance)));
        assert(size_of(type_of(RequestAdapterOptions.forceFallbackAdapter)) == 4, "RequestAdapterOptions.forceFallbackAdapter has unexpected size % instead of 4", size_of(type_of(RequestAdapterOptions.forceFallbackAdapter)));
        assert(size_of(RequestAdapterOptions) == 32, "RequestAdapterOptions has size % instead of 32", size_of(RequestAdapterOptions));
    }

    {
        instance: SamplerBindingLayout;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "SamplerBindingLayout.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(SamplerBindingLayout.nextInChain)) == 8, "SamplerBindingLayout.nextInChain has unexpected size % instead of 8", size_of(type_of(SamplerBindingLayout.nextInChain)));
        assert(((cast(*void)(*instance.type)) - cast(*void)(*instance)) == 8, "SamplerBindingLayout.type has unexpected offset % instead of 8", ((cast(*void)(*instance.type)) - cast(*void)(*instance)));
        assert(size_of(type_of(SamplerBindingLayout.type)) == 4, "SamplerBindingLayout.type has unexpected size % instead of 4", size_of(type_of(SamplerBindingLayout.type)));
        assert(size_of(SamplerBindingLayout) == 16, "SamplerBindingLayout has size % instead of 16", size_of(SamplerBindingLayout));
    }

    {
        instance: SamplerDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "SamplerDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(SamplerDescriptor.nextInChain)) == 8, "SamplerDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(SamplerDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "SamplerDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(SamplerDescriptor.label)) == 8, "SamplerDescriptor.label has unexpected size % instead of 8", size_of(type_of(SamplerDescriptor.label)));
        assert(((cast(*void)(*instance.addressModeU)) - cast(*void)(*instance)) == 16, "SamplerDescriptor.addressModeU has unexpected offset % instead of 16", ((cast(*void)(*instance.addressModeU)) - cast(*void)(*instance)));
        assert(size_of(type_of(SamplerDescriptor.addressModeU)) == 4, "SamplerDescriptor.addressModeU has unexpected size % instead of 4", size_of(type_of(SamplerDescriptor.addressModeU)));
        assert(((cast(*void)(*instance.addressModeV)) - cast(*void)(*instance)) == 20, "SamplerDescriptor.addressModeV has unexpected offset % instead of 20", ((cast(*void)(*instance.addressModeV)) - cast(*void)(*instance)));
        assert(size_of(type_of(SamplerDescriptor.addressModeV)) == 4, "SamplerDescriptor.addressModeV has unexpected size % instead of 4", size_of(type_of(SamplerDescriptor.addressModeV)));
        assert(((cast(*void)(*instance.addressModeW)) - cast(*void)(*instance)) == 24, "SamplerDescriptor.addressModeW has unexpected offset % instead of 24", ((cast(*void)(*instance.addressModeW)) - cast(*void)(*instance)));
        assert(size_of(type_of(SamplerDescriptor.addressModeW)) == 4, "SamplerDescriptor.addressModeW has unexpected size % instead of 4", size_of(type_of(SamplerDescriptor.addressModeW)));
        assert(((cast(*void)(*instance.magFilter)) - cast(*void)(*instance)) == 28, "SamplerDescriptor.magFilter has unexpected offset % instead of 28", ((cast(*void)(*instance.magFilter)) - cast(*void)(*instance)));
        assert(size_of(type_of(SamplerDescriptor.magFilter)) == 4, "SamplerDescriptor.magFilter has unexpected size % instead of 4", size_of(type_of(SamplerDescriptor.magFilter)));
        assert(((cast(*void)(*instance.minFilter)) - cast(*void)(*instance)) == 32, "SamplerDescriptor.minFilter has unexpected offset % instead of 32", ((cast(*void)(*instance.minFilter)) - cast(*void)(*instance)));
        assert(size_of(type_of(SamplerDescriptor.minFilter)) == 4, "SamplerDescriptor.minFilter has unexpected size % instead of 4", size_of(type_of(SamplerDescriptor.minFilter)));
        assert(((cast(*void)(*instance.mipmapFilter)) - cast(*void)(*instance)) == 36, "SamplerDescriptor.mipmapFilter has unexpected offset % instead of 36", ((cast(*void)(*instance.mipmapFilter)) - cast(*void)(*instance)));
        assert(size_of(type_of(SamplerDescriptor.mipmapFilter)) == 4, "SamplerDescriptor.mipmapFilter has unexpected size % instead of 4", size_of(type_of(SamplerDescriptor.mipmapFilter)));
        assert(((cast(*void)(*instance.lodMinClamp)) - cast(*void)(*instance)) == 40, "SamplerDescriptor.lodMinClamp has unexpected offset % instead of 40", ((cast(*void)(*instance.lodMinClamp)) - cast(*void)(*instance)));
        assert(size_of(type_of(SamplerDescriptor.lodMinClamp)) == 4, "SamplerDescriptor.lodMinClamp has unexpected size % instead of 4", size_of(type_of(SamplerDescriptor.lodMinClamp)));
        assert(((cast(*void)(*instance.lodMaxClamp)) - cast(*void)(*instance)) == 44, "SamplerDescriptor.lodMaxClamp has unexpected offset % instead of 44", ((cast(*void)(*instance.lodMaxClamp)) - cast(*void)(*instance)));
        assert(size_of(type_of(SamplerDescriptor.lodMaxClamp)) == 4, "SamplerDescriptor.lodMaxClamp has unexpected size % instead of 4", size_of(type_of(SamplerDescriptor.lodMaxClamp)));
        assert(((cast(*void)(*instance.compare)) - cast(*void)(*instance)) == 48, "SamplerDescriptor.compare has unexpected offset % instead of 48", ((cast(*void)(*instance.compare)) - cast(*void)(*instance)));
        assert(size_of(type_of(SamplerDescriptor.compare)) == 4, "SamplerDescriptor.compare has unexpected size % instead of 4", size_of(type_of(SamplerDescriptor.compare)));
        assert(((cast(*void)(*instance.maxAnisotropy)) - cast(*void)(*instance)) == 52, "SamplerDescriptor.maxAnisotropy has unexpected offset % instead of 52", ((cast(*void)(*instance.maxAnisotropy)) - cast(*void)(*instance)));
        assert(size_of(type_of(SamplerDescriptor.maxAnisotropy)) == 2, "SamplerDescriptor.maxAnisotropy has unexpected size % instead of 2", size_of(type_of(SamplerDescriptor.maxAnisotropy)));
        assert(size_of(SamplerDescriptor) == 56, "SamplerDescriptor has size % instead of 56", size_of(SamplerDescriptor));
    }

    {
        instance: ShaderModuleCompilationHint;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "ShaderModuleCompilationHint.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(ShaderModuleCompilationHint.nextInChain)) == 8, "ShaderModuleCompilationHint.nextInChain has unexpected size % instead of 8", size_of(type_of(ShaderModuleCompilationHint.nextInChain)));
        assert(((cast(*void)(*instance.entryPoint)) - cast(*void)(*instance)) == 8, "ShaderModuleCompilationHint.entryPoint has unexpected offset % instead of 8", ((cast(*void)(*instance.entryPoint)) - cast(*void)(*instance)));
        assert(size_of(type_of(ShaderModuleCompilationHint.entryPoint)) == 8, "ShaderModuleCompilationHint.entryPoint has unexpected size % instead of 8", size_of(type_of(ShaderModuleCompilationHint.entryPoint)));
        assert(((cast(*void)(*instance.layout)) - cast(*void)(*instance)) == 16, "ShaderModuleCompilationHint.layout has unexpected offset % instead of 16", ((cast(*void)(*instance.layout)) - cast(*void)(*instance)));
        assert(size_of(type_of(ShaderModuleCompilationHint.layout)) == 8, "ShaderModuleCompilationHint.layout has unexpected size % instead of 8", size_of(type_of(ShaderModuleCompilationHint.layout)));
        assert(size_of(ShaderModuleCompilationHint) == 24, "ShaderModuleCompilationHint has size % instead of 24", size_of(ShaderModuleCompilationHint));
    }

    {
        instance: ShaderModuleSPIRVDescriptor;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "ShaderModuleSPIRVDescriptor.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(ShaderModuleSPIRVDescriptor.chain)) == 16, "ShaderModuleSPIRVDescriptor.chain has unexpected size % instead of 16", size_of(type_of(ShaderModuleSPIRVDescriptor.chain)));
        assert(((cast(*void)(*instance.codeSize)) - cast(*void)(*instance)) == 16, "ShaderModuleSPIRVDescriptor.codeSize has unexpected offset % instead of 16", ((cast(*void)(*instance.codeSize)) - cast(*void)(*instance)));
        assert(size_of(type_of(ShaderModuleSPIRVDescriptor.codeSize)) == 4, "ShaderModuleSPIRVDescriptor.codeSize has unexpected size % instead of 4", size_of(type_of(ShaderModuleSPIRVDescriptor.codeSize)));
        assert(((cast(*void)(*instance.code)) - cast(*void)(*instance)) == 24, "ShaderModuleSPIRVDescriptor.code has unexpected offset % instead of 24", ((cast(*void)(*instance.code)) - cast(*void)(*instance)));
        assert(size_of(type_of(ShaderModuleSPIRVDescriptor.code)) == 8, "ShaderModuleSPIRVDescriptor.code has unexpected size % instead of 8", size_of(type_of(ShaderModuleSPIRVDescriptor.code)));
        assert(size_of(ShaderModuleSPIRVDescriptor) == 32, "ShaderModuleSPIRVDescriptor has size % instead of 32", size_of(ShaderModuleSPIRVDescriptor));
    }

    {
        instance: ShaderModuleWGSLDescriptor;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "ShaderModuleWGSLDescriptor.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(ShaderModuleWGSLDescriptor.chain)) == 16, "ShaderModuleWGSLDescriptor.chain has unexpected size % instead of 16", size_of(type_of(ShaderModuleWGSLDescriptor.chain)));
        assert(((cast(*void)(*instance.code)) - cast(*void)(*instance)) == 16, "ShaderModuleWGSLDescriptor.code has unexpected offset % instead of 16", ((cast(*void)(*instance.code)) - cast(*void)(*instance)));
        assert(size_of(type_of(ShaderModuleWGSLDescriptor.code)) == 8, "ShaderModuleWGSLDescriptor.code has unexpected size % instead of 8", size_of(type_of(ShaderModuleWGSLDescriptor.code)));
        assert(size_of(ShaderModuleWGSLDescriptor) == 24, "ShaderModuleWGSLDescriptor has size % instead of 24", size_of(ShaderModuleWGSLDescriptor));
    }

    {
        instance: StencilFaceState;
        assert(((cast(*void)(*instance.compare)) - cast(*void)(*instance)) == 0, "StencilFaceState.compare has unexpected offset % instead of 0", ((cast(*void)(*instance.compare)) - cast(*void)(*instance)));
        assert(size_of(type_of(StencilFaceState.compare)) == 4, "StencilFaceState.compare has unexpected size % instead of 4", size_of(type_of(StencilFaceState.compare)));
        assert(((cast(*void)(*instance.failOp)) - cast(*void)(*instance)) == 4, "StencilFaceState.failOp has unexpected offset % instead of 4", ((cast(*void)(*instance.failOp)) - cast(*void)(*instance)));
        assert(size_of(type_of(StencilFaceState.failOp)) == 4, "StencilFaceState.failOp has unexpected size % instead of 4", size_of(type_of(StencilFaceState.failOp)));
        assert(((cast(*void)(*instance.depthFailOp)) - cast(*void)(*instance)) == 8, "StencilFaceState.depthFailOp has unexpected offset % instead of 8", ((cast(*void)(*instance.depthFailOp)) - cast(*void)(*instance)));
        assert(size_of(type_of(StencilFaceState.depthFailOp)) == 4, "StencilFaceState.depthFailOp has unexpected size % instead of 4", size_of(type_of(StencilFaceState.depthFailOp)));
        assert(((cast(*void)(*instance.passOp)) - cast(*void)(*instance)) == 12, "StencilFaceState.passOp has unexpected offset % instead of 12", ((cast(*void)(*instance.passOp)) - cast(*void)(*instance)));
        assert(size_of(type_of(StencilFaceState.passOp)) == 4, "StencilFaceState.passOp has unexpected size % instead of 4", size_of(type_of(StencilFaceState.passOp)));
        assert(size_of(StencilFaceState) == 16, "StencilFaceState has size % instead of 16", size_of(StencilFaceState));
    }

    {
        instance: StorageTextureBindingLayout;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "StorageTextureBindingLayout.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(StorageTextureBindingLayout.nextInChain)) == 8, "StorageTextureBindingLayout.nextInChain has unexpected size % instead of 8", size_of(type_of(StorageTextureBindingLayout.nextInChain)));
        assert(((cast(*void)(*instance.access)) - cast(*void)(*instance)) == 8, "StorageTextureBindingLayout.access has unexpected offset % instead of 8", ((cast(*void)(*instance.access)) - cast(*void)(*instance)));
        assert(size_of(type_of(StorageTextureBindingLayout.access)) == 4, "StorageTextureBindingLayout.access has unexpected size % instead of 4", size_of(type_of(StorageTextureBindingLayout.access)));
        assert(((cast(*void)(*instance.format)) - cast(*void)(*instance)) == 12, "StorageTextureBindingLayout.format has unexpected offset % instead of 12", ((cast(*void)(*instance.format)) - cast(*void)(*instance)));
        assert(size_of(type_of(StorageTextureBindingLayout.format)) == 4, "StorageTextureBindingLayout.format has unexpected size % instead of 4", size_of(type_of(StorageTextureBindingLayout.format)));
        assert(((cast(*void)(*instance.viewDimension)) - cast(*void)(*instance)) == 16, "StorageTextureBindingLayout.viewDimension has unexpected offset % instead of 16", ((cast(*void)(*instance.viewDimension)) - cast(*void)(*instance)));
        assert(size_of(type_of(StorageTextureBindingLayout.viewDimension)) == 4, "StorageTextureBindingLayout.viewDimension has unexpected size % instead of 4", size_of(type_of(StorageTextureBindingLayout.viewDimension)));
        assert(size_of(StorageTextureBindingLayout) == 24, "StorageTextureBindingLayout has size % instead of 24", size_of(StorageTextureBindingLayout));
    }

    {
        instance: SurfaceCapabilities;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "SurfaceCapabilities.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceCapabilities.nextInChain)) == 8, "SurfaceCapabilities.nextInChain has unexpected size % instead of 8", size_of(type_of(SurfaceCapabilities.nextInChain)));
        assert(((cast(*void)(*instance.formatCount)) - cast(*void)(*instance)) == 8, "SurfaceCapabilities.formatCount has unexpected offset % instead of 8", ((cast(*void)(*instance.formatCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceCapabilities.formatCount)) == 8, "SurfaceCapabilities.formatCount has unexpected size % instead of 8", size_of(type_of(SurfaceCapabilities.formatCount)));
        assert(((cast(*void)(*instance.formats)) - cast(*void)(*instance)) == 16, "SurfaceCapabilities.formats has unexpected offset % instead of 16", ((cast(*void)(*instance.formats)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceCapabilities.formats)) == 8, "SurfaceCapabilities.formats has unexpected size % instead of 8", size_of(type_of(SurfaceCapabilities.formats)));
        assert(((cast(*void)(*instance.presentModeCount)) - cast(*void)(*instance)) == 24, "SurfaceCapabilities.presentModeCount has unexpected offset % instead of 24", ((cast(*void)(*instance.presentModeCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceCapabilities.presentModeCount)) == 8, "SurfaceCapabilities.presentModeCount has unexpected size % instead of 8", size_of(type_of(SurfaceCapabilities.presentModeCount)));
        assert(((cast(*void)(*instance.presentModes)) - cast(*void)(*instance)) == 32, "SurfaceCapabilities.presentModes has unexpected offset % instead of 32", ((cast(*void)(*instance.presentModes)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceCapabilities.presentModes)) == 8, "SurfaceCapabilities.presentModes has unexpected size % instead of 8", size_of(type_of(SurfaceCapabilities.presentModes)));
        assert(((cast(*void)(*instance.alphaModeCount)) - cast(*void)(*instance)) == 40, "SurfaceCapabilities.alphaModeCount has unexpected offset % instead of 40", ((cast(*void)(*instance.alphaModeCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceCapabilities.alphaModeCount)) == 8, "SurfaceCapabilities.alphaModeCount has unexpected size % instead of 8", size_of(type_of(SurfaceCapabilities.alphaModeCount)));
        assert(((cast(*void)(*instance.alphaModes)) - cast(*void)(*instance)) == 48, "SurfaceCapabilities.alphaModes has unexpected offset % instead of 48", ((cast(*void)(*instance.alphaModes)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceCapabilities.alphaModes)) == 8, "SurfaceCapabilities.alphaModes has unexpected size % instead of 8", size_of(type_of(SurfaceCapabilities.alphaModes)));
        assert(size_of(SurfaceCapabilities) == 56, "SurfaceCapabilities has size % instead of 56", size_of(SurfaceCapabilities));
    }

    {
        instance: SurfaceConfiguration;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "SurfaceConfiguration.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceConfiguration.nextInChain)) == 8, "SurfaceConfiguration.nextInChain has unexpected size % instead of 8", size_of(type_of(SurfaceConfiguration.nextInChain)));
        assert(((cast(*void)(*instance.device)) - cast(*void)(*instance)) == 8, "SurfaceConfiguration.device has unexpected offset % instead of 8", ((cast(*void)(*instance.device)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceConfiguration.device)) == 8, "SurfaceConfiguration.device has unexpected size % instead of 8", size_of(type_of(SurfaceConfiguration.device)));
        assert(((cast(*void)(*instance.format)) - cast(*void)(*instance)) == 16, "SurfaceConfiguration.format has unexpected offset % instead of 16", ((cast(*void)(*instance.format)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceConfiguration.format)) == 4, "SurfaceConfiguration.format has unexpected size % instead of 4", size_of(type_of(SurfaceConfiguration.format)));
        assert(((cast(*void)(*instance.usage)) - cast(*void)(*instance)) == 20, "SurfaceConfiguration.usage has unexpected offset % instead of 20", ((cast(*void)(*instance.usage)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceConfiguration.usage)) == 4, "SurfaceConfiguration.usage has unexpected size % instead of 4", size_of(type_of(SurfaceConfiguration.usage)));
        assert(((cast(*void)(*instance.viewFormatCount)) - cast(*void)(*instance)) == 24, "SurfaceConfiguration.viewFormatCount has unexpected offset % instead of 24", ((cast(*void)(*instance.viewFormatCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceConfiguration.viewFormatCount)) == 8, "SurfaceConfiguration.viewFormatCount has unexpected size % instead of 8", size_of(type_of(SurfaceConfiguration.viewFormatCount)));
        assert(((cast(*void)(*instance.viewFormats)) - cast(*void)(*instance)) == 32, "SurfaceConfiguration.viewFormats has unexpected offset % instead of 32", ((cast(*void)(*instance.viewFormats)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceConfiguration.viewFormats)) == 8, "SurfaceConfiguration.viewFormats has unexpected size % instead of 8", size_of(type_of(SurfaceConfiguration.viewFormats)));
        assert(((cast(*void)(*instance.alphaMode)) - cast(*void)(*instance)) == 40, "SurfaceConfiguration.alphaMode has unexpected offset % instead of 40", ((cast(*void)(*instance.alphaMode)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceConfiguration.alphaMode)) == 4, "SurfaceConfiguration.alphaMode has unexpected size % instead of 4", size_of(type_of(SurfaceConfiguration.alphaMode)));
        assert(((cast(*void)(*instance.width)) - cast(*void)(*instance)) == 44, "SurfaceConfiguration.width has unexpected offset % instead of 44", ((cast(*void)(*instance.width)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceConfiguration.width)) == 4, "SurfaceConfiguration.width has unexpected size % instead of 4", size_of(type_of(SurfaceConfiguration.width)));
        assert(((cast(*void)(*instance.height)) - cast(*void)(*instance)) == 48, "SurfaceConfiguration.height has unexpected offset % instead of 48", ((cast(*void)(*instance.height)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceConfiguration.height)) == 4, "SurfaceConfiguration.height has unexpected size % instead of 4", size_of(type_of(SurfaceConfiguration.height)));
        assert(((cast(*void)(*instance.presentMode)) - cast(*void)(*instance)) == 52, "SurfaceConfiguration.presentMode has unexpected offset % instead of 52", ((cast(*void)(*instance.presentMode)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceConfiguration.presentMode)) == 4, "SurfaceConfiguration.presentMode has unexpected size % instead of 4", size_of(type_of(SurfaceConfiguration.presentMode)));
        assert(size_of(SurfaceConfiguration) == 56, "SurfaceConfiguration has size % instead of 56", size_of(SurfaceConfiguration));
    }

    {
        instance: SurfaceDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "SurfaceDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceDescriptor.nextInChain)) == 8, "SurfaceDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(SurfaceDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "SurfaceDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceDescriptor.label)) == 8, "SurfaceDescriptor.label has unexpected size % instead of 8", size_of(type_of(SurfaceDescriptor.label)));
        assert(size_of(SurfaceDescriptor) == 16, "SurfaceDescriptor has size % instead of 16", size_of(SurfaceDescriptor));
    }

    {
        instance: SurfaceDescriptorFromAndroidNativeWindow;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "SurfaceDescriptorFromAndroidNativeWindow.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceDescriptorFromAndroidNativeWindow.chain)) == 16, "SurfaceDescriptorFromAndroidNativeWindow.chain has unexpected size % instead of 16", size_of(type_of(SurfaceDescriptorFromAndroidNativeWindow.chain)));
        assert(((cast(*void)(*instance.window)) - cast(*void)(*instance)) == 16, "SurfaceDescriptorFromAndroidNativeWindow.window has unexpected offset % instead of 16", ((cast(*void)(*instance.window)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceDescriptorFromAndroidNativeWindow.window)) == 8, "SurfaceDescriptorFromAndroidNativeWindow.window has unexpected size % instead of 8", size_of(type_of(SurfaceDescriptorFromAndroidNativeWindow.window)));
        assert(size_of(SurfaceDescriptorFromAndroidNativeWindow) == 24, "SurfaceDescriptorFromAndroidNativeWindow has size % instead of 24", size_of(SurfaceDescriptorFromAndroidNativeWindow));
    }

    {
        instance: SurfaceDescriptorFromCanvasHTMLSelector;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "SurfaceDescriptorFromCanvasHTMLSelector.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceDescriptorFromCanvasHTMLSelector.chain)) == 16, "SurfaceDescriptorFromCanvasHTMLSelector.chain has unexpected size % instead of 16", size_of(type_of(SurfaceDescriptorFromCanvasHTMLSelector.chain)));
        assert(((cast(*void)(*instance.selector)) - cast(*void)(*instance)) == 16, "SurfaceDescriptorFromCanvasHTMLSelector.selector has unexpected offset % instead of 16", ((cast(*void)(*instance.selector)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceDescriptorFromCanvasHTMLSelector.selector)) == 8, "SurfaceDescriptorFromCanvasHTMLSelector.selector has unexpected size % instead of 8", size_of(type_of(SurfaceDescriptorFromCanvasHTMLSelector.selector)));
        assert(size_of(SurfaceDescriptorFromCanvasHTMLSelector) == 24, "SurfaceDescriptorFromCanvasHTMLSelector has size % instead of 24", size_of(SurfaceDescriptorFromCanvasHTMLSelector));
    }

    {
        instance: SurfaceDescriptorFromMetalLayer;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "SurfaceDescriptorFromMetalLayer.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceDescriptorFromMetalLayer.chain)) == 16, "SurfaceDescriptorFromMetalLayer.chain has unexpected size % instead of 16", size_of(type_of(SurfaceDescriptorFromMetalLayer.chain)));
        assert(((cast(*void)(*instance.layer)) - cast(*void)(*instance)) == 16, "SurfaceDescriptorFromMetalLayer.layer has unexpected offset % instead of 16", ((cast(*void)(*instance.layer)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceDescriptorFromMetalLayer.layer)) == 8, "SurfaceDescriptorFromMetalLayer.layer has unexpected size % instead of 8", size_of(type_of(SurfaceDescriptorFromMetalLayer.layer)));
        assert(size_of(SurfaceDescriptorFromMetalLayer) == 24, "SurfaceDescriptorFromMetalLayer has size % instead of 24", size_of(SurfaceDescriptorFromMetalLayer));
    }

    {
        instance: SurfaceDescriptorFromWaylandSurface;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "SurfaceDescriptorFromWaylandSurface.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceDescriptorFromWaylandSurface.chain)) == 16, "SurfaceDescriptorFromWaylandSurface.chain has unexpected size % instead of 16", size_of(type_of(SurfaceDescriptorFromWaylandSurface.chain)));
        assert(((cast(*void)(*instance.display)) - cast(*void)(*instance)) == 16, "SurfaceDescriptorFromWaylandSurface.display has unexpected offset % instead of 16", ((cast(*void)(*instance.display)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceDescriptorFromWaylandSurface.display)) == 8, "SurfaceDescriptorFromWaylandSurface.display has unexpected size % instead of 8", size_of(type_of(SurfaceDescriptorFromWaylandSurface.display)));
        assert(((cast(*void)(*instance.surface)) - cast(*void)(*instance)) == 24, "SurfaceDescriptorFromWaylandSurface.surface has unexpected offset % instead of 24", ((cast(*void)(*instance.surface)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceDescriptorFromWaylandSurface.surface)) == 8, "SurfaceDescriptorFromWaylandSurface.surface has unexpected size % instead of 8", size_of(type_of(SurfaceDescriptorFromWaylandSurface.surface)));
        assert(size_of(SurfaceDescriptorFromWaylandSurface) == 32, "SurfaceDescriptorFromWaylandSurface has size % instead of 32", size_of(SurfaceDescriptorFromWaylandSurface));
    }

    {
        instance: SurfaceDescriptorFromWindowsHWND;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "SurfaceDescriptorFromWindowsHWND.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceDescriptorFromWindowsHWND.chain)) == 16, "SurfaceDescriptorFromWindowsHWND.chain has unexpected size % instead of 16", size_of(type_of(SurfaceDescriptorFromWindowsHWND.chain)));
        assert(((cast(*void)(*instance.hinstance)) - cast(*void)(*instance)) == 16, "SurfaceDescriptorFromWindowsHWND.hinstance has unexpected offset % instead of 16", ((cast(*void)(*instance.hinstance)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceDescriptorFromWindowsHWND.hinstance)) == 8, "SurfaceDescriptorFromWindowsHWND.hinstance has unexpected size % instead of 8", size_of(type_of(SurfaceDescriptorFromWindowsHWND.hinstance)));
        assert(((cast(*void)(*instance.hwnd)) - cast(*void)(*instance)) == 24, "SurfaceDescriptorFromWindowsHWND.hwnd has unexpected offset % instead of 24", ((cast(*void)(*instance.hwnd)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceDescriptorFromWindowsHWND.hwnd)) == 8, "SurfaceDescriptorFromWindowsHWND.hwnd has unexpected size % instead of 8", size_of(type_of(SurfaceDescriptorFromWindowsHWND.hwnd)));
        assert(size_of(SurfaceDescriptorFromWindowsHWND) == 32, "SurfaceDescriptorFromWindowsHWND has size % instead of 32", size_of(SurfaceDescriptorFromWindowsHWND));
    }

    {
        instance: SurfaceDescriptorFromXcbWindow;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "SurfaceDescriptorFromXcbWindow.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceDescriptorFromXcbWindow.chain)) == 16, "SurfaceDescriptorFromXcbWindow.chain has unexpected size % instead of 16", size_of(type_of(SurfaceDescriptorFromXcbWindow.chain)));
        assert(((cast(*void)(*instance.connection)) - cast(*void)(*instance)) == 16, "SurfaceDescriptorFromXcbWindow.connection has unexpected offset % instead of 16", ((cast(*void)(*instance.connection)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceDescriptorFromXcbWindow.connection)) == 8, "SurfaceDescriptorFromXcbWindow.connection has unexpected size % instead of 8", size_of(type_of(SurfaceDescriptorFromXcbWindow.connection)));
        assert(((cast(*void)(*instance.window)) - cast(*void)(*instance)) == 24, "SurfaceDescriptorFromXcbWindow.window has unexpected offset % instead of 24", ((cast(*void)(*instance.window)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceDescriptorFromXcbWindow.window)) == 4, "SurfaceDescriptorFromXcbWindow.window has unexpected size % instead of 4", size_of(type_of(SurfaceDescriptorFromXcbWindow.window)));
        assert(size_of(SurfaceDescriptorFromXcbWindow) == 32, "SurfaceDescriptorFromXcbWindow has size % instead of 32", size_of(SurfaceDescriptorFromXcbWindow));
    }

    {
        instance: SurfaceDescriptorFromXlibWindow;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "SurfaceDescriptorFromXlibWindow.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceDescriptorFromXlibWindow.chain)) == 16, "SurfaceDescriptorFromXlibWindow.chain has unexpected size % instead of 16", size_of(type_of(SurfaceDescriptorFromXlibWindow.chain)));
        assert(((cast(*void)(*instance.display)) - cast(*void)(*instance)) == 16, "SurfaceDescriptorFromXlibWindow.display has unexpected offset % instead of 16", ((cast(*void)(*instance.display)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceDescriptorFromXlibWindow.display)) == 8, "SurfaceDescriptorFromXlibWindow.display has unexpected size % instead of 8", size_of(type_of(SurfaceDescriptorFromXlibWindow.display)));
        assert(((cast(*void)(*instance.window)) - cast(*void)(*instance)) == 24, "SurfaceDescriptorFromXlibWindow.window has unexpected offset % instead of 24", ((cast(*void)(*instance.window)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceDescriptorFromXlibWindow.window)) == 8, "SurfaceDescriptorFromXlibWindow.window has unexpected size % instead of 8", size_of(type_of(SurfaceDescriptorFromXlibWindow.window)));
        assert(size_of(SurfaceDescriptorFromXlibWindow) == 32, "SurfaceDescriptorFromXlibWindow has size % instead of 32", size_of(SurfaceDescriptorFromXlibWindow));
    }

    {
        instance: SurfaceTexture;
        assert(((cast(*void)(*instance.texture)) - cast(*void)(*instance)) == 0, "SurfaceTexture.texture has unexpected offset % instead of 0", ((cast(*void)(*instance.texture)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceTexture.texture)) == 8, "SurfaceTexture.texture has unexpected size % instead of 8", size_of(type_of(SurfaceTexture.texture)));
        assert(((cast(*void)(*instance.suboptimal)) - cast(*void)(*instance)) == 8, "SurfaceTexture.suboptimal has unexpected offset % instead of 8", ((cast(*void)(*instance.suboptimal)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceTexture.suboptimal)) == 4, "SurfaceTexture.suboptimal has unexpected size % instead of 4", size_of(type_of(SurfaceTexture.suboptimal)));
        assert(((cast(*void)(*instance.status)) - cast(*void)(*instance)) == 12, "SurfaceTexture.status has unexpected offset % instead of 12", ((cast(*void)(*instance.status)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceTexture.status)) == 4, "SurfaceTexture.status has unexpected size % instead of 4", size_of(type_of(SurfaceTexture.status)));
        assert(size_of(SurfaceTexture) == 16, "SurfaceTexture has size % instead of 16", size_of(SurfaceTexture));
    }

    {
        instance: TextureBindingLayout;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "TextureBindingLayout.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(TextureBindingLayout.nextInChain)) == 8, "TextureBindingLayout.nextInChain has unexpected size % instead of 8", size_of(type_of(TextureBindingLayout.nextInChain)));
        assert(((cast(*void)(*instance.sampleType)) - cast(*void)(*instance)) == 8, "TextureBindingLayout.sampleType has unexpected offset % instead of 8", ((cast(*void)(*instance.sampleType)) - cast(*void)(*instance)));
        assert(size_of(type_of(TextureBindingLayout.sampleType)) == 4, "TextureBindingLayout.sampleType has unexpected size % instead of 4", size_of(type_of(TextureBindingLayout.sampleType)));
        assert(((cast(*void)(*instance.viewDimension)) - cast(*void)(*instance)) == 12, "TextureBindingLayout.viewDimension has unexpected offset % instead of 12", ((cast(*void)(*instance.viewDimension)) - cast(*void)(*instance)));
        assert(size_of(type_of(TextureBindingLayout.viewDimension)) == 4, "TextureBindingLayout.viewDimension has unexpected size % instead of 4", size_of(type_of(TextureBindingLayout.viewDimension)));
        assert(((cast(*void)(*instance.multisampled)) - cast(*void)(*instance)) == 16, "TextureBindingLayout.multisampled has unexpected offset % instead of 16", ((cast(*void)(*instance.multisampled)) - cast(*void)(*instance)));
        assert(size_of(type_of(TextureBindingLayout.multisampled)) == 4, "TextureBindingLayout.multisampled has unexpected size % instead of 4", size_of(type_of(TextureBindingLayout.multisampled)));
        assert(size_of(TextureBindingLayout) == 24, "TextureBindingLayout has size % instead of 24", size_of(TextureBindingLayout));
    }

    {
        instance: TextureDataLayout;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "TextureDataLayout.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(TextureDataLayout.nextInChain)) == 8, "TextureDataLayout.nextInChain has unexpected size % instead of 8", size_of(type_of(TextureDataLayout.nextInChain)));
        assert(((cast(*void)(*instance.offset)) - cast(*void)(*instance)) == 8, "TextureDataLayout.offset has unexpected offset % instead of 8", ((cast(*void)(*instance.offset)) - cast(*void)(*instance)));
        assert(size_of(type_of(TextureDataLayout.offset)) == 8, "TextureDataLayout.offset has unexpected size % instead of 8", size_of(type_of(TextureDataLayout.offset)));
        assert(((cast(*void)(*instance.bytesPerRow)) - cast(*void)(*instance)) == 16, "TextureDataLayout.bytesPerRow has unexpected offset % instead of 16", ((cast(*void)(*instance.bytesPerRow)) - cast(*void)(*instance)));
        assert(size_of(type_of(TextureDataLayout.bytesPerRow)) == 4, "TextureDataLayout.bytesPerRow has unexpected size % instead of 4", size_of(type_of(TextureDataLayout.bytesPerRow)));
        assert(((cast(*void)(*instance.rowsPerImage)) - cast(*void)(*instance)) == 20, "TextureDataLayout.rowsPerImage has unexpected offset % instead of 20", ((cast(*void)(*instance.rowsPerImage)) - cast(*void)(*instance)));
        assert(size_of(type_of(TextureDataLayout.rowsPerImage)) == 4, "TextureDataLayout.rowsPerImage has unexpected size % instead of 4", size_of(type_of(TextureDataLayout.rowsPerImage)));
        assert(size_of(TextureDataLayout) == 24, "TextureDataLayout has size % instead of 24", size_of(TextureDataLayout));
    }

    {
        instance: TextureViewDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "TextureViewDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(TextureViewDescriptor.nextInChain)) == 8, "TextureViewDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(TextureViewDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "TextureViewDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(TextureViewDescriptor.label)) == 8, "TextureViewDescriptor.label has unexpected size % instead of 8", size_of(type_of(TextureViewDescriptor.label)));
        assert(((cast(*void)(*instance.format)) - cast(*void)(*instance)) == 16, "TextureViewDescriptor.format has unexpected offset % instead of 16", ((cast(*void)(*instance.format)) - cast(*void)(*instance)));
        assert(size_of(type_of(TextureViewDescriptor.format)) == 4, "TextureViewDescriptor.format has unexpected size % instead of 4", size_of(type_of(TextureViewDescriptor.format)));
        assert(((cast(*void)(*instance.dimension)) - cast(*void)(*instance)) == 20, "TextureViewDescriptor.dimension has unexpected offset % instead of 20", ((cast(*void)(*instance.dimension)) - cast(*void)(*instance)));
        assert(size_of(type_of(TextureViewDescriptor.dimension)) == 4, "TextureViewDescriptor.dimension has unexpected size % instead of 4", size_of(type_of(TextureViewDescriptor.dimension)));
        assert(((cast(*void)(*instance.baseMipLevel)) - cast(*void)(*instance)) == 24, "TextureViewDescriptor.baseMipLevel has unexpected offset % instead of 24", ((cast(*void)(*instance.baseMipLevel)) - cast(*void)(*instance)));
        assert(size_of(type_of(TextureViewDescriptor.baseMipLevel)) == 4, "TextureViewDescriptor.baseMipLevel has unexpected size % instead of 4", size_of(type_of(TextureViewDescriptor.baseMipLevel)));
        assert(((cast(*void)(*instance.mipLevelCount)) - cast(*void)(*instance)) == 28, "TextureViewDescriptor.mipLevelCount has unexpected offset % instead of 28", ((cast(*void)(*instance.mipLevelCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(TextureViewDescriptor.mipLevelCount)) == 4, "TextureViewDescriptor.mipLevelCount has unexpected size % instead of 4", size_of(type_of(TextureViewDescriptor.mipLevelCount)));
        assert(((cast(*void)(*instance.baseArrayLayer)) - cast(*void)(*instance)) == 32, "TextureViewDescriptor.baseArrayLayer has unexpected offset % instead of 32", ((cast(*void)(*instance.baseArrayLayer)) - cast(*void)(*instance)));
        assert(size_of(type_of(TextureViewDescriptor.baseArrayLayer)) == 4, "TextureViewDescriptor.baseArrayLayer has unexpected size % instead of 4", size_of(type_of(TextureViewDescriptor.baseArrayLayer)));
        assert(((cast(*void)(*instance.arrayLayerCount)) - cast(*void)(*instance)) == 36, "TextureViewDescriptor.arrayLayerCount has unexpected offset % instead of 36", ((cast(*void)(*instance.arrayLayerCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(TextureViewDescriptor.arrayLayerCount)) == 4, "TextureViewDescriptor.arrayLayerCount has unexpected size % instead of 4", size_of(type_of(TextureViewDescriptor.arrayLayerCount)));
        assert(((cast(*void)(*instance.aspect)) - cast(*void)(*instance)) == 40, "TextureViewDescriptor.aspect has unexpected offset % instead of 40", ((cast(*void)(*instance.aspect)) - cast(*void)(*instance)));
        assert(size_of(type_of(TextureViewDescriptor.aspect)) == 4, "TextureViewDescriptor.aspect has unexpected size % instead of 4", size_of(type_of(TextureViewDescriptor.aspect)));
        assert(size_of(TextureViewDescriptor) == 48, "TextureViewDescriptor has size % instead of 48", size_of(TextureViewDescriptor));
    }

    {
        instance: VertexAttribute;
        assert(((cast(*void)(*instance.format)) - cast(*void)(*instance)) == 0, "VertexAttribute.format has unexpected offset % instead of 0", ((cast(*void)(*instance.format)) - cast(*void)(*instance)));
        assert(size_of(type_of(VertexAttribute.format)) == 4, "VertexAttribute.format has unexpected size % instead of 4", size_of(type_of(VertexAttribute.format)));
        assert(((cast(*void)(*instance.offset)) - cast(*void)(*instance)) == 8, "VertexAttribute.offset has unexpected offset % instead of 8", ((cast(*void)(*instance.offset)) - cast(*void)(*instance)));
        assert(size_of(type_of(VertexAttribute.offset)) == 8, "VertexAttribute.offset has unexpected size % instead of 8", size_of(type_of(VertexAttribute.offset)));
        assert(((cast(*void)(*instance.shaderLocation)) - cast(*void)(*instance)) == 16, "VertexAttribute.shaderLocation has unexpected offset % instead of 16", ((cast(*void)(*instance.shaderLocation)) - cast(*void)(*instance)));
        assert(size_of(type_of(VertexAttribute.shaderLocation)) == 4, "VertexAttribute.shaderLocation has unexpected size % instead of 4", size_of(type_of(VertexAttribute.shaderLocation)));
        assert(size_of(VertexAttribute) == 24, "VertexAttribute has size % instead of 24", size_of(VertexAttribute));
    }

    {
        instance: BindGroupDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "BindGroupDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(BindGroupDescriptor.nextInChain)) == 8, "BindGroupDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(BindGroupDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "BindGroupDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(BindGroupDescriptor.label)) == 8, "BindGroupDescriptor.label has unexpected size % instead of 8", size_of(type_of(BindGroupDescriptor.label)));
        assert(((cast(*void)(*instance.layout)) - cast(*void)(*instance)) == 16, "BindGroupDescriptor.layout has unexpected offset % instead of 16", ((cast(*void)(*instance.layout)) - cast(*void)(*instance)));
        assert(size_of(type_of(BindGroupDescriptor.layout)) == 8, "BindGroupDescriptor.layout has unexpected size % instead of 8", size_of(type_of(BindGroupDescriptor.layout)));
        assert(((cast(*void)(*instance.entryCount)) - cast(*void)(*instance)) == 24, "BindGroupDescriptor.entryCount has unexpected offset % instead of 24", ((cast(*void)(*instance.entryCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(BindGroupDescriptor.entryCount)) == 8, "BindGroupDescriptor.entryCount has unexpected size % instead of 8", size_of(type_of(BindGroupDescriptor.entryCount)));
        assert(((cast(*void)(*instance.entries)) - cast(*void)(*instance)) == 32, "BindGroupDescriptor.entries has unexpected offset % instead of 32", ((cast(*void)(*instance.entries)) - cast(*void)(*instance)));
        assert(size_of(type_of(BindGroupDescriptor.entries)) == 8, "BindGroupDescriptor.entries has unexpected size % instead of 8", size_of(type_of(BindGroupDescriptor.entries)));
        assert(size_of(BindGroupDescriptor) == 40, "BindGroupDescriptor has size % instead of 40", size_of(BindGroupDescriptor));
    }

    {
        instance: BindGroupLayoutEntry;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "BindGroupLayoutEntry.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(BindGroupLayoutEntry.nextInChain)) == 8, "BindGroupLayoutEntry.nextInChain has unexpected size % instead of 8", size_of(type_of(BindGroupLayoutEntry.nextInChain)));
        assert(((cast(*void)(*instance.binding)) - cast(*void)(*instance)) == 8, "BindGroupLayoutEntry.binding has unexpected offset % instead of 8", ((cast(*void)(*instance.binding)) - cast(*void)(*instance)));
        assert(size_of(type_of(BindGroupLayoutEntry.binding)) == 4, "BindGroupLayoutEntry.binding has unexpected size % instead of 4", size_of(type_of(BindGroupLayoutEntry.binding)));
        assert(((cast(*void)(*instance.visibility)) - cast(*void)(*instance)) == 12, "BindGroupLayoutEntry.visibility has unexpected offset % instead of 12", ((cast(*void)(*instance.visibility)) - cast(*void)(*instance)));
        assert(size_of(type_of(BindGroupLayoutEntry.visibility)) == 4, "BindGroupLayoutEntry.visibility has unexpected size % instead of 4", size_of(type_of(BindGroupLayoutEntry.visibility)));
        assert(((cast(*void)(*instance.buffer)) - cast(*void)(*instance)) == 16, "BindGroupLayoutEntry.buffer has unexpected offset % instead of 16", ((cast(*void)(*instance.buffer)) - cast(*void)(*instance)));
        assert(size_of(type_of(BindGroupLayoutEntry.buffer)) == 24, "BindGroupLayoutEntry.buffer has unexpected size % instead of 24", size_of(type_of(BindGroupLayoutEntry.buffer)));
        assert(((cast(*void)(*instance.sampler)) - cast(*void)(*instance)) == 40, "BindGroupLayoutEntry.sampler has unexpected offset % instead of 40", ((cast(*void)(*instance.sampler)) - cast(*void)(*instance)));
        assert(size_of(type_of(BindGroupLayoutEntry.sampler)) == 16, "BindGroupLayoutEntry.sampler has unexpected size % instead of 16", size_of(type_of(BindGroupLayoutEntry.sampler)));
        assert(((cast(*void)(*instance.texture)) - cast(*void)(*instance)) == 56, "BindGroupLayoutEntry.texture has unexpected offset % instead of 56", ((cast(*void)(*instance.texture)) - cast(*void)(*instance)));
        assert(size_of(type_of(BindGroupLayoutEntry.texture)) == 24, "BindGroupLayoutEntry.texture has unexpected size % instead of 24", size_of(type_of(BindGroupLayoutEntry.texture)));
        assert(((cast(*void)(*instance.storageTexture)) - cast(*void)(*instance)) == 80, "BindGroupLayoutEntry.storageTexture has unexpected offset % instead of 80", ((cast(*void)(*instance.storageTexture)) - cast(*void)(*instance)));
        assert(size_of(type_of(BindGroupLayoutEntry.storageTexture)) == 24, "BindGroupLayoutEntry.storageTexture has unexpected size % instead of 24", size_of(type_of(BindGroupLayoutEntry.storageTexture)));
        assert(size_of(BindGroupLayoutEntry) == 104, "BindGroupLayoutEntry has size % instead of 104", size_of(BindGroupLayoutEntry));
    }

    {
        instance: BlendState;
        assert(((cast(*void)(*instance.color)) - cast(*void)(*instance)) == 0, "BlendState.color has unexpected offset % instead of 0", ((cast(*void)(*instance.color)) - cast(*void)(*instance)));
        assert(size_of(type_of(BlendState.color)) == 12, "BlendState.color has unexpected size % instead of 12", size_of(type_of(BlendState.color)));
        assert(((cast(*void)(*instance.alpha)) - cast(*void)(*instance)) == 12, "BlendState.alpha has unexpected offset % instead of 12", ((cast(*void)(*instance.alpha)) - cast(*void)(*instance)));
        assert(size_of(type_of(BlendState.alpha)) == 12, "BlendState.alpha has unexpected size % instead of 12", size_of(type_of(BlendState.alpha)));
        assert(size_of(BlendState) == 24, "BlendState has size % instead of 24", size_of(BlendState));
    }

    {
        instance: CompilationInfo;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "CompilationInfo.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(CompilationInfo.nextInChain)) == 8, "CompilationInfo.nextInChain has unexpected size % instead of 8", size_of(type_of(CompilationInfo.nextInChain)));
        assert(((cast(*void)(*instance.messageCount)) - cast(*void)(*instance)) == 8, "CompilationInfo.messageCount has unexpected offset % instead of 8", ((cast(*void)(*instance.messageCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(CompilationInfo.messageCount)) == 8, "CompilationInfo.messageCount has unexpected size % instead of 8", size_of(type_of(CompilationInfo.messageCount)));
        assert(((cast(*void)(*instance.messages)) - cast(*void)(*instance)) == 16, "CompilationInfo.messages has unexpected offset % instead of 16", ((cast(*void)(*instance.messages)) - cast(*void)(*instance)));
        assert(size_of(type_of(CompilationInfo.messages)) == 8, "CompilationInfo.messages has unexpected size % instead of 8", size_of(type_of(CompilationInfo.messages)));
        assert(size_of(CompilationInfo) == 24, "CompilationInfo has size % instead of 24", size_of(CompilationInfo));
    }

    {
        instance: ComputePassDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "ComputePassDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(ComputePassDescriptor.nextInChain)) == 8, "ComputePassDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(ComputePassDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "ComputePassDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(ComputePassDescriptor.label)) == 8, "ComputePassDescriptor.label has unexpected size % instead of 8", size_of(type_of(ComputePassDescriptor.label)));
        assert(((cast(*void)(*instance.timestampWrites)) - cast(*void)(*instance)) == 16, "ComputePassDescriptor.timestampWrites has unexpected offset % instead of 16", ((cast(*void)(*instance.timestampWrites)) - cast(*void)(*instance)));
        assert(size_of(type_of(ComputePassDescriptor.timestampWrites)) == 8, "ComputePassDescriptor.timestampWrites has unexpected size % instead of 8", size_of(type_of(ComputePassDescriptor.timestampWrites)));
        assert(size_of(ComputePassDescriptor) == 24, "ComputePassDescriptor has size % instead of 24", size_of(ComputePassDescriptor));
    }

    {
        instance: DepthStencilState;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "DepthStencilState.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(DepthStencilState.nextInChain)) == 8, "DepthStencilState.nextInChain has unexpected size % instead of 8", size_of(type_of(DepthStencilState.nextInChain)));
        assert(((cast(*void)(*instance.format)) - cast(*void)(*instance)) == 8, "DepthStencilState.format has unexpected offset % instead of 8", ((cast(*void)(*instance.format)) - cast(*void)(*instance)));
        assert(size_of(type_of(DepthStencilState.format)) == 4, "DepthStencilState.format has unexpected size % instead of 4", size_of(type_of(DepthStencilState.format)));
        assert(((cast(*void)(*instance.depthWriteEnabled)) - cast(*void)(*instance)) == 12, "DepthStencilState.depthWriteEnabled has unexpected offset % instead of 12", ((cast(*void)(*instance.depthWriteEnabled)) - cast(*void)(*instance)));
        assert(size_of(type_of(DepthStencilState.depthWriteEnabled)) == 4, "DepthStencilState.depthWriteEnabled has unexpected size % instead of 4", size_of(type_of(DepthStencilState.depthWriteEnabled)));
        assert(((cast(*void)(*instance.depthCompare)) - cast(*void)(*instance)) == 16, "DepthStencilState.depthCompare has unexpected offset % instead of 16", ((cast(*void)(*instance.depthCompare)) - cast(*void)(*instance)));
        assert(size_of(type_of(DepthStencilState.depthCompare)) == 4, "DepthStencilState.depthCompare has unexpected size % instead of 4", size_of(type_of(DepthStencilState.depthCompare)));
        assert(((cast(*void)(*instance.stencilFront)) - cast(*void)(*instance)) == 20, "DepthStencilState.stencilFront has unexpected offset % instead of 20", ((cast(*void)(*instance.stencilFront)) - cast(*void)(*instance)));
        assert(size_of(type_of(DepthStencilState.stencilFront)) == 16, "DepthStencilState.stencilFront has unexpected size % instead of 16", size_of(type_of(DepthStencilState.stencilFront)));
        assert(((cast(*void)(*instance.stencilBack)) - cast(*void)(*instance)) == 36, "DepthStencilState.stencilBack has unexpected offset % instead of 36", ((cast(*void)(*instance.stencilBack)) - cast(*void)(*instance)));
        assert(size_of(type_of(DepthStencilState.stencilBack)) == 16, "DepthStencilState.stencilBack has unexpected size % instead of 16", size_of(type_of(DepthStencilState.stencilBack)));
        assert(((cast(*void)(*instance.stencilReadMask)) - cast(*void)(*instance)) == 52, "DepthStencilState.stencilReadMask has unexpected offset % instead of 52", ((cast(*void)(*instance.stencilReadMask)) - cast(*void)(*instance)));
        assert(size_of(type_of(DepthStencilState.stencilReadMask)) == 4, "DepthStencilState.stencilReadMask has unexpected size % instead of 4", size_of(type_of(DepthStencilState.stencilReadMask)));
        assert(((cast(*void)(*instance.stencilWriteMask)) - cast(*void)(*instance)) == 56, "DepthStencilState.stencilWriteMask has unexpected offset % instead of 56", ((cast(*void)(*instance.stencilWriteMask)) - cast(*void)(*instance)));
        assert(size_of(type_of(DepthStencilState.stencilWriteMask)) == 4, "DepthStencilState.stencilWriteMask has unexpected size % instead of 4", size_of(type_of(DepthStencilState.stencilWriteMask)));
        assert(((cast(*void)(*instance.depthBias)) - cast(*void)(*instance)) == 60, "DepthStencilState.depthBias has unexpected offset % instead of 60", ((cast(*void)(*instance.depthBias)) - cast(*void)(*instance)));
        assert(size_of(type_of(DepthStencilState.depthBias)) == 4, "DepthStencilState.depthBias has unexpected size % instead of 4", size_of(type_of(DepthStencilState.depthBias)));
        assert(((cast(*void)(*instance.depthBiasSlopeScale)) - cast(*void)(*instance)) == 64, "DepthStencilState.depthBiasSlopeScale has unexpected offset % instead of 64", ((cast(*void)(*instance.depthBiasSlopeScale)) - cast(*void)(*instance)));
        assert(size_of(type_of(DepthStencilState.depthBiasSlopeScale)) == 4, "DepthStencilState.depthBiasSlopeScale has unexpected size % instead of 4", size_of(type_of(DepthStencilState.depthBiasSlopeScale)));
        assert(((cast(*void)(*instance.depthBiasClamp)) - cast(*void)(*instance)) == 68, "DepthStencilState.depthBiasClamp has unexpected offset % instead of 68", ((cast(*void)(*instance.depthBiasClamp)) - cast(*void)(*instance)));
        assert(size_of(type_of(DepthStencilState.depthBiasClamp)) == 4, "DepthStencilState.depthBiasClamp has unexpected size % instead of 4", size_of(type_of(DepthStencilState.depthBiasClamp)));
        assert(size_of(DepthStencilState) == 72, "DepthStencilState has size % instead of 72", size_of(DepthStencilState));
    }

    {
        instance: ImageCopyBuffer;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "ImageCopyBuffer.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(ImageCopyBuffer.nextInChain)) == 8, "ImageCopyBuffer.nextInChain has unexpected size % instead of 8", size_of(type_of(ImageCopyBuffer.nextInChain)));
        assert(((cast(*void)(*instance.layout)) - cast(*void)(*instance)) == 8, "ImageCopyBuffer.layout has unexpected offset % instead of 8", ((cast(*void)(*instance.layout)) - cast(*void)(*instance)));
        assert(size_of(type_of(ImageCopyBuffer.layout)) == 24, "ImageCopyBuffer.layout has unexpected size % instead of 24", size_of(type_of(ImageCopyBuffer.layout)));
        assert(((cast(*void)(*instance.buffer)) - cast(*void)(*instance)) == 32, "ImageCopyBuffer.buffer has unexpected offset % instead of 32", ((cast(*void)(*instance.buffer)) - cast(*void)(*instance)));
        assert(size_of(type_of(ImageCopyBuffer.buffer)) == 8, "ImageCopyBuffer.buffer has unexpected size % instead of 8", size_of(type_of(ImageCopyBuffer.buffer)));
        assert(size_of(ImageCopyBuffer) == 40, "ImageCopyBuffer has size % instead of 40", size_of(ImageCopyBuffer));
    }

    {
        instance: ImageCopyTexture;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "ImageCopyTexture.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(ImageCopyTexture.nextInChain)) == 8, "ImageCopyTexture.nextInChain has unexpected size % instead of 8", size_of(type_of(ImageCopyTexture.nextInChain)));
        assert(((cast(*void)(*instance.texture)) - cast(*void)(*instance)) == 8, "ImageCopyTexture.texture has unexpected offset % instead of 8", ((cast(*void)(*instance.texture)) - cast(*void)(*instance)));
        assert(size_of(type_of(ImageCopyTexture.texture)) == 8, "ImageCopyTexture.texture has unexpected size % instead of 8", size_of(type_of(ImageCopyTexture.texture)));
        assert(((cast(*void)(*instance.mipLevel)) - cast(*void)(*instance)) == 16, "ImageCopyTexture.mipLevel has unexpected offset % instead of 16", ((cast(*void)(*instance.mipLevel)) - cast(*void)(*instance)));
        assert(size_of(type_of(ImageCopyTexture.mipLevel)) == 4, "ImageCopyTexture.mipLevel has unexpected size % instead of 4", size_of(type_of(ImageCopyTexture.mipLevel)));
        assert(((cast(*void)(*instance.origin)) - cast(*void)(*instance)) == 20, "ImageCopyTexture.origin has unexpected offset % instead of 20", ((cast(*void)(*instance.origin)) - cast(*void)(*instance)));
        assert(size_of(type_of(ImageCopyTexture.origin)) == 12, "ImageCopyTexture.origin has unexpected size % instead of 12", size_of(type_of(ImageCopyTexture.origin)));
        assert(((cast(*void)(*instance.aspect)) - cast(*void)(*instance)) == 32, "ImageCopyTexture.aspect has unexpected offset % instead of 32", ((cast(*void)(*instance.aspect)) - cast(*void)(*instance)));
        assert(size_of(type_of(ImageCopyTexture.aspect)) == 4, "ImageCopyTexture.aspect has unexpected size % instead of 4", size_of(type_of(ImageCopyTexture.aspect)));
        assert(size_of(ImageCopyTexture) == 40, "ImageCopyTexture has size % instead of 40", size_of(ImageCopyTexture));
    }

    {
        instance: ProgrammableStageDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "ProgrammableStageDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(ProgrammableStageDescriptor.nextInChain)) == 8, "ProgrammableStageDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(ProgrammableStageDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.module)) - cast(*void)(*instance)) == 8, "ProgrammableStageDescriptor.module has unexpected offset % instead of 8", ((cast(*void)(*instance.module)) - cast(*void)(*instance)));
        assert(size_of(type_of(ProgrammableStageDescriptor.module)) == 8, "ProgrammableStageDescriptor.module has unexpected size % instead of 8", size_of(type_of(ProgrammableStageDescriptor.module)));
        assert(((cast(*void)(*instance.entryPoint)) - cast(*void)(*instance)) == 16, "ProgrammableStageDescriptor.entryPoint has unexpected offset % instead of 16", ((cast(*void)(*instance.entryPoint)) - cast(*void)(*instance)));
        assert(size_of(type_of(ProgrammableStageDescriptor.entryPoint)) == 8, "ProgrammableStageDescriptor.entryPoint has unexpected size % instead of 8", size_of(type_of(ProgrammableStageDescriptor.entryPoint)));
        assert(((cast(*void)(*instance.constantCount)) - cast(*void)(*instance)) == 24, "ProgrammableStageDescriptor.constantCount has unexpected offset % instead of 24", ((cast(*void)(*instance.constantCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(ProgrammableStageDescriptor.constantCount)) == 8, "ProgrammableStageDescriptor.constantCount has unexpected size % instead of 8", size_of(type_of(ProgrammableStageDescriptor.constantCount)));
        assert(((cast(*void)(*instance.constants)) - cast(*void)(*instance)) == 32, "ProgrammableStageDescriptor.constants has unexpected offset % instead of 32", ((cast(*void)(*instance.constants)) - cast(*void)(*instance)));
        assert(size_of(type_of(ProgrammableStageDescriptor.constants)) == 8, "ProgrammableStageDescriptor.constants has unexpected size % instead of 8", size_of(type_of(ProgrammableStageDescriptor.constants)));
        assert(size_of(ProgrammableStageDescriptor) == 40, "ProgrammableStageDescriptor has size % instead of 40", size_of(ProgrammableStageDescriptor));
    }

    {
        instance: RenderPassColorAttachment;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "RenderPassColorAttachment.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderPassColorAttachment.nextInChain)) == 8, "RenderPassColorAttachment.nextInChain has unexpected size % instead of 8", size_of(type_of(RenderPassColorAttachment.nextInChain)));
        assert(((cast(*void)(*instance.view)) - cast(*void)(*instance)) == 8, "RenderPassColorAttachment.view has unexpected offset % instead of 8", ((cast(*void)(*instance.view)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderPassColorAttachment.view)) == 8, "RenderPassColorAttachment.view has unexpected size % instead of 8", size_of(type_of(RenderPassColorAttachment.view)));
        assert(((cast(*void)(*instance.resolveTarget)) - cast(*void)(*instance)) == 16, "RenderPassColorAttachment.resolveTarget has unexpected offset % instead of 16", ((cast(*void)(*instance.resolveTarget)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderPassColorAttachment.resolveTarget)) == 8, "RenderPassColorAttachment.resolveTarget has unexpected size % instead of 8", size_of(type_of(RenderPassColorAttachment.resolveTarget)));
        assert(((cast(*void)(*instance.loadOp)) - cast(*void)(*instance)) == 24, "RenderPassColorAttachment.loadOp has unexpected offset % instead of 24", ((cast(*void)(*instance.loadOp)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderPassColorAttachment.loadOp)) == 4, "RenderPassColorAttachment.loadOp has unexpected size % instead of 4", size_of(type_of(RenderPassColorAttachment.loadOp)));
        assert(((cast(*void)(*instance.storeOp)) - cast(*void)(*instance)) == 28, "RenderPassColorAttachment.storeOp has unexpected offset % instead of 28", ((cast(*void)(*instance.storeOp)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderPassColorAttachment.storeOp)) == 4, "RenderPassColorAttachment.storeOp has unexpected size % instead of 4", size_of(type_of(RenderPassColorAttachment.storeOp)));
        assert(((cast(*void)(*instance.clearValue)) - cast(*void)(*instance)) == 32, "RenderPassColorAttachment.clearValue has unexpected offset % instead of 32", ((cast(*void)(*instance.clearValue)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderPassColorAttachment.clearValue)) == 32, "RenderPassColorAttachment.clearValue has unexpected size % instead of 32", size_of(type_of(RenderPassColorAttachment.clearValue)));
        assert(size_of(RenderPassColorAttachment) == 64, "RenderPassColorAttachment has size % instead of 64", size_of(RenderPassColorAttachment));
    }

    {
        instance: RequiredLimits;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "RequiredLimits.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(RequiredLimits.nextInChain)) == 8, "RequiredLimits.nextInChain has unexpected size % instead of 8", size_of(type_of(RequiredLimits.nextInChain)));
        assert(((cast(*void)(*instance.limits)) - cast(*void)(*instance)) == 8, "RequiredLimits.limits has unexpected offset % instead of 8", ((cast(*void)(*instance.limits)) - cast(*void)(*instance)));
        assert(size_of(type_of(RequiredLimits.limits)) == 144, "RequiredLimits.limits has unexpected size % instead of 144", size_of(type_of(RequiredLimits.limits)));
        assert(size_of(RequiredLimits) == 152, "RequiredLimits has size % instead of 152", size_of(RequiredLimits));
    }

    {
        instance: ShaderModuleDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "ShaderModuleDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(ShaderModuleDescriptor.nextInChain)) == 8, "ShaderModuleDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(ShaderModuleDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "ShaderModuleDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(ShaderModuleDescriptor.label)) == 8, "ShaderModuleDescriptor.label has unexpected size % instead of 8", size_of(type_of(ShaderModuleDescriptor.label)));
        assert(((cast(*void)(*instance.hintCount)) - cast(*void)(*instance)) == 16, "ShaderModuleDescriptor.hintCount has unexpected offset % instead of 16", ((cast(*void)(*instance.hintCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(ShaderModuleDescriptor.hintCount)) == 8, "ShaderModuleDescriptor.hintCount has unexpected size % instead of 8", size_of(type_of(ShaderModuleDescriptor.hintCount)));
        assert(((cast(*void)(*instance.hints)) - cast(*void)(*instance)) == 24, "ShaderModuleDescriptor.hints has unexpected offset % instead of 24", ((cast(*void)(*instance.hints)) - cast(*void)(*instance)));
        assert(size_of(type_of(ShaderModuleDescriptor.hints)) == 8, "ShaderModuleDescriptor.hints has unexpected size % instead of 8", size_of(type_of(ShaderModuleDescriptor.hints)));
        assert(size_of(ShaderModuleDescriptor) == 32, "ShaderModuleDescriptor has size % instead of 32", size_of(ShaderModuleDescriptor));
    }

    {
        instance: SupportedLimits;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "SupportedLimits.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(SupportedLimits.nextInChain)) == 8, "SupportedLimits.nextInChain has unexpected size % instead of 8", size_of(type_of(SupportedLimits.nextInChain)));
        assert(((cast(*void)(*instance.limits)) - cast(*void)(*instance)) == 8, "SupportedLimits.limits has unexpected offset % instead of 8", ((cast(*void)(*instance.limits)) - cast(*void)(*instance)));
        assert(size_of(type_of(SupportedLimits.limits)) == 144, "SupportedLimits.limits has unexpected size % instead of 144", size_of(type_of(SupportedLimits.limits)));
        assert(size_of(SupportedLimits) == 152, "SupportedLimits has size % instead of 152", size_of(SupportedLimits));
    }

    {
        instance: TextureDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "TextureDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(TextureDescriptor.nextInChain)) == 8, "TextureDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(TextureDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "TextureDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(TextureDescriptor.label)) == 8, "TextureDescriptor.label has unexpected size % instead of 8", size_of(type_of(TextureDescriptor.label)));
        assert(((cast(*void)(*instance.usage)) - cast(*void)(*instance)) == 16, "TextureDescriptor.usage has unexpected offset % instead of 16", ((cast(*void)(*instance.usage)) - cast(*void)(*instance)));
        assert(size_of(type_of(TextureDescriptor.usage)) == 4, "TextureDescriptor.usage has unexpected size % instead of 4", size_of(type_of(TextureDescriptor.usage)));
        assert(((cast(*void)(*instance.dimension)) - cast(*void)(*instance)) == 20, "TextureDescriptor.dimension has unexpected offset % instead of 20", ((cast(*void)(*instance.dimension)) - cast(*void)(*instance)));
        assert(size_of(type_of(TextureDescriptor.dimension)) == 4, "TextureDescriptor.dimension has unexpected size % instead of 4", size_of(type_of(TextureDescriptor.dimension)));
        assert(((cast(*void)(*instance.size)) - cast(*void)(*instance)) == 24, "TextureDescriptor.size has unexpected offset % instead of 24", ((cast(*void)(*instance.size)) - cast(*void)(*instance)));
        assert(size_of(type_of(TextureDescriptor.size)) == 12, "TextureDescriptor.size has unexpected size % instead of 12", size_of(type_of(TextureDescriptor.size)));
        assert(((cast(*void)(*instance.format)) - cast(*void)(*instance)) == 36, "TextureDescriptor.format has unexpected offset % instead of 36", ((cast(*void)(*instance.format)) - cast(*void)(*instance)));
        assert(size_of(type_of(TextureDescriptor.format)) == 4, "TextureDescriptor.format has unexpected size % instead of 4", size_of(type_of(TextureDescriptor.format)));
        assert(((cast(*void)(*instance.mipLevelCount)) - cast(*void)(*instance)) == 40, "TextureDescriptor.mipLevelCount has unexpected offset % instead of 40", ((cast(*void)(*instance.mipLevelCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(TextureDescriptor.mipLevelCount)) == 4, "TextureDescriptor.mipLevelCount has unexpected size % instead of 4", size_of(type_of(TextureDescriptor.mipLevelCount)));
        assert(((cast(*void)(*instance.sampleCount)) - cast(*void)(*instance)) == 44, "TextureDescriptor.sampleCount has unexpected offset % instead of 44", ((cast(*void)(*instance.sampleCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(TextureDescriptor.sampleCount)) == 4, "TextureDescriptor.sampleCount has unexpected size % instead of 4", size_of(type_of(TextureDescriptor.sampleCount)));
        assert(((cast(*void)(*instance.viewFormatCount)) - cast(*void)(*instance)) == 48, "TextureDescriptor.viewFormatCount has unexpected offset % instead of 48", ((cast(*void)(*instance.viewFormatCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(TextureDescriptor.viewFormatCount)) == 8, "TextureDescriptor.viewFormatCount has unexpected size % instead of 8", size_of(type_of(TextureDescriptor.viewFormatCount)));
        assert(((cast(*void)(*instance.viewFormats)) - cast(*void)(*instance)) == 56, "TextureDescriptor.viewFormats has unexpected offset % instead of 56", ((cast(*void)(*instance.viewFormats)) - cast(*void)(*instance)));
        assert(size_of(type_of(TextureDescriptor.viewFormats)) == 8, "TextureDescriptor.viewFormats has unexpected size % instead of 8", size_of(type_of(TextureDescriptor.viewFormats)));
        assert(size_of(TextureDescriptor) == 64, "TextureDescriptor has size % instead of 64", size_of(TextureDescriptor));
    }

    {
        instance: VertexBufferLayout;
        assert(((cast(*void)(*instance.arrayStride)) - cast(*void)(*instance)) == 0, "VertexBufferLayout.arrayStride has unexpected offset % instead of 0", ((cast(*void)(*instance.arrayStride)) - cast(*void)(*instance)));
        assert(size_of(type_of(VertexBufferLayout.arrayStride)) == 8, "VertexBufferLayout.arrayStride has unexpected size % instead of 8", size_of(type_of(VertexBufferLayout.arrayStride)));
        assert(((cast(*void)(*instance.stepMode)) - cast(*void)(*instance)) == 8, "VertexBufferLayout.stepMode has unexpected offset % instead of 8", ((cast(*void)(*instance.stepMode)) - cast(*void)(*instance)));
        assert(size_of(type_of(VertexBufferLayout.stepMode)) == 4, "VertexBufferLayout.stepMode has unexpected size % instead of 4", size_of(type_of(VertexBufferLayout.stepMode)));
        assert(((cast(*void)(*instance.attributeCount)) - cast(*void)(*instance)) == 16, "VertexBufferLayout.attributeCount has unexpected offset % instead of 16", ((cast(*void)(*instance.attributeCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(VertexBufferLayout.attributeCount)) == 8, "VertexBufferLayout.attributeCount has unexpected size % instead of 8", size_of(type_of(VertexBufferLayout.attributeCount)));
        assert(((cast(*void)(*instance.attributes)) - cast(*void)(*instance)) == 24, "VertexBufferLayout.attributes has unexpected offset % instead of 24", ((cast(*void)(*instance.attributes)) - cast(*void)(*instance)));
        assert(size_of(type_of(VertexBufferLayout.attributes)) == 8, "VertexBufferLayout.attributes has unexpected size % instead of 8", size_of(type_of(VertexBufferLayout.attributes)));
        assert(size_of(VertexBufferLayout) == 32, "VertexBufferLayout has size % instead of 32", size_of(VertexBufferLayout));
    }

    {
        instance: BindGroupLayoutDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "BindGroupLayoutDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(BindGroupLayoutDescriptor.nextInChain)) == 8, "BindGroupLayoutDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(BindGroupLayoutDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "BindGroupLayoutDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(BindGroupLayoutDescriptor.label)) == 8, "BindGroupLayoutDescriptor.label has unexpected size % instead of 8", size_of(type_of(BindGroupLayoutDescriptor.label)));
        assert(((cast(*void)(*instance.entryCount)) - cast(*void)(*instance)) == 16, "BindGroupLayoutDescriptor.entryCount has unexpected offset % instead of 16", ((cast(*void)(*instance.entryCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(BindGroupLayoutDescriptor.entryCount)) == 8, "BindGroupLayoutDescriptor.entryCount has unexpected size % instead of 8", size_of(type_of(BindGroupLayoutDescriptor.entryCount)));
        assert(((cast(*void)(*instance.entries)) - cast(*void)(*instance)) == 24, "BindGroupLayoutDescriptor.entries has unexpected offset % instead of 24", ((cast(*void)(*instance.entries)) - cast(*void)(*instance)));
        assert(size_of(type_of(BindGroupLayoutDescriptor.entries)) == 8, "BindGroupLayoutDescriptor.entries has unexpected size % instead of 8", size_of(type_of(BindGroupLayoutDescriptor.entries)));
        assert(size_of(BindGroupLayoutDescriptor) == 32, "BindGroupLayoutDescriptor has size % instead of 32", size_of(BindGroupLayoutDescriptor));
    }

    {
        instance: ColorTargetState;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "ColorTargetState.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(ColorTargetState.nextInChain)) == 8, "ColorTargetState.nextInChain has unexpected size % instead of 8", size_of(type_of(ColorTargetState.nextInChain)));
        assert(((cast(*void)(*instance.format)) - cast(*void)(*instance)) == 8, "ColorTargetState.format has unexpected offset % instead of 8", ((cast(*void)(*instance.format)) - cast(*void)(*instance)));
        assert(size_of(type_of(ColorTargetState.format)) == 4, "ColorTargetState.format has unexpected size % instead of 4", size_of(type_of(ColorTargetState.format)));
        assert(((cast(*void)(*instance.blend)) - cast(*void)(*instance)) == 16, "ColorTargetState.blend has unexpected offset % instead of 16", ((cast(*void)(*instance.blend)) - cast(*void)(*instance)));
        assert(size_of(type_of(ColorTargetState.blend)) == 8, "ColorTargetState.blend has unexpected size % instead of 8", size_of(type_of(ColorTargetState.blend)));
        assert(((cast(*void)(*instance.writeMask)) - cast(*void)(*instance)) == 24, "ColorTargetState.writeMask has unexpected offset % instead of 24", ((cast(*void)(*instance.writeMask)) - cast(*void)(*instance)));
        assert(size_of(type_of(ColorTargetState.writeMask)) == 4, "ColorTargetState.writeMask has unexpected size % instead of 4", size_of(type_of(ColorTargetState.writeMask)));
        assert(size_of(ColorTargetState) == 32, "ColorTargetState has size % instead of 32", size_of(ColorTargetState));
    }

    {
        instance: ComputePipelineDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "ComputePipelineDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(ComputePipelineDescriptor.nextInChain)) == 8, "ComputePipelineDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(ComputePipelineDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "ComputePipelineDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(ComputePipelineDescriptor.label)) == 8, "ComputePipelineDescriptor.label has unexpected size % instead of 8", size_of(type_of(ComputePipelineDescriptor.label)));
        assert(((cast(*void)(*instance.layout)) - cast(*void)(*instance)) == 16, "ComputePipelineDescriptor.layout has unexpected offset % instead of 16", ((cast(*void)(*instance.layout)) - cast(*void)(*instance)));
        assert(size_of(type_of(ComputePipelineDescriptor.layout)) == 8, "ComputePipelineDescriptor.layout has unexpected size % instead of 8", size_of(type_of(ComputePipelineDescriptor.layout)));
        assert(((cast(*void)(*instance.compute)) - cast(*void)(*instance)) == 24, "ComputePipelineDescriptor.compute has unexpected offset % instead of 24", ((cast(*void)(*instance.compute)) - cast(*void)(*instance)));
        assert(size_of(type_of(ComputePipelineDescriptor.compute)) == 40, "ComputePipelineDescriptor.compute has unexpected size % instead of 40", size_of(type_of(ComputePipelineDescriptor.compute)));
        assert(size_of(ComputePipelineDescriptor) == 64, "ComputePipelineDescriptor has size % instead of 64", size_of(ComputePipelineDescriptor));
    }

    {
        instance: DeviceDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "DeviceDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(DeviceDescriptor.nextInChain)) == 8, "DeviceDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(DeviceDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "DeviceDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(DeviceDescriptor.label)) == 8, "DeviceDescriptor.label has unexpected size % instead of 8", size_of(type_of(DeviceDescriptor.label)));
        assert(((cast(*void)(*instance.requiredFeatureCount)) - cast(*void)(*instance)) == 16, "DeviceDescriptor.requiredFeatureCount has unexpected offset % instead of 16", ((cast(*void)(*instance.requiredFeatureCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(DeviceDescriptor.requiredFeatureCount)) == 8, "DeviceDescriptor.requiredFeatureCount has unexpected size % instead of 8", size_of(type_of(DeviceDescriptor.requiredFeatureCount)));
        assert(((cast(*void)(*instance.requiredFeatures)) - cast(*void)(*instance)) == 24, "DeviceDescriptor.requiredFeatures has unexpected offset % instead of 24", ((cast(*void)(*instance.requiredFeatures)) - cast(*void)(*instance)));
        assert(size_of(type_of(DeviceDescriptor.requiredFeatures)) == 8, "DeviceDescriptor.requiredFeatures has unexpected size % instead of 8", size_of(type_of(DeviceDescriptor.requiredFeatures)));
        assert(((cast(*void)(*instance.requiredLimits)) - cast(*void)(*instance)) == 32, "DeviceDescriptor.requiredLimits has unexpected offset % instead of 32", ((cast(*void)(*instance.requiredLimits)) - cast(*void)(*instance)));
        assert(size_of(type_of(DeviceDescriptor.requiredLimits)) == 8, "DeviceDescriptor.requiredLimits has unexpected size % instead of 8", size_of(type_of(DeviceDescriptor.requiredLimits)));
        assert(((cast(*void)(*instance.defaultQueue)) - cast(*void)(*instance)) == 40, "DeviceDescriptor.defaultQueue has unexpected offset % instead of 40", ((cast(*void)(*instance.defaultQueue)) - cast(*void)(*instance)));
        assert(size_of(type_of(DeviceDescriptor.defaultQueue)) == 16, "DeviceDescriptor.defaultQueue has unexpected size % instead of 16", size_of(type_of(DeviceDescriptor.defaultQueue)));
        assert(((cast(*void)(*instance.deviceLostCallback)) - cast(*void)(*instance)) == 56, "DeviceDescriptor.deviceLostCallback has unexpected offset % instead of 56", ((cast(*void)(*instance.deviceLostCallback)) - cast(*void)(*instance)));
        assert(size_of(type_of(DeviceDescriptor.deviceLostCallback)) == 8, "DeviceDescriptor.deviceLostCallback has unexpected size % instead of 8", size_of(type_of(DeviceDescriptor.deviceLostCallback)));
        assert(((cast(*void)(*instance.deviceLostUserdata)) - cast(*void)(*instance)) == 64, "DeviceDescriptor.deviceLostUserdata has unexpected offset % instead of 64", ((cast(*void)(*instance.deviceLostUserdata)) - cast(*void)(*instance)));
        assert(size_of(type_of(DeviceDescriptor.deviceLostUserdata)) == 8, "DeviceDescriptor.deviceLostUserdata has unexpected size % instead of 8", size_of(type_of(DeviceDescriptor.deviceLostUserdata)));
        assert(size_of(DeviceDescriptor) == 72, "DeviceDescriptor has size % instead of 72", size_of(DeviceDescriptor));
    }

    {
        instance: RenderPassDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "RenderPassDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderPassDescriptor.nextInChain)) == 8, "RenderPassDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(RenderPassDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "RenderPassDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderPassDescriptor.label)) == 8, "RenderPassDescriptor.label has unexpected size % instead of 8", size_of(type_of(RenderPassDescriptor.label)));
        assert(((cast(*void)(*instance.colorAttachmentCount)) - cast(*void)(*instance)) == 16, "RenderPassDescriptor.colorAttachmentCount has unexpected offset % instead of 16", ((cast(*void)(*instance.colorAttachmentCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderPassDescriptor.colorAttachmentCount)) == 8, "RenderPassDescriptor.colorAttachmentCount has unexpected size % instead of 8", size_of(type_of(RenderPassDescriptor.colorAttachmentCount)));
        assert(((cast(*void)(*instance.colorAttachments)) - cast(*void)(*instance)) == 24, "RenderPassDescriptor.colorAttachments has unexpected offset % instead of 24", ((cast(*void)(*instance.colorAttachments)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderPassDescriptor.colorAttachments)) == 8, "RenderPassDescriptor.colorAttachments has unexpected size % instead of 8", size_of(type_of(RenderPassDescriptor.colorAttachments)));
        assert(((cast(*void)(*instance.depthStencilAttachment)) - cast(*void)(*instance)) == 32, "RenderPassDescriptor.depthStencilAttachment has unexpected offset % instead of 32", ((cast(*void)(*instance.depthStencilAttachment)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderPassDescriptor.depthStencilAttachment)) == 8, "RenderPassDescriptor.depthStencilAttachment has unexpected size % instead of 8", size_of(type_of(RenderPassDescriptor.depthStencilAttachment)));
        assert(((cast(*void)(*instance.occlusionQuerySet)) - cast(*void)(*instance)) == 40, "RenderPassDescriptor.occlusionQuerySet has unexpected offset % instead of 40", ((cast(*void)(*instance.occlusionQuerySet)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderPassDescriptor.occlusionQuerySet)) == 8, "RenderPassDescriptor.occlusionQuerySet has unexpected size % instead of 8", size_of(type_of(RenderPassDescriptor.occlusionQuerySet)));
        assert(((cast(*void)(*instance.timestampWrites)) - cast(*void)(*instance)) == 48, "RenderPassDescriptor.timestampWrites has unexpected offset % instead of 48", ((cast(*void)(*instance.timestampWrites)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderPassDescriptor.timestampWrites)) == 8, "RenderPassDescriptor.timestampWrites has unexpected size % instead of 8", size_of(type_of(RenderPassDescriptor.timestampWrites)));
        assert(size_of(RenderPassDescriptor) == 56, "RenderPassDescriptor has size % instead of 56", size_of(RenderPassDescriptor));
    }

    {
        instance: VertexState;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "VertexState.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(VertexState.nextInChain)) == 8, "VertexState.nextInChain has unexpected size % instead of 8", size_of(type_of(VertexState.nextInChain)));
        assert(((cast(*void)(*instance.module)) - cast(*void)(*instance)) == 8, "VertexState.module has unexpected offset % instead of 8", ((cast(*void)(*instance.module)) - cast(*void)(*instance)));
        assert(size_of(type_of(VertexState.module)) == 8, "VertexState.module has unexpected size % instead of 8", size_of(type_of(VertexState.module)));
        assert(((cast(*void)(*instance.entryPoint)) - cast(*void)(*instance)) == 16, "VertexState.entryPoint has unexpected offset % instead of 16", ((cast(*void)(*instance.entryPoint)) - cast(*void)(*instance)));
        assert(size_of(type_of(VertexState.entryPoint)) == 8, "VertexState.entryPoint has unexpected size % instead of 8", size_of(type_of(VertexState.entryPoint)));
        assert(((cast(*void)(*instance.constantCount)) - cast(*void)(*instance)) == 24, "VertexState.constantCount has unexpected offset % instead of 24", ((cast(*void)(*instance.constantCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(VertexState.constantCount)) == 8, "VertexState.constantCount has unexpected size % instead of 8", size_of(type_of(VertexState.constantCount)));
        assert(((cast(*void)(*instance.constants)) - cast(*void)(*instance)) == 32, "VertexState.constants has unexpected offset % instead of 32", ((cast(*void)(*instance.constants)) - cast(*void)(*instance)));
        assert(size_of(type_of(VertexState.constants)) == 8, "VertexState.constants has unexpected size % instead of 8", size_of(type_of(VertexState.constants)));
        assert(((cast(*void)(*instance.bufferCount)) - cast(*void)(*instance)) == 40, "VertexState.bufferCount has unexpected offset % instead of 40", ((cast(*void)(*instance.bufferCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(VertexState.bufferCount)) == 8, "VertexState.bufferCount has unexpected size % instead of 8", size_of(type_of(VertexState.bufferCount)));
        assert(((cast(*void)(*instance.buffers)) - cast(*void)(*instance)) == 48, "VertexState.buffers has unexpected offset % instead of 48", ((cast(*void)(*instance.buffers)) - cast(*void)(*instance)));
        assert(size_of(type_of(VertexState.buffers)) == 8, "VertexState.buffers has unexpected size % instead of 8", size_of(type_of(VertexState.buffers)));
        assert(size_of(VertexState) == 56, "VertexState has size % instead of 56", size_of(VertexState));
    }

    {
        instance: FragmentState;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "FragmentState.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(FragmentState.nextInChain)) == 8, "FragmentState.nextInChain has unexpected size % instead of 8", size_of(type_of(FragmentState.nextInChain)));
        assert(((cast(*void)(*instance.module)) - cast(*void)(*instance)) == 8, "FragmentState.module has unexpected offset % instead of 8", ((cast(*void)(*instance.module)) - cast(*void)(*instance)));
        assert(size_of(type_of(FragmentState.module)) == 8, "FragmentState.module has unexpected size % instead of 8", size_of(type_of(FragmentState.module)));
        assert(((cast(*void)(*instance.entryPoint)) - cast(*void)(*instance)) == 16, "FragmentState.entryPoint has unexpected offset % instead of 16", ((cast(*void)(*instance.entryPoint)) - cast(*void)(*instance)));
        assert(size_of(type_of(FragmentState.entryPoint)) == 8, "FragmentState.entryPoint has unexpected size % instead of 8", size_of(type_of(FragmentState.entryPoint)));
        assert(((cast(*void)(*instance.constantCount)) - cast(*void)(*instance)) == 24, "FragmentState.constantCount has unexpected offset % instead of 24", ((cast(*void)(*instance.constantCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(FragmentState.constantCount)) == 8, "FragmentState.constantCount has unexpected size % instead of 8", size_of(type_of(FragmentState.constantCount)));
        assert(((cast(*void)(*instance.constants)) - cast(*void)(*instance)) == 32, "FragmentState.constants has unexpected offset % instead of 32", ((cast(*void)(*instance.constants)) - cast(*void)(*instance)));
        assert(size_of(type_of(FragmentState.constants)) == 8, "FragmentState.constants has unexpected size % instead of 8", size_of(type_of(FragmentState.constants)));
        assert(((cast(*void)(*instance.targetCount)) - cast(*void)(*instance)) == 40, "FragmentState.targetCount has unexpected offset % instead of 40", ((cast(*void)(*instance.targetCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(FragmentState.targetCount)) == 8, "FragmentState.targetCount has unexpected size % instead of 8", size_of(type_of(FragmentState.targetCount)));
        assert(((cast(*void)(*instance.targets)) - cast(*void)(*instance)) == 48, "FragmentState.targets has unexpected offset % instead of 48", ((cast(*void)(*instance.targets)) - cast(*void)(*instance)));
        assert(size_of(type_of(FragmentState.targets)) == 8, "FragmentState.targets has unexpected size % instead of 8", size_of(type_of(FragmentState.targets)));
        assert(size_of(FragmentState) == 56, "FragmentState has size % instead of 56", size_of(FragmentState));
    }

    {
        instance: RenderPipelineDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "RenderPipelineDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderPipelineDescriptor.nextInChain)) == 8, "RenderPipelineDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(RenderPipelineDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "RenderPipelineDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderPipelineDescriptor.label)) == 8, "RenderPipelineDescriptor.label has unexpected size % instead of 8", size_of(type_of(RenderPipelineDescriptor.label)));
        assert(((cast(*void)(*instance.layout)) - cast(*void)(*instance)) == 16, "RenderPipelineDescriptor.layout has unexpected offset % instead of 16", ((cast(*void)(*instance.layout)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderPipelineDescriptor.layout)) == 8, "RenderPipelineDescriptor.layout has unexpected size % instead of 8", size_of(type_of(RenderPipelineDescriptor.layout)));
        assert(((cast(*void)(*instance.vertex)) - cast(*void)(*instance)) == 24, "RenderPipelineDescriptor.vertex has unexpected offset % instead of 24", ((cast(*void)(*instance.vertex)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderPipelineDescriptor.vertex)) == 56, "RenderPipelineDescriptor.vertex has unexpected size % instead of 56", size_of(type_of(RenderPipelineDescriptor.vertex)));
        assert(((cast(*void)(*instance.primitive)) - cast(*void)(*instance)) == 80, "RenderPipelineDescriptor.primitive has unexpected offset % instead of 80", ((cast(*void)(*instance.primitive)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderPipelineDescriptor.primitive)) == 24, "RenderPipelineDescriptor.primitive has unexpected size % instead of 24", size_of(type_of(RenderPipelineDescriptor.primitive)));
        assert(((cast(*void)(*instance.depthStencil)) - cast(*void)(*instance)) == 104, "RenderPipelineDescriptor.depthStencil has unexpected offset % instead of 104", ((cast(*void)(*instance.depthStencil)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderPipelineDescriptor.depthStencil)) == 8, "RenderPipelineDescriptor.depthStencil has unexpected size % instead of 8", size_of(type_of(RenderPipelineDescriptor.depthStencil)));
        assert(((cast(*void)(*instance.multisample)) - cast(*void)(*instance)) == 112, "RenderPipelineDescriptor.multisample has unexpected offset % instead of 112", ((cast(*void)(*instance.multisample)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderPipelineDescriptor.multisample)) == 24, "RenderPipelineDescriptor.multisample has unexpected size % instead of 24", size_of(type_of(RenderPipelineDescriptor.multisample)));
        assert(((cast(*void)(*instance.fragment)) - cast(*void)(*instance)) == 136, "RenderPipelineDescriptor.fragment has unexpected offset % instead of 136", ((cast(*void)(*instance.fragment)) - cast(*void)(*instance)));
        assert(size_of(type_of(RenderPipelineDescriptor.fragment)) == 8, "RenderPipelineDescriptor.fragment has unexpected size % instead of 8", size_of(type_of(RenderPipelineDescriptor.fragment)));
        assert(size_of(RenderPipelineDescriptor) == 144, "RenderPipelineDescriptor has size % instead of 144", size_of(RenderPipelineDescriptor));
    }

    {
        instance: InstanceExtras;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "InstanceExtras.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(InstanceExtras.chain)) == 16, "InstanceExtras.chain has unexpected size % instead of 16", size_of(type_of(InstanceExtras.chain)));
        assert(((cast(*void)(*instance.backends)) - cast(*void)(*instance)) == 16, "InstanceExtras.backends has unexpected offset % instead of 16", ((cast(*void)(*instance.backends)) - cast(*void)(*instance)));
        assert(size_of(type_of(InstanceExtras.backends)) == 4, "InstanceExtras.backends has unexpected size % instead of 4", size_of(type_of(InstanceExtras.backends)));
        assert(((cast(*void)(*instance.flags)) - cast(*void)(*instance)) == 20, "InstanceExtras.flags has unexpected offset % instead of 20", ((cast(*void)(*instance.flags)) - cast(*void)(*instance)));
        assert(size_of(type_of(InstanceExtras.flags)) == 4, "InstanceExtras.flags has unexpected size % instead of 4", size_of(type_of(InstanceExtras.flags)));
        assert(((cast(*void)(*instance.dx12ShaderCompiler)) - cast(*void)(*instance)) == 24, "InstanceExtras.dx12ShaderCompiler has unexpected offset % instead of 24", ((cast(*void)(*instance.dx12ShaderCompiler)) - cast(*void)(*instance)));
        assert(size_of(type_of(InstanceExtras.dx12ShaderCompiler)) == 4, "InstanceExtras.dx12ShaderCompiler has unexpected size % instead of 4", size_of(type_of(InstanceExtras.dx12ShaderCompiler)));
        assert(((cast(*void)(*instance.gles3MinorVersion)) - cast(*void)(*instance)) == 28, "InstanceExtras.gles3MinorVersion has unexpected offset % instead of 28", ((cast(*void)(*instance.gles3MinorVersion)) - cast(*void)(*instance)));
        assert(size_of(type_of(InstanceExtras.gles3MinorVersion)) == 4, "InstanceExtras.gles3MinorVersion has unexpected size % instead of 4", size_of(type_of(InstanceExtras.gles3MinorVersion)));
        assert(((cast(*void)(*instance.dxilPath)) - cast(*void)(*instance)) == 32, "InstanceExtras.dxilPath has unexpected offset % instead of 32", ((cast(*void)(*instance.dxilPath)) - cast(*void)(*instance)));
        assert(size_of(type_of(InstanceExtras.dxilPath)) == 8, "InstanceExtras.dxilPath has unexpected size % instead of 8", size_of(type_of(InstanceExtras.dxilPath)));
        assert(((cast(*void)(*instance.dxcPath)) - cast(*void)(*instance)) == 40, "InstanceExtras.dxcPath has unexpected offset % instead of 40", ((cast(*void)(*instance.dxcPath)) - cast(*void)(*instance)));
        assert(size_of(type_of(InstanceExtras.dxcPath)) == 8, "InstanceExtras.dxcPath has unexpected size % instead of 8", size_of(type_of(InstanceExtras.dxcPath)));
        assert(size_of(InstanceExtras) == 48, "InstanceExtras has size % instead of 48", size_of(InstanceExtras));
    }

    {
        instance: DeviceExtras;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "DeviceExtras.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(DeviceExtras.chain)) == 16, "DeviceExtras.chain has unexpected size % instead of 16", size_of(type_of(DeviceExtras.chain)));
        assert(((cast(*void)(*instance.tracePath)) - cast(*void)(*instance)) == 16, "DeviceExtras.tracePath has unexpected offset % instead of 16", ((cast(*void)(*instance.tracePath)) - cast(*void)(*instance)));
        assert(size_of(type_of(DeviceExtras.tracePath)) == 8, "DeviceExtras.tracePath has unexpected size % instead of 8", size_of(type_of(DeviceExtras.tracePath)));
        assert(size_of(DeviceExtras) == 24, "DeviceExtras has size % instead of 24", size_of(DeviceExtras));
    }

    {
        instance: NativeLimits;
        assert(((cast(*void)(*instance.maxPushConstantSize)) - cast(*void)(*instance)) == 0, "NativeLimits.maxPushConstantSize has unexpected offset % instead of 0", ((cast(*void)(*instance.maxPushConstantSize)) - cast(*void)(*instance)));
        assert(size_of(type_of(NativeLimits.maxPushConstantSize)) == 4, "NativeLimits.maxPushConstantSize has unexpected size % instead of 4", size_of(type_of(NativeLimits.maxPushConstantSize)));
        assert(((cast(*void)(*instance.maxNonSamplerBindings)) - cast(*void)(*instance)) == 4, "NativeLimits.maxNonSamplerBindings has unexpected offset % instead of 4", ((cast(*void)(*instance.maxNonSamplerBindings)) - cast(*void)(*instance)));
        assert(size_of(type_of(NativeLimits.maxNonSamplerBindings)) == 4, "NativeLimits.maxNonSamplerBindings has unexpected size % instead of 4", size_of(type_of(NativeLimits.maxNonSamplerBindings)));
        assert(size_of(NativeLimits) == 8, "NativeLimits has size % instead of 8", size_of(NativeLimits));
    }

    {
        instance: RequiredLimitsExtras;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "RequiredLimitsExtras.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(RequiredLimitsExtras.chain)) == 16, "RequiredLimitsExtras.chain has unexpected size % instead of 16", size_of(type_of(RequiredLimitsExtras.chain)));
        assert(((cast(*void)(*instance.limits)) - cast(*void)(*instance)) == 16, "RequiredLimitsExtras.limits has unexpected offset % instead of 16", ((cast(*void)(*instance.limits)) - cast(*void)(*instance)));
        assert(size_of(type_of(RequiredLimitsExtras.limits)) == 8, "RequiredLimitsExtras.limits has unexpected size % instead of 8", size_of(type_of(RequiredLimitsExtras.limits)));
        assert(size_of(RequiredLimitsExtras) == 24, "RequiredLimitsExtras has size % instead of 24", size_of(RequiredLimitsExtras));
    }

    {
        instance: SupportedLimitsExtras;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "SupportedLimitsExtras.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(SupportedLimitsExtras.chain)) == 16, "SupportedLimitsExtras.chain has unexpected size % instead of 16", size_of(type_of(SupportedLimitsExtras.chain)));
        assert(((cast(*void)(*instance.limits)) - cast(*void)(*instance)) == 16, "SupportedLimitsExtras.limits has unexpected offset % instead of 16", ((cast(*void)(*instance.limits)) - cast(*void)(*instance)));
        assert(size_of(type_of(SupportedLimitsExtras.limits)) == 8, "SupportedLimitsExtras.limits has unexpected size % instead of 8", size_of(type_of(SupportedLimitsExtras.limits)));
        assert(size_of(SupportedLimitsExtras) == 24, "SupportedLimitsExtras has size % instead of 24", size_of(SupportedLimitsExtras));
    }

    {
        instance: PushConstantRange;
        assert(((cast(*void)(*instance.stages)) - cast(*void)(*instance)) == 0, "PushConstantRange.stages has unexpected offset % instead of 0", ((cast(*void)(*instance.stages)) - cast(*void)(*instance)));
        assert(size_of(type_of(PushConstantRange.stages)) == 4, "PushConstantRange.stages has unexpected size % instead of 4", size_of(type_of(PushConstantRange.stages)));
        assert(((cast(*void)(*instance.start)) - cast(*void)(*instance)) == 4, "PushConstantRange.start has unexpected offset % instead of 4", ((cast(*void)(*instance.start)) - cast(*void)(*instance)));
        assert(size_of(type_of(PushConstantRange.start)) == 4, "PushConstantRange.start has unexpected size % instead of 4", size_of(type_of(PushConstantRange.start)));
        assert(((cast(*void)(*instance.end)) - cast(*void)(*instance)) == 8, "PushConstantRange.end has unexpected offset % instead of 8", ((cast(*void)(*instance.end)) - cast(*void)(*instance)));
        assert(size_of(type_of(PushConstantRange.end)) == 4, "PushConstantRange.end has unexpected size % instead of 4", size_of(type_of(PushConstantRange.end)));
        assert(size_of(PushConstantRange) == 12, "PushConstantRange has size % instead of 12", size_of(PushConstantRange));
    }

    {
        instance: PipelineLayoutExtras;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "PipelineLayoutExtras.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(PipelineLayoutExtras.chain)) == 16, "PipelineLayoutExtras.chain has unexpected size % instead of 16", size_of(type_of(PipelineLayoutExtras.chain)));
        assert(((cast(*void)(*instance.pushConstantRangeCount)) - cast(*void)(*instance)) == 16, "PipelineLayoutExtras.pushConstantRangeCount has unexpected offset % instead of 16", ((cast(*void)(*instance.pushConstantRangeCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(PipelineLayoutExtras.pushConstantRangeCount)) == 8, "PipelineLayoutExtras.pushConstantRangeCount has unexpected size % instead of 8", size_of(type_of(PipelineLayoutExtras.pushConstantRangeCount)));
        assert(((cast(*void)(*instance.pushConstantRanges)) - cast(*void)(*instance)) == 24, "PipelineLayoutExtras.pushConstantRanges has unexpected offset % instead of 24", ((cast(*void)(*instance.pushConstantRanges)) - cast(*void)(*instance)));
        assert(size_of(type_of(PipelineLayoutExtras.pushConstantRanges)) == 8, "PipelineLayoutExtras.pushConstantRanges has unexpected size % instead of 8", size_of(type_of(PipelineLayoutExtras.pushConstantRanges)));
        assert(size_of(PipelineLayoutExtras) == 32, "PipelineLayoutExtras has size % instead of 32", size_of(PipelineLayoutExtras));
    }

    {
        instance: WrappedSubmissionIndex;
        assert(((cast(*void)(*instance.queue)) - cast(*void)(*instance)) == 0, "WrappedSubmissionIndex.queue has unexpected offset % instead of 0", ((cast(*void)(*instance.queue)) - cast(*void)(*instance)));
        assert(size_of(type_of(WrappedSubmissionIndex.queue)) == 8, "WrappedSubmissionIndex.queue has unexpected size % instead of 8", size_of(type_of(WrappedSubmissionIndex.queue)));
        assert(((cast(*void)(*instance.submissionIndex)) - cast(*void)(*instance)) == 8, "WrappedSubmissionIndex.submissionIndex has unexpected offset % instead of 8", ((cast(*void)(*instance.submissionIndex)) - cast(*void)(*instance)));
        assert(size_of(type_of(WrappedSubmissionIndex.submissionIndex)) == 8, "WrappedSubmissionIndex.submissionIndex has unexpected size % instead of 8", size_of(type_of(WrappedSubmissionIndex.submissionIndex)));
        assert(size_of(WrappedSubmissionIndex) == 16, "WrappedSubmissionIndex has size % instead of 16", size_of(WrappedSubmissionIndex));
    }

    {
        instance: ShaderDefine;
        assert(((cast(*void)(*instance.name)) - cast(*void)(*instance)) == 0, "ShaderDefine.name has unexpected offset % instead of 0", ((cast(*void)(*instance.name)) - cast(*void)(*instance)));
        assert(size_of(type_of(ShaderDefine.name)) == 8, "ShaderDefine.name has unexpected size % instead of 8", size_of(type_of(ShaderDefine.name)));
        assert(((cast(*void)(*instance.value)) - cast(*void)(*instance)) == 8, "ShaderDefine.value has unexpected offset % instead of 8", ((cast(*void)(*instance.value)) - cast(*void)(*instance)));
        assert(size_of(type_of(ShaderDefine.value)) == 8, "ShaderDefine.value has unexpected size % instead of 8", size_of(type_of(ShaderDefine.value)));
        assert(size_of(ShaderDefine) == 16, "ShaderDefine has size % instead of 16", size_of(ShaderDefine));
    }

    {
        instance: ShaderModuleGLSLDescriptor;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "ShaderModuleGLSLDescriptor.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(ShaderModuleGLSLDescriptor.chain)) == 16, "ShaderModuleGLSLDescriptor.chain has unexpected size % instead of 16", size_of(type_of(ShaderModuleGLSLDescriptor.chain)));
        assert(((cast(*void)(*instance.stage)) - cast(*void)(*instance)) == 16, "ShaderModuleGLSLDescriptor.stage has unexpected offset % instead of 16", ((cast(*void)(*instance.stage)) - cast(*void)(*instance)));
        assert(size_of(type_of(ShaderModuleGLSLDescriptor.stage)) == 4, "ShaderModuleGLSLDescriptor.stage has unexpected size % instead of 4", size_of(type_of(ShaderModuleGLSLDescriptor.stage)));
        assert(((cast(*void)(*instance.code)) - cast(*void)(*instance)) == 24, "ShaderModuleGLSLDescriptor.code has unexpected offset % instead of 24", ((cast(*void)(*instance.code)) - cast(*void)(*instance)));
        assert(size_of(type_of(ShaderModuleGLSLDescriptor.code)) == 8, "ShaderModuleGLSLDescriptor.code has unexpected size % instead of 8", size_of(type_of(ShaderModuleGLSLDescriptor.code)));
        assert(((cast(*void)(*instance.defineCount)) - cast(*void)(*instance)) == 32, "ShaderModuleGLSLDescriptor.defineCount has unexpected offset % instead of 32", ((cast(*void)(*instance.defineCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(ShaderModuleGLSLDescriptor.defineCount)) == 4, "ShaderModuleGLSLDescriptor.defineCount has unexpected size % instead of 4", size_of(type_of(ShaderModuleGLSLDescriptor.defineCount)));
        assert(((cast(*void)(*instance.defines)) - cast(*void)(*instance)) == 40, "ShaderModuleGLSLDescriptor.defines has unexpected offset % instead of 40", ((cast(*void)(*instance.defines)) - cast(*void)(*instance)));
        assert(size_of(type_of(ShaderModuleGLSLDescriptor.defines)) == 8, "ShaderModuleGLSLDescriptor.defines has unexpected size % instead of 8", size_of(type_of(ShaderModuleGLSLDescriptor.defines)));
        assert(size_of(ShaderModuleGLSLDescriptor) == 48, "ShaderModuleGLSLDescriptor has size % instead of 48", size_of(ShaderModuleGLSLDescriptor));
    }

    {
        instance: RegistryReport;
        assert(((cast(*void)(*instance.numAllocated)) - cast(*void)(*instance)) == 0, "RegistryReport.numAllocated has unexpected offset % instead of 0", ((cast(*void)(*instance.numAllocated)) - cast(*void)(*instance)));
        assert(size_of(type_of(RegistryReport.numAllocated)) == 8, "RegistryReport.numAllocated has unexpected size % instead of 8", size_of(type_of(RegistryReport.numAllocated)));
        assert(((cast(*void)(*instance.numKeptFromUser)) - cast(*void)(*instance)) == 8, "RegistryReport.numKeptFromUser has unexpected offset % instead of 8", ((cast(*void)(*instance.numKeptFromUser)) - cast(*void)(*instance)));
        assert(size_of(type_of(RegistryReport.numKeptFromUser)) == 8, "RegistryReport.numKeptFromUser has unexpected size % instead of 8", size_of(type_of(RegistryReport.numKeptFromUser)));
        assert(((cast(*void)(*instance.numReleasedFromUser)) - cast(*void)(*instance)) == 16, "RegistryReport.numReleasedFromUser has unexpected offset % instead of 16", ((cast(*void)(*instance.numReleasedFromUser)) - cast(*void)(*instance)));
        assert(size_of(type_of(RegistryReport.numReleasedFromUser)) == 8, "RegistryReport.numReleasedFromUser has unexpected size % instead of 8", size_of(type_of(RegistryReport.numReleasedFromUser)));
        assert(((cast(*void)(*instance.numError)) - cast(*void)(*instance)) == 24, "RegistryReport.numError has unexpected offset % instead of 24", ((cast(*void)(*instance.numError)) - cast(*void)(*instance)));
        assert(size_of(type_of(RegistryReport.numError)) == 8, "RegistryReport.numError has unexpected size % instead of 8", size_of(type_of(RegistryReport.numError)));
        assert(((cast(*void)(*instance.elementSize)) - cast(*void)(*instance)) == 32, "RegistryReport.elementSize has unexpected offset % instead of 32", ((cast(*void)(*instance.elementSize)) - cast(*void)(*instance)));
        assert(size_of(type_of(RegistryReport.elementSize)) == 8, "RegistryReport.elementSize has unexpected size % instead of 8", size_of(type_of(RegistryReport.elementSize)));
        assert(size_of(RegistryReport) == 40, "RegistryReport has size % instead of 40", size_of(RegistryReport));
    }

    {
        instance: HubReport;
        assert(((cast(*void)(*instance.adapters)) - cast(*void)(*instance)) == 0, "HubReport.adapters has unexpected offset % instead of 0", ((cast(*void)(*instance.adapters)) - cast(*void)(*instance)));
        assert(size_of(type_of(HubReport.adapters)) == 40, "HubReport.adapters has unexpected size % instead of 40", size_of(type_of(HubReport.adapters)));
        assert(((cast(*void)(*instance.devices)) - cast(*void)(*instance)) == 40, "HubReport.devices has unexpected offset % instead of 40", ((cast(*void)(*instance.devices)) - cast(*void)(*instance)));
        assert(size_of(type_of(HubReport.devices)) == 40, "HubReport.devices has unexpected size % instead of 40", size_of(type_of(HubReport.devices)));
        assert(((cast(*void)(*instance.queues)) - cast(*void)(*instance)) == 80, "HubReport.queues has unexpected offset % instead of 80", ((cast(*void)(*instance.queues)) - cast(*void)(*instance)));
        assert(size_of(type_of(HubReport.queues)) == 40, "HubReport.queues has unexpected size % instead of 40", size_of(type_of(HubReport.queues)));
        assert(((cast(*void)(*instance.pipelineLayouts)) - cast(*void)(*instance)) == 120, "HubReport.pipelineLayouts has unexpected offset % instead of 120", ((cast(*void)(*instance.pipelineLayouts)) - cast(*void)(*instance)));
        assert(size_of(type_of(HubReport.pipelineLayouts)) == 40, "HubReport.pipelineLayouts has unexpected size % instead of 40", size_of(type_of(HubReport.pipelineLayouts)));
        assert(((cast(*void)(*instance.shaderModules)) - cast(*void)(*instance)) == 160, "HubReport.shaderModules has unexpected offset % instead of 160", ((cast(*void)(*instance.shaderModules)) - cast(*void)(*instance)));
        assert(size_of(type_of(HubReport.shaderModules)) == 40, "HubReport.shaderModules has unexpected size % instead of 40", size_of(type_of(HubReport.shaderModules)));
        assert(((cast(*void)(*instance.bindGroupLayouts)) - cast(*void)(*instance)) == 200, "HubReport.bindGroupLayouts has unexpected offset % instead of 200", ((cast(*void)(*instance.bindGroupLayouts)) - cast(*void)(*instance)));
        assert(size_of(type_of(HubReport.bindGroupLayouts)) == 40, "HubReport.bindGroupLayouts has unexpected size % instead of 40", size_of(type_of(HubReport.bindGroupLayouts)));
        assert(((cast(*void)(*instance.bindGroups)) - cast(*void)(*instance)) == 240, "HubReport.bindGroups has unexpected offset % instead of 240", ((cast(*void)(*instance.bindGroups)) - cast(*void)(*instance)));
        assert(size_of(type_of(HubReport.bindGroups)) == 40, "HubReport.bindGroups has unexpected size % instead of 40", size_of(type_of(HubReport.bindGroups)));
        assert(((cast(*void)(*instance.commandBuffers)) - cast(*void)(*instance)) == 280, "HubReport.commandBuffers has unexpected offset % instead of 280", ((cast(*void)(*instance.commandBuffers)) - cast(*void)(*instance)));
        assert(size_of(type_of(HubReport.commandBuffers)) == 40, "HubReport.commandBuffers has unexpected size % instead of 40", size_of(type_of(HubReport.commandBuffers)));
        assert(((cast(*void)(*instance.renderBundles)) - cast(*void)(*instance)) == 320, "HubReport.renderBundles has unexpected offset % instead of 320", ((cast(*void)(*instance.renderBundles)) - cast(*void)(*instance)));
        assert(size_of(type_of(HubReport.renderBundles)) == 40, "HubReport.renderBundles has unexpected size % instead of 40", size_of(type_of(HubReport.renderBundles)));
        assert(((cast(*void)(*instance.renderPipelines)) - cast(*void)(*instance)) == 360, "HubReport.renderPipelines has unexpected offset % instead of 360", ((cast(*void)(*instance.renderPipelines)) - cast(*void)(*instance)));
        assert(size_of(type_of(HubReport.renderPipelines)) == 40, "HubReport.renderPipelines has unexpected size % instead of 40", size_of(type_of(HubReport.renderPipelines)));
        assert(((cast(*void)(*instance.computePipelines)) - cast(*void)(*instance)) == 400, "HubReport.computePipelines has unexpected offset % instead of 400", ((cast(*void)(*instance.computePipelines)) - cast(*void)(*instance)));
        assert(size_of(type_of(HubReport.computePipelines)) == 40, "HubReport.computePipelines has unexpected size % instead of 40", size_of(type_of(HubReport.computePipelines)));
        assert(((cast(*void)(*instance.querySets)) - cast(*void)(*instance)) == 440, "HubReport.querySets has unexpected offset % instead of 440", ((cast(*void)(*instance.querySets)) - cast(*void)(*instance)));
        assert(size_of(type_of(HubReport.querySets)) == 40, "HubReport.querySets has unexpected size % instead of 40", size_of(type_of(HubReport.querySets)));
        assert(((cast(*void)(*instance.buffers)) - cast(*void)(*instance)) == 480, "HubReport.buffers has unexpected offset % instead of 480", ((cast(*void)(*instance.buffers)) - cast(*void)(*instance)));
        assert(size_of(type_of(HubReport.buffers)) == 40, "HubReport.buffers has unexpected size % instead of 40", size_of(type_of(HubReport.buffers)));
        assert(((cast(*void)(*instance.textures)) - cast(*void)(*instance)) == 520, "HubReport.textures has unexpected offset % instead of 520", ((cast(*void)(*instance.textures)) - cast(*void)(*instance)));
        assert(size_of(type_of(HubReport.textures)) == 40, "HubReport.textures has unexpected size % instead of 40", size_of(type_of(HubReport.textures)));
        assert(((cast(*void)(*instance.textureViews)) - cast(*void)(*instance)) == 560, "HubReport.textureViews has unexpected offset % instead of 560", ((cast(*void)(*instance.textureViews)) - cast(*void)(*instance)));
        assert(size_of(type_of(HubReport.textureViews)) == 40, "HubReport.textureViews has unexpected size % instead of 40", size_of(type_of(HubReport.textureViews)));
        assert(((cast(*void)(*instance.samplers)) - cast(*void)(*instance)) == 600, "HubReport.samplers has unexpected offset % instead of 600", ((cast(*void)(*instance.samplers)) - cast(*void)(*instance)));
        assert(size_of(type_of(HubReport.samplers)) == 40, "HubReport.samplers has unexpected size % instead of 40", size_of(type_of(HubReport.samplers)));
        assert(size_of(HubReport) == 640, "HubReport has size % instead of 640", size_of(HubReport));
    }

    {
        instance: GlobalReport;
        assert(((cast(*void)(*instance.surfaces)) - cast(*void)(*instance)) == 0, "GlobalReport.surfaces has unexpected offset % instead of 0", ((cast(*void)(*instance.surfaces)) - cast(*void)(*instance)));
        assert(size_of(type_of(GlobalReport.surfaces)) == 40, "GlobalReport.surfaces has unexpected size % instead of 40", size_of(type_of(GlobalReport.surfaces)));
        assert(((cast(*void)(*instance.backendType)) - cast(*void)(*instance)) == 40, "GlobalReport.backendType has unexpected offset % instead of 40", ((cast(*void)(*instance.backendType)) - cast(*void)(*instance)));
        assert(size_of(type_of(GlobalReport.backendType)) == 4, "GlobalReport.backendType has unexpected size % instead of 4", size_of(type_of(GlobalReport.backendType)));
        assert(((cast(*void)(*instance.vulkan)) - cast(*void)(*instance)) == 48, "GlobalReport.vulkan has unexpected offset % instead of 48", ((cast(*void)(*instance.vulkan)) - cast(*void)(*instance)));
        assert(size_of(type_of(GlobalReport.vulkan)) == 640, "GlobalReport.vulkan has unexpected size % instead of 640", size_of(type_of(GlobalReport.vulkan)));
        assert(((cast(*void)(*instance.metal)) - cast(*void)(*instance)) == 688, "GlobalReport.metal has unexpected offset % instead of 688", ((cast(*void)(*instance.metal)) - cast(*void)(*instance)));
        assert(size_of(type_of(GlobalReport.metal)) == 640, "GlobalReport.metal has unexpected size % instead of 640", size_of(type_of(GlobalReport.metal)));
        assert(((cast(*void)(*instance.dx12)) - cast(*void)(*instance)) == 1328, "GlobalReport.dx12 has unexpected offset % instead of 1328", ((cast(*void)(*instance.dx12)) - cast(*void)(*instance)));
        assert(size_of(type_of(GlobalReport.dx12)) == 640, "GlobalReport.dx12 has unexpected size % instead of 640", size_of(type_of(GlobalReport.dx12)));
        assert(((cast(*void)(*instance.gl)) - cast(*void)(*instance)) == 1968, "GlobalReport.gl has unexpected offset % instead of 1968", ((cast(*void)(*instance.gl)) - cast(*void)(*instance)));
        assert(size_of(type_of(GlobalReport.gl)) == 640, "GlobalReport.gl has unexpected size % instead of 640", size_of(type_of(GlobalReport.gl)));
        assert(size_of(GlobalReport) == 2608, "GlobalReport has size % instead of 2608", size_of(GlobalReport));
    }

    {
        instance: InstanceEnumerateAdapterOptions;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "InstanceEnumerateAdapterOptions.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(InstanceEnumerateAdapterOptions.nextInChain)) == 8, "InstanceEnumerateAdapterOptions.nextInChain has unexpected size % instead of 8", size_of(type_of(InstanceEnumerateAdapterOptions.nextInChain)));
        assert(((cast(*void)(*instance.backends)) - cast(*void)(*instance)) == 8, "InstanceEnumerateAdapterOptions.backends has unexpected offset % instead of 8", ((cast(*void)(*instance.backends)) - cast(*void)(*instance)));
        assert(size_of(type_of(InstanceEnumerateAdapterOptions.backends)) == 4, "InstanceEnumerateAdapterOptions.backends has unexpected size % instead of 4", size_of(type_of(InstanceEnumerateAdapterOptions.backends)));
        assert(size_of(InstanceEnumerateAdapterOptions) == 16, "InstanceEnumerateAdapterOptions has size % instead of 16", size_of(InstanceEnumerateAdapterOptions));
    }

    {
        instance: BindGroupEntryExtras;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "BindGroupEntryExtras.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(BindGroupEntryExtras.chain)) == 16, "BindGroupEntryExtras.chain has unexpected size % instead of 16", size_of(type_of(BindGroupEntryExtras.chain)));
        assert(((cast(*void)(*instance.buffers)) - cast(*void)(*instance)) == 16, "BindGroupEntryExtras.buffers has unexpected offset % instead of 16", ((cast(*void)(*instance.buffers)) - cast(*void)(*instance)));
        assert(size_of(type_of(BindGroupEntryExtras.buffers)) == 8, "BindGroupEntryExtras.buffers has unexpected size % instead of 8", size_of(type_of(BindGroupEntryExtras.buffers)));
        assert(((cast(*void)(*instance.bufferCount)) - cast(*void)(*instance)) == 24, "BindGroupEntryExtras.bufferCount has unexpected offset % instead of 24", ((cast(*void)(*instance.bufferCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(BindGroupEntryExtras.bufferCount)) == 8, "BindGroupEntryExtras.bufferCount has unexpected size % instead of 8", size_of(type_of(BindGroupEntryExtras.bufferCount)));
        assert(((cast(*void)(*instance.samplers)) - cast(*void)(*instance)) == 32, "BindGroupEntryExtras.samplers has unexpected offset % instead of 32", ((cast(*void)(*instance.samplers)) - cast(*void)(*instance)));
        assert(size_of(type_of(BindGroupEntryExtras.samplers)) == 8, "BindGroupEntryExtras.samplers has unexpected size % instead of 8", size_of(type_of(BindGroupEntryExtras.samplers)));
        assert(((cast(*void)(*instance.samplerCount)) - cast(*void)(*instance)) == 40, "BindGroupEntryExtras.samplerCount has unexpected offset % instead of 40", ((cast(*void)(*instance.samplerCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(BindGroupEntryExtras.samplerCount)) == 8, "BindGroupEntryExtras.samplerCount has unexpected size % instead of 8", size_of(type_of(BindGroupEntryExtras.samplerCount)));
        assert(((cast(*void)(*instance.textureViews)) - cast(*void)(*instance)) == 48, "BindGroupEntryExtras.textureViews has unexpected offset % instead of 48", ((cast(*void)(*instance.textureViews)) - cast(*void)(*instance)));
        assert(size_of(type_of(BindGroupEntryExtras.textureViews)) == 8, "BindGroupEntryExtras.textureViews has unexpected size % instead of 8", size_of(type_of(BindGroupEntryExtras.textureViews)));
        assert(((cast(*void)(*instance.textureViewCount)) - cast(*void)(*instance)) == 56, "BindGroupEntryExtras.textureViewCount has unexpected offset % instead of 56", ((cast(*void)(*instance.textureViewCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(BindGroupEntryExtras.textureViewCount)) == 8, "BindGroupEntryExtras.textureViewCount has unexpected size % instead of 8", size_of(type_of(BindGroupEntryExtras.textureViewCount)));
        assert(size_of(BindGroupEntryExtras) == 64, "BindGroupEntryExtras has size % instead of 64", size_of(BindGroupEntryExtras));
    }

    {
        instance: BindGroupLayoutEntryExtras;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "BindGroupLayoutEntryExtras.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(BindGroupLayoutEntryExtras.chain)) == 16, "BindGroupLayoutEntryExtras.chain has unexpected size % instead of 16", size_of(type_of(BindGroupLayoutEntryExtras.chain)));
        assert(((cast(*void)(*instance.count)) - cast(*void)(*instance)) == 16, "BindGroupLayoutEntryExtras.count has unexpected offset % instead of 16", ((cast(*void)(*instance.count)) - cast(*void)(*instance)));
        assert(size_of(type_of(BindGroupLayoutEntryExtras.count)) == 4, "BindGroupLayoutEntryExtras.count has unexpected size % instead of 4", size_of(type_of(BindGroupLayoutEntryExtras.count)));
        assert(size_of(BindGroupLayoutEntryExtras) == 24, "BindGroupLayoutEntryExtras has size % instead of 24", size_of(BindGroupLayoutEntryExtras));
    }

    {
        instance: QuerySetDescriptorExtras;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "QuerySetDescriptorExtras.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(QuerySetDescriptorExtras.chain)) == 16, "QuerySetDescriptorExtras.chain has unexpected size % instead of 16", size_of(type_of(QuerySetDescriptorExtras.chain)));
        assert(((cast(*void)(*instance.pipelineStatistics)) - cast(*void)(*instance)) == 16, "QuerySetDescriptorExtras.pipelineStatistics has unexpected offset % instead of 16", ((cast(*void)(*instance.pipelineStatistics)) - cast(*void)(*instance)));
        assert(size_of(type_of(QuerySetDescriptorExtras.pipelineStatistics)) == 8, "QuerySetDescriptorExtras.pipelineStatistics has unexpected size % instead of 8", size_of(type_of(QuerySetDescriptorExtras.pipelineStatistics)));
        assert(((cast(*void)(*instance.pipelineStatisticCount)) - cast(*void)(*instance)) == 24, "QuerySetDescriptorExtras.pipelineStatisticCount has unexpected offset % instead of 24", ((cast(*void)(*instance.pipelineStatisticCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(QuerySetDescriptorExtras.pipelineStatisticCount)) == 8, "QuerySetDescriptorExtras.pipelineStatisticCount has unexpected size % instead of 8", size_of(type_of(QuerySetDescriptorExtras.pipelineStatisticCount)));
        assert(size_of(QuerySetDescriptorExtras) == 32, "QuerySetDescriptorExtras has size % instead of 32", size_of(QuerySetDescriptorExtras));
    }

    {
        instance: SurfaceConfigurationExtras;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "SurfaceConfigurationExtras.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceConfigurationExtras.chain)) == 16, "SurfaceConfigurationExtras.chain has unexpected size % instead of 16", size_of(type_of(SurfaceConfigurationExtras.chain)));
        assert(((cast(*void)(*instance.desiredMaximumFrameLatency)) - cast(*void)(*instance)) == 16, "SurfaceConfigurationExtras.desiredMaximumFrameLatency has unexpected offset % instead of 16", ((cast(*void)(*instance.desiredMaximumFrameLatency)) - cast(*void)(*instance)));
        assert(size_of(type_of(SurfaceConfigurationExtras.desiredMaximumFrameLatency)) == 4, "SurfaceConfigurationExtras.desiredMaximumFrameLatency has unexpected size % instead of 4", size_of(type_of(SurfaceConfigurationExtras.desiredMaximumFrameLatency)));
        assert(size_of(SurfaceConfigurationExtras) == 24, "SurfaceConfigurationExtras has size % instead of 24", size_of(SurfaceConfigurationExtras));
    }
}

