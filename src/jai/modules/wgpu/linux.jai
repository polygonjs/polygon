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

WGPUFlags :: u32;
WGPUBool :: u32;

WGPUAdapterImpl :: struct {}
WGPUAdapter :: *WGPUAdapterImpl;
WGPUBindGroupImpl :: struct {}
WGPUBindGroup :: *WGPUBindGroupImpl;
WGPUBindGroupLayoutImpl :: struct {}
WGPUBindGroupLayout :: *WGPUBindGroupLayoutImpl;
WGPUBufferImpl :: struct {}
WGPUBuffer :: *WGPUBufferImpl;
WGPUCommandBufferImpl :: struct {}
WGPUCommandBuffer :: *WGPUCommandBufferImpl;
WGPUCommandEncoderImpl :: struct {}
WGPUCommandEncoder :: *WGPUCommandEncoderImpl;
WGPUComputePassEncoderImpl :: struct {}
WGPUComputePassEncoder :: *WGPUComputePassEncoderImpl;
WGPUComputePipelineImpl :: struct {}
WGPUComputePipeline :: *WGPUComputePipelineImpl;
WGPUDeviceImpl :: struct {}
WGPUDevice :: *WGPUDeviceImpl;
WGPUInstanceImpl :: struct {}
WGPUInstance :: *WGPUInstanceImpl;
WGPUPipelineLayoutImpl :: struct {}
WGPUPipelineLayout :: *WGPUPipelineLayoutImpl;
WGPUQuerySetImpl :: struct {}
WGPUQuerySet :: *WGPUQuerySetImpl;
WGPUQueueImpl :: struct {}
WGPUQueue :: *WGPUQueueImpl;
WGPURenderBundleImpl :: struct {}
WGPURenderBundle :: *WGPURenderBundleImpl;
WGPURenderBundleEncoderImpl :: struct {}
WGPURenderBundleEncoder :: *WGPURenderBundleEncoderImpl;
WGPURenderPassEncoderImpl :: struct {}
WGPURenderPassEncoder :: *WGPURenderPassEncoderImpl;
WGPURenderPipelineImpl :: struct {}
WGPURenderPipeline :: *WGPURenderPipelineImpl;
WGPUSamplerImpl :: struct {}
WGPUSampler :: *WGPUSamplerImpl;
WGPUShaderModuleImpl :: struct {}
WGPUShaderModule :: *WGPUShaderModuleImpl;
WGPUSurfaceImpl :: struct {}
WGPUSurface :: *WGPUSurfaceImpl;
WGPUTextureImpl :: struct {}
WGPUTexture :: *WGPUTextureImpl;
WGPUTextureViewImpl :: struct {}
WGPUTextureView :: *WGPUTextureViewImpl;

WGPUAdapterType :: enum u32 {
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

WGPUAddressMode :: enum u32 {
    Repeat       :: 0;
    MirrorRepeat :: 1;
    ClampToEdge  :: 2;
    Force32      :: 2147483647;

    WGPUAddressMode_Repeat       :: Repeat;
    WGPUAddressMode_MirrorRepeat :: MirrorRepeat;
    WGPUAddressMode_ClampToEdge  :: ClampToEdge;
    WGPUAddressMode_Force32      :: Force32;
}

WGPUBackendType :: enum u32 {
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

WGPUBlendFactor :: enum u32 {
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

WGPUBlendOperation :: enum u32 {
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

WGPUBufferBindingType :: enum u32 {
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

WGPUBufferMapAsyncStatus :: enum u32 {
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

WGPUBufferMapState :: enum u32 {
    Unmapped :: 0;
    Pending  :: 1;
    Mapped   :: 2;
    Force32  :: 2147483647;

    WGPUBufferMapState_Unmapped :: Unmapped;
    WGPUBufferMapState_Pending  :: Pending;
    WGPUBufferMapState_Mapped   :: Mapped;
    WGPUBufferMapState_Force32  :: Force32;
}

WGPUCompareFunction :: enum u32 {
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

WGPUCompilationInfoRequestStatus :: enum u32 {
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

WGPUCompilationMessageType :: enum u32 {
    Error   :: 0;
    Warning :: 1;
    Info    :: 2;
    Force32 :: 2147483647;

    WGPUCompilationMessageType_Error   :: Error;
    WGPUCompilationMessageType_Warning :: Warning;
    WGPUCompilationMessageType_Info    :: Info;
    WGPUCompilationMessageType_Force32 :: Force32;
}

WGPUCompositeAlphaMode :: enum u32 {
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

WGPUCreatePipelineAsyncStatus :: enum u32 {
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

WGPUCullMode :: enum u32 {
    None    :: 0;
    Front   :: 1;
    Back    :: 2;
    Force32 :: 2147483647;

    WGPUCullMode_None    :: None;
    WGPUCullMode_Front   :: Front;
    WGPUCullMode_Back    :: Back;
    WGPUCullMode_Force32 :: Force32;
}

WGPUDeviceLostReason :: enum u32 {
    Undefined :: 0;
    Destroyed :: 1;
    Force32   :: 2147483647;

    WGPUDeviceLostReason_Undefined :: Undefined;
    WGPUDeviceLostReason_Destroyed :: Destroyed;
    WGPUDeviceLostReason_Force32   :: Force32;
}

WGPUErrorFilter :: enum u32 {
    Validation  :: 0;
    OutOfMemory :: 1;
    Internal    :: 2;
    Force32     :: 2147483647;

    WGPUErrorFilter_Validation  :: Validation;
    WGPUErrorFilter_OutOfMemory :: OutOfMemory;
    WGPUErrorFilter_Internal    :: Internal;
    WGPUErrorFilter_Force32     :: Force32;
}

WGPUErrorType :: enum u32 {
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

WGPUFeatureName :: enum u32 {
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

WGPUFilterMode :: enum u32 {
    Nearest :: 0;
    Linear  :: 1;
    Force32 :: 2147483647;

    WGPUFilterMode_Nearest :: Nearest;
    WGPUFilterMode_Linear  :: Linear;
    WGPUFilterMode_Force32 :: Force32;
}

WGPUFrontFace :: enum u32 {
    CCW     :: 0;
    CW      :: 1;
    Force32 :: 2147483647;

    WGPUFrontFace_CCW     :: CCW;
    WGPUFrontFace_CW      :: CW;
    WGPUFrontFace_Force32 :: Force32;
}

WGPUIndexFormat :: enum u32 {
    Undefined :: 0;
    Uint16    :: 1;
    Uint32    :: 2;
    Force32   :: 2147483647;

    WGPUIndexFormat_Undefined :: Undefined;
    WGPUIndexFormat_Uint16    :: Uint16;
    WGPUIndexFormat_Uint32    :: Uint32;
    WGPUIndexFormat_Force32   :: Force32;
}

WGPULoadOp :: enum u32 {
    Undefined :: 0;
    Clear     :: 1;
    Load      :: 2;
    Force32   :: 2147483647;

    WGPULoadOp_Undefined :: Undefined;
    WGPULoadOp_Clear     :: Clear;
    WGPULoadOp_Load      :: Load;
    WGPULoadOp_Force32   :: Force32;
}

WGPUMipmapFilterMode :: enum u32 {
    Nearest :: 0;
    Linear  :: 1;
    Force32 :: 2147483647;

    WGPUMipmapFilterMode_Nearest :: Nearest;
    WGPUMipmapFilterMode_Linear  :: Linear;
    WGPUMipmapFilterMode_Force32 :: Force32;
}

WGPUPowerPreference :: enum u32 {
    Undefined       :: 0;
    LowPower        :: 1;
    HighPerformance :: 2;
    Force32         :: 2147483647;

    WGPUPowerPreference_Undefined       :: Undefined;
    WGPUPowerPreference_LowPower        :: LowPower;
    WGPUPowerPreference_HighPerformance :: HighPerformance;
    WGPUPowerPreference_Force32         :: Force32;
}

WGPUPresentMode :: enum u32 {
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

WGPUPrimitiveTopology :: enum u32 {
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

WGPUQueryType :: enum u32 {
    Occlusion :: 0;
    Timestamp :: 1;
    Force32   :: 2147483647;

    WGPUQueryType_Occlusion :: Occlusion;
    WGPUQueryType_Timestamp :: Timestamp;
    WGPUQueryType_Force32   :: Force32;
}

WGPUQueueWorkDoneStatus :: enum u32 {
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

WGPURequestAdapterStatus :: enum u32 {
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

WGPURequestDeviceStatus :: enum u32 {
    Success :: 0;
    Error   :: 1;
    Unknown :: 2;
    Force32 :: 2147483647;

    WGPURequestDeviceStatus_Success :: Success;
    WGPURequestDeviceStatus_Error   :: Error;
    WGPURequestDeviceStatus_Unknown :: Unknown;
    WGPURequestDeviceStatus_Force32 :: Force32;
}

WGPUSType :: enum u32 {
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

WGPUSamplerBindingType :: enum u32 {
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

WGPUStencilOperation :: enum u32 {
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

WGPUStorageTextureAccess :: enum u32 {
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

WGPUStoreOp :: enum u32 {
    Undefined :: 0;
    Store     :: 1;
    Discard   :: 2;
    Force32   :: 2147483647;

    WGPUStoreOp_Undefined :: Undefined;
    WGPUStoreOp_Store     :: Store;
    WGPUStoreOp_Discard   :: Discard;
    WGPUStoreOp_Force32   :: Force32;
}

WGPUSurfaceGetCurrentTextureStatus :: enum u32 {
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

WGPUTextureAspect :: enum u32 {
    All         :: 0;
    StencilOnly :: 1;
    DepthOnly   :: 2;
    Force32     :: 2147483647;

    WGPUTextureAspect_All         :: All;
    WGPUTextureAspect_StencilOnly :: StencilOnly;
    WGPUTextureAspect_DepthOnly   :: DepthOnly;
    WGPUTextureAspect_Force32     :: Force32;
}

WGPUTextureDimension :: enum u32 {
    _1D     :: 0;
    _2D     :: 1;
    _3D     :: 2;
    Force32 :: 2147483647;

    WGPUTextureDimension_1D      :: _1D;
    WGPUTextureDimension_2D      :: _2D;
    WGPUTextureDimension_3D      :: _3D;
    WGPUTextureDimension_Force32 :: Force32;
}

WGPUTextureFormat :: enum u32 {
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

WGPUTextureSampleType :: enum u32 {
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

WGPUTextureViewDimension :: enum u32 {
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

WGPUVertexFormat :: enum u32 {
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

WGPUVertexStepMode :: enum u32 {
    Vertex              :: 0;
    Instance            :: 1;
    VertexBufferNotUsed :: 2;
    Force32             :: 2147483647;

    WGPUVertexStepMode_Vertex              :: Vertex;
    WGPUVertexStepMode_Instance            :: Instance;
    WGPUVertexStepMode_VertexBufferNotUsed :: VertexBufferNotUsed;
    WGPUVertexStepMode_Force32             :: Force32;
}

WGPUBufferUsage :: enum u32 {
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

WGPUBufferUsageFlags :: WGPUFlags;

WGPUColorWriteMask :: enum u32 {
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

WGPUColorWriteMaskFlags :: WGPUFlags;

WGPUMapMode :: enum u32 {
    None    :: 0;
    Read    :: 1;
    Write   :: 2;
    Force32 :: 2147483647;

    WGPUMapMode_None    :: None;
    WGPUMapMode_Read    :: Read;
    WGPUMapMode_Write   :: Write;
    WGPUMapMode_Force32 :: Force32;
}

WGPUMapModeFlags :: WGPUFlags;

WGPUShaderStage :: enum u32 {
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

WGPUShaderStageFlags :: WGPUFlags;

WGPUTextureUsage :: enum u32 {
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

WGPUTextureUsageFlags :: WGPUFlags;

WGPUBufferMapCallback :: #type (status: WGPUBufferMapAsyncStatus, userdata: *void) -> void #c_call;
WGPUCompilationInfoCallback :: #type (status: WGPUCompilationInfoRequestStatus, compilationInfo: *WGPUCompilationInfo, userdata: *void) -> void #c_call;
WGPUCreateComputePipelineAsyncCallback :: #type (status: WGPUCreatePipelineAsyncStatus, pipeline: WGPUComputePipeline, message: *u8, userdata: *void) -> void #c_call;
WGPUCreateRenderPipelineAsyncCallback :: #type (status: WGPUCreatePipelineAsyncStatus, pipeline: WGPURenderPipeline, message: *u8, userdata: *void) -> void #c_call;
WGPUDeviceLostCallback :: #type (reason: WGPUDeviceLostReason, message: *u8, userdata: *void) -> void #c_call;
WGPUErrorCallback :: #type (type: WGPUErrorType, message: *u8, userdata: *void) -> void #c_call;
WGPUProc :: #type () -> void #c_call;
WGPUQueueWorkDoneCallback :: #type (status: WGPUQueueWorkDoneStatus, userdata: *void) -> void #c_call;
WGPURequestAdapterCallback :: #type (status: WGPURequestAdapterStatus, adapter: WGPUAdapter, message: *u8, userdata: *void) -> void #c_call;
WGPURequestDeviceCallback :: #type (status: WGPURequestDeviceStatus, device: WGPUDevice, message: *u8, userdata: *void) -> void #c_call;

WGPUChainedStruct :: struct {
    next:  *WGPUChainedStruct;
    sType: WGPUSType;
}

WGPUChainedStructOut :: struct {
    next:  *WGPUChainedStructOut;
    sType: WGPUSType;
}

// Structure forward declarations
WGPUAdapterProperties :: struct {
    nextInChain:       *WGPUChainedStructOut;
    vendorID:          u32;
    vendorName:        *u8;
    architecture:      *u8;
    deviceID:          u32;
    name:              *u8;
    driverDescription: *u8;
    adapterType:       WGPUAdapterType;
    backendType:       WGPUBackendType;
}

WGPUBindGroupEntry :: struct {
    nextInChain: *WGPUChainedStruct;
    binding:     u32;
    buffer:      WGPUBuffer;
    offset:      u64;
    size:        u64;
    sampler:     WGPUSampler;
    textureView: WGPUTextureView;
}

WGPUBlendComponent :: struct {
    operation: WGPUBlendOperation;
    srcFactor: WGPUBlendFactor;
    dstFactor: WGPUBlendFactor;
}

WGPUBufferBindingLayout :: struct {
    nextInChain:      *WGPUChainedStruct;
    type:             WGPUBufferBindingType;
    hasDynamicOffset: WGPUBool;
    minBindingSize:   u64;
}

WGPUBufferDescriptor :: struct {
    nextInChain:      *WGPUChainedStruct;
    label:            *u8;
    usage:            WGPUBufferUsageFlags;
    size:             u64;
    mappedAtCreation: WGPUBool;
}

WGPUColor :: struct {
    r: float64;
    g: float64;
    b: float64;
    a: float64;
}

WGPUCommandBufferDescriptor :: struct {
    nextInChain: *WGPUChainedStruct;
    label:       *u8;
}

WGPUCommandEncoderDescriptor :: struct {
    nextInChain: *WGPUChainedStruct;
    label:       *u8;
}

WGPUCompilationMessage :: struct {
    nextInChain:  *WGPUChainedStruct;
    message:      *u8;
    type:         WGPUCompilationMessageType;
    lineNum:      u64;
    linePos:      u64;
    offset:       u64;
    length:       u64;
    utf16LinePos: u64;
    utf16Offset:  u64;
    utf16Length:  u64;
}

WGPUComputePassTimestampWrites :: struct {
    querySet:                  WGPUQuerySet;
    beginningOfPassWriteIndex: u32;
    endOfPassWriteIndex:       u32;
}

WGPUConstantEntry :: struct {
    nextInChain: *WGPUChainedStruct;
    key:         *u8;
    value:       float64;
}

WGPUExtent3D :: struct {
    width:              u32;
    height:             u32;
    depthOrArrayLayers: u32;
}

WGPUInstanceDescriptor :: struct {
    nextInChain: *WGPUChainedStruct;
}

WGPULimits :: struct {
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

WGPUMultisampleState :: struct {
    nextInChain:            *WGPUChainedStruct;
    count:                  u32;
    mask:                   u32;
    alphaToCoverageEnabled: WGPUBool;
}

WGPUOrigin3D :: struct {
    x: u32;
    y: u32;
    z: u32;
}

WGPUPipelineLayoutDescriptor :: struct {
    nextInChain:          *WGPUChainedStruct;
    label:                *u8;
    bindGroupLayoutCount: u64;
    bindGroupLayouts:     *WGPUBindGroupLayout;
}

// Can be chained in WGPUPrimitiveState
WGPUPrimitiveDepthClipControl :: struct {
    chain:          WGPUChainedStruct;
    unclippedDepth: WGPUBool;
}

WGPUPrimitiveState :: struct {
    nextInChain:      *WGPUChainedStruct;
    topology:         WGPUPrimitiveTopology;
    stripIndexFormat: WGPUIndexFormat;
    frontFace:        WGPUFrontFace;
    cullMode:         WGPUCullMode;
}

WGPUQuerySetDescriptor :: struct {
    nextInChain: *WGPUChainedStruct;
    label:       *u8;
    type:        WGPUQueryType;
    count:       u32;
}

WGPUQueueDescriptor :: struct {
    nextInChain: *WGPUChainedStruct;
    label:       *u8;
}

WGPURenderBundleDescriptor :: struct {
    nextInChain: *WGPUChainedStruct;
    label:       *u8;
}

WGPURenderBundleEncoderDescriptor :: struct {
    nextInChain:        *WGPUChainedStruct;
    label:              *u8;
    colorFormatCount:   u64;
    colorFormats:       *WGPUTextureFormat;
    depthStencilFormat: WGPUTextureFormat;
    sampleCount:        u32;
    depthReadOnly:      WGPUBool;
    stencilReadOnly:    WGPUBool;
}

WGPURenderPassDepthStencilAttachment :: struct {
    view:              WGPUTextureView;
    depthLoadOp:       WGPULoadOp;
    depthStoreOp:      WGPUStoreOp;
    depthClearValue:   float;
    depthReadOnly:     WGPUBool;
    stencilLoadOp:     WGPULoadOp;
    stencilStoreOp:    WGPUStoreOp;
    stencilClearValue: u32;
    stencilReadOnly:   WGPUBool;
}

// Can be chained in WGPURenderPassDescriptor
WGPURenderPassDescriptorMaxDrawCount :: struct {
    chain:        WGPUChainedStruct;
    maxDrawCount: u64;
}

WGPURenderPassTimestampWrites :: struct {
    querySet:                  WGPUQuerySet;
    beginningOfPassWriteIndex: u32;
    endOfPassWriteIndex:       u32;
}

WGPURequestAdapterOptions :: struct {
    nextInChain:          *WGPUChainedStruct;
    compatibleSurface:    WGPUSurface;
    powerPreference:      WGPUPowerPreference;
    backendType:          WGPUBackendType;
    forceFallbackAdapter: WGPUBool;
}

WGPUSamplerBindingLayout :: struct {
    nextInChain: *WGPUChainedStruct;
    type:        WGPUSamplerBindingType;
}

WGPUSamplerDescriptor :: struct {
    nextInChain:   *WGPUChainedStruct;
    label:         *u8;
    addressModeU:  WGPUAddressMode;
    addressModeV:  WGPUAddressMode;
    addressModeW:  WGPUAddressMode;
    magFilter:     WGPUFilterMode;
    minFilter:     WGPUFilterMode;
    mipmapFilter:  WGPUMipmapFilterMode;
    lodMinClamp:   float;
    lodMaxClamp:   float;
    compare:       WGPUCompareFunction;
    maxAnisotropy: u16;
}

WGPUShaderModuleCompilationHint :: struct {
    nextInChain: *WGPUChainedStruct;
    entryPoint:  *u8;
    layout:      WGPUPipelineLayout;
}

// Can be chained in WGPUShaderModuleDescriptor
WGPUShaderModuleSPIRVDescriptor :: struct {
    chain:    WGPUChainedStruct;
    codeSize: u32;
    code:     *u32;
}

// Can be chained in WGPUShaderModuleDescriptor
WGPUShaderModuleWGSLDescriptor :: struct {
    chain: WGPUChainedStruct;
    code:  *u8;
}

WGPUStencilFaceState :: struct {
    compare:     WGPUCompareFunction;
    failOp:      WGPUStencilOperation;
    depthFailOp: WGPUStencilOperation;
    passOp:      WGPUStencilOperation;
}

WGPUStorageTextureBindingLayout :: struct {
    nextInChain:   *WGPUChainedStruct;
    access:        WGPUStorageTextureAccess;
    format:        WGPUTextureFormat;
    viewDimension: WGPUTextureViewDimension;
}

WGPUSurfaceCapabilities :: struct {
    nextInChain:      *WGPUChainedStructOut;
    formatCount:      u64;
    formats:          *WGPUTextureFormat;
    presentModeCount: u64;
    presentModes:     *WGPUPresentMode;
    alphaModeCount:   u64;
    alphaModes:       *WGPUCompositeAlphaMode;
}

WGPUSurfaceConfiguration :: struct {
    nextInChain:     *WGPUChainedStruct;
    device:          WGPUDevice;
    format:          WGPUTextureFormat;
    usage:           WGPUTextureUsageFlags;
    viewFormatCount: u64;
    viewFormats:     *WGPUTextureFormat;
    alphaMode:       WGPUCompositeAlphaMode;
    width:           u32;
    height:          u32;
    presentMode:     WGPUPresentMode;
}

WGPUSurfaceDescriptor :: struct {
    nextInChain: *WGPUChainedStruct;
    label:       *u8;
}

// Can be chained in WGPUSurfaceDescriptor
WGPUSurfaceDescriptorFromAndroidNativeWindow :: struct {
    chain:  WGPUChainedStruct;
    window: *void;
}

// Can be chained in WGPUSurfaceDescriptor
WGPUSurfaceDescriptorFromCanvasHTMLSelector :: struct {
    chain:    WGPUChainedStruct;
    selector: *u8;
}

// Can be chained in WGPUSurfaceDescriptor
WGPUSurfaceDescriptorFromMetalLayer :: struct {
    chain: WGPUChainedStruct;
    layer: *void;
}

// Can be chained in WGPUSurfaceDescriptor
WGPUSurfaceDescriptorFromWaylandSurface :: struct {
    chain:   WGPUChainedStruct;
    display: *void;
    surface: *void;
}

// Can be chained in WGPUSurfaceDescriptor
WGPUSurfaceDescriptorFromWindowsHWND :: struct {
    chain:     WGPUChainedStruct;
    hinstance: *void;
    hwnd:      *void;
}

// Can be chained in WGPUSurfaceDescriptor
WGPUSurfaceDescriptorFromXcbWindow :: struct {
    chain:      WGPUChainedStruct;
    connection: *void;
    window:     u32;
}

// Can be chained in WGPUSurfaceDescriptor
WGPUSurfaceDescriptorFromXlibWindow :: struct {
    chain:   WGPUChainedStruct;
    display: *void;
    window:  u64;
}

WGPUSurfaceTexture :: struct {
    texture:    WGPUTexture;
    suboptimal: WGPUBool;
    status:     WGPUSurfaceGetCurrentTextureStatus;
}

WGPUTextureBindingLayout :: struct {
    nextInChain:   *WGPUChainedStruct;
    sampleType:    WGPUTextureSampleType;
    viewDimension: WGPUTextureViewDimension;
    multisampled:  WGPUBool;
}

WGPUTextureDataLayout :: struct {
    nextInChain:  *WGPUChainedStruct;
    offset:       u64;
    bytesPerRow:  u32;
    rowsPerImage: u32;
}

WGPUTextureViewDescriptor :: struct {
    nextInChain:     *WGPUChainedStruct;
    label:           *u8;
    format:          WGPUTextureFormat;
    dimension:       WGPUTextureViewDimension;
    baseMipLevel:    u32;
    mipLevelCount:   u32;
    baseArrayLayer:  u32;
    arrayLayerCount: u32;
    aspect:          WGPUTextureAspect;
}

WGPUVertexAttribute :: struct {
    format:         WGPUVertexFormat;
    offset:         u64;
    shaderLocation: u32;
}

WGPUBindGroupDescriptor :: struct {
    nextInChain: *WGPUChainedStruct;
    label:       *u8;
    layout:      WGPUBindGroupLayout;
    entryCount:  u64;
    entries:     *WGPUBindGroupEntry;
}

WGPUBindGroupLayoutEntry :: struct {
    nextInChain:    *WGPUChainedStruct;
    binding:        u32;
    visibility:     WGPUShaderStageFlags;
    buffer:         WGPUBufferBindingLayout;
    sampler:        WGPUSamplerBindingLayout;
    texture:        WGPUTextureBindingLayout;
    storageTexture: WGPUStorageTextureBindingLayout;
}

WGPUBlendState :: struct {
    color: WGPUBlendComponent;
    alpha: WGPUBlendComponent;
}

WGPUCompilationInfo :: struct {
    nextInChain:  *WGPUChainedStruct;
    messageCount: u64;
    messages:     *WGPUCompilationMessage;
}

WGPUComputePassDescriptor :: struct {
    nextInChain:     *WGPUChainedStruct;
    label:           *u8;
    timestampWrites: *WGPUComputePassTimestampWrites;
}

WGPUDepthStencilState :: struct {
    nextInChain:         *WGPUChainedStruct;
    format:              WGPUTextureFormat;
    depthWriteEnabled:   WGPUBool;
    depthCompare:        WGPUCompareFunction;
    stencilFront:        WGPUStencilFaceState;
    stencilBack:         WGPUStencilFaceState;
    stencilReadMask:     u32;
    stencilWriteMask:    u32;
    depthBias:           s32;
    depthBiasSlopeScale: float;
    depthBiasClamp:      float;
}

WGPUImageCopyBuffer :: struct {
    nextInChain: *WGPUChainedStruct;
    layout:      WGPUTextureDataLayout;
    buffer:      WGPUBuffer;
}

WGPUImageCopyTexture :: struct {
    nextInChain: *WGPUChainedStruct;
    texture:     WGPUTexture;
    mipLevel:    u32;
    origin:      WGPUOrigin3D;
    aspect:      WGPUTextureAspect;
}

WGPUProgrammableStageDescriptor :: struct {
    nextInChain:   *WGPUChainedStruct;
    module:        WGPUShaderModule;
    entryPoint:    *u8;
    constantCount: u64;
    constants:     *WGPUConstantEntry;
}

WGPURenderPassColorAttachment :: struct {
    nextInChain:   *WGPUChainedStruct;
    view:          WGPUTextureView;
    resolveTarget: WGPUTextureView;
    loadOp:        WGPULoadOp;
    storeOp:       WGPUStoreOp;
    clearValue:    WGPUColor;
}

WGPURequiredLimits :: struct {
    nextInChain: *WGPUChainedStruct;
    limits:      WGPULimits;
}

WGPUShaderModuleDescriptor :: struct {
    nextInChain: *WGPUChainedStruct;
    label:       *u8;
    hintCount:   u64;
    hints:       *WGPUShaderModuleCompilationHint;
}

WGPUSupportedLimits :: struct {
    nextInChain: *WGPUChainedStructOut;
    limits:      WGPULimits;
}

WGPUTextureDescriptor :: struct {
    nextInChain:     *WGPUChainedStruct;
    label:           *u8;
    usage:           WGPUTextureUsageFlags;
    dimension:       WGPUTextureDimension;
    size:            WGPUExtent3D;
    format:          WGPUTextureFormat;
    mipLevelCount:   u32;
    sampleCount:     u32;
    viewFormatCount: u64;
    viewFormats:     *WGPUTextureFormat;
}

WGPUVertexBufferLayout :: struct {
    arrayStride:    u64;
    stepMode:       WGPUVertexStepMode;
    attributeCount: u64;
    attributes:     *WGPUVertexAttribute;
}

WGPUBindGroupLayoutDescriptor :: struct {
    nextInChain: *WGPUChainedStruct;
    label:       *u8;
    entryCount:  u64;
    entries:     *WGPUBindGroupLayoutEntry;
}

WGPUColorTargetState :: struct {
    nextInChain: *WGPUChainedStruct;
    format:      WGPUTextureFormat;
    blend:       *WGPUBlendState;
    writeMask:   WGPUColorWriteMaskFlags;
}

WGPUComputePipelineDescriptor :: struct {
    nextInChain: *WGPUChainedStruct;
    label:       *u8;
    layout:      WGPUPipelineLayout;
    compute:     WGPUProgrammableStageDescriptor;
}

WGPUDeviceDescriptor :: struct {
    nextInChain:          *WGPUChainedStruct;
    label:                *u8;
    requiredFeatureCount: u64;
    requiredFeatures:     *WGPUFeatureName;
    requiredLimits:       *WGPURequiredLimits;
    defaultQueue:         WGPUQueueDescriptor;
    deviceLostCallback:   WGPUDeviceLostCallback;
    deviceLostUserdata:   *void;
}

WGPURenderPassDescriptor :: struct {
    nextInChain:            *WGPUChainedStruct;
    label:                  *u8;
    colorAttachmentCount:   u64;
    colorAttachments:       *WGPURenderPassColorAttachment;
    depthStencilAttachment: *WGPURenderPassDepthStencilAttachment;
    occlusionQuerySet:      WGPUQuerySet;
    timestampWrites:        *WGPURenderPassTimestampWrites;
}

WGPUVertexState :: struct {
    nextInChain:   *WGPUChainedStruct;
    module:        WGPUShaderModule;
    entryPoint:    *u8;
    constantCount: u64;
    constants:     *WGPUConstantEntry;
    bufferCount:   u64;
    buffers:       *WGPUVertexBufferLayout;
}

WGPUFragmentState :: struct {
    nextInChain:   *WGPUChainedStruct;
    module:        WGPUShaderModule;
    entryPoint:    *u8;
    constantCount: u64;
    constants:     *WGPUConstantEntry;
    targetCount:   u64;
    targets:       *WGPUColorTargetState;
}

WGPURenderPipelineDescriptor :: struct {
    nextInChain:  *WGPUChainedStruct;
    label:        *u8;
    layout:       WGPUPipelineLayout;
    vertex:       WGPUVertexState;
    primitive:    WGPUPrimitiveState;
    depthStencil: *WGPUDepthStencilState;
    multisample:  WGPUMultisampleState;
    fragment:     *WGPUFragmentState;
}

WGPUProcCreateInstance :: #type (descriptor: *WGPUInstanceDescriptor) -> WGPUInstance #c_call;
WGPUProcGetProcAddress :: #type (device: WGPUDevice, procName: *u8) -> WGPUProc #c_call;

// Procs of Adapter
WGPUProcAdapterEnumerateFeatures :: #type (adapter: WGPUAdapter, features: *WGPUFeatureName) -> u64 #c_call;
WGPUProcAdapterGetLimits :: #type (adapter: WGPUAdapter, limits: *WGPUSupportedLimits) -> WGPUBool #c_call;
WGPUProcAdapterGetProperties :: #type (adapter: WGPUAdapter, properties: *WGPUAdapterProperties) -> void #c_call;
WGPUProcAdapterHasFeature :: #type (adapter: WGPUAdapter, feature: WGPUFeatureName) -> WGPUBool #c_call;
WGPUProcAdapterRequestDevice :: #type (adapter: WGPUAdapter, descriptor: *WGPUDeviceDescriptor, callback: WGPURequestDeviceCallback, userdata: *void) -> void #c_call;
WGPUProcAdapterReference :: #type (adapter: WGPUAdapter) -> void #c_call;
WGPUProcAdapterRelease :: #type (adapter: WGPUAdapter) -> void #c_call;

// Procs of BindGroup
WGPUProcBindGroupSetLabel :: #type (bindGroup: WGPUBindGroup, label: *u8) -> void #c_call;
WGPUProcBindGroupReference :: #type (bindGroup: WGPUBindGroup) -> void #c_call;
WGPUProcBindGroupRelease :: #type (bindGroup: WGPUBindGroup) -> void #c_call;

// Procs of BindGroupLayout
WGPUProcBindGroupLayoutSetLabel :: #type (bindGroupLayout: WGPUBindGroupLayout, label: *u8) -> void #c_call;
WGPUProcBindGroupLayoutReference :: #type (bindGroupLayout: WGPUBindGroupLayout) -> void #c_call;
WGPUProcBindGroupLayoutRelease :: #type (bindGroupLayout: WGPUBindGroupLayout) -> void #c_call;

// Procs of Buffer
WGPUProcBufferDestroy :: #type (buffer: WGPUBuffer) -> void #c_call;
WGPUProcBufferGetConstMappedRange :: #type (buffer: WGPUBuffer, offset: u64, size: u64) -> *void #c_call;
WGPUProcBufferGetMapState :: #type (buffer: WGPUBuffer) -> WGPUBufferMapState #c_call;
WGPUProcBufferGetMappedRange :: #type (buffer: WGPUBuffer, offset: u64, size: u64) -> *void #c_call;
WGPUProcBufferGetSize :: #type (buffer: WGPUBuffer) -> u64 #c_call;
WGPUProcBufferGetUsage :: #type (buffer: WGPUBuffer) -> WGPUBufferUsageFlags #c_call;
WGPUProcBufferMapAsync :: #type (buffer: WGPUBuffer, mode: WGPUMapModeFlags, offset: u64, size: u64, callback: WGPUBufferMapCallback, userdata: *void) -> void #c_call;
WGPUProcBufferSetLabel :: #type (buffer: WGPUBuffer, label: *u8) -> void #c_call;
WGPUProcBufferUnmap :: #type (buffer: WGPUBuffer) -> void #c_call;
WGPUProcBufferReference :: #type (buffer: WGPUBuffer) -> void #c_call;
WGPUProcBufferRelease :: #type (buffer: WGPUBuffer) -> void #c_call;

// Procs of CommandBuffer
WGPUProcCommandBufferSetLabel :: #type (commandBuffer: WGPUCommandBuffer, label: *u8) -> void #c_call;
WGPUProcCommandBufferReference :: #type (commandBuffer: WGPUCommandBuffer) -> void #c_call;
WGPUProcCommandBufferRelease :: #type (commandBuffer: WGPUCommandBuffer) -> void #c_call;

// Procs of CommandEncoder
WGPUProcCommandEncoderBeginComputePass :: #type (commandEncoder: WGPUCommandEncoder, descriptor: *WGPUComputePassDescriptor) -> WGPUComputePassEncoder #c_call;
WGPUProcCommandEncoderBeginRenderPass :: #type (commandEncoder: WGPUCommandEncoder, descriptor: *WGPURenderPassDescriptor) -> WGPURenderPassEncoder #c_call;
WGPUProcCommandEncoderClearBuffer :: #type (commandEncoder: WGPUCommandEncoder, buffer: WGPUBuffer, offset: u64, size: u64) -> void #c_call;
WGPUProcCommandEncoderCopyBufferToBuffer :: #type (commandEncoder: WGPUCommandEncoder, source: WGPUBuffer, sourceOffset: u64, destination: WGPUBuffer, destinationOffset: u64, size: u64) -> void #c_call;
WGPUProcCommandEncoderCopyBufferToTexture :: #type (commandEncoder: WGPUCommandEncoder, source: *WGPUImageCopyBuffer, destination: *WGPUImageCopyTexture, copySize: *WGPUExtent3D) -> void #c_call;
WGPUProcCommandEncoderCopyTextureToBuffer :: #type (commandEncoder: WGPUCommandEncoder, source: *WGPUImageCopyTexture, destination: *WGPUImageCopyBuffer, copySize: *WGPUExtent3D) -> void #c_call;
WGPUProcCommandEncoderCopyTextureToTexture :: #type (commandEncoder: WGPUCommandEncoder, source: *WGPUImageCopyTexture, destination: *WGPUImageCopyTexture, copySize: *WGPUExtent3D) -> void #c_call;
WGPUProcCommandEncoderFinish :: #type (commandEncoder: WGPUCommandEncoder, descriptor: *WGPUCommandBufferDescriptor) -> WGPUCommandBuffer #c_call;
WGPUProcCommandEncoderInsertDebugMarker :: #type (commandEncoder: WGPUCommandEncoder, markerLabel: *u8) -> void #c_call;
WGPUProcCommandEncoderPopDebugGroup :: #type (commandEncoder: WGPUCommandEncoder) -> void #c_call;
WGPUProcCommandEncoderPushDebugGroup :: #type (commandEncoder: WGPUCommandEncoder, groupLabel: *u8) -> void #c_call;
WGPUProcCommandEncoderResolveQuerySet :: #type (commandEncoder: WGPUCommandEncoder, querySet: WGPUQuerySet, firstQuery: u32, queryCount: u32, destination: WGPUBuffer, destinationOffset: u64) -> void #c_call;
WGPUProcCommandEncoderSetLabel :: #type (commandEncoder: WGPUCommandEncoder, label: *u8) -> void #c_call;
WGPUProcCommandEncoderWriteTimestamp :: #type (commandEncoder: WGPUCommandEncoder, querySet: WGPUQuerySet, queryIndex: u32) -> void #c_call;
WGPUProcCommandEncoderReference :: #type (commandEncoder: WGPUCommandEncoder) -> void #c_call;
WGPUProcCommandEncoderRelease :: #type (commandEncoder: WGPUCommandEncoder) -> void #c_call;

// Procs of ComputePassEncoder
WGPUProcComputePassEncoderDispatchWorkgroups :: #type (computePassEncoder: WGPUComputePassEncoder, workgroupCountX: u32, workgroupCountY: u32, workgroupCountZ: u32) -> void #c_call;
WGPUProcComputePassEncoderDispatchWorkgroupsIndirect :: #type (computePassEncoder: WGPUComputePassEncoder, indirectBuffer: WGPUBuffer, indirectOffset: u64) -> void #c_call;
WGPUProcComputePassEncoderEnd :: #type (computePassEncoder: WGPUComputePassEncoder) -> void #c_call;
WGPUProcComputePassEncoderInsertDebugMarker :: #type (computePassEncoder: WGPUComputePassEncoder, markerLabel: *u8) -> void #c_call;
WGPUProcComputePassEncoderPopDebugGroup :: #type (computePassEncoder: WGPUComputePassEncoder) -> void #c_call;
WGPUProcComputePassEncoderPushDebugGroup :: #type (computePassEncoder: WGPUComputePassEncoder, groupLabel: *u8) -> void #c_call;
WGPUProcComputePassEncoderSetBindGroup :: #type (computePassEncoder: WGPUComputePassEncoder, groupIndex: u32, group: WGPUBindGroup, dynamicOffsetCount: u64, dynamicOffsets: *u32) -> void #c_call;
WGPUProcComputePassEncoderSetLabel :: #type (computePassEncoder: WGPUComputePassEncoder, label: *u8) -> void #c_call;
WGPUProcComputePassEncoderSetPipeline :: #type (computePassEncoder: WGPUComputePassEncoder, pipeline: WGPUComputePipeline) -> void #c_call;
WGPUProcComputePassEncoderReference :: #type (computePassEncoder: WGPUComputePassEncoder) -> void #c_call;
WGPUProcComputePassEncoderRelease :: #type (computePassEncoder: WGPUComputePassEncoder) -> void #c_call;

// Procs of ComputePipeline
WGPUProcComputePipelineGetBindGroupLayout :: #type (computePipeline: WGPUComputePipeline, groupIndex: u32) -> WGPUBindGroupLayout #c_call;
WGPUProcComputePipelineSetLabel :: #type (computePipeline: WGPUComputePipeline, label: *u8) -> void #c_call;
WGPUProcComputePipelineReference :: #type (computePipeline: WGPUComputePipeline) -> void #c_call;
WGPUProcComputePipelineRelease :: #type (computePipeline: WGPUComputePipeline) -> void #c_call;

// Procs of Device
WGPUProcDeviceCreateBindGroup :: #type (device: WGPUDevice, descriptor: *WGPUBindGroupDescriptor) -> WGPUBindGroup #c_call;
WGPUProcDeviceCreateBindGroupLayout :: #type (device: WGPUDevice, descriptor: *WGPUBindGroupLayoutDescriptor) -> WGPUBindGroupLayout #c_call;
WGPUProcDeviceCreateBuffer :: #type (device: WGPUDevice, descriptor: *WGPUBufferDescriptor) -> WGPUBuffer #c_call;
WGPUProcDeviceCreateCommandEncoder :: #type (device: WGPUDevice, descriptor: *WGPUCommandEncoderDescriptor) -> WGPUCommandEncoder #c_call;
WGPUProcDeviceCreateComputePipeline :: #type (device: WGPUDevice, descriptor: *WGPUComputePipelineDescriptor) -> WGPUComputePipeline #c_call;
WGPUProcDeviceCreateComputePipelineAsync :: #type (device: WGPUDevice, descriptor: *WGPUComputePipelineDescriptor, callback: WGPUCreateComputePipelineAsyncCallback, userdata: *void) -> void #c_call;
WGPUProcDeviceCreatePipelineLayout :: #type (device: WGPUDevice, descriptor: *WGPUPipelineLayoutDescriptor) -> WGPUPipelineLayout #c_call;
WGPUProcDeviceCreateQuerySet :: #type (device: WGPUDevice, descriptor: *WGPUQuerySetDescriptor) -> WGPUQuerySet #c_call;
WGPUProcDeviceCreateRenderBundleEncoder :: #type (device: WGPUDevice, descriptor: *WGPURenderBundleEncoderDescriptor) -> WGPURenderBundleEncoder #c_call;
WGPUProcDeviceCreateRenderPipeline :: #type (device: WGPUDevice, descriptor: *WGPURenderPipelineDescriptor) -> WGPURenderPipeline #c_call;
WGPUProcDeviceCreateRenderPipelineAsync :: #type (device: WGPUDevice, descriptor: *WGPURenderPipelineDescriptor, callback: WGPUCreateRenderPipelineAsyncCallback, userdata: *void) -> void #c_call;
WGPUProcDeviceCreateSampler :: #type (device: WGPUDevice, descriptor: *WGPUSamplerDescriptor) -> WGPUSampler #c_call;
WGPUProcDeviceCreateShaderModule :: #type (device: WGPUDevice, descriptor: *WGPUShaderModuleDescriptor) -> WGPUShaderModule #c_call;
WGPUProcDeviceCreateTexture :: #type (device: WGPUDevice, descriptor: *WGPUTextureDescriptor) -> WGPUTexture #c_call;
WGPUProcDeviceDestroy :: #type (device: WGPUDevice) -> void #c_call;
WGPUProcDeviceEnumerateFeatures :: #type (device: WGPUDevice, features: *WGPUFeatureName) -> u64 #c_call;
WGPUProcDeviceGetLimits :: #type (device: WGPUDevice, limits: *WGPUSupportedLimits) -> WGPUBool #c_call;
WGPUProcDeviceGetQueue :: #type (device: WGPUDevice) -> WGPUQueue #c_call;
WGPUProcDeviceHasFeature :: #type (device: WGPUDevice, feature: WGPUFeatureName) -> WGPUBool #c_call;
WGPUProcDevicePopErrorScope :: #type (device: WGPUDevice, callback: WGPUErrorCallback, userdata: *void) -> void #c_call;
WGPUProcDevicePushErrorScope :: #type (device: WGPUDevice, filter: WGPUErrorFilter) -> void #c_call;
WGPUProcDeviceSetLabel :: #type (device: WGPUDevice, label: *u8) -> void #c_call;
WGPUProcDeviceSetUncapturedErrorCallback :: #type (device: WGPUDevice, callback: WGPUErrorCallback, userdata: *void) -> void #c_call;
WGPUProcDeviceReference :: #type (device: WGPUDevice) -> void #c_call;
WGPUProcDeviceRelease :: #type (device: WGPUDevice) -> void #c_call;

// Procs of Instance
WGPUProcInstanceCreateSurface :: #type (instance: WGPUInstance, descriptor: *WGPUSurfaceDescriptor) -> WGPUSurface #c_call;
WGPUProcInstanceProcessEvents :: #type (instance: WGPUInstance) -> void #c_call;
WGPUProcInstanceRequestAdapter :: #type (instance: WGPUInstance, options: *WGPURequestAdapterOptions, callback: WGPURequestAdapterCallback, userdata: *void) -> void #c_call;
WGPUProcInstanceReference :: #type (instance: WGPUInstance) -> void #c_call;
WGPUProcInstanceRelease :: #type (instance: WGPUInstance) -> void #c_call;

// Procs of PipelineLayout
WGPUProcPipelineLayoutSetLabel :: #type (pipelineLayout: WGPUPipelineLayout, label: *u8) -> void #c_call;
WGPUProcPipelineLayoutReference :: #type (pipelineLayout: WGPUPipelineLayout) -> void #c_call;
WGPUProcPipelineLayoutRelease :: #type (pipelineLayout: WGPUPipelineLayout) -> void #c_call;

// Procs of QuerySet
WGPUProcQuerySetDestroy :: #type (querySet: WGPUQuerySet) -> void #c_call;
WGPUProcQuerySetGetCount :: #type (querySet: WGPUQuerySet) -> u32 #c_call;
WGPUProcQuerySetGetType :: #type (querySet: WGPUQuerySet) -> WGPUQueryType #c_call;
WGPUProcQuerySetSetLabel :: #type (querySet: WGPUQuerySet, label: *u8) -> void #c_call;
WGPUProcQuerySetReference :: #type (querySet: WGPUQuerySet) -> void #c_call;
WGPUProcQuerySetRelease :: #type (querySet: WGPUQuerySet) -> void #c_call;

// Procs of Queue
WGPUProcQueueOnSubmittedWorkDone :: #type (queue: WGPUQueue, callback: WGPUQueueWorkDoneCallback, userdata: *void) -> void #c_call;
WGPUProcQueueSetLabel :: #type (queue: WGPUQueue, label: *u8) -> void #c_call;
WGPUProcQueueSubmit :: #type (queue: WGPUQueue, commandCount: u64, commands: *WGPUCommandBuffer) -> void #c_call;
WGPUProcQueueWriteBuffer :: #type (queue: WGPUQueue, buffer: WGPUBuffer, bufferOffset: u64, data: *void, size: u64) -> void #c_call;
WGPUProcQueueWriteTexture :: #type (queue: WGPUQueue, destination: *WGPUImageCopyTexture, data: *void, dataSize: u64, dataLayout: *WGPUTextureDataLayout, writeSize: *WGPUExtent3D) -> void #c_call;
WGPUProcQueueReference :: #type (queue: WGPUQueue) -> void #c_call;
WGPUProcQueueRelease :: #type (queue: WGPUQueue) -> void #c_call;

// Procs of RenderBundle
WGPUProcRenderBundleSetLabel :: #type (renderBundle: WGPURenderBundle, label: *u8) -> void #c_call;
WGPUProcRenderBundleReference :: #type (renderBundle: WGPURenderBundle) -> void #c_call;
WGPUProcRenderBundleRelease :: #type (renderBundle: WGPURenderBundle) -> void #c_call;

// Procs of RenderBundleEncoder
WGPUProcRenderBundleEncoderDraw :: #type (renderBundleEncoder: WGPURenderBundleEncoder, vertexCount: u32, instanceCount: u32, firstVertex: u32, firstInstance: u32) -> void #c_call;
WGPUProcRenderBundleEncoderDrawIndexed :: #type (renderBundleEncoder: WGPURenderBundleEncoder, indexCount: u32, instanceCount: u32, firstIndex: u32, baseVertex: s32, firstInstance: u32) -> void #c_call;
WGPUProcRenderBundleEncoderDrawIndexedIndirect :: #type (renderBundleEncoder: WGPURenderBundleEncoder, indirectBuffer: WGPUBuffer, indirectOffset: u64) -> void #c_call;
WGPUProcRenderBundleEncoderDrawIndirect :: #type (renderBundleEncoder: WGPURenderBundleEncoder, indirectBuffer: WGPUBuffer, indirectOffset: u64) -> void #c_call;
WGPUProcRenderBundleEncoderFinish :: #type (renderBundleEncoder: WGPURenderBundleEncoder, descriptor: *WGPURenderBundleDescriptor) -> WGPURenderBundle #c_call;
WGPUProcRenderBundleEncoderInsertDebugMarker :: #type (renderBundleEncoder: WGPURenderBundleEncoder, markerLabel: *u8) -> void #c_call;
WGPUProcRenderBundleEncoderPopDebugGroup :: #type (renderBundleEncoder: WGPURenderBundleEncoder) -> void #c_call;
WGPUProcRenderBundleEncoderPushDebugGroup :: #type (renderBundleEncoder: WGPURenderBundleEncoder, groupLabel: *u8) -> void #c_call;
WGPUProcRenderBundleEncoderSetBindGroup :: #type (renderBundleEncoder: WGPURenderBundleEncoder, groupIndex: u32, group: WGPUBindGroup, dynamicOffsetCount: u64, dynamicOffsets: *u32) -> void #c_call;
WGPUProcRenderBundleEncoderSetIndexBuffer :: #type (renderBundleEncoder: WGPURenderBundleEncoder, buffer: WGPUBuffer, format: WGPUIndexFormat, offset: u64, size: u64) -> void #c_call;
WGPUProcRenderBundleEncoderSetLabel :: #type (renderBundleEncoder: WGPURenderBundleEncoder, label: *u8) -> void #c_call;
WGPUProcRenderBundleEncoderSetPipeline :: #type (renderBundleEncoder: WGPURenderBundleEncoder, pipeline: WGPURenderPipeline) -> void #c_call;
WGPUProcRenderBundleEncoderSetVertexBuffer :: #type (renderBundleEncoder: WGPURenderBundleEncoder, slot: u32, buffer: WGPUBuffer, offset: u64, size: u64) -> void #c_call;
WGPUProcRenderBundleEncoderReference :: #type (renderBundleEncoder: WGPURenderBundleEncoder) -> void #c_call;
WGPUProcRenderBundleEncoderRelease :: #type (renderBundleEncoder: WGPURenderBundleEncoder) -> void #c_call;

// Procs of RenderPassEncoder
WGPUProcRenderPassEncoderBeginOcclusionQuery :: #type (renderPassEncoder: WGPURenderPassEncoder, queryIndex: u32) -> void #c_call;
WGPUProcRenderPassEncoderDraw :: #type (renderPassEncoder: WGPURenderPassEncoder, vertexCount: u32, instanceCount: u32, firstVertex: u32, firstInstance: u32) -> void #c_call;
WGPUProcRenderPassEncoderDrawIndexed :: #type (renderPassEncoder: WGPURenderPassEncoder, indexCount: u32, instanceCount: u32, firstIndex: u32, baseVertex: s32, firstInstance: u32) -> void #c_call;
WGPUProcRenderPassEncoderDrawIndexedIndirect :: #type (renderPassEncoder: WGPURenderPassEncoder, indirectBuffer: WGPUBuffer, indirectOffset: u64) -> void #c_call;
WGPUProcRenderPassEncoderDrawIndirect :: #type (renderPassEncoder: WGPURenderPassEncoder, indirectBuffer: WGPUBuffer, indirectOffset: u64) -> void #c_call;
WGPUProcRenderPassEncoderEnd :: #type (renderPassEncoder: WGPURenderPassEncoder) -> void #c_call;
WGPUProcRenderPassEncoderEndOcclusionQuery :: #type (renderPassEncoder: WGPURenderPassEncoder) -> void #c_call;
WGPUProcRenderPassEncoderExecuteBundles :: #type (renderPassEncoder: WGPURenderPassEncoder, bundleCount: u64, bundles: *WGPURenderBundle) -> void #c_call;
WGPUProcRenderPassEncoderInsertDebugMarker :: #type (renderPassEncoder: WGPURenderPassEncoder, markerLabel: *u8) -> void #c_call;
WGPUProcRenderPassEncoderPopDebugGroup :: #type (renderPassEncoder: WGPURenderPassEncoder) -> void #c_call;
WGPUProcRenderPassEncoderPushDebugGroup :: #type (renderPassEncoder: WGPURenderPassEncoder, groupLabel: *u8) -> void #c_call;
WGPUProcRenderPassEncoderSetBindGroup :: #type (renderPassEncoder: WGPURenderPassEncoder, groupIndex: u32, group: WGPUBindGroup, dynamicOffsetCount: u64, dynamicOffsets: *u32) -> void #c_call;
WGPUProcRenderPassEncoderSetBlendConstant :: #type (renderPassEncoder: WGPURenderPassEncoder, color: *WGPUColor) -> void #c_call;
WGPUProcRenderPassEncoderSetIndexBuffer :: #type (renderPassEncoder: WGPURenderPassEncoder, buffer: WGPUBuffer, format: WGPUIndexFormat, offset: u64, size: u64) -> void #c_call;
WGPUProcRenderPassEncoderSetLabel :: #type (renderPassEncoder: WGPURenderPassEncoder, label: *u8) -> void #c_call;
WGPUProcRenderPassEncoderSetPipeline :: #type (renderPassEncoder: WGPURenderPassEncoder, pipeline: WGPURenderPipeline) -> void #c_call;
WGPUProcRenderPassEncoderSetScissorRect :: #type (renderPassEncoder: WGPURenderPassEncoder, x: u32, y: u32, width: u32, height: u32) -> void #c_call;
WGPUProcRenderPassEncoderSetStencilReference :: #type (renderPassEncoder: WGPURenderPassEncoder, reference: u32) -> void #c_call;
WGPUProcRenderPassEncoderSetVertexBuffer :: #type (renderPassEncoder: WGPURenderPassEncoder, slot: u32, buffer: WGPUBuffer, offset: u64, size: u64) -> void #c_call;
WGPUProcRenderPassEncoderSetViewport :: #type (renderPassEncoder: WGPURenderPassEncoder, x: float, y: float, width: float, height: float, minDepth: float, maxDepth: float) -> void #c_call;
WGPUProcRenderPassEncoderReference :: #type (renderPassEncoder: WGPURenderPassEncoder) -> void #c_call;
WGPUProcRenderPassEncoderRelease :: #type (renderPassEncoder: WGPURenderPassEncoder) -> void #c_call;

// Procs of RenderPipeline
WGPUProcRenderPipelineGetBindGroupLayout :: #type (renderPipeline: WGPURenderPipeline, groupIndex: u32) -> WGPUBindGroupLayout #c_call;
WGPUProcRenderPipelineSetLabel :: #type (renderPipeline: WGPURenderPipeline, label: *u8) -> void #c_call;
WGPUProcRenderPipelineReference :: #type (renderPipeline: WGPURenderPipeline) -> void #c_call;
WGPUProcRenderPipelineRelease :: #type (renderPipeline: WGPURenderPipeline) -> void #c_call;

// Procs of Sampler
WGPUProcSamplerSetLabel :: #type (sampler: WGPUSampler, label: *u8) -> void #c_call;
WGPUProcSamplerReference :: #type (sampler: WGPUSampler) -> void #c_call;
WGPUProcSamplerRelease :: #type (sampler: WGPUSampler) -> void #c_call;

// Procs of ShaderModule
WGPUProcShaderModuleGetCompilationInfo :: #type (shaderModule: WGPUShaderModule, callback: WGPUCompilationInfoCallback, userdata: *void) -> void #c_call;
WGPUProcShaderModuleSetLabel :: #type (shaderModule: WGPUShaderModule, label: *u8) -> void #c_call;
WGPUProcShaderModuleReference :: #type (shaderModule: WGPUShaderModule) -> void #c_call;
WGPUProcShaderModuleRelease :: #type (shaderModule: WGPUShaderModule) -> void #c_call;

// Procs of Surface
WGPUProcSurfaceConfigure :: #type (surface: WGPUSurface, config: *WGPUSurfaceConfiguration) -> void #c_call;
WGPUProcSurfaceGetCapabilities :: #type (surface: WGPUSurface, adapter: WGPUAdapter, capabilities: *WGPUSurfaceCapabilities) -> void #c_call;
WGPUProcSurfaceGetCurrentTexture :: #type (surface: WGPUSurface, surfaceTexture: *WGPUSurfaceTexture) -> void #c_call;
WGPUProcSurfaceGetPreferredFormat :: #type (surface: WGPUSurface, adapter: WGPUAdapter) -> WGPUTextureFormat #c_call;
WGPUProcSurfacePresent :: #type (surface: WGPUSurface) -> void #c_call;
WGPUProcSurfaceUnconfigure :: #type (surface: WGPUSurface) -> void #c_call;
WGPUProcSurfaceReference :: #type (surface: WGPUSurface) -> void #c_call;
WGPUProcSurfaceRelease :: #type (surface: WGPUSurface) -> void #c_call;

// Procs of SurfaceCapabilities
WGPUProcSurfaceCapabilitiesFreeMembers :: #type (capabilities: WGPUSurfaceCapabilities) -> void #c_call;

// Procs of Texture
WGPUProcTextureCreateView :: #type (texture: WGPUTexture, descriptor: *WGPUTextureViewDescriptor) -> WGPUTextureView #c_call;
WGPUProcTextureDestroy :: #type (texture: WGPUTexture) -> void #c_call;
WGPUProcTextureGetDepthOrArrayLayers :: #type (texture: WGPUTexture) -> u32 #c_call;
WGPUProcTextureGetDimension :: #type (texture: WGPUTexture) -> WGPUTextureDimension #c_call;
WGPUProcTextureGetFormat :: #type (texture: WGPUTexture) -> WGPUTextureFormat #c_call;
WGPUProcTextureGetHeight :: #type (texture: WGPUTexture) -> u32 #c_call;
WGPUProcTextureGetMipLevelCount :: #type (texture: WGPUTexture) -> u32 #c_call;
WGPUProcTextureGetSampleCount :: #type (texture: WGPUTexture) -> u32 #c_call;
WGPUProcTextureGetUsage :: #type (texture: WGPUTexture) -> WGPUTextureUsageFlags #c_call;
WGPUProcTextureGetWidth :: #type (texture: WGPUTexture) -> u32 #c_call;
WGPUProcTextureSetLabel :: #type (texture: WGPUTexture, label: *u8) -> void #c_call;
WGPUProcTextureReference :: #type (texture: WGPUTexture) -> void #c_call;
WGPUProcTextureRelease :: #type (texture: WGPUTexture) -> void #c_call;

// Procs of TextureView
WGPUProcTextureViewSetLabel :: #type (textureView: WGPUTextureView, label: *u8) -> void #c_call;
WGPUProcTextureViewReference :: #type (textureView: WGPUTextureView) -> void #c_call;
WGPUProcTextureViewRelease :: #type (textureView: WGPUTextureView) -> void #c_call;

wgpuCreateInstance :: (descriptor: *WGPUInstanceDescriptor) -> WGPUInstance #foreign libwgpu_native;
wgpuGetProcAddress :: (device: WGPUDevice, procName: *u8) -> WGPUProc #foreign libwgpu_native;

// Methods of Adapter
wgpuAdapterEnumerateFeatures :: (adapter: WGPUAdapter, features: *WGPUFeatureName) -> u64 #foreign libwgpu_native;
wgpuAdapterGetLimits :: (adapter: WGPUAdapter, limits: *WGPUSupportedLimits) -> WGPUBool #foreign libwgpu_native;
wgpuAdapterGetProperties :: (adapter: WGPUAdapter, properties: *WGPUAdapterProperties) -> void #foreign libwgpu_native;
wgpuAdapterHasFeature :: (adapter: WGPUAdapter, feature: WGPUFeatureName) -> WGPUBool #foreign libwgpu_native;
wgpuAdapterRequestDevice :: (adapter: WGPUAdapter, descriptor: *WGPUDeviceDescriptor, callback: WGPURequestDeviceCallback, userdata: *void) -> void #foreign libwgpu_native;
wgpuAdapterReference :: (adapter: WGPUAdapter) -> void #foreign libwgpu_native;
wgpuAdapterRelease :: (adapter: WGPUAdapter) -> void #foreign libwgpu_native;

// Methods of BindGroup
wgpuBindGroupSetLabel :: (bindGroup: WGPUBindGroup, label: *u8) -> void #foreign libwgpu_native;
wgpuBindGroupReference :: (bindGroup: WGPUBindGroup) -> void #foreign libwgpu_native;
wgpuBindGroupRelease :: (bindGroup: WGPUBindGroup) -> void #foreign libwgpu_native;

// Methods of BindGroupLayout
wgpuBindGroupLayoutSetLabel :: (bindGroupLayout: WGPUBindGroupLayout, label: *u8) -> void #foreign libwgpu_native;
wgpuBindGroupLayoutReference :: (bindGroupLayout: WGPUBindGroupLayout) -> void #foreign libwgpu_native;
wgpuBindGroupLayoutRelease :: (bindGroupLayout: WGPUBindGroupLayout) -> void #foreign libwgpu_native;

// Methods of Buffer
wgpuBufferDestroy :: (buffer: WGPUBuffer) -> void #foreign libwgpu_native;
wgpuBufferGetConstMappedRange :: (buffer: WGPUBuffer, offset: u64, size: u64) -> *void #foreign libwgpu_native;
wgpuBufferGetMapState :: (buffer: WGPUBuffer) -> WGPUBufferMapState #foreign libwgpu_native;
wgpuBufferGetMappedRange :: (buffer: WGPUBuffer, offset: u64, size: u64) -> *void #foreign libwgpu_native;
wgpuBufferGetSize :: (buffer: WGPUBuffer) -> u64 #foreign libwgpu_native;
wgpuBufferGetUsage :: (buffer: WGPUBuffer) -> WGPUBufferUsageFlags #foreign libwgpu_native;
wgpuBufferMapAsync :: (buffer: WGPUBuffer, mode: WGPUMapModeFlags, offset: u64, size: u64, callback: WGPUBufferMapCallback, userdata: *void) -> void #foreign libwgpu_native;
wgpuBufferSetLabel :: (buffer: WGPUBuffer, label: *u8) -> void #foreign libwgpu_native;
wgpuBufferUnmap :: (buffer: WGPUBuffer) -> void #foreign libwgpu_native;
wgpuBufferReference :: (buffer: WGPUBuffer) -> void #foreign libwgpu_native;
wgpuBufferRelease :: (buffer: WGPUBuffer) -> void #foreign libwgpu_native;

// Methods of CommandBuffer
wgpuCommandBufferSetLabel :: (commandBuffer: WGPUCommandBuffer, label: *u8) -> void #foreign libwgpu_native;
wgpuCommandBufferReference :: (commandBuffer: WGPUCommandBuffer) -> void #foreign libwgpu_native;
wgpuCommandBufferRelease :: (commandBuffer: WGPUCommandBuffer) -> void #foreign libwgpu_native;

// Methods of CommandEncoder
wgpuCommandEncoderBeginComputePass :: (commandEncoder: WGPUCommandEncoder, descriptor: *WGPUComputePassDescriptor) -> WGPUComputePassEncoder #foreign libwgpu_native;
wgpuCommandEncoderBeginRenderPass :: (commandEncoder: WGPUCommandEncoder, descriptor: *WGPURenderPassDescriptor) -> WGPURenderPassEncoder #foreign libwgpu_native;
wgpuCommandEncoderClearBuffer :: (commandEncoder: WGPUCommandEncoder, buffer: WGPUBuffer, offset: u64, size: u64) -> void #foreign libwgpu_native;
wgpuCommandEncoderCopyBufferToBuffer :: (commandEncoder: WGPUCommandEncoder, source: WGPUBuffer, sourceOffset: u64, destination: WGPUBuffer, destinationOffset: u64, size: u64) -> void #foreign libwgpu_native;
wgpuCommandEncoderCopyBufferToTexture :: (commandEncoder: WGPUCommandEncoder, source: *WGPUImageCopyBuffer, destination: *WGPUImageCopyTexture, copySize: *WGPUExtent3D) -> void #foreign libwgpu_native;
wgpuCommandEncoderCopyTextureToBuffer :: (commandEncoder: WGPUCommandEncoder, source: *WGPUImageCopyTexture, destination: *WGPUImageCopyBuffer, copySize: *WGPUExtent3D) -> void #foreign libwgpu_native;
wgpuCommandEncoderCopyTextureToTexture :: (commandEncoder: WGPUCommandEncoder, source: *WGPUImageCopyTexture, destination: *WGPUImageCopyTexture, copySize: *WGPUExtent3D) -> void #foreign libwgpu_native;
wgpuCommandEncoderFinish :: (commandEncoder: WGPUCommandEncoder, descriptor: *WGPUCommandBufferDescriptor) -> WGPUCommandBuffer #foreign libwgpu_native;
wgpuCommandEncoderInsertDebugMarker :: (commandEncoder: WGPUCommandEncoder, markerLabel: *u8) -> void #foreign libwgpu_native;
wgpuCommandEncoderPopDebugGroup :: (commandEncoder: WGPUCommandEncoder) -> void #foreign libwgpu_native;
wgpuCommandEncoderPushDebugGroup :: (commandEncoder: WGPUCommandEncoder, groupLabel: *u8) -> void #foreign libwgpu_native;
wgpuCommandEncoderResolveQuerySet :: (commandEncoder: WGPUCommandEncoder, querySet: WGPUQuerySet, firstQuery: u32, queryCount: u32, destination: WGPUBuffer, destinationOffset: u64) -> void #foreign libwgpu_native;
wgpuCommandEncoderSetLabel :: (commandEncoder: WGPUCommandEncoder, label: *u8) -> void #foreign libwgpu_native;
wgpuCommandEncoderWriteTimestamp :: (commandEncoder: WGPUCommandEncoder, querySet: WGPUQuerySet, queryIndex: u32) -> void #foreign libwgpu_native;
wgpuCommandEncoderReference :: (commandEncoder: WGPUCommandEncoder) -> void #foreign libwgpu_native;
wgpuCommandEncoderRelease :: (commandEncoder: WGPUCommandEncoder) -> void #foreign libwgpu_native;

// Methods of ComputePassEncoder
wgpuComputePassEncoderDispatchWorkgroups :: (computePassEncoder: WGPUComputePassEncoder, workgroupCountX: u32, workgroupCountY: u32, workgroupCountZ: u32) -> void #foreign libwgpu_native;
wgpuComputePassEncoderDispatchWorkgroupsIndirect :: (computePassEncoder: WGPUComputePassEncoder, indirectBuffer: WGPUBuffer, indirectOffset: u64) -> void #foreign libwgpu_native;
wgpuComputePassEncoderEnd :: (computePassEncoder: WGPUComputePassEncoder) -> void #foreign libwgpu_native;
wgpuComputePassEncoderInsertDebugMarker :: (computePassEncoder: WGPUComputePassEncoder, markerLabel: *u8) -> void #foreign libwgpu_native;
wgpuComputePassEncoderPopDebugGroup :: (computePassEncoder: WGPUComputePassEncoder) -> void #foreign libwgpu_native;
wgpuComputePassEncoderPushDebugGroup :: (computePassEncoder: WGPUComputePassEncoder, groupLabel: *u8) -> void #foreign libwgpu_native;
wgpuComputePassEncoderSetBindGroup :: (computePassEncoder: WGPUComputePassEncoder, groupIndex: u32, group: WGPUBindGroup, dynamicOffsetCount: u64, dynamicOffsets: *u32) -> void #foreign libwgpu_native;
wgpuComputePassEncoderSetLabel :: (computePassEncoder: WGPUComputePassEncoder, label: *u8) -> void #foreign libwgpu_native;
wgpuComputePassEncoderSetPipeline :: (computePassEncoder: WGPUComputePassEncoder, pipeline: WGPUComputePipeline) -> void #foreign libwgpu_native;
wgpuComputePassEncoderReference :: (computePassEncoder: WGPUComputePassEncoder) -> void #foreign libwgpu_native;
wgpuComputePassEncoderRelease :: (computePassEncoder: WGPUComputePassEncoder) -> void #foreign libwgpu_native;

// Methods of ComputePipeline
wgpuComputePipelineGetBindGroupLayout :: (computePipeline: WGPUComputePipeline, groupIndex: u32) -> WGPUBindGroupLayout #foreign libwgpu_native;
wgpuComputePipelineSetLabel :: (computePipeline: WGPUComputePipeline, label: *u8) -> void #foreign libwgpu_native;
wgpuComputePipelineReference :: (computePipeline: WGPUComputePipeline) -> void #foreign libwgpu_native;
wgpuComputePipelineRelease :: (computePipeline: WGPUComputePipeline) -> void #foreign libwgpu_native;

// Methods of Device
wgpuDeviceCreateBindGroup :: (device: WGPUDevice, descriptor: *WGPUBindGroupDescriptor) -> WGPUBindGroup #foreign libwgpu_native;
wgpuDeviceCreateBindGroupLayout :: (device: WGPUDevice, descriptor: *WGPUBindGroupLayoutDescriptor) -> WGPUBindGroupLayout #foreign libwgpu_native;
wgpuDeviceCreateBuffer :: (device: WGPUDevice, descriptor: *WGPUBufferDescriptor) -> WGPUBuffer #foreign libwgpu_native;
wgpuDeviceCreateCommandEncoder :: (device: WGPUDevice, descriptor: *WGPUCommandEncoderDescriptor) -> WGPUCommandEncoder #foreign libwgpu_native;
wgpuDeviceCreateComputePipeline :: (device: WGPUDevice, descriptor: *WGPUComputePipelineDescriptor) -> WGPUComputePipeline #foreign libwgpu_native;
wgpuDeviceCreateComputePipelineAsync :: (device: WGPUDevice, descriptor: *WGPUComputePipelineDescriptor, callback: WGPUCreateComputePipelineAsyncCallback, userdata: *void) -> void #foreign libwgpu_native;
wgpuDeviceCreatePipelineLayout :: (device: WGPUDevice, descriptor: *WGPUPipelineLayoutDescriptor) -> WGPUPipelineLayout #foreign libwgpu_native;
wgpuDeviceCreateQuerySet :: (device: WGPUDevice, descriptor: *WGPUQuerySetDescriptor) -> WGPUQuerySet #foreign libwgpu_native;
wgpuDeviceCreateRenderBundleEncoder :: (device: WGPUDevice, descriptor: *WGPURenderBundleEncoderDescriptor) -> WGPURenderBundleEncoder #foreign libwgpu_native;
wgpuDeviceCreateRenderPipeline :: (device: WGPUDevice, descriptor: *WGPURenderPipelineDescriptor) -> WGPURenderPipeline #foreign libwgpu_native;
wgpuDeviceCreateRenderPipelineAsync :: (device: WGPUDevice, descriptor: *WGPURenderPipelineDescriptor, callback: WGPUCreateRenderPipelineAsyncCallback, userdata: *void) -> void #foreign libwgpu_native;
wgpuDeviceCreateSampler :: (device: WGPUDevice, descriptor: *WGPUSamplerDescriptor) -> WGPUSampler #foreign libwgpu_native;
wgpuDeviceCreateShaderModule :: (device: WGPUDevice, descriptor: *WGPUShaderModuleDescriptor) -> WGPUShaderModule #foreign libwgpu_native;
wgpuDeviceCreateTexture :: (device: WGPUDevice, descriptor: *WGPUTextureDescriptor) -> WGPUTexture #foreign libwgpu_native;
wgpuDeviceDestroy :: (device: WGPUDevice) -> void #foreign libwgpu_native;
wgpuDeviceEnumerateFeatures :: (device: WGPUDevice, features: *WGPUFeatureName) -> u64 #foreign libwgpu_native;
wgpuDeviceGetLimits :: (device: WGPUDevice, limits: *WGPUSupportedLimits) -> WGPUBool #foreign libwgpu_native;
wgpuDeviceGetQueue :: (device: WGPUDevice) -> WGPUQueue #foreign libwgpu_native;
wgpuDeviceHasFeature :: (device: WGPUDevice, feature: WGPUFeatureName) -> WGPUBool #foreign libwgpu_native;
wgpuDevicePopErrorScope :: (device: WGPUDevice, callback: WGPUErrorCallback, userdata: *void) -> void #foreign libwgpu_native;
wgpuDevicePushErrorScope :: (device: WGPUDevice, filter: WGPUErrorFilter) -> void #foreign libwgpu_native;
wgpuDeviceSetLabel :: (device: WGPUDevice, label: *u8) -> void #foreign libwgpu_native;
wgpuDeviceSetUncapturedErrorCallback :: (device: WGPUDevice, callback: WGPUErrorCallback, userdata: *void) -> void #foreign libwgpu_native;
wgpuDeviceReference :: (device: WGPUDevice) -> void #foreign libwgpu_native;
wgpuDeviceRelease :: (device: WGPUDevice) -> void #foreign libwgpu_native;

// Methods of Instance
wgpuInstanceCreateSurface :: (instance: WGPUInstance, descriptor: *WGPUSurfaceDescriptor) -> WGPUSurface #foreign libwgpu_native;
wgpuInstanceProcessEvents :: (instance: WGPUInstance) -> void #foreign libwgpu_native;
wgpuInstanceRequestAdapter :: (instance: WGPUInstance, options: *WGPURequestAdapterOptions, callback: WGPURequestAdapterCallback, userdata: *void) -> void #foreign libwgpu_native;
wgpuInstanceReference :: (instance: WGPUInstance) -> void #foreign libwgpu_native;
wgpuInstanceRelease :: (instance: WGPUInstance) -> void #foreign libwgpu_native;

// Methods of PipelineLayout
wgpuPipelineLayoutSetLabel :: (pipelineLayout: WGPUPipelineLayout, label: *u8) -> void #foreign libwgpu_native;
wgpuPipelineLayoutReference :: (pipelineLayout: WGPUPipelineLayout) -> void #foreign libwgpu_native;
wgpuPipelineLayoutRelease :: (pipelineLayout: WGPUPipelineLayout) -> void #foreign libwgpu_native;

// Methods of QuerySet
wgpuQuerySetDestroy :: (querySet: WGPUQuerySet) -> void #foreign libwgpu_native;
wgpuQuerySetGetCount :: (querySet: WGPUQuerySet) -> u32 #foreign libwgpu_native;
wgpuQuerySetGetType :: (querySet: WGPUQuerySet) -> WGPUQueryType #foreign libwgpu_native;
wgpuQuerySetSetLabel :: (querySet: WGPUQuerySet, label: *u8) -> void #foreign libwgpu_native;
wgpuQuerySetReference :: (querySet: WGPUQuerySet) -> void #foreign libwgpu_native;
wgpuQuerySetRelease :: (querySet: WGPUQuerySet) -> void #foreign libwgpu_native;

// Methods of Queue
wgpuQueueOnSubmittedWorkDone :: (queue: WGPUQueue, callback: WGPUQueueWorkDoneCallback, userdata: *void) -> void #foreign libwgpu_native;
wgpuQueueSetLabel :: (queue: WGPUQueue, label: *u8) -> void #foreign libwgpu_native;
wgpuQueueSubmit :: (queue: WGPUQueue, commandCount: u64, commands: *WGPUCommandBuffer) -> void #foreign libwgpu_native;
wgpuQueueWriteBuffer :: (queue: WGPUQueue, buffer: WGPUBuffer, bufferOffset: u64, data: *void, size: u64) -> void #foreign libwgpu_native;
wgpuQueueWriteTexture :: (queue: WGPUQueue, destination: *WGPUImageCopyTexture, data: *void, dataSize: u64, dataLayout: *WGPUTextureDataLayout, writeSize: *WGPUExtent3D) -> void #foreign libwgpu_native;
wgpuQueueReference :: (queue: WGPUQueue) -> void #foreign libwgpu_native;
wgpuQueueRelease :: (queue: WGPUQueue) -> void #foreign libwgpu_native;

// Methods of RenderBundle
wgpuRenderBundleSetLabel :: (renderBundle: WGPURenderBundle, label: *u8) -> void #foreign libwgpu_native;
wgpuRenderBundleReference :: (renderBundle: WGPURenderBundle) -> void #foreign libwgpu_native;
wgpuRenderBundleRelease :: (renderBundle: WGPURenderBundle) -> void #foreign libwgpu_native;

// Methods of RenderBundleEncoder
wgpuRenderBundleEncoderDraw :: (renderBundleEncoder: WGPURenderBundleEncoder, vertexCount: u32, instanceCount: u32, firstVertex: u32, firstInstance: u32) -> void #foreign libwgpu_native;
wgpuRenderBundleEncoderDrawIndexed :: (renderBundleEncoder: WGPURenderBundleEncoder, indexCount: u32, instanceCount: u32, firstIndex: u32, baseVertex: s32, firstInstance: u32) -> void #foreign libwgpu_native;
wgpuRenderBundleEncoderDrawIndexedIndirect :: (renderBundleEncoder: WGPURenderBundleEncoder, indirectBuffer: WGPUBuffer, indirectOffset: u64) -> void #foreign libwgpu_native;
wgpuRenderBundleEncoderDrawIndirect :: (renderBundleEncoder: WGPURenderBundleEncoder, indirectBuffer: WGPUBuffer, indirectOffset: u64) -> void #foreign libwgpu_native;
wgpuRenderBundleEncoderFinish :: (renderBundleEncoder: WGPURenderBundleEncoder, descriptor: *WGPURenderBundleDescriptor) -> WGPURenderBundle #foreign libwgpu_native;
wgpuRenderBundleEncoderInsertDebugMarker :: (renderBundleEncoder: WGPURenderBundleEncoder, markerLabel: *u8) -> void #foreign libwgpu_native;
wgpuRenderBundleEncoderPopDebugGroup :: (renderBundleEncoder: WGPURenderBundleEncoder) -> void #foreign libwgpu_native;
wgpuRenderBundleEncoderPushDebugGroup :: (renderBundleEncoder: WGPURenderBundleEncoder, groupLabel: *u8) -> void #foreign libwgpu_native;
wgpuRenderBundleEncoderSetBindGroup :: (renderBundleEncoder: WGPURenderBundleEncoder, groupIndex: u32, group: WGPUBindGroup, dynamicOffsetCount: u64, dynamicOffsets: *u32) -> void #foreign libwgpu_native;
wgpuRenderBundleEncoderSetIndexBuffer :: (renderBundleEncoder: WGPURenderBundleEncoder, buffer: WGPUBuffer, format: WGPUIndexFormat, offset: u64, size: u64) -> void #foreign libwgpu_native;
wgpuRenderBundleEncoderSetLabel :: (renderBundleEncoder: WGPURenderBundleEncoder, label: *u8) -> void #foreign libwgpu_native;
wgpuRenderBundleEncoderSetPipeline :: (renderBundleEncoder: WGPURenderBundleEncoder, pipeline: WGPURenderPipeline) -> void #foreign libwgpu_native;
wgpuRenderBundleEncoderSetVertexBuffer :: (renderBundleEncoder: WGPURenderBundleEncoder, slot: u32, buffer: WGPUBuffer, offset: u64, size: u64) -> void #foreign libwgpu_native;
wgpuRenderBundleEncoderReference :: (renderBundleEncoder: WGPURenderBundleEncoder) -> void #foreign libwgpu_native;
wgpuRenderBundleEncoderRelease :: (renderBundleEncoder: WGPURenderBundleEncoder) -> void #foreign libwgpu_native;

// Methods of RenderPassEncoder
wgpuRenderPassEncoderBeginOcclusionQuery :: (renderPassEncoder: WGPURenderPassEncoder, queryIndex: u32) -> void #foreign libwgpu_native;
wgpuRenderPassEncoderDraw :: (renderPassEncoder: WGPURenderPassEncoder, vertexCount: u32, instanceCount: u32, firstVertex: u32, firstInstance: u32) -> void #foreign libwgpu_native;
wgpuRenderPassEncoderDrawIndexed :: (renderPassEncoder: WGPURenderPassEncoder, indexCount: u32, instanceCount: u32, firstIndex: u32, baseVertex: s32, firstInstance: u32) -> void #foreign libwgpu_native;
wgpuRenderPassEncoderDrawIndexedIndirect :: (renderPassEncoder: WGPURenderPassEncoder, indirectBuffer: WGPUBuffer, indirectOffset: u64) -> void #foreign libwgpu_native;
wgpuRenderPassEncoderDrawIndirect :: (renderPassEncoder: WGPURenderPassEncoder, indirectBuffer: WGPUBuffer, indirectOffset: u64) -> void #foreign libwgpu_native;
wgpuRenderPassEncoderEnd :: (renderPassEncoder: WGPURenderPassEncoder) -> void #foreign libwgpu_native;
wgpuRenderPassEncoderEndOcclusionQuery :: (renderPassEncoder: WGPURenderPassEncoder) -> void #foreign libwgpu_native;
wgpuRenderPassEncoderExecuteBundles :: (renderPassEncoder: WGPURenderPassEncoder, bundleCount: u64, bundles: *WGPURenderBundle) -> void #foreign libwgpu_native;
wgpuRenderPassEncoderInsertDebugMarker :: (renderPassEncoder: WGPURenderPassEncoder, markerLabel: *u8) -> void #foreign libwgpu_native;
wgpuRenderPassEncoderPopDebugGroup :: (renderPassEncoder: WGPURenderPassEncoder) -> void #foreign libwgpu_native;
wgpuRenderPassEncoderPushDebugGroup :: (renderPassEncoder: WGPURenderPassEncoder, groupLabel: *u8) -> void #foreign libwgpu_native;
wgpuRenderPassEncoderSetBindGroup :: (renderPassEncoder: WGPURenderPassEncoder, groupIndex: u32, group: WGPUBindGroup, dynamicOffsetCount: u64, dynamicOffsets: *u32) -> void #foreign libwgpu_native;
wgpuRenderPassEncoderSetBlendConstant :: (renderPassEncoder: WGPURenderPassEncoder, color: *WGPUColor) -> void #foreign libwgpu_native;
wgpuRenderPassEncoderSetIndexBuffer :: (renderPassEncoder: WGPURenderPassEncoder, buffer: WGPUBuffer, format: WGPUIndexFormat, offset: u64, size: u64) -> void #foreign libwgpu_native;
wgpuRenderPassEncoderSetLabel :: (renderPassEncoder: WGPURenderPassEncoder, label: *u8) -> void #foreign libwgpu_native;
wgpuRenderPassEncoderSetPipeline :: (renderPassEncoder: WGPURenderPassEncoder, pipeline: WGPURenderPipeline) -> void #foreign libwgpu_native;
wgpuRenderPassEncoderSetScissorRect :: (renderPassEncoder: WGPURenderPassEncoder, x: u32, y: u32, width: u32, height: u32) -> void #foreign libwgpu_native;
wgpuRenderPassEncoderSetStencilReference :: (renderPassEncoder: WGPURenderPassEncoder, reference: u32) -> void #foreign libwgpu_native;
wgpuRenderPassEncoderSetVertexBuffer :: (renderPassEncoder: WGPURenderPassEncoder, slot: u32, buffer: WGPUBuffer, offset: u64, size: u64) -> void #foreign libwgpu_native;
wgpuRenderPassEncoderSetViewport :: (renderPassEncoder: WGPURenderPassEncoder, x: float, y: float, width: float, height: float, minDepth: float, maxDepth: float) -> void #foreign libwgpu_native;
wgpuRenderPassEncoderReference :: (renderPassEncoder: WGPURenderPassEncoder) -> void #foreign libwgpu_native;
wgpuRenderPassEncoderRelease :: (renderPassEncoder: WGPURenderPassEncoder) -> void #foreign libwgpu_native;

// Methods of RenderPipeline
wgpuRenderPipelineGetBindGroupLayout :: (renderPipeline: WGPURenderPipeline, groupIndex: u32) -> WGPUBindGroupLayout #foreign libwgpu_native;
wgpuRenderPipelineSetLabel :: (renderPipeline: WGPURenderPipeline, label: *u8) -> void #foreign libwgpu_native;
wgpuRenderPipelineReference :: (renderPipeline: WGPURenderPipeline) -> void #foreign libwgpu_native;
wgpuRenderPipelineRelease :: (renderPipeline: WGPURenderPipeline) -> void #foreign libwgpu_native;

// Methods of Sampler
wgpuSamplerSetLabel :: (sampler: WGPUSampler, label: *u8) -> void #foreign libwgpu_native;
wgpuSamplerReference :: (sampler: WGPUSampler) -> void #foreign libwgpu_native;
wgpuSamplerRelease :: (sampler: WGPUSampler) -> void #foreign libwgpu_native;

// Methods of ShaderModule
wgpuShaderModuleGetCompilationInfo :: (shaderModule: WGPUShaderModule, callback: WGPUCompilationInfoCallback, userdata: *void) -> void #foreign libwgpu_native;
wgpuShaderModuleSetLabel :: (shaderModule: WGPUShaderModule, label: *u8) -> void #foreign libwgpu_native;
wgpuShaderModuleReference :: (shaderModule: WGPUShaderModule) -> void #foreign libwgpu_native;
wgpuShaderModuleRelease :: (shaderModule: WGPUShaderModule) -> void #foreign libwgpu_native;

// Methods of Surface
wgpuSurfaceConfigure :: (surface: WGPUSurface, config: *WGPUSurfaceConfiguration) -> void #foreign libwgpu_native;
wgpuSurfaceGetCapabilities :: (surface: WGPUSurface, adapter: WGPUAdapter, capabilities: *WGPUSurfaceCapabilities) -> void #foreign libwgpu_native;
wgpuSurfaceGetCurrentTexture :: (surface: WGPUSurface, surfaceTexture: *WGPUSurfaceTexture) -> void #foreign libwgpu_native;
wgpuSurfaceGetPreferredFormat :: (surface: WGPUSurface, adapter: WGPUAdapter) -> WGPUTextureFormat #foreign libwgpu_native;
wgpuSurfacePresent :: (surface: WGPUSurface) -> void #foreign libwgpu_native;
wgpuSurfaceUnconfigure :: (surface: WGPUSurface) -> void #foreign libwgpu_native;
wgpuSurfaceReference :: (surface: WGPUSurface) -> void #foreign libwgpu_native;
wgpuSurfaceRelease :: (surface: WGPUSurface) -> void #foreign libwgpu_native;

// Methods of SurfaceCapabilities
wgpuSurfaceCapabilitiesFreeMembers :: (capabilities: WGPUSurfaceCapabilities) -> void #foreign libwgpu_native;

// Methods of Texture
wgpuTextureCreateView :: (texture: WGPUTexture, descriptor: *WGPUTextureViewDescriptor) -> WGPUTextureView #foreign libwgpu_native;
wgpuTextureDestroy :: (texture: WGPUTexture) -> void #foreign libwgpu_native;
wgpuTextureGetDepthOrArrayLayers :: (texture: WGPUTexture) -> u32 #foreign libwgpu_native;
wgpuTextureGetDimension :: (texture: WGPUTexture) -> WGPUTextureDimension #foreign libwgpu_native;
wgpuTextureGetFormat :: (texture: WGPUTexture) -> WGPUTextureFormat #foreign libwgpu_native;
wgpuTextureGetHeight :: (texture: WGPUTexture) -> u32 #foreign libwgpu_native;
wgpuTextureGetMipLevelCount :: (texture: WGPUTexture) -> u32 #foreign libwgpu_native;
wgpuTextureGetSampleCount :: (texture: WGPUTexture) -> u32 #foreign libwgpu_native;
wgpuTextureGetUsage :: (texture: WGPUTexture) -> WGPUTextureUsageFlags #foreign libwgpu_native;
wgpuTextureGetWidth :: (texture: WGPUTexture) -> u32 #foreign libwgpu_native;
wgpuTextureSetLabel :: (texture: WGPUTexture, label: *u8) -> void #foreign libwgpu_native;
wgpuTextureReference :: (texture: WGPUTexture) -> void #foreign libwgpu_native;
wgpuTextureRelease :: (texture: WGPUTexture) -> void #foreign libwgpu_native;

// Methods of TextureView
wgpuTextureViewSetLabel :: (textureView: WGPUTextureView, label: *u8) -> void #foreign libwgpu_native;
wgpuTextureViewReference :: (textureView: WGPUTextureView) -> void #foreign libwgpu_native;
wgpuTextureViewRelease :: (textureView: WGPUTextureView) -> void #foreign libwgpu_native;

WGPUNativeSType :: enum u32 {
    WGPUSType_DeviceExtras               :: 196609;
    WGPUSType_RequiredLimitsExtras       :: 196610;
    WGPUSType_PipelineLayoutExtras       :: 196611;
    WGPUSType_ShaderModuleGLSLDescriptor :: 196612;
    WGPUSType_SupportedLimitsExtras      :: 196613;
    WGPUSType_InstanceExtras             :: 196614;
    WGPUSType_BindGroupEntryExtras       :: 196615;
    WGPUSType_BindGroupLayoutEntryExtras :: 196616;
    WGPUSType_QuerySetDescriptorExtras   :: 196617;
    WGPUSType_SurfaceConfigurationExtras :: 196618;
    Force32                              :: 2147483647;
    WGPUNativeSType_Force32 :: Force32;
}

WGPUNativeFeature :: enum u32 {
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

WGPULogLevel :: enum u32 {
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

WGPUInstanceBackend :: enum u32 {
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

WGPUInstanceBackendFlags :: WGPUFlags;

WGPUInstanceFlag :: enum u32 {
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

WGPUInstanceFlags :: WGPUFlags;

WGPUDx12Compiler :: enum u32 {
    Undefined :: 0;
    Fxc       :: 1;
    Dxc       :: 2;
    Force32   :: 2147483647;

    WGPUDx12Compiler_Undefined :: Undefined;
    WGPUDx12Compiler_Fxc       :: Fxc;
    WGPUDx12Compiler_Dxc       :: Dxc;
    WGPUDx12Compiler_Force32   :: Force32;
}

WGPUGles3MinorVersion :: enum u32 {
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

WGPUPipelineStatisticName :: enum u32 {
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

WGPUNativeQueryType :: enum u32 {
    PipelineStatistics :: 196608;
    Force32            :: 2147483647;

    WGPUNativeQueryType_PipelineStatistics :: PipelineStatistics;
    WGPUNativeQueryType_Force32            :: Force32;
}

WGPUInstanceExtras :: struct {
    chain:              WGPUChainedStruct;
    backends:           WGPUInstanceBackendFlags;
    flags:              WGPUInstanceFlags;
    dx12ShaderCompiler: WGPUDx12Compiler;
    gles3MinorVersion:  WGPUGles3MinorVersion;
    dxilPath:           *u8;
    dxcPath:            *u8;
}

WGPUDeviceExtras :: struct {
    chain:     WGPUChainedStruct;
    tracePath: *u8;
}

WGPUNativeLimits :: struct {
    maxPushConstantSize:   u32;
    maxNonSamplerBindings: u32;
}

WGPURequiredLimitsExtras :: struct {
    chain:  WGPUChainedStruct;
    limits: WGPUNativeLimits;
}

WGPUSupportedLimitsExtras :: struct {
    chain:  WGPUChainedStructOut;
    limits: WGPUNativeLimits;
}

WGPUPushConstantRange :: struct {
    stages: WGPUShaderStageFlags;
    start:  u32;
    end:    u32;
}

WGPUPipelineLayoutExtras :: struct {
    chain:                  WGPUChainedStruct;
    pushConstantRangeCount: u64;
    pushConstantRanges:     *WGPUPushConstantRange;
}

WGPUSubmissionIndex :: u64;

WGPUWrappedSubmissionIndex :: struct {
    queue:           WGPUQueue;
    submissionIndex: WGPUSubmissionIndex;
}

WGPUShaderDefine :: struct {
    name:  *u8;
    value: *u8;
}

WGPUShaderModuleGLSLDescriptor :: struct {
    chain:       WGPUChainedStruct;
    stage:       WGPUShaderStage;
    code:        *u8;
    defineCount: u32;
    defines:     *WGPUShaderDefine;
}

WGPURegistryReport :: struct {
    numAllocated:        u64;
    numKeptFromUser:     u64;
    numReleasedFromUser: u64;
    numError:            u64;
    elementSize:         u64;
}

WGPUHubReport :: struct {
    adapters:         WGPURegistryReport;
    devices:          WGPURegistryReport;
    queues:           WGPURegistryReport;
    pipelineLayouts:  WGPURegistryReport;
    shaderModules:    WGPURegistryReport;
    bindGroupLayouts: WGPURegistryReport;
    bindGroups:       WGPURegistryReport;
    commandBuffers:   WGPURegistryReport;
    renderBundles:    WGPURegistryReport;
    renderPipelines:  WGPURegistryReport;
    computePipelines: WGPURegistryReport;
    querySets:        WGPURegistryReport;
    buffers:          WGPURegistryReport;
    textures:         WGPURegistryReport;
    textureViews:     WGPURegistryReport;
    samplers:         WGPURegistryReport;
}

WGPUGlobalReport :: struct {
    surfaces:    WGPURegistryReport;
    backendType: WGPUBackendType;
    vulkan:      WGPUHubReport;
    metal:       WGPUHubReport;
    dx12:        WGPUHubReport;
    gl:          WGPUHubReport;
}

WGPUInstanceEnumerateAdapterOptions :: struct {
    nextInChain: *WGPUChainedStruct;
    backends:    WGPUInstanceBackendFlags;
}

WGPUBindGroupEntryExtras :: struct {
    chain:            WGPUChainedStruct;
    buffers:          *WGPUBuffer;
    bufferCount:      u64;
    samplers:         *WGPUSampler;
    samplerCount:     u64;
    textureViews:     *WGPUTextureView;
    textureViewCount: u64;
}

WGPUBindGroupLayoutEntryExtras :: struct {
    chain: WGPUChainedStruct;
    count: u32;
}

WGPUQuerySetDescriptorExtras :: struct {
    chain:                  WGPUChainedStruct;
    pipelineStatistics:     *WGPUPipelineStatisticName;
    pipelineStatisticCount: u64;
}

WGPUSurfaceConfigurationExtras :: struct {
    chain:                      WGPUChainedStruct;
    desiredMaximumFrameLatency: WGPUBool;
}

WGPULogCallback :: #type (level: WGPULogLevel, message: *u8, userdata: *void) -> void #c_call;

wgpuGenerateReport :: (instance: WGPUInstance, report: *WGPUGlobalReport) -> void #foreign libwgpu_native;
wgpuInstanceEnumerateAdapters :: (instance: WGPUInstance, options: *WGPUInstanceEnumerateAdapterOptions, adapters: *WGPUAdapter) -> u64 #foreign libwgpu_native;

wgpuQueueSubmitForIndex :: (queue: WGPUQueue, commandCount: u64, commands: *WGPUCommandBuffer) -> WGPUSubmissionIndex #foreign libwgpu_native;

// Returns true if the queue is empty, or false if there are more queue submissions still in flight.
wgpuDevicePoll :: (device: WGPUDevice, wait: WGPUBool, wrappedSubmissionIndex: *WGPUWrappedSubmissionIndex) -> WGPUBool #foreign libwgpu_native;

wgpuSetLogCallback :: (callback: WGPULogCallback, userdata: *void) -> void #foreign libwgpu_native;

wgpuSetLogLevel :: (level: WGPULogLevel) -> void #foreign libwgpu_native;

wgpuGetVersion :: () -> u32 #foreign libwgpu_native;

wgpuRenderPassEncoderSetPushConstants :: (encoder: WGPURenderPassEncoder, stages: WGPUShaderStageFlags, offset: u32, sizeBytes: u32, data: *void) -> void #foreign libwgpu_native;

wgpuRenderPassEncoderMultiDrawIndirect :: (encoder: WGPURenderPassEncoder, buffer: WGPUBuffer, offset: u64, count: u32) -> void #foreign libwgpu_native;
wgpuRenderPassEncoderMultiDrawIndexedIndirect :: (encoder: WGPURenderPassEncoder, buffer: WGPUBuffer, offset: u64, count: u32) -> void #foreign libwgpu_native;

wgpuRenderPassEncoderMultiDrawIndirectCount :: (encoder: WGPURenderPassEncoder, buffer: WGPUBuffer, offset: u64, count_buffer: WGPUBuffer, count_buffer_offset: u64, max_count: u32) -> void #foreign libwgpu_native;
wgpuRenderPassEncoderMultiDrawIndexedIndirectCount :: (encoder: WGPURenderPassEncoder, buffer: WGPUBuffer, offset: u64, count_buffer: WGPUBuffer, count_buffer_offset: u64, max_count: u32) -> void #foreign libwgpu_native;

wgpuComputePassEncoderBeginPipelineStatisticsQuery :: (computePassEncoder: WGPUComputePassEncoder, querySet: WGPUQuerySet, queryIndex: u32) -> void #foreign libwgpu_native;
wgpuComputePassEncoderEndPipelineStatisticsQuery :: (computePassEncoder: WGPUComputePassEncoder) -> void #foreign libwgpu_native;
wgpuRenderPassEncoderBeginPipelineStatisticsQuery :: (renderPassEncoder: WGPURenderPassEncoder, querySet: WGPUQuerySet, queryIndex: u32) -> void #foreign libwgpu_native;
wgpuRenderPassEncoderEndPipelineStatisticsQuery :: (renderPassEncoder: WGPURenderPassEncoder) -> void #foreign libwgpu_native;

#scope_file

#import "Basic"; // For assert

libwgpu_native :: #library "./linux/libwgpu_native";

#run {
    {
        instance: WGPUChainedStruct;
        assert(((cast(*void)(*instance.next)) - cast(*void)(*instance)) == 0, "WGPUChainedStruct.next has unexpected offset % instead of 0", ((cast(*void)(*instance.next)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUChainedStruct.next)) == 8, "WGPUChainedStruct.next has unexpected size % instead of 8", size_of(type_of(WGPUChainedStruct.next)));
        assert(((cast(*void)(*instance.sType)) - cast(*void)(*instance)) == 8, "WGPUChainedStruct.sType has unexpected offset % instead of 8", ((cast(*void)(*instance.sType)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUChainedStruct.sType)) == 4, "WGPUChainedStruct.sType has unexpected size % instead of 4", size_of(type_of(WGPUChainedStruct.sType)));
        assert(size_of(WGPUChainedStruct) == 16, "WGPUChainedStruct has size % instead of 16", size_of(WGPUChainedStruct));
    }

    {
        instance: WGPUChainedStructOut;
        assert(((cast(*void)(*instance.next)) - cast(*void)(*instance)) == 0, "WGPUChainedStructOut.next has unexpected offset % instead of 0", ((cast(*void)(*instance.next)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUChainedStructOut.next)) == 8, "WGPUChainedStructOut.next has unexpected size % instead of 8", size_of(type_of(WGPUChainedStructOut.next)));
        assert(((cast(*void)(*instance.sType)) - cast(*void)(*instance)) == 8, "WGPUChainedStructOut.sType has unexpected offset % instead of 8", ((cast(*void)(*instance.sType)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUChainedStructOut.sType)) == 4, "WGPUChainedStructOut.sType has unexpected size % instead of 4", size_of(type_of(WGPUChainedStructOut.sType)));
        assert(size_of(WGPUChainedStructOut) == 16, "WGPUChainedStructOut has size % instead of 16", size_of(WGPUChainedStructOut));
    }

    {
        instance: WGPUAdapterProperties;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUAdapterProperties.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUAdapterProperties.nextInChain)) == 8, "WGPUAdapterProperties.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUAdapterProperties.nextInChain)));
        assert(((cast(*void)(*instance.vendorID)) - cast(*void)(*instance)) == 8, "WGPUAdapterProperties.vendorID has unexpected offset % instead of 8", ((cast(*void)(*instance.vendorID)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUAdapterProperties.vendorID)) == 4, "WGPUAdapterProperties.vendorID has unexpected size % instead of 4", size_of(type_of(WGPUAdapterProperties.vendorID)));
        assert(((cast(*void)(*instance.vendorName)) - cast(*void)(*instance)) == 16, "WGPUAdapterProperties.vendorName has unexpected offset % instead of 16", ((cast(*void)(*instance.vendorName)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUAdapterProperties.vendorName)) == 8, "WGPUAdapterProperties.vendorName has unexpected size % instead of 8", size_of(type_of(WGPUAdapterProperties.vendorName)));
        assert(((cast(*void)(*instance.architecture)) - cast(*void)(*instance)) == 24, "WGPUAdapterProperties.architecture has unexpected offset % instead of 24", ((cast(*void)(*instance.architecture)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUAdapterProperties.architecture)) == 8, "WGPUAdapterProperties.architecture has unexpected size % instead of 8", size_of(type_of(WGPUAdapterProperties.architecture)));
        assert(((cast(*void)(*instance.deviceID)) - cast(*void)(*instance)) == 32, "WGPUAdapterProperties.deviceID has unexpected offset % instead of 32", ((cast(*void)(*instance.deviceID)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUAdapterProperties.deviceID)) == 4, "WGPUAdapterProperties.deviceID has unexpected size % instead of 4", size_of(type_of(WGPUAdapterProperties.deviceID)));
        assert(((cast(*void)(*instance.name)) - cast(*void)(*instance)) == 40, "WGPUAdapterProperties.name has unexpected offset % instead of 40", ((cast(*void)(*instance.name)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUAdapterProperties.name)) == 8, "WGPUAdapterProperties.name has unexpected size % instead of 8", size_of(type_of(WGPUAdapterProperties.name)));
        assert(((cast(*void)(*instance.driverDescription)) - cast(*void)(*instance)) == 48, "WGPUAdapterProperties.driverDescription has unexpected offset % instead of 48", ((cast(*void)(*instance.driverDescription)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUAdapterProperties.driverDescription)) == 8, "WGPUAdapterProperties.driverDescription has unexpected size % instead of 8", size_of(type_of(WGPUAdapterProperties.driverDescription)));
        assert(((cast(*void)(*instance.adapterType)) - cast(*void)(*instance)) == 56, "WGPUAdapterProperties.adapterType has unexpected offset % instead of 56", ((cast(*void)(*instance.adapterType)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUAdapterProperties.adapterType)) == 4, "WGPUAdapterProperties.adapterType has unexpected size % instead of 4", size_of(type_of(WGPUAdapterProperties.adapterType)));
        assert(((cast(*void)(*instance.backendType)) - cast(*void)(*instance)) == 60, "WGPUAdapterProperties.backendType has unexpected offset % instead of 60", ((cast(*void)(*instance.backendType)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUAdapterProperties.backendType)) == 4, "WGPUAdapterProperties.backendType has unexpected size % instead of 4", size_of(type_of(WGPUAdapterProperties.backendType)));
        assert(size_of(WGPUAdapterProperties) == 64, "WGPUAdapterProperties has size % instead of 64", size_of(WGPUAdapterProperties));
    }

    {
        instance: WGPUBindGroupEntry;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUBindGroupEntry.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBindGroupEntry.nextInChain)) == 8, "WGPUBindGroupEntry.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUBindGroupEntry.nextInChain)));
        assert(((cast(*void)(*instance.binding)) - cast(*void)(*instance)) == 8, "WGPUBindGroupEntry.binding has unexpected offset % instead of 8", ((cast(*void)(*instance.binding)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBindGroupEntry.binding)) == 4, "WGPUBindGroupEntry.binding has unexpected size % instead of 4", size_of(type_of(WGPUBindGroupEntry.binding)));
        assert(((cast(*void)(*instance.buffer)) - cast(*void)(*instance)) == 16, "WGPUBindGroupEntry.buffer has unexpected offset % instead of 16", ((cast(*void)(*instance.buffer)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBindGroupEntry.buffer)) == 8, "WGPUBindGroupEntry.buffer has unexpected size % instead of 8", size_of(type_of(WGPUBindGroupEntry.buffer)));
        assert(((cast(*void)(*instance.offset)) - cast(*void)(*instance)) == 24, "WGPUBindGroupEntry.offset has unexpected offset % instead of 24", ((cast(*void)(*instance.offset)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBindGroupEntry.offset)) == 8, "WGPUBindGroupEntry.offset has unexpected size % instead of 8", size_of(type_of(WGPUBindGroupEntry.offset)));
        assert(((cast(*void)(*instance.size)) - cast(*void)(*instance)) == 32, "WGPUBindGroupEntry.size has unexpected offset % instead of 32", ((cast(*void)(*instance.size)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBindGroupEntry.size)) == 8, "WGPUBindGroupEntry.size has unexpected size % instead of 8", size_of(type_of(WGPUBindGroupEntry.size)));
        assert(((cast(*void)(*instance.sampler)) - cast(*void)(*instance)) == 40, "WGPUBindGroupEntry.sampler has unexpected offset % instead of 40", ((cast(*void)(*instance.sampler)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBindGroupEntry.sampler)) == 8, "WGPUBindGroupEntry.sampler has unexpected size % instead of 8", size_of(type_of(WGPUBindGroupEntry.sampler)));
        assert(((cast(*void)(*instance.textureView)) - cast(*void)(*instance)) == 48, "WGPUBindGroupEntry.textureView has unexpected offset % instead of 48", ((cast(*void)(*instance.textureView)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBindGroupEntry.textureView)) == 8, "WGPUBindGroupEntry.textureView has unexpected size % instead of 8", size_of(type_of(WGPUBindGroupEntry.textureView)));
        assert(size_of(WGPUBindGroupEntry) == 56, "WGPUBindGroupEntry has size % instead of 56", size_of(WGPUBindGroupEntry));
    }

    {
        instance: WGPUBlendComponent;
        assert(((cast(*void)(*instance.operation)) - cast(*void)(*instance)) == 0, "WGPUBlendComponent.operation has unexpected offset % instead of 0", ((cast(*void)(*instance.operation)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBlendComponent.operation)) == 4, "WGPUBlendComponent.operation has unexpected size % instead of 4", size_of(type_of(WGPUBlendComponent.operation)));
        assert(((cast(*void)(*instance.srcFactor)) - cast(*void)(*instance)) == 4, "WGPUBlendComponent.srcFactor has unexpected offset % instead of 4", ((cast(*void)(*instance.srcFactor)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBlendComponent.srcFactor)) == 4, "WGPUBlendComponent.srcFactor has unexpected size % instead of 4", size_of(type_of(WGPUBlendComponent.srcFactor)));
        assert(((cast(*void)(*instance.dstFactor)) - cast(*void)(*instance)) == 8, "WGPUBlendComponent.dstFactor has unexpected offset % instead of 8", ((cast(*void)(*instance.dstFactor)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBlendComponent.dstFactor)) == 4, "WGPUBlendComponent.dstFactor has unexpected size % instead of 4", size_of(type_of(WGPUBlendComponent.dstFactor)));
        assert(size_of(WGPUBlendComponent) == 12, "WGPUBlendComponent has size % instead of 12", size_of(WGPUBlendComponent));
    }

    {
        instance: WGPUBufferBindingLayout;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUBufferBindingLayout.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBufferBindingLayout.nextInChain)) == 8, "WGPUBufferBindingLayout.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUBufferBindingLayout.nextInChain)));
        assert(((cast(*void)(*instance.type)) - cast(*void)(*instance)) == 8, "WGPUBufferBindingLayout.type has unexpected offset % instead of 8", ((cast(*void)(*instance.type)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBufferBindingLayout.type)) == 4, "WGPUBufferBindingLayout.type has unexpected size % instead of 4", size_of(type_of(WGPUBufferBindingLayout.type)));
        assert(((cast(*void)(*instance.hasDynamicOffset)) - cast(*void)(*instance)) == 12, "WGPUBufferBindingLayout.hasDynamicOffset has unexpected offset % instead of 12", ((cast(*void)(*instance.hasDynamicOffset)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBufferBindingLayout.hasDynamicOffset)) == 4, "WGPUBufferBindingLayout.hasDynamicOffset has unexpected size % instead of 4", size_of(type_of(WGPUBufferBindingLayout.hasDynamicOffset)));
        assert(((cast(*void)(*instance.minBindingSize)) - cast(*void)(*instance)) == 16, "WGPUBufferBindingLayout.minBindingSize has unexpected offset % instead of 16", ((cast(*void)(*instance.minBindingSize)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBufferBindingLayout.minBindingSize)) == 8, "WGPUBufferBindingLayout.minBindingSize has unexpected size % instead of 8", size_of(type_of(WGPUBufferBindingLayout.minBindingSize)));
        assert(size_of(WGPUBufferBindingLayout) == 24, "WGPUBufferBindingLayout has size % instead of 24", size_of(WGPUBufferBindingLayout));
    }

    {
        instance: WGPUBufferDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUBufferDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBufferDescriptor.nextInChain)) == 8, "WGPUBufferDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUBufferDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "WGPUBufferDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBufferDescriptor.label)) == 8, "WGPUBufferDescriptor.label has unexpected size % instead of 8", size_of(type_of(WGPUBufferDescriptor.label)));
        assert(((cast(*void)(*instance.usage)) - cast(*void)(*instance)) == 16, "WGPUBufferDescriptor.usage has unexpected offset % instead of 16", ((cast(*void)(*instance.usage)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBufferDescriptor.usage)) == 4, "WGPUBufferDescriptor.usage has unexpected size % instead of 4", size_of(type_of(WGPUBufferDescriptor.usage)));
        assert(((cast(*void)(*instance.size)) - cast(*void)(*instance)) == 24, "WGPUBufferDescriptor.size has unexpected offset % instead of 24", ((cast(*void)(*instance.size)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBufferDescriptor.size)) == 8, "WGPUBufferDescriptor.size has unexpected size % instead of 8", size_of(type_of(WGPUBufferDescriptor.size)));
        assert(((cast(*void)(*instance.mappedAtCreation)) - cast(*void)(*instance)) == 32, "WGPUBufferDescriptor.mappedAtCreation has unexpected offset % instead of 32", ((cast(*void)(*instance.mappedAtCreation)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBufferDescriptor.mappedAtCreation)) == 4, "WGPUBufferDescriptor.mappedAtCreation has unexpected size % instead of 4", size_of(type_of(WGPUBufferDescriptor.mappedAtCreation)));
        assert(size_of(WGPUBufferDescriptor) == 40, "WGPUBufferDescriptor has size % instead of 40", size_of(WGPUBufferDescriptor));
    }

    {
        instance: WGPUColor;
        assert(((cast(*void)(*instance.r)) - cast(*void)(*instance)) == 0, "WGPUColor.r has unexpected offset % instead of 0", ((cast(*void)(*instance.r)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUColor.r)) == 8, "WGPUColor.r has unexpected size % instead of 8", size_of(type_of(WGPUColor.r)));
        assert(((cast(*void)(*instance.g)) - cast(*void)(*instance)) == 8, "WGPUColor.g has unexpected offset % instead of 8", ((cast(*void)(*instance.g)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUColor.g)) == 8, "WGPUColor.g has unexpected size % instead of 8", size_of(type_of(WGPUColor.g)));
        assert(((cast(*void)(*instance.b)) - cast(*void)(*instance)) == 16, "WGPUColor.b has unexpected offset % instead of 16", ((cast(*void)(*instance.b)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUColor.b)) == 8, "WGPUColor.b has unexpected size % instead of 8", size_of(type_of(WGPUColor.b)));
        assert(((cast(*void)(*instance.a)) - cast(*void)(*instance)) == 24, "WGPUColor.a has unexpected offset % instead of 24", ((cast(*void)(*instance.a)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUColor.a)) == 8, "WGPUColor.a has unexpected size % instead of 8", size_of(type_of(WGPUColor.a)));
        assert(size_of(WGPUColor) == 32, "WGPUColor has size % instead of 32", size_of(WGPUColor));
    }

    {
        instance: WGPUCommandBufferDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUCommandBufferDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUCommandBufferDescriptor.nextInChain)) == 8, "WGPUCommandBufferDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUCommandBufferDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "WGPUCommandBufferDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUCommandBufferDescriptor.label)) == 8, "WGPUCommandBufferDescriptor.label has unexpected size % instead of 8", size_of(type_of(WGPUCommandBufferDescriptor.label)));
        assert(size_of(WGPUCommandBufferDescriptor) == 16, "WGPUCommandBufferDescriptor has size % instead of 16", size_of(WGPUCommandBufferDescriptor));
    }

    {
        instance: WGPUCommandEncoderDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUCommandEncoderDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUCommandEncoderDescriptor.nextInChain)) == 8, "WGPUCommandEncoderDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUCommandEncoderDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "WGPUCommandEncoderDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUCommandEncoderDescriptor.label)) == 8, "WGPUCommandEncoderDescriptor.label has unexpected size % instead of 8", size_of(type_of(WGPUCommandEncoderDescriptor.label)));
        assert(size_of(WGPUCommandEncoderDescriptor) == 16, "WGPUCommandEncoderDescriptor has size % instead of 16", size_of(WGPUCommandEncoderDescriptor));
    }

    {
        instance: WGPUCompilationMessage;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUCompilationMessage.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUCompilationMessage.nextInChain)) == 8, "WGPUCompilationMessage.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUCompilationMessage.nextInChain)));
        assert(((cast(*void)(*instance.message)) - cast(*void)(*instance)) == 8, "WGPUCompilationMessage.message has unexpected offset % instead of 8", ((cast(*void)(*instance.message)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUCompilationMessage.message)) == 8, "WGPUCompilationMessage.message has unexpected size % instead of 8", size_of(type_of(WGPUCompilationMessage.message)));
        assert(((cast(*void)(*instance.type)) - cast(*void)(*instance)) == 16, "WGPUCompilationMessage.type has unexpected offset % instead of 16", ((cast(*void)(*instance.type)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUCompilationMessage.type)) == 4, "WGPUCompilationMessage.type has unexpected size % instead of 4", size_of(type_of(WGPUCompilationMessage.type)));
        assert(((cast(*void)(*instance.lineNum)) - cast(*void)(*instance)) == 24, "WGPUCompilationMessage.lineNum has unexpected offset % instead of 24", ((cast(*void)(*instance.lineNum)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUCompilationMessage.lineNum)) == 8, "WGPUCompilationMessage.lineNum has unexpected size % instead of 8", size_of(type_of(WGPUCompilationMessage.lineNum)));
        assert(((cast(*void)(*instance.linePos)) - cast(*void)(*instance)) == 32, "WGPUCompilationMessage.linePos has unexpected offset % instead of 32", ((cast(*void)(*instance.linePos)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUCompilationMessage.linePos)) == 8, "WGPUCompilationMessage.linePos has unexpected size % instead of 8", size_of(type_of(WGPUCompilationMessage.linePos)));
        assert(((cast(*void)(*instance.offset)) - cast(*void)(*instance)) == 40, "WGPUCompilationMessage.offset has unexpected offset % instead of 40", ((cast(*void)(*instance.offset)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUCompilationMessage.offset)) == 8, "WGPUCompilationMessage.offset has unexpected size % instead of 8", size_of(type_of(WGPUCompilationMessage.offset)));
        assert(((cast(*void)(*instance.length)) - cast(*void)(*instance)) == 48, "WGPUCompilationMessage.length has unexpected offset % instead of 48", ((cast(*void)(*instance.length)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUCompilationMessage.length)) == 8, "WGPUCompilationMessage.length has unexpected size % instead of 8", size_of(type_of(WGPUCompilationMessage.length)));
        assert(((cast(*void)(*instance.utf16LinePos)) - cast(*void)(*instance)) == 56, "WGPUCompilationMessage.utf16LinePos has unexpected offset % instead of 56", ((cast(*void)(*instance.utf16LinePos)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUCompilationMessage.utf16LinePos)) == 8, "WGPUCompilationMessage.utf16LinePos has unexpected size % instead of 8", size_of(type_of(WGPUCompilationMessage.utf16LinePos)));
        assert(((cast(*void)(*instance.utf16Offset)) - cast(*void)(*instance)) == 64, "WGPUCompilationMessage.utf16Offset has unexpected offset % instead of 64", ((cast(*void)(*instance.utf16Offset)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUCompilationMessage.utf16Offset)) == 8, "WGPUCompilationMessage.utf16Offset has unexpected size % instead of 8", size_of(type_of(WGPUCompilationMessage.utf16Offset)));
        assert(((cast(*void)(*instance.utf16Length)) - cast(*void)(*instance)) == 72, "WGPUCompilationMessage.utf16Length has unexpected offset % instead of 72", ((cast(*void)(*instance.utf16Length)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUCompilationMessage.utf16Length)) == 8, "WGPUCompilationMessage.utf16Length has unexpected size % instead of 8", size_of(type_of(WGPUCompilationMessage.utf16Length)));
        assert(size_of(WGPUCompilationMessage) == 80, "WGPUCompilationMessage has size % instead of 80", size_of(WGPUCompilationMessage));
    }

    {
        instance: WGPUComputePassTimestampWrites;
        assert(((cast(*void)(*instance.querySet)) - cast(*void)(*instance)) == 0, "WGPUComputePassTimestampWrites.querySet has unexpected offset % instead of 0", ((cast(*void)(*instance.querySet)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUComputePassTimestampWrites.querySet)) == 8, "WGPUComputePassTimestampWrites.querySet has unexpected size % instead of 8", size_of(type_of(WGPUComputePassTimestampWrites.querySet)));
        assert(((cast(*void)(*instance.beginningOfPassWriteIndex)) - cast(*void)(*instance)) == 8, "WGPUComputePassTimestampWrites.beginningOfPassWriteIndex has unexpected offset % instead of 8", ((cast(*void)(*instance.beginningOfPassWriteIndex)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUComputePassTimestampWrites.beginningOfPassWriteIndex)) == 4, "WGPUComputePassTimestampWrites.beginningOfPassWriteIndex has unexpected size % instead of 4", size_of(type_of(WGPUComputePassTimestampWrites.beginningOfPassWriteIndex)));
        assert(((cast(*void)(*instance.endOfPassWriteIndex)) - cast(*void)(*instance)) == 12, "WGPUComputePassTimestampWrites.endOfPassWriteIndex has unexpected offset % instead of 12", ((cast(*void)(*instance.endOfPassWriteIndex)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUComputePassTimestampWrites.endOfPassWriteIndex)) == 4, "WGPUComputePassTimestampWrites.endOfPassWriteIndex has unexpected size % instead of 4", size_of(type_of(WGPUComputePassTimestampWrites.endOfPassWriteIndex)));
        assert(size_of(WGPUComputePassTimestampWrites) == 16, "WGPUComputePassTimestampWrites has size % instead of 16", size_of(WGPUComputePassTimestampWrites));
    }

    {
        instance: WGPUConstantEntry;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUConstantEntry.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUConstantEntry.nextInChain)) == 8, "WGPUConstantEntry.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUConstantEntry.nextInChain)));
        assert(((cast(*void)(*instance.key)) - cast(*void)(*instance)) == 8, "WGPUConstantEntry.key has unexpected offset % instead of 8", ((cast(*void)(*instance.key)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUConstantEntry.key)) == 8, "WGPUConstantEntry.key has unexpected size % instead of 8", size_of(type_of(WGPUConstantEntry.key)));
        assert(((cast(*void)(*instance.value)) - cast(*void)(*instance)) == 16, "WGPUConstantEntry.value has unexpected offset % instead of 16", ((cast(*void)(*instance.value)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUConstantEntry.value)) == 8, "WGPUConstantEntry.value has unexpected size % instead of 8", size_of(type_of(WGPUConstantEntry.value)));
        assert(size_of(WGPUConstantEntry) == 24, "WGPUConstantEntry has size % instead of 24", size_of(WGPUConstantEntry));
    }

    {
        instance: WGPUExtent3D;
        assert(((cast(*void)(*instance.width)) - cast(*void)(*instance)) == 0, "WGPUExtent3D.width has unexpected offset % instead of 0", ((cast(*void)(*instance.width)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUExtent3D.width)) == 4, "WGPUExtent3D.width has unexpected size % instead of 4", size_of(type_of(WGPUExtent3D.width)));
        assert(((cast(*void)(*instance.height)) - cast(*void)(*instance)) == 4, "WGPUExtent3D.height has unexpected offset % instead of 4", ((cast(*void)(*instance.height)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUExtent3D.height)) == 4, "WGPUExtent3D.height has unexpected size % instead of 4", size_of(type_of(WGPUExtent3D.height)));
        assert(((cast(*void)(*instance.depthOrArrayLayers)) - cast(*void)(*instance)) == 8, "WGPUExtent3D.depthOrArrayLayers has unexpected offset % instead of 8", ((cast(*void)(*instance.depthOrArrayLayers)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUExtent3D.depthOrArrayLayers)) == 4, "WGPUExtent3D.depthOrArrayLayers has unexpected size % instead of 4", size_of(type_of(WGPUExtent3D.depthOrArrayLayers)));
        assert(size_of(WGPUExtent3D) == 12, "WGPUExtent3D has size % instead of 12", size_of(WGPUExtent3D));
    }

    {
        instance: WGPUInstanceDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUInstanceDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUInstanceDescriptor.nextInChain)) == 8, "WGPUInstanceDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUInstanceDescriptor.nextInChain)));
        assert(size_of(WGPUInstanceDescriptor) == 8, "WGPUInstanceDescriptor has size % instead of 8", size_of(WGPUInstanceDescriptor));
    }

    {
        instance: WGPULimits;
        assert(((cast(*void)(*instance.maxTextureDimension1D)) - cast(*void)(*instance)) == 0, "WGPULimits.maxTextureDimension1D has unexpected offset % instead of 0", ((cast(*void)(*instance.maxTextureDimension1D)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPULimits.maxTextureDimension1D)) == 4, "WGPULimits.maxTextureDimension1D has unexpected size % instead of 4", size_of(type_of(WGPULimits.maxTextureDimension1D)));
        assert(((cast(*void)(*instance.maxTextureDimension2D)) - cast(*void)(*instance)) == 4, "WGPULimits.maxTextureDimension2D has unexpected offset % instead of 4", ((cast(*void)(*instance.maxTextureDimension2D)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPULimits.maxTextureDimension2D)) == 4, "WGPULimits.maxTextureDimension2D has unexpected size % instead of 4", size_of(type_of(WGPULimits.maxTextureDimension2D)));
        assert(((cast(*void)(*instance.maxTextureDimension3D)) - cast(*void)(*instance)) == 8, "WGPULimits.maxTextureDimension3D has unexpected offset % instead of 8", ((cast(*void)(*instance.maxTextureDimension3D)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPULimits.maxTextureDimension3D)) == 4, "WGPULimits.maxTextureDimension3D has unexpected size % instead of 4", size_of(type_of(WGPULimits.maxTextureDimension3D)));
        assert(((cast(*void)(*instance.maxTextureArrayLayers)) - cast(*void)(*instance)) == 12, "WGPULimits.maxTextureArrayLayers has unexpected offset % instead of 12", ((cast(*void)(*instance.maxTextureArrayLayers)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPULimits.maxTextureArrayLayers)) == 4, "WGPULimits.maxTextureArrayLayers has unexpected size % instead of 4", size_of(type_of(WGPULimits.maxTextureArrayLayers)));
        assert(((cast(*void)(*instance.maxBindGroups)) - cast(*void)(*instance)) == 16, "WGPULimits.maxBindGroups has unexpected offset % instead of 16", ((cast(*void)(*instance.maxBindGroups)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPULimits.maxBindGroups)) == 4, "WGPULimits.maxBindGroups has unexpected size % instead of 4", size_of(type_of(WGPULimits.maxBindGroups)));
        assert(((cast(*void)(*instance.maxBindGroupsPlusVertexBuffers)) - cast(*void)(*instance)) == 20, "WGPULimits.maxBindGroupsPlusVertexBuffers has unexpected offset % instead of 20", ((cast(*void)(*instance.maxBindGroupsPlusVertexBuffers)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPULimits.maxBindGroupsPlusVertexBuffers)) == 4, "WGPULimits.maxBindGroupsPlusVertexBuffers has unexpected size % instead of 4", size_of(type_of(WGPULimits.maxBindGroupsPlusVertexBuffers)));
        assert(((cast(*void)(*instance.maxBindingsPerBindGroup)) - cast(*void)(*instance)) == 24, "WGPULimits.maxBindingsPerBindGroup has unexpected offset % instead of 24", ((cast(*void)(*instance.maxBindingsPerBindGroup)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPULimits.maxBindingsPerBindGroup)) == 4, "WGPULimits.maxBindingsPerBindGroup has unexpected size % instead of 4", size_of(type_of(WGPULimits.maxBindingsPerBindGroup)));
        assert(((cast(*void)(*instance.maxDynamicUniformBuffersPerPipelineLayout)) - cast(*void)(*instance)) == 28, "WGPULimits.maxDynamicUniformBuffersPerPipelineLayout has unexpected offset % instead of 28", ((cast(*void)(*instance.maxDynamicUniformBuffersPerPipelineLayout)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPULimits.maxDynamicUniformBuffersPerPipelineLayout)) == 4, "WGPULimits.maxDynamicUniformBuffersPerPipelineLayout has unexpected size % instead of 4", size_of(type_of(WGPULimits.maxDynamicUniformBuffersPerPipelineLayout)));
        assert(((cast(*void)(*instance.maxDynamicStorageBuffersPerPipelineLayout)) - cast(*void)(*instance)) == 32, "WGPULimits.maxDynamicStorageBuffersPerPipelineLayout has unexpected offset % instead of 32", ((cast(*void)(*instance.maxDynamicStorageBuffersPerPipelineLayout)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPULimits.maxDynamicStorageBuffersPerPipelineLayout)) == 4, "WGPULimits.maxDynamicStorageBuffersPerPipelineLayout has unexpected size % instead of 4", size_of(type_of(WGPULimits.maxDynamicStorageBuffersPerPipelineLayout)));
        assert(((cast(*void)(*instance.maxSampledTexturesPerShaderStage)) - cast(*void)(*instance)) == 36, "WGPULimits.maxSampledTexturesPerShaderStage has unexpected offset % instead of 36", ((cast(*void)(*instance.maxSampledTexturesPerShaderStage)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPULimits.maxSampledTexturesPerShaderStage)) == 4, "WGPULimits.maxSampledTexturesPerShaderStage has unexpected size % instead of 4", size_of(type_of(WGPULimits.maxSampledTexturesPerShaderStage)));
        assert(((cast(*void)(*instance.maxSamplersPerShaderStage)) - cast(*void)(*instance)) == 40, "WGPULimits.maxSamplersPerShaderStage has unexpected offset % instead of 40", ((cast(*void)(*instance.maxSamplersPerShaderStage)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPULimits.maxSamplersPerShaderStage)) == 4, "WGPULimits.maxSamplersPerShaderStage has unexpected size % instead of 4", size_of(type_of(WGPULimits.maxSamplersPerShaderStage)));
        assert(((cast(*void)(*instance.maxStorageBuffersPerShaderStage)) - cast(*void)(*instance)) == 44, "WGPULimits.maxStorageBuffersPerShaderStage has unexpected offset % instead of 44", ((cast(*void)(*instance.maxStorageBuffersPerShaderStage)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPULimits.maxStorageBuffersPerShaderStage)) == 4, "WGPULimits.maxStorageBuffersPerShaderStage has unexpected size % instead of 4", size_of(type_of(WGPULimits.maxStorageBuffersPerShaderStage)));
        assert(((cast(*void)(*instance.maxStorageTexturesPerShaderStage)) - cast(*void)(*instance)) == 48, "WGPULimits.maxStorageTexturesPerShaderStage has unexpected offset % instead of 48", ((cast(*void)(*instance.maxStorageTexturesPerShaderStage)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPULimits.maxStorageTexturesPerShaderStage)) == 4, "WGPULimits.maxStorageTexturesPerShaderStage has unexpected size % instead of 4", size_of(type_of(WGPULimits.maxStorageTexturesPerShaderStage)));
        assert(((cast(*void)(*instance.maxUniformBuffersPerShaderStage)) - cast(*void)(*instance)) == 52, "WGPULimits.maxUniformBuffersPerShaderStage has unexpected offset % instead of 52", ((cast(*void)(*instance.maxUniformBuffersPerShaderStage)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPULimits.maxUniformBuffersPerShaderStage)) == 4, "WGPULimits.maxUniformBuffersPerShaderStage has unexpected size % instead of 4", size_of(type_of(WGPULimits.maxUniformBuffersPerShaderStage)));
        assert(((cast(*void)(*instance.maxUniformBufferBindingSize)) - cast(*void)(*instance)) == 56, "WGPULimits.maxUniformBufferBindingSize has unexpected offset % instead of 56", ((cast(*void)(*instance.maxUniformBufferBindingSize)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPULimits.maxUniformBufferBindingSize)) == 8, "WGPULimits.maxUniformBufferBindingSize has unexpected size % instead of 8", size_of(type_of(WGPULimits.maxUniformBufferBindingSize)));
        assert(((cast(*void)(*instance.maxStorageBufferBindingSize)) - cast(*void)(*instance)) == 64, "WGPULimits.maxStorageBufferBindingSize has unexpected offset % instead of 64", ((cast(*void)(*instance.maxStorageBufferBindingSize)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPULimits.maxStorageBufferBindingSize)) == 8, "WGPULimits.maxStorageBufferBindingSize has unexpected size % instead of 8", size_of(type_of(WGPULimits.maxStorageBufferBindingSize)));
        assert(((cast(*void)(*instance.minUniformBufferOffsetAlignment)) - cast(*void)(*instance)) == 72, "WGPULimits.minUniformBufferOffsetAlignment has unexpected offset % instead of 72", ((cast(*void)(*instance.minUniformBufferOffsetAlignment)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPULimits.minUniformBufferOffsetAlignment)) == 4, "WGPULimits.minUniformBufferOffsetAlignment has unexpected size % instead of 4", size_of(type_of(WGPULimits.minUniformBufferOffsetAlignment)));
        assert(((cast(*void)(*instance.minStorageBufferOffsetAlignment)) - cast(*void)(*instance)) == 76, "WGPULimits.minStorageBufferOffsetAlignment has unexpected offset % instead of 76", ((cast(*void)(*instance.minStorageBufferOffsetAlignment)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPULimits.minStorageBufferOffsetAlignment)) == 4, "WGPULimits.minStorageBufferOffsetAlignment has unexpected size % instead of 4", size_of(type_of(WGPULimits.minStorageBufferOffsetAlignment)));
        assert(((cast(*void)(*instance.maxVertexBuffers)) - cast(*void)(*instance)) == 80, "WGPULimits.maxVertexBuffers has unexpected offset % instead of 80", ((cast(*void)(*instance.maxVertexBuffers)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPULimits.maxVertexBuffers)) == 4, "WGPULimits.maxVertexBuffers has unexpected size % instead of 4", size_of(type_of(WGPULimits.maxVertexBuffers)));
        assert(((cast(*void)(*instance.maxBufferSize)) - cast(*void)(*instance)) == 88, "WGPULimits.maxBufferSize has unexpected offset % instead of 88", ((cast(*void)(*instance.maxBufferSize)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPULimits.maxBufferSize)) == 8, "WGPULimits.maxBufferSize has unexpected size % instead of 8", size_of(type_of(WGPULimits.maxBufferSize)));
        assert(((cast(*void)(*instance.maxVertexAttributes)) - cast(*void)(*instance)) == 96, "WGPULimits.maxVertexAttributes has unexpected offset % instead of 96", ((cast(*void)(*instance.maxVertexAttributes)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPULimits.maxVertexAttributes)) == 4, "WGPULimits.maxVertexAttributes has unexpected size % instead of 4", size_of(type_of(WGPULimits.maxVertexAttributes)));
        assert(((cast(*void)(*instance.maxVertexBufferArrayStride)) - cast(*void)(*instance)) == 100, "WGPULimits.maxVertexBufferArrayStride has unexpected offset % instead of 100", ((cast(*void)(*instance.maxVertexBufferArrayStride)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPULimits.maxVertexBufferArrayStride)) == 4, "WGPULimits.maxVertexBufferArrayStride has unexpected size % instead of 4", size_of(type_of(WGPULimits.maxVertexBufferArrayStride)));
        assert(((cast(*void)(*instance.maxInterStageShaderComponents)) - cast(*void)(*instance)) == 104, "WGPULimits.maxInterStageShaderComponents has unexpected offset % instead of 104", ((cast(*void)(*instance.maxInterStageShaderComponents)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPULimits.maxInterStageShaderComponents)) == 4, "WGPULimits.maxInterStageShaderComponents has unexpected size % instead of 4", size_of(type_of(WGPULimits.maxInterStageShaderComponents)));
        assert(((cast(*void)(*instance.maxInterStageShaderVariables)) - cast(*void)(*instance)) == 108, "WGPULimits.maxInterStageShaderVariables has unexpected offset % instead of 108", ((cast(*void)(*instance.maxInterStageShaderVariables)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPULimits.maxInterStageShaderVariables)) == 4, "WGPULimits.maxInterStageShaderVariables has unexpected size % instead of 4", size_of(type_of(WGPULimits.maxInterStageShaderVariables)));
        assert(((cast(*void)(*instance.maxColorAttachments)) - cast(*void)(*instance)) == 112, "WGPULimits.maxColorAttachments has unexpected offset % instead of 112", ((cast(*void)(*instance.maxColorAttachments)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPULimits.maxColorAttachments)) == 4, "WGPULimits.maxColorAttachments has unexpected size % instead of 4", size_of(type_of(WGPULimits.maxColorAttachments)));
        assert(((cast(*void)(*instance.maxColorAttachmentBytesPerSample)) - cast(*void)(*instance)) == 116, "WGPULimits.maxColorAttachmentBytesPerSample has unexpected offset % instead of 116", ((cast(*void)(*instance.maxColorAttachmentBytesPerSample)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPULimits.maxColorAttachmentBytesPerSample)) == 4, "WGPULimits.maxColorAttachmentBytesPerSample has unexpected size % instead of 4", size_of(type_of(WGPULimits.maxColorAttachmentBytesPerSample)));
        assert(((cast(*void)(*instance.maxComputeWorkgroupStorageSize)) - cast(*void)(*instance)) == 120, "WGPULimits.maxComputeWorkgroupStorageSize has unexpected offset % instead of 120", ((cast(*void)(*instance.maxComputeWorkgroupStorageSize)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPULimits.maxComputeWorkgroupStorageSize)) == 4, "WGPULimits.maxComputeWorkgroupStorageSize has unexpected size % instead of 4", size_of(type_of(WGPULimits.maxComputeWorkgroupStorageSize)));
        assert(((cast(*void)(*instance.maxComputeInvocationsPerWorkgroup)) - cast(*void)(*instance)) == 124, "WGPULimits.maxComputeInvocationsPerWorkgroup has unexpected offset % instead of 124", ((cast(*void)(*instance.maxComputeInvocationsPerWorkgroup)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPULimits.maxComputeInvocationsPerWorkgroup)) == 4, "WGPULimits.maxComputeInvocationsPerWorkgroup has unexpected size % instead of 4", size_of(type_of(WGPULimits.maxComputeInvocationsPerWorkgroup)));
        assert(((cast(*void)(*instance.maxComputeWorkgroupSizeX)) - cast(*void)(*instance)) == 128, "WGPULimits.maxComputeWorkgroupSizeX has unexpected offset % instead of 128", ((cast(*void)(*instance.maxComputeWorkgroupSizeX)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPULimits.maxComputeWorkgroupSizeX)) == 4, "WGPULimits.maxComputeWorkgroupSizeX has unexpected size % instead of 4", size_of(type_of(WGPULimits.maxComputeWorkgroupSizeX)));
        assert(((cast(*void)(*instance.maxComputeWorkgroupSizeY)) - cast(*void)(*instance)) == 132, "WGPULimits.maxComputeWorkgroupSizeY has unexpected offset % instead of 132", ((cast(*void)(*instance.maxComputeWorkgroupSizeY)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPULimits.maxComputeWorkgroupSizeY)) == 4, "WGPULimits.maxComputeWorkgroupSizeY has unexpected size % instead of 4", size_of(type_of(WGPULimits.maxComputeWorkgroupSizeY)));
        assert(((cast(*void)(*instance.maxComputeWorkgroupSizeZ)) - cast(*void)(*instance)) == 136, "WGPULimits.maxComputeWorkgroupSizeZ has unexpected offset % instead of 136", ((cast(*void)(*instance.maxComputeWorkgroupSizeZ)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPULimits.maxComputeWorkgroupSizeZ)) == 4, "WGPULimits.maxComputeWorkgroupSizeZ has unexpected size % instead of 4", size_of(type_of(WGPULimits.maxComputeWorkgroupSizeZ)));
        assert(((cast(*void)(*instance.maxComputeWorkgroupsPerDimension)) - cast(*void)(*instance)) == 140, "WGPULimits.maxComputeWorkgroupsPerDimension has unexpected offset % instead of 140", ((cast(*void)(*instance.maxComputeWorkgroupsPerDimension)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPULimits.maxComputeWorkgroupsPerDimension)) == 4, "WGPULimits.maxComputeWorkgroupsPerDimension has unexpected size % instead of 4", size_of(type_of(WGPULimits.maxComputeWorkgroupsPerDimension)));
        assert(size_of(WGPULimits) == 144, "WGPULimits has size % instead of 144", size_of(WGPULimits));
    }

    {
        instance: WGPUMultisampleState;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUMultisampleState.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUMultisampleState.nextInChain)) == 8, "WGPUMultisampleState.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUMultisampleState.nextInChain)));
        assert(((cast(*void)(*instance.count)) - cast(*void)(*instance)) == 8, "WGPUMultisampleState.count has unexpected offset % instead of 8", ((cast(*void)(*instance.count)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUMultisampleState.count)) == 4, "WGPUMultisampleState.count has unexpected size % instead of 4", size_of(type_of(WGPUMultisampleState.count)));
        assert(((cast(*void)(*instance.mask)) - cast(*void)(*instance)) == 12, "WGPUMultisampleState.mask has unexpected offset % instead of 12", ((cast(*void)(*instance.mask)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUMultisampleState.mask)) == 4, "WGPUMultisampleState.mask has unexpected size % instead of 4", size_of(type_of(WGPUMultisampleState.mask)));
        assert(((cast(*void)(*instance.alphaToCoverageEnabled)) - cast(*void)(*instance)) == 16, "WGPUMultisampleState.alphaToCoverageEnabled has unexpected offset % instead of 16", ((cast(*void)(*instance.alphaToCoverageEnabled)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUMultisampleState.alphaToCoverageEnabled)) == 4, "WGPUMultisampleState.alphaToCoverageEnabled has unexpected size % instead of 4", size_of(type_of(WGPUMultisampleState.alphaToCoverageEnabled)));
        assert(size_of(WGPUMultisampleState) == 24, "WGPUMultisampleState has size % instead of 24", size_of(WGPUMultisampleState));
    }

    {
        instance: WGPUOrigin3D;
        assert(((cast(*void)(*instance.x)) - cast(*void)(*instance)) == 0, "WGPUOrigin3D.x has unexpected offset % instead of 0", ((cast(*void)(*instance.x)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUOrigin3D.x)) == 4, "WGPUOrigin3D.x has unexpected size % instead of 4", size_of(type_of(WGPUOrigin3D.x)));
        assert(((cast(*void)(*instance.y)) - cast(*void)(*instance)) == 4, "WGPUOrigin3D.y has unexpected offset % instead of 4", ((cast(*void)(*instance.y)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUOrigin3D.y)) == 4, "WGPUOrigin3D.y has unexpected size % instead of 4", size_of(type_of(WGPUOrigin3D.y)));
        assert(((cast(*void)(*instance.z)) - cast(*void)(*instance)) == 8, "WGPUOrigin3D.z has unexpected offset % instead of 8", ((cast(*void)(*instance.z)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUOrigin3D.z)) == 4, "WGPUOrigin3D.z has unexpected size % instead of 4", size_of(type_of(WGPUOrigin3D.z)));
        assert(size_of(WGPUOrigin3D) == 12, "WGPUOrigin3D has size % instead of 12", size_of(WGPUOrigin3D));
    }

    {
        instance: WGPUPipelineLayoutDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUPipelineLayoutDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUPipelineLayoutDescriptor.nextInChain)) == 8, "WGPUPipelineLayoutDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUPipelineLayoutDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "WGPUPipelineLayoutDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUPipelineLayoutDescriptor.label)) == 8, "WGPUPipelineLayoutDescriptor.label has unexpected size % instead of 8", size_of(type_of(WGPUPipelineLayoutDescriptor.label)));
        assert(((cast(*void)(*instance.bindGroupLayoutCount)) - cast(*void)(*instance)) == 16, "WGPUPipelineLayoutDescriptor.bindGroupLayoutCount has unexpected offset % instead of 16", ((cast(*void)(*instance.bindGroupLayoutCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUPipelineLayoutDescriptor.bindGroupLayoutCount)) == 8, "WGPUPipelineLayoutDescriptor.bindGroupLayoutCount has unexpected size % instead of 8", size_of(type_of(WGPUPipelineLayoutDescriptor.bindGroupLayoutCount)));
        assert(((cast(*void)(*instance.bindGroupLayouts)) - cast(*void)(*instance)) == 24, "WGPUPipelineLayoutDescriptor.bindGroupLayouts has unexpected offset % instead of 24", ((cast(*void)(*instance.bindGroupLayouts)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUPipelineLayoutDescriptor.bindGroupLayouts)) == 8, "WGPUPipelineLayoutDescriptor.bindGroupLayouts has unexpected size % instead of 8", size_of(type_of(WGPUPipelineLayoutDescriptor.bindGroupLayouts)));
        assert(size_of(WGPUPipelineLayoutDescriptor) == 32, "WGPUPipelineLayoutDescriptor has size % instead of 32", size_of(WGPUPipelineLayoutDescriptor));
    }

    {
        instance: WGPUPrimitiveDepthClipControl;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "WGPUPrimitiveDepthClipControl.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUPrimitiveDepthClipControl.chain)) == 16, "WGPUPrimitiveDepthClipControl.chain has unexpected size % instead of 16", size_of(type_of(WGPUPrimitiveDepthClipControl.chain)));
        assert(((cast(*void)(*instance.unclippedDepth)) - cast(*void)(*instance)) == 16, "WGPUPrimitiveDepthClipControl.unclippedDepth has unexpected offset % instead of 16", ((cast(*void)(*instance.unclippedDepth)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUPrimitiveDepthClipControl.unclippedDepth)) == 4, "WGPUPrimitiveDepthClipControl.unclippedDepth has unexpected size % instead of 4", size_of(type_of(WGPUPrimitiveDepthClipControl.unclippedDepth)));
        assert(size_of(WGPUPrimitiveDepthClipControl) == 24, "WGPUPrimitiveDepthClipControl has size % instead of 24", size_of(WGPUPrimitiveDepthClipControl));
    }

    {
        instance: WGPUPrimitiveState;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUPrimitiveState.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUPrimitiveState.nextInChain)) == 8, "WGPUPrimitiveState.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUPrimitiveState.nextInChain)));
        assert(((cast(*void)(*instance.topology)) - cast(*void)(*instance)) == 8, "WGPUPrimitiveState.topology has unexpected offset % instead of 8", ((cast(*void)(*instance.topology)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUPrimitiveState.topology)) == 4, "WGPUPrimitiveState.topology has unexpected size % instead of 4", size_of(type_of(WGPUPrimitiveState.topology)));
        assert(((cast(*void)(*instance.stripIndexFormat)) - cast(*void)(*instance)) == 12, "WGPUPrimitiveState.stripIndexFormat has unexpected offset % instead of 12", ((cast(*void)(*instance.stripIndexFormat)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUPrimitiveState.stripIndexFormat)) == 4, "WGPUPrimitiveState.stripIndexFormat has unexpected size % instead of 4", size_of(type_of(WGPUPrimitiveState.stripIndexFormat)));
        assert(((cast(*void)(*instance.frontFace)) - cast(*void)(*instance)) == 16, "WGPUPrimitiveState.frontFace has unexpected offset % instead of 16", ((cast(*void)(*instance.frontFace)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUPrimitiveState.frontFace)) == 4, "WGPUPrimitiveState.frontFace has unexpected size % instead of 4", size_of(type_of(WGPUPrimitiveState.frontFace)));
        assert(((cast(*void)(*instance.cullMode)) - cast(*void)(*instance)) == 20, "WGPUPrimitiveState.cullMode has unexpected offset % instead of 20", ((cast(*void)(*instance.cullMode)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUPrimitiveState.cullMode)) == 4, "WGPUPrimitiveState.cullMode has unexpected size % instead of 4", size_of(type_of(WGPUPrimitiveState.cullMode)));
        assert(size_of(WGPUPrimitiveState) == 24, "WGPUPrimitiveState has size % instead of 24", size_of(WGPUPrimitiveState));
    }

    {
        instance: WGPUQuerySetDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUQuerySetDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUQuerySetDescriptor.nextInChain)) == 8, "WGPUQuerySetDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUQuerySetDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "WGPUQuerySetDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUQuerySetDescriptor.label)) == 8, "WGPUQuerySetDescriptor.label has unexpected size % instead of 8", size_of(type_of(WGPUQuerySetDescriptor.label)));
        assert(((cast(*void)(*instance.type)) - cast(*void)(*instance)) == 16, "WGPUQuerySetDescriptor.type has unexpected offset % instead of 16", ((cast(*void)(*instance.type)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUQuerySetDescriptor.type)) == 4, "WGPUQuerySetDescriptor.type has unexpected size % instead of 4", size_of(type_of(WGPUQuerySetDescriptor.type)));
        assert(((cast(*void)(*instance.count)) - cast(*void)(*instance)) == 20, "WGPUQuerySetDescriptor.count has unexpected offset % instead of 20", ((cast(*void)(*instance.count)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUQuerySetDescriptor.count)) == 4, "WGPUQuerySetDescriptor.count has unexpected size % instead of 4", size_of(type_of(WGPUQuerySetDescriptor.count)));
        assert(size_of(WGPUQuerySetDescriptor) == 24, "WGPUQuerySetDescriptor has size % instead of 24", size_of(WGPUQuerySetDescriptor));
    }

    {
        instance: WGPUQueueDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUQueueDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUQueueDescriptor.nextInChain)) == 8, "WGPUQueueDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUQueueDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "WGPUQueueDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUQueueDescriptor.label)) == 8, "WGPUQueueDescriptor.label has unexpected size % instead of 8", size_of(type_of(WGPUQueueDescriptor.label)));
        assert(size_of(WGPUQueueDescriptor) == 16, "WGPUQueueDescriptor has size % instead of 16", size_of(WGPUQueueDescriptor));
    }

    {
        instance: WGPURenderBundleDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPURenderBundleDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderBundleDescriptor.nextInChain)) == 8, "WGPURenderBundleDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPURenderBundleDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "WGPURenderBundleDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderBundleDescriptor.label)) == 8, "WGPURenderBundleDescriptor.label has unexpected size % instead of 8", size_of(type_of(WGPURenderBundleDescriptor.label)));
        assert(size_of(WGPURenderBundleDescriptor) == 16, "WGPURenderBundleDescriptor has size % instead of 16", size_of(WGPURenderBundleDescriptor));
    }

    {
        instance: WGPURenderBundleEncoderDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPURenderBundleEncoderDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderBundleEncoderDescriptor.nextInChain)) == 8, "WGPURenderBundleEncoderDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPURenderBundleEncoderDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "WGPURenderBundleEncoderDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderBundleEncoderDescriptor.label)) == 8, "WGPURenderBundleEncoderDescriptor.label has unexpected size % instead of 8", size_of(type_of(WGPURenderBundleEncoderDescriptor.label)));
        assert(((cast(*void)(*instance.colorFormatCount)) - cast(*void)(*instance)) == 16, "WGPURenderBundleEncoderDescriptor.colorFormatCount has unexpected offset % instead of 16", ((cast(*void)(*instance.colorFormatCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderBundleEncoderDescriptor.colorFormatCount)) == 8, "WGPURenderBundleEncoderDescriptor.colorFormatCount has unexpected size % instead of 8", size_of(type_of(WGPURenderBundleEncoderDescriptor.colorFormatCount)));
        assert(((cast(*void)(*instance.colorFormats)) - cast(*void)(*instance)) == 24, "WGPURenderBundleEncoderDescriptor.colorFormats has unexpected offset % instead of 24", ((cast(*void)(*instance.colorFormats)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderBundleEncoderDescriptor.colorFormats)) == 8, "WGPURenderBundleEncoderDescriptor.colorFormats has unexpected size % instead of 8", size_of(type_of(WGPURenderBundleEncoderDescriptor.colorFormats)));
        assert(((cast(*void)(*instance.depthStencilFormat)) - cast(*void)(*instance)) == 32, "WGPURenderBundleEncoderDescriptor.depthStencilFormat has unexpected offset % instead of 32", ((cast(*void)(*instance.depthStencilFormat)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderBundleEncoderDescriptor.depthStencilFormat)) == 4, "WGPURenderBundleEncoderDescriptor.depthStencilFormat has unexpected size % instead of 4", size_of(type_of(WGPURenderBundleEncoderDescriptor.depthStencilFormat)));
        assert(((cast(*void)(*instance.sampleCount)) - cast(*void)(*instance)) == 36, "WGPURenderBundleEncoderDescriptor.sampleCount has unexpected offset % instead of 36", ((cast(*void)(*instance.sampleCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderBundleEncoderDescriptor.sampleCount)) == 4, "WGPURenderBundleEncoderDescriptor.sampleCount has unexpected size % instead of 4", size_of(type_of(WGPURenderBundleEncoderDescriptor.sampleCount)));
        assert(((cast(*void)(*instance.depthReadOnly)) - cast(*void)(*instance)) == 40, "WGPURenderBundleEncoderDescriptor.depthReadOnly has unexpected offset % instead of 40", ((cast(*void)(*instance.depthReadOnly)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderBundleEncoderDescriptor.depthReadOnly)) == 4, "WGPURenderBundleEncoderDescriptor.depthReadOnly has unexpected size % instead of 4", size_of(type_of(WGPURenderBundleEncoderDescriptor.depthReadOnly)));
        assert(((cast(*void)(*instance.stencilReadOnly)) - cast(*void)(*instance)) == 44, "WGPURenderBundleEncoderDescriptor.stencilReadOnly has unexpected offset % instead of 44", ((cast(*void)(*instance.stencilReadOnly)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderBundleEncoderDescriptor.stencilReadOnly)) == 4, "WGPURenderBundleEncoderDescriptor.stencilReadOnly has unexpected size % instead of 4", size_of(type_of(WGPURenderBundleEncoderDescriptor.stencilReadOnly)));
        assert(size_of(WGPURenderBundleEncoderDescriptor) == 48, "WGPURenderBundleEncoderDescriptor has size % instead of 48", size_of(WGPURenderBundleEncoderDescriptor));
    }

    {
        instance: WGPURenderPassDepthStencilAttachment;
        assert(((cast(*void)(*instance.view)) - cast(*void)(*instance)) == 0, "WGPURenderPassDepthStencilAttachment.view has unexpected offset % instead of 0", ((cast(*void)(*instance.view)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderPassDepthStencilAttachment.view)) == 8, "WGPURenderPassDepthStencilAttachment.view has unexpected size % instead of 8", size_of(type_of(WGPURenderPassDepthStencilAttachment.view)));
        assert(((cast(*void)(*instance.depthLoadOp)) - cast(*void)(*instance)) == 8, "WGPURenderPassDepthStencilAttachment.depthLoadOp has unexpected offset % instead of 8", ((cast(*void)(*instance.depthLoadOp)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderPassDepthStencilAttachment.depthLoadOp)) == 4, "WGPURenderPassDepthStencilAttachment.depthLoadOp has unexpected size % instead of 4", size_of(type_of(WGPURenderPassDepthStencilAttachment.depthLoadOp)));
        assert(((cast(*void)(*instance.depthStoreOp)) - cast(*void)(*instance)) == 12, "WGPURenderPassDepthStencilAttachment.depthStoreOp has unexpected offset % instead of 12", ((cast(*void)(*instance.depthStoreOp)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderPassDepthStencilAttachment.depthStoreOp)) == 4, "WGPURenderPassDepthStencilAttachment.depthStoreOp has unexpected size % instead of 4", size_of(type_of(WGPURenderPassDepthStencilAttachment.depthStoreOp)));
        assert(((cast(*void)(*instance.depthClearValue)) - cast(*void)(*instance)) == 16, "WGPURenderPassDepthStencilAttachment.depthClearValue has unexpected offset % instead of 16", ((cast(*void)(*instance.depthClearValue)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderPassDepthStencilAttachment.depthClearValue)) == 4, "WGPURenderPassDepthStencilAttachment.depthClearValue has unexpected size % instead of 4", size_of(type_of(WGPURenderPassDepthStencilAttachment.depthClearValue)));
        assert(((cast(*void)(*instance.depthReadOnly)) - cast(*void)(*instance)) == 20, "WGPURenderPassDepthStencilAttachment.depthReadOnly has unexpected offset % instead of 20", ((cast(*void)(*instance.depthReadOnly)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderPassDepthStencilAttachment.depthReadOnly)) == 4, "WGPURenderPassDepthStencilAttachment.depthReadOnly has unexpected size % instead of 4", size_of(type_of(WGPURenderPassDepthStencilAttachment.depthReadOnly)));
        assert(((cast(*void)(*instance.stencilLoadOp)) - cast(*void)(*instance)) == 24, "WGPURenderPassDepthStencilAttachment.stencilLoadOp has unexpected offset % instead of 24", ((cast(*void)(*instance.stencilLoadOp)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderPassDepthStencilAttachment.stencilLoadOp)) == 4, "WGPURenderPassDepthStencilAttachment.stencilLoadOp has unexpected size % instead of 4", size_of(type_of(WGPURenderPassDepthStencilAttachment.stencilLoadOp)));
        assert(((cast(*void)(*instance.stencilStoreOp)) - cast(*void)(*instance)) == 28, "WGPURenderPassDepthStencilAttachment.stencilStoreOp has unexpected offset % instead of 28", ((cast(*void)(*instance.stencilStoreOp)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderPassDepthStencilAttachment.stencilStoreOp)) == 4, "WGPURenderPassDepthStencilAttachment.stencilStoreOp has unexpected size % instead of 4", size_of(type_of(WGPURenderPassDepthStencilAttachment.stencilStoreOp)));
        assert(((cast(*void)(*instance.stencilClearValue)) - cast(*void)(*instance)) == 32, "WGPURenderPassDepthStencilAttachment.stencilClearValue has unexpected offset % instead of 32", ((cast(*void)(*instance.stencilClearValue)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderPassDepthStencilAttachment.stencilClearValue)) == 4, "WGPURenderPassDepthStencilAttachment.stencilClearValue has unexpected size % instead of 4", size_of(type_of(WGPURenderPassDepthStencilAttachment.stencilClearValue)));
        assert(((cast(*void)(*instance.stencilReadOnly)) - cast(*void)(*instance)) == 36, "WGPURenderPassDepthStencilAttachment.stencilReadOnly has unexpected offset % instead of 36", ((cast(*void)(*instance.stencilReadOnly)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderPassDepthStencilAttachment.stencilReadOnly)) == 4, "WGPURenderPassDepthStencilAttachment.stencilReadOnly has unexpected size % instead of 4", size_of(type_of(WGPURenderPassDepthStencilAttachment.stencilReadOnly)));
        assert(size_of(WGPURenderPassDepthStencilAttachment) == 40, "WGPURenderPassDepthStencilAttachment has size % instead of 40", size_of(WGPURenderPassDepthStencilAttachment));
    }

    {
        instance: WGPURenderPassDescriptorMaxDrawCount;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "WGPURenderPassDescriptorMaxDrawCount.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderPassDescriptorMaxDrawCount.chain)) == 16, "WGPURenderPassDescriptorMaxDrawCount.chain has unexpected size % instead of 16", size_of(type_of(WGPURenderPassDescriptorMaxDrawCount.chain)));
        assert(((cast(*void)(*instance.maxDrawCount)) - cast(*void)(*instance)) == 16, "WGPURenderPassDescriptorMaxDrawCount.maxDrawCount has unexpected offset % instead of 16", ((cast(*void)(*instance.maxDrawCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderPassDescriptorMaxDrawCount.maxDrawCount)) == 8, "WGPURenderPassDescriptorMaxDrawCount.maxDrawCount has unexpected size % instead of 8", size_of(type_of(WGPURenderPassDescriptorMaxDrawCount.maxDrawCount)));
        assert(size_of(WGPURenderPassDescriptorMaxDrawCount) == 24, "WGPURenderPassDescriptorMaxDrawCount has size % instead of 24", size_of(WGPURenderPassDescriptorMaxDrawCount));
    }

    {
        instance: WGPURenderPassTimestampWrites;
        assert(((cast(*void)(*instance.querySet)) - cast(*void)(*instance)) == 0, "WGPURenderPassTimestampWrites.querySet has unexpected offset % instead of 0", ((cast(*void)(*instance.querySet)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderPassTimestampWrites.querySet)) == 8, "WGPURenderPassTimestampWrites.querySet has unexpected size % instead of 8", size_of(type_of(WGPURenderPassTimestampWrites.querySet)));
        assert(((cast(*void)(*instance.beginningOfPassWriteIndex)) - cast(*void)(*instance)) == 8, "WGPURenderPassTimestampWrites.beginningOfPassWriteIndex has unexpected offset % instead of 8", ((cast(*void)(*instance.beginningOfPassWriteIndex)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderPassTimestampWrites.beginningOfPassWriteIndex)) == 4, "WGPURenderPassTimestampWrites.beginningOfPassWriteIndex has unexpected size % instead of 4", size_of(type_of(WGPURenderPassTimestampWrites.beginningOfPassWriteIndex)));
        assert(((cast(*void)(*instance.endOfPassWriteIndex)) - cast(*void)(*instance)) == 12, "WGPURenderPassTimestampWrites.endOfPassWriteIndex has unexpected offset % instead of 12", ((cast(*void)(*instance.endOfPassWriteIndex)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderPassTimestampWrites.endOfPassWriteIndex)) == 4, "WGPURenderPassTimestampWrites.endOfPassWriteIndex has unexpected size % instead of 4", size_of(type_of(WGPURenderPassTimestampWrites.endOfPassWriteIndex)));
        assert(size_of(WGPURenderPassTimestampWrites) == 16, "WGPURenderPassTimestampWrites has size % instead of 16", size_of(WGPURenderPassTimestampWrites));
    }

    {
        instance: WGPURequestAdapterOptions;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPURequestAdapterOptions.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURequestAdapterOptions.nextInChain)) == 8, "WGPURequestAdapterOptions.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPURequestAdapterOptions.nextInChain)));
        assert(((cast(*void)(*instance.compatibleSurface)) - cast(*void)(*instance)) == 8, "WGPURequestAdapterOptions.compatibleSurface has unexpected offset % instead of 8", ((cast(*void)(*instance.compatibleSurface)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURequestAdapterOptions.compatibleSurface)) == 8, "WGPURequestAdapterOptions.compatibleSurface has unexpected size % instead of 8", size_of(type_of(WGPURequestAdapterOptions.compatibleSurface)));
        assert(((cast(*void)(*instance.powerPreference)) - cast(*void)(*instance)) == 16, "WGPURequestAdapterOptions.powerPreference has unexpected offset % instead of 16", ((cast(*void)(*instance.powerPreference)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURequestAdapterOptions.powerPreference)) == 4, "WGPURequestAdapterOptions.powerPreference has unexpected size % instead of 4", size_of(type_of(WGPURequestAdapterOptions.powerPreference)));
        assert(((cast(*void)(*instance.backendType)) - cast(*void)(*instance)) == 20, "WGPURequestAdapterOptions.backendType has unexpected offset % instead of 20", ((cast(*void)(*instance.backendType)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURequestAdapterOptions.backendType)) == 4, "WGPURequestAdapterOptions.backendType has unexpected size % instead of 4", size_of(type_of(WGPURequestAdapterOptions.backendType)));
        assert(((cast(*void)(*instance.forceFallbackAdapter)) - cast(*void)(*instance)) == 24, "WGPURequestAdapterOptions.forceFallbackAdapter has unexpected offset % instead of 24", ((cast(*void)(*instance.forceFallbackAdapter)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURequestAdapterOptions.forceFallbackAdapter)) == 4, "WGPURequestAdapterOptions.forceFallbackAdapter has unexpected size % instead of 4", size_of(type_of(WGPURequestAdapterOptions.forceFallbackAdapter)));
        assert(size_of(WGPURequestAdapterOptions) == 32, "WGPURequestAdapterOptions has size % instead of 32", size_of(WGPURequestAdapterOptions));
    }

    {
        instance: WGPUSamplerBindingLayout;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUSamplerBindingLayout.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSamplerBindingLayout.nextInChain)) == 8, "WGPUSamplerBindingLayout.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUSamplerBindingLayout.nextInChain)));
        assert(((cast(*void)(*instance.type)) - cast(*void)(*instance)) == 8, "WGPUSamplerBindingLayout.type has unexpected offset % instead of 8", ((cast(*void)(*instance.type)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSamplerBindingLayout.type)) == 4, "WGPUSamplerBindingLayout.type has unexpected size % instead of 4", size_of(type_of(WGPUSamplerBindingLayout.type)));
        assert(size_of(WGPUSamplerBindingLayout) == 16, "WGPUSamplerBindingLayout has size % instead of 16", size_of(WGPUSamplerBindingLayout));
    }

    {
        instance: WGPUSamplerDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUSamplerDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSamplerDescriptor.nextInChain)) == 8, "WGPUSamplerDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUSamplerDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "WGPUSamplerDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSamplerDescriptor.label)) == 8, "WGPUSamplerDescriptor.label has unexpected size % instead of 8", size_of(type_of(WGPUSamplerDescriptor.label)));
        assert(((cast(*void)(*instance.addressModeU)) - cast(*void)(*instance)) == 16, "WGPUSamplerDescriptor.addressModeU has unexpected offset % instead of 16", ((cast(*void)(*instance.addressModeU)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSamplerDescriptor.addressModeU)) == 4, "WGPUSamplerDescriptor.addressModeU has unexpected size % instead of 4", size_of(type_of(WGPUSamplerDescriptor.addressModeU)));
        assert(((cast(*void)(*instance.addressModeV)) - cast(*void)(*instance)) == 20, "WGPUSamplerDescriptor.addressModeV has unexpected offset % instead of 20", ((cast(*void)(*instance.addressModeV)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSamplerDescriptor.addressModeV)) == 4, "WGPUSamplerDescriptor.addressModeV has unexpected size % instead of 4", size_of(type_of(WGPUSamplerDescriptor.addressModeV)));
        assert(((cast(*void)(*instance.addressModeW)) - cast(*void)(*instance)) == 24, "WGPUSamplerDescriptor.addressModeW has unexpected offset % instead of 24", ((cast(*void)(*instance.addressModeW)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSamplerDescriptor.addressModeW)) == 4, "WGPUSamplerDescriptor.addressModeW has unexpected size % instead of 4", size_of(type_of(WGPUSamplerDescriptor.addressModeW)));
        assert(((cast(*void)(*instance.magFilter)) - cast(*void)(*instance)) == 28, "WGPUSamplerDescriptor.magFilter has unexpected offset % instead of 28", ((cast(*void)(*instance.magFilter)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSamplerDescriptor.magFilter)) == 4, "WGPUSamplerDescriptor.magFilter has unexpected size % instead of 4", size_of(type_of(WGPUSamplerDescriptor.magFilter)));
        assert(((cast(*void)(*instance.minFilter)) - cast(*void)(*instance)) == 32, "WGPUSamplerDescriptor.minFilter has unexpected offset % instead of 32", ((cast(*void)(*instance.minFilter)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSamplerDescriptor.minFilter)) == 4, "WGPUSamplerDescriptor.minFilter has unexpected size % instead of 4", size_of(type_of(WGPUSamplerDescriptor.minFilter)));
        assert(((cast(*void)(*instance.mipmapFilter)) - cast(*void)(*instance)) == 36, "WGPUSamplerDescriptor.mipmapFilter has unexpected offset % instead of 36", ((cast(*void)(*instance.mipmapFilter)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSamplerDescriptor.mipmapFilter)) == 4, "WGPUSamplerDescriptor.mipmapFilter has unexpected size % instead of 4", size_of(type_of(WGPUSamplerDescriptor.mipmapFilter)));
        assert(((cast(*void)(*instance.lodMinClamp)) - cast(*void)(*instance)) == 40, "WGPUSamplerDescriptor.lodMinClamp has unexpected offset % instead of 40", ((cast(*void)(*instance.lodMinClamp)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSamplerDescriptor.lodMinClamp)) == 4, "WGPUSamplerDescriptor.lodMinClamp has unexpected size % instead of 4", size_of(type_of(WGPUSamplerDescriptor.lodMinClamp)));
        assert(((cast(*void)(*instance.lodMaxClamp)) - cast(*void)(*instance)) == 44, "WGPUSamplerDescriptor.lodMaxClamp has unexpected offset % instead of 44", ((cast(*void)(*instance.lodMaxClamp)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSamplerDescriptor.lodMaxClamp)) == 4, "WGPUSamplerDescriptor.lodMaxClamp has unexpected size % instead of 4", size_of(type_of(WGPUSamplerDescriptor.lodMaxClamp)));
        assert(((cast(*void)(*instance.compare)) - cast(*void)(*instance)) == 48, "WGPUSamplerDescriptor.compare has unexpected offset % instead of 48", ((cast(*void)(*instance.compare)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSamplerDescriptor.compare)) == 4, "WGPUSamplerDescriptor.compare has unexpected size % instead of 4", size_of(type_of(WGPUSamplerDescriptor.compare)));
        assert(((cast(*void)(*instance.maxAnisotropy)) - cast(*void)(*instance)) == 52, "WGPUSamplerDescriptor.maxAnisotropy has unexpected offset % instead of 52", ((cast(*void)(*instance.maxAnisotropy)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSamplerDescriptor.maxAnisotropy)) == 2, "WGPUSamplerDescriptor.maxAnisotropy has unexpected size % instead of 2", size_of(type_of(WGPUSamplerDescriptor.maxAnisotropy)));
        assert(size_of(WGPUSamplerDescriptor) == 56, "WGPUSamplerDescriptor has size % instead of 56", size_of(WGPUSamplerDescriptor));
    }

    {
        instance: WGPUShaderModuleCompilationHint;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUShaderModuleCompilationHint.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUShaderModuleCompilationHint.nextInChain)) == 8, "WGPUShaderModuleCompilationHint.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUShaderModuleCompilationHint.nextInChain)));
        assert(((cast(*void)(*instance.entryPoint)) - cast(*void)(*instance)) == 8, "WGPUShaderModuleCompilationHint.entryPoint has unexpected offset % instead of 8", ((cast(*void)(*instance.entryPoint)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUShaderModuleCompilationHint.entryPoint)) == 8, "WGPUShaderModuleCompilationHint.entryPoint has unexpected size % instead of 8", size_of(type_of(WGPUShaderModuleCompilationHint.entryPoint)));
        assert(((cast(*void)(*instance.layout)) - cast(*void)(*instance)) == 16, "WGPUShaderModuleCompilationHint.layout has unexpected offset % instead of 16", ((cast(*void)(*instance.layout)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUShaderModuleCompilationHint.layout)) == 8, "WGPUShaderModuleCompilationHint.layout has unexpected size % instead of 8", size_of(type_of(WGPUShaderModuleCompilationHint.layout)));
        assert(size_of(WGPUShaderModuleCompilationHint) == 24, "WGPUShaderModuleCompilationHint has size % instead of 24", size_of(WGPUShaderModuleCompilationHint));
    }

    {
        instance: WGPUShaderModuleSPIRVDescriptor;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "WGPUShaderModuleSPIRVDescriptor.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUShaderModuleSPIRVDescriptor.chain)) == 16, "WGPUShaderModuleSPIRVDescriptor.chain has unexpected size % instead of 16", size_of(type_of(WGPUShaderModuleSPIRVDescriptor.chain)));
        assert(((cast(*void)(*instance.codeSize)) - cast(*void)(*instance)) == 16, "WGPUShaderModuleSPIRVDescriptor.codeSize has unexpected offset % instead of 16", ((cast(*void)(*instance.codeSize)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUShaderModuleSPIRVDescriptor.codeSize)) == 4, "WGPUShaderModuleSPIRVDescriptor.codeSize has unexpected size % instead of 4", size_of(type_of(WGPUShaderModuleSPIRVDescriptor.codeSize)));
        assert(((cast(*void)(*instance.code)) - cast(*void)(*instance)) == 24, "WGPUShaderModuleSPIRVDescriptor.code has unexpected offset % instead of 24", ((cast(*void)(*instance.code)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUShaderModuleSPIRVDescriptor.code)) == 8, "WGPUShaderModuleSPIRVDescriptor.code has unexpected size % instead of 8", size_of(type_of(WGPUShaderModuleSPIRVDescriptor.code)));
        assert(size_of(WGPUShaderModuleSPIRVDescriptor) == 32, "WGPUShaderModuleSPIRVDescriptor has size % instead of 32", size_of(WGPUShaderModuleSPIRVDescriptor));
    }

    {
        instance: WGPUShaderModuleWGSLDescriptor;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "WGPUShaderModuleWGSLDescriptor.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUShaderModuleWGSLDescriptor.chain)) == 16, "WGPUShaderModuleWGSLDescriptor.chain has unexpected size % instead of 16", size_of(type_of(WGPUShaderModuleWGSLDescriptor.chain)));
        assert(((cast(*void)(*instance.code)) - cast(*void)(*instance)) == 16, "WGPUShaderModuleWGSLDescriptor.code has unexpected offset % instead of 16", ((cast(*void)(*instance.code)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUShaderModuleWGSLDescriptor.code)) == 8, "WGPUShaderModuleWGSLDescriptor.code has unexpected size % instead of 8", size_of(type_of(WGPUShaderModuleWGSLDescriptor.code)));
        assert(size_of(WGPUShaderModuleWGSLDescriptor) == 24, "WGPUShaderModuleWGSLDescriptor has size % instead of 24", size_of(WGPUShaderModuleWGSLDescriptor));
    }

    {
        instance: WGPUStencilFaceState;
        assert(((cast(*void)(*instance.compare)) - cast(*void)(*instance)) == 0, "WGPUStencilFaceState.compare has unexpected offset % instead of 0", ((cast(*void)(*instance.compare)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUStencilFaceState.compare)) == 4, "WGPUStencilFaceState.compare has unexpected size % instead of 4", size_of(type_of(WGPUStencilFaceState.compare)));
        assert(((cast(*void)(*instance.failOp)) - cast(*void)(*instance)) == 4, "WGPUStencilFaceState.failOp has unexpected offset % instead of 4", ((cast(*void)(*instance.failOp)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUStencilFaceState.failOp)) == 4, "WGPUStencilFaceState.failOp has unexpected size % instead of 4", size_of(type_of(WGPUStencilFaceState.failOp)));
        assert(((cast(*void)(*instance.depthFailOp)) - cast(*void)(*instance)) == 8, "WGPUStencilFaceState.depthFailOp has unexpected offset % instead of 8", ((cast(*void)(*instance.depthFailOp)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUStencilFaceState.depthFailOp)) == 4, "WGPUStencilFaceState.depthFailOp has unexpected size % instead of 4", size_of(type_of(WGPUStencilFaceState.depthFailOp)));
        assert(((cast(*void)(*instance.passOp)) - cast(*void)(*instance)) == 12, "WGPUStencilFaceState.passOp has unexpected offset % instead of 12", ((cast(*void)(*instance.passOp)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUStencilFaceState.passOp)) == 4, "WGPUStencilFaceState.passOp has unexpected size % instead of 4", size_of(type_of(WGPUStencilFaceState.passOp)));
        assert(size_of(WGPUStencilFaceState) == 16, "WGPUStencilFaceState has size % instead of 16", size_of(WGPUStencilFaceState));
    }

    {
        instance: WGPUStorageTextureBindingLayout;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUStorageTextureBindingLayout.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUStorageTextureBindingLayout.nextInChain)) == 8, "WGPUStorageTextureBindingLayout.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUStorageTextureBindingLayout.nextInChain)));
        assert(((cast(*void)(*instance.access)) - cast(*void)(*instance)) == 8, "WGPUStorageTextureBindingLayout.access has unexpected offset % instead of 8", ((cast(*void)(*instance.access)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUStorageTextureBindingLayout.access)) == 4, "WGPUStorageTextureBindingLayout.access has unexpected size % instead of 4", size_of(type_of(WGPUStorageTextureBindingLayout.access)));
        assert(((cast(*void)(*instance.format)) - cast(*void)(*instance)) == 12, "WGPUStorageTextureBindingLayout.format has unexpected offset % instead of 12", ((cast(*void)(*instance.format)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUStorageTextureBindingLayout.format)) == 4, "WGPUStorageTextureBindingLayout.format has unexpected size % instead of 4", size_of(type_of(WGPUStorageTextureBindingLayout.format)));
        assert(((cast(*void)(*instance.viewDimension)) - cast(*void)(*instance)) == 16, "WGPUStorageTextureBindingLayout.viewDimension has unexpected offset % instead of 16", ((cast(*void)(*instance.viewDimension)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUStorageTextureBindingLayout.viewDimension)) == 4, "WGPUStorageTextureBindingLayout.viewDimension has unexpected size % instead of 4", size_of(type_of(WGPUStorageTextureBindingLayout.viewDimension)));
        assert(size_of(WGPUStorageTextureBindingLayout) == 24, "WGPUStorageTextureBindingLayout has size % instead of 24", size_of(WGPUStorageTextureBindingLayout));
    }

    {
        instance: WGPUSurfaceCapabilities;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUSurfaceCapabilities.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceCapabilities.nextInChain)) == 8, "WGPUSurfaceCapabilities.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUSurfaceCapabilities.nextInChain)));
        assert(((cast(*void)(*instance.formatCount)) - cast(*void)(*instance)) == 8, "WGPUSurfaceCapabilities.formatCount has unexpected offset % instead of 8", ((cast(*void)(*instance.formatCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceCapabilities.formatCount)) == 8, "WGPUSurfaceCapabilities.formatCount has unexpected size % instead of 8", size_of(type_of(WGPUSurfaceCapabilities.formatCount)));
        assert(((cast(*void)(*instance.formats)) - cast(*void)(*instance)) == 16, "WGPUSurfaceCapabilities.formats has unexpected offset % instead of 16", ((cast(*void)(*instance.formats)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceCapabilities.formats)) == 8, "WGPUSurfaceCapabilities.formats has unexpected size % instead of 8", size_of(type_of(WGPUSurfaceCapabilities.formats)));
        assert(((cast(*void)(*instance.presentModeCount)) - cast(*void)(*instance)) == 24, "WGPUSurfaceCapabilities.presentModeCount has unexpected offset % instead of 24", ((cast(*void)(*instance.presentModeCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceCapabilities.presentModeCount)) == 8, "WGPUSurfaceCapabilities.presentModeCount has unexpected size % instead of 8", size_of(type_of(WGPUSurfaceCapabilities.presentModeCount)));
        assert(((cast(*void)(*instance.presentModes)) - cast(*void)(*instance)) == 32, "WGPUSurfaceCapabilities.presentModes has unexpected offset % instead of 32", ((cast(*void)(*instance.presentModes)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceCapabilities.presentModes)) == 8, "WGPUSurfaceCapabilities.presentModes has unexpected size % instead of 8", size_of(type_of(WGPUSurfaceCapabilities.presentModes)));
        assert(((cast(*void)(*instance.alphaModeCount)) - cast(*void)(*instance)) == 40, "WGPUSurfaceCapabilities.alphaModeCount has unexpected offset % instead of 40", ((cast(*void)(*instance.alphaModeCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceCapabilities.alphaModeCount)) == 8, "WGPUSurfaceCapabilities.alphaModeCount has unexpected size % instead of 8", size_of(type_of(WGPUSurfaceCapabilities.alphaModeCount)));
        assert(((cast(*void)(*instance.alphaModes)) - cast(*void)(*instance)) == 48, "WGPUSurfaceCapabilities.alphaModes has unexpected offset % instead of 48", ((cast(*void)(*instance.alphaModes)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceCapabilities.alphaModes)) == 8, "WGPUSurfaceCapabilities.alphaModes has unexpected size % instead of 8", size_of(type_of(WGPUSurfaceCapabilities.alphaModes)));
        assert(size_of(WGPUSurfaceCapabilities) == 56, "WGPUSurfaceCapabilities has size % instead of 56", size_of(WGPUSurfaceCapabilities));
    }

    {
        instance: WGPUSurfaceConfiguration;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUSurfaceConfiguration.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceConfiguration.nextInChain)) == 8, "WGPUSurfaceConfiguration.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUSurfaceConfiguration.nextInChain)));
        assert(((cast(*void)(*instance.device)) - cast(*void)(*instance)) == 8, "WGPUSurfaceConfiguration.device has unexpected offset % instead of 8", ((cast(*void)(*instance.device)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceConfiguration.device)) == 8, "WGPUSurfaceConfiguration.device has unexpected size % instead of 8", size_of(type_of(WGPUSurfaceConfiguration.device)));
        assert(((cast(*void)(*instance.format)) - cast(*void)(*instance)) == 16, "WGPUSurfaceConfiguration.format has unexpected offset % instead of 16", ((cast(*void)(*instance.format)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceConfiguration.format)) == 4, "WGPUSurfaceConfiguration.format has unexpected size % instead of 4", size_of(type_of(WGPUSurfaceConfiguration.format)));
        assert(((cast(*void)(*instance.usage)) - cast(*void)(*instance)) == 20, "WGPUSurfaceConfiguration.usage has unexpected offset % instead of 20", ((cast(*void)(*instance.usage)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceConfiguration.usage)) == 4, "WGPUSurfaceConfiguration.usage has unexpected size % instead of 4", size_of(type_of(WGPUSurfaceConfiguration.usage)));
        assert(((cast(*void)(*instance.viewFormatCount)) - cast(*void)(*instance)) == 24, "WGPUSurfaceConfiguration.viewFormatCount has unexpected offset % instead of 24", ((cast(*void)(*instance.viewFormatCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceConfiguration.viewFormatCount)) == 8, "WGPUSurfaceConfiguration.viewFormatCount has unexpected size % instead of 8", size_of(type_of(WGPUSurfaceConfiguration.viewFormatCount)));
        assert(((cast(*void)(*instance.viewFormats)) - cast(*void)(*instance)) == 32, "WGPUSurfaceConfiguration.viewFormats has unexpected offset % instead of 32", ((cast(*void)(*instance.viewFormats)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceConfiguration.viewFormats)) == 8, "WGPUSurfaceConfiguration.viewFormats has unexpected size % instead of 8", size_of(type_of(WGPUSurfaceConfiguration.viewFormats)));
        assert(((cast(*void)(*instance.alphaMode)) - cast(*void)(*instance)) == 40, "WGPUSurfaceConfiguration.alphaMode has unexpected offset % instead of 40", ((cast(*void)(*instance.alphaMode)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceConfiguration.alphaMode)) == 4, "WGPUSurfaceConfiguration.alphaMode has unexpected size % instead of 4", size_of(type_of(WGPUSurfaceConfiguration.alphaMode)));
        assert(((cast(*void)(*instance.width)) - cast(*void)(*instance)) == 44, "WGPUSurfaceConfiguration.width has unexpected offset % instead of 44", ((cast(*void)(*instance.width)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceConfiguration.width)) == 4, "WGPUSurfaceConfiguration.width has unexpected size % instead of 4", size_of(type_of(WGPUSurfaceConfiguration.width)));
        assert(((cast(*void)(*instance.height)) - cast(*void)(*instance)) == 48, "WGPUSurfaceConfiguration.height has unexpected offset % instead of 48", ((cast(*void)(*instance.height)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceConfiguration.height)) == 4, "WGPUSurfaceConfiguration.height has unexpected size % instead of 4", size_of(type_of(WGPUSurfaceConfiguration.height)));
        assert(((cast(*void)(*instance.presentMode)) - cast(*void)(*instance)) == 52, "WGPUSurfaceConfiguration.presentMode has unexpected offset % instead of 52", ((cast(*void)(*instance.presentMode)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceConfiguration.presentMode)) == 4, "WGPUSurfaceConfiguration.presentMode has unexpected size % instead of 4", size_of(type_of(WGPUSurfaceConfiguration.presentMode)));
        assert(size_of(WGPUSurfaceConfiguration) == 56, "WGPUSurfaceConfiguration has size % instead of 56", size_of(WGPUSurfaceConfiguration));
    }

    {
        instance: WGPUSurfaceDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUSurfaceDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceDescriptor.nextInChain)) == 8, "WGPUSurfaceDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUSurfaceDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "WGPUSurfaceDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceDescriptor.label)) == 8, "WGPUSurfaceDescriptor.label has unexpected size % instead of 8", size_of(type_of(WGPUSurfaceDescriptor.label)));
        assert(size_of(WGPUSurfaceDescriptor) == 16, "WGPUSurfaceDescriptor has size % instead of 16", size_of(WGPUSurfaceDescriptor));
    }

    {
        instance: WGPUSurfaceDescriptorFromAndroidNativeWindow;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "WGPUSurfaceDescriptorFromAndroidNativeWindow.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceDescriptorFromAndroidNativeWindow.chain)) == 16, "WGPUSurfaceDescriptorFromAndroidNativeWindow.chain has unexpected size % instead of 16", size_of(type_of(WGPUSurfaceDescriptorFromAndroidNativeWindow.chain)));
        assert(((cast(*void)(*instance.window)) - cast(*void)(*instance)) == 16, "WGPUSurfaceDescriptorFromAndroidNativeWindow.window has unexpected offset % instead of 16", ((cast(*void)(*instance.window)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceDescriptorFromAndroidNativeWindow.window)) == 8, "WGPUSurfaceDescriptorFromAndroidNativeWindow.window has unexpected size % instead of 8", size_of(type_of(WGPUSurfaceDescriptorFromAndroidNativeWindow.window)));
        assert(size_of(WGPUSurfaceDescriptorFromAndroidNativeWindow) == 24, "WGPUSurfaceDescriptorFromAndroidNativeWindow has size % instead of 24", size_of(WGPUSurfaceDescriptorFromAndroidNativeWindow));
    }

    {
        instance: WGPUSurfaceDescriptorFromCanvasHTMLSelector;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "WGPUSurfaceDescriptorFromCanvasHTMLSelector.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceDescriptorFromCanvasHTMLSelector.chain)) == 16, "WGPUSurfaceDescriptorFromCanvasHTMLSelector.chain has unexpected size % instead of 16", size_of(type_of(WGPUSurfaceDescriptorFromCanvasHTMLSelector.chain)));
        assert(((cast(*void)(*instance.selector)) - cast(*void)(*instance)) == 16, "WGPUSurfaceDescriptorFromCanvasHTMLSelector.selector has unexpected offset % instead of 16", ((cast(*void)(*instance.selector)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceDescriptorFromCanvasHTMLSelector.selector)) == 8, "WGPUSurfaceDescriptorFromCanvasHTMLSelector.selector has unexpected size % instead of 8", size_of(type_of(WGPUSurfaceDescriptorFromCanvasHTMLSelector.selector)));
        assert(size_of(WGPUSurfaceDescriptorFromCanvasHTMLSelector) == 24, "WGPUSurfaceDescriptorFromCanvasHTMLSelector has size % instead of 24", size_of(WGPUSurfaceDescriptorFromCanvasHTMLSelector));
    }

    {
        instance: WGPUSurfaceDescriptorFromMetalLayer;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "WGPUSurfaceDescriptorFromMetalLayer.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceDescriptorFromMetalLayer.chain)) == 16, "WGPUSurfaceDescriptorFromMetalLayer.chain has unexpected size % instead of 16", size_of(type_of(WGPUSurfaceDescriptorFromMetalLayer.chain)));
        assert(((cast(*void)(*instance.layer)) - cast(*void)(*instance)) == 16, "WGPUSurfaceDescriptorFromMetalLayer.layer has unexpected offset % instead of 16", ((cast(*void)(*instance.layer)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceDescriptorFromMetalLayer.layer)) == 8, "WGPUSurfaceDescriptorFromMetalLayer.layer has unexpected size % instead of 8", size_of(type_of(WGPUSurfaceDescriptorFromMetalLayer.layer)));
        assert(size_of(WGPUSurfaceDescriptorFromMetalLayer) == 24, "WGPUSurfaceDescriptorFromMetalLayer has size % instead of 24", size_of(WGPUSurfaceDescriptorFromMetalLayer));
    }

    {
        instance: WGPUSurfaceDescriptorFromWaylandSurface;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "WGPUSurfaceDescriptorFromWaylandSurface.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceDescriptorFromWaylandSurface.chain)) == 16, "WGPUSurfaceDescriptorFromWaylandSurface.chain has unexpected size % instead of 16", size_of(type_of(WGPUSurfaceDescriptorFromWaylandSurface.chain)));
        assert(((cast(*void)(*instance.display)) - cast(*void)(*instance)) == 16, "WGPUSurfaceDescriptorFromWaylandSurface.display has unexpected offset % instead of 16", ((cast(*void)(*instance.display)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceDescriptorFromWaylandSurface.display)) == 8, "WGPUSurfaceDescriptorFromWaylandSurface.display has unexpected size % instead of 8", size_of(type_of(WGPUSurfaceDescriptorFromWaylandSurface.display)));
        assert(((cast(*void)(*instance.surface)) - cast(*void)(*instance)) == 24, "WGPUSurfaceDescriptorFromWaylandSurface.surface has unexpected offset % instead of 24", ((cast(*void)(*instance.surface)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceDescriptorFromWaylandSurface.surface)) == 8, "WGPUSurfaceDescriptorFromWaylandSurface.surface has unexpected size % instead of 8", size_of(type_of(WGPUSurfaceDescriptorFromWaylandSurface.surface)));
        assert(size_of(WGPUSurfaceDescriptorFromWaylandSurface) == 32, "WGPUSurfaceDescriptorFromWaylandSurface has size % instead of 32", size_of(WGPUSurfaceDescriptorFromWaylandSurface));
    }

    {
        instance: WGPUSurfaceDescriptorFromWindowsHWND;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "WGPUSurfaceDescriptorFromWindowsHWND.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceDescriptorFromWindowsHWND.chain)) == 16, "WGPUSurfaceDescriptorFromWindowsHWND.chain has unexpected size % instead of 16", size_of(type_of(WGPUSurfaceDescriptorFromWindowsHWND.chain)));
        assert(((cast(*void)(*instance.hinstance)) - cast(*void)(*instance)) == 16, "WGPUSurfaceDescriptorFromWindowsHWND.hinstance has unexpected offset % instead of 16", ((cast(*void)(*instance.hinstance)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceDescriptorFromWindowsHWND.hinstance)) == 8, "WGPUSurfaceDescriptorFromWindowsHWND.hinstance has unexpected size % instead of 8", size_of(type_of(WGPUSurfaceDescriptorFromWindowsHWND.hinstance)));
        assert(((cast(*void)(*instance.hwnd)) - cast(*void)(*instance)) == 24, "WGPUSurfaceDescriptorFromWindowsHWND.hwnd has unexpected offset % instead of 24", ((cast(*void)(*instance.hwnd)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceDescriptorFromWindowsHWND.hwnd)) == 8, "WGPUSurfaceDescriptorFromWindowsHWND.hwnd has unexpected size % instead of 8", size_of(type_of(WGPUSurfaceDescriptorFromWindowsHWND.hwnd)));
        assert(size_of(WGPUSurfaceDescriptorFromWindowsHWND) == 32, "WGPUSurfaceDescriptorFromWindowsHWND has size % instead of 32", size_of(WGPUSurfaceDescriptorFromWindowsHWND));
    }

    {
        instance: WGPUSurfaceDescriptorFromXcbWindow;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "WGPUSurfaceDescriptorFromXcbWindow.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceDescriptorFromXcbWindow.chain)) == 16, "WGPUSurfaceDescriptorFromXcbWindow.chain has unexpected size % instead of 16", size_of(type_of(WGPUSurfaceDescriptorFromXcbWindow.chain)));
        assert(((cast(*void)(*instance.connection)) - cast(*void)(*instance)) == 16, "WGPUSurfaceDescriptorFromXcbWindow.connection has unexpected offset % instead of 16", ((cast(*void)(*instance.connection)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceDescriptorFromXcbWindow.connection)) == 8, "WGPUSurfaceDescriptorFromXcbWindow.connection has unexpected size % instead of 8", size_of(type_of(WGPUSurfaceDescriptorFromXcbWindow.connection)));
        assert(((cast(*void)(*instance.window)) - cast(*void)(*instance)) == 24, "WGPUSurfaceDescriptorFromXcbWindow.window has unexpected offset % instead of 24", ((cast(*void)(*instance.window)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceDescriptorFromXcbWindow.window)) == 4, "WGPUSurfaceDescriptorFromXcbWindow.window has unexpected size % instead of 4", size_of(type_of(WGPUSurfaceDescriptorFromXcbWindow.window)));
        assert(size_of(WGPUSurfaceDescriptorFromXcbWindow) == 32, "WGPUSurfaceDescriptorFromXcbWindow has size % instead of 32", size_of(WGPUSurfaceDescriptorFromXcbWindow));
    }

    {
        instance: WGPUSurfaceDescriptorFromXlibWindow;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "WGPUSurfaceDescriptorFromXlibWindow.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceDescriptorFromXlibWindow.chain)) == 16, "WGPUSurfaceDescriptorFromXlibWindow.chain has unexpected size % instead of 16", size_of(type_of(WGPUSurfaceDescriptorFromXlibWindow.chain)));
        assert(((cast(*void)(*instance.display)) - cast(*void)(*instance)) == 16, "WGPUSurfaceDescriptorFromXlibWindow.display has unexpected offset % instead of 16", ((cast(*void)(*instance.display)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceDescriptorFromXlibWindow.display)) == 8, "WGPUSurfaceDescriptorFromXlibWindow.display has unexpected size % instead of 8", size_of(type_of(WGPUSurfaceDescriptorFromXlibWindow.display)));
        assert(((cast(*void)(*instance.window)) - cast(*void)(*instance)) == 24, "WGPUSurfaceDescriptorFromXlibWindow.window has unexpected offset % instead of 24", ((cast(*void)(*instance.window)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceDescriptorFromXlibWindow.window)) == 8, "WGPUSurfaceDescriptorFromXlibWindow.window has unexpected size % instead of 8", size_of(type_of(WGPUSurfaceDescriptorFromXlibWindow.window)));
        assert(size_of(WGPUSurfaceDescriptorFromXlibWindow) == 32, "WGPUSurfaceDescriptorFromXlibWindow has size % instead of 32", size_of(WGPUSurfaceDescriptorFromXlibWindow));
    }

    {
        instance: WGPUSurfaceTexture;
        assert(((cast(*void)(*instance.texture)) - cast(*void)(*instance)) == 0, "WGPUSurfaceTexture.texture has unexpected offset % instead of 0", ((cast(*void)(*instance.texture)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceTexture.texture)) == 8, "WGPUSurfaceTexture.texture has unexpected size % instead of 8", size_of(type_of(WGPUSurfaceTexture.texture)));
        assert(((cast(*void)(*instance.suboptimal)) - cast(*void)(*instance)) == 8, "WGPUSurfaceTexture.suboptimal has unexpected offset % instead of 8", ((cast(*void)(*instance.suboptimal)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceTexture.suboptimal)) == 4, "WGPUSurfaceTexture.suboptimal has unexpected size % instead of 4", size_of(type_of(WGPUSurfaceTexture.suboptimal)));
        assert(((cast(*void)(*instance.status)) - cast(*void)(*instance)) == 12, "WGPUSurfaceTexture.status has unexpected offset % instead of 12", ((cast(*void)(*instance.status)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceTexture.status)) == 4, "WGPUSurfaceTexture.status has unexpected size % instead of 4", size_of(type_of(WGPUSurfaceTexture.status)));
        assert(size_of(WGPUSurfaceTexture) == 16, "WGPUSurfaceTexture has size % instead of 16", size_of(WGPUSurfaceTexture));
    }

    {
        instance: WGPUTextureBindingLayout;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUTextureBindingLayout.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUTextureBindingLayout.nextInChain)) == 8, "WGPUTextureBindingLayout.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUTextureBindingLayout.nextInChain)));
        assert(((cast(*void)(*instance.sampleType)) - cast(*void)(*instance)) == 8, "WGPUTextureBindingLayout.sampleType has unexpected offset % instead of 8", ((cast(*void)(*instance.sampleType)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUTextureBindingLayout.sampleType)) == 4, "WGPUTextureBindingLayout.sampleType has unexpected size % instead of 4", size_of(type_of(WGPUTextureBindingLayout.sampleType)));
        assert(((cast(*void)(*instance.viewDimension)) - cast(*void)(*instance)) == 12, "WGPUTextureBindingLayout.viewDimension has unexpected offset % instead of 12", ((cast(*void)(*instance.viewDimension)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUTextureBindingLayout.viewDimension)) == 4, "WGPUTextureBindingLayout.viewDimension has unexpected size % instead of 4", size_of(type_of(WGPUTextureBindingLayout.viewDimension)));
        assert(((cast(*void)(*instance.multisampled)) - cast(*void)(*instance)) == 16, "WGPUTextureBindingLayout.multisampled has unexpected offset % instead of 16", ((cast(*void)(*instance.multisampled)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUTextureBindingLayout.multisampled)) == 4, "WGPUTextureBindingLayout.multisampled has unexpected size % instead of 4", size_of(type_of(WGPUTextureBindingLayout.multisampled)));
        assert(size_of(WGPUTextureBindingLayout) == 24, "WGPUTextureBindingLayout has size % instead of 24", size_of(WGPUTextureBindingLayout));
    }

    {
        instance: WGPUTextureDataLayout;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUTextureDataLayout.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUTextureDataLayout.nextInChain)) == 8, "WGPUTextureDataLayout.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUTextureDataLayout.nextInChain)));
        assert(((cast(*void)(*instance.offset)) - cast(*void)(*instance)) == 8, "WGPUTextureDataLayout.offset has unexpected offset % instead of 8", ((cast(*void)(*instance.offset)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUTextureDataLayout.offset)) == 8, "WGPUTextureDataLayout.offset has unexpected size % instead of 8", size_of(type_of(WGPUTextureDataLayout.offset)));
        assert(((cast(*void)(*instance.bytesPerRow)) - cast(*void)(*instance)) == 16, "WGPUTextureDataLayout.bytesPerRow has unexpected offset % instead of 16", ((cast(*void)(*instance.bytesPerRow)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUTextureDataLayout.bytesPerRow)) == 4, "WGPUTextureDataLayout.bytesPerRow has unexpected size % instead of 4", size_of(type_of(WGPUTextureDataLayout.bytesPerRow)));
        assert(((cast(*void)(*instance.rowsPerImage)) - cast(*void)(*instance)) == 20, "WGPUTextureDataLayout.rowsPerImage has unexpected offset % instead of 20", ((cast(*void)(*instance.rowsPerImage)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUTextureDataLayout.rowsPerImage)) == 4, "WGPUTextureDataLayout.rowsPerImage has unexpected size % instead of 4", size_of(type_of(WGPUTextureDataLayout.rowsPerImage)));
        assert(size_of(WGPUTextureDataLayout) == 24, "WGPUTextureDataLayout has size % instead of 24", size_of(WGPUTextureDataLayout));
    }

    {
        instance: WGPUTextureViewDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUTextureViewDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUTextureViewDescriptor.nextInChain)) == 8, "WGPUTextureViewDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUTextureViewDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "WGPUTextureViewDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUTextureViewDescriptor.label)) == 8, "WGPUTextureViewDescriptor.label has unexpected size % instead of 8", size_of(type_of(WGPUTextureViewDescriptor.label)));
        assert(((cast(*void)(*instance.format)) - cast(*void)(*instance)) == 16, "WGPUTextureViewDescriptor.format has unexpected offset % instead of 16", ((cast(*void)(*instance.format)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUTextureViewDescriptor.format)) == 4, "WGPUTextureViewDescriptor.format has unexpected size % instead of 4", size_of(type_of(WGPUTextureViewDescriptor.format)));
        assert(((cast(*void)(*instance.dimension)) - cast(*void)(*instance)) == 20, "WGPUTextureViewDescriptor.dimension has unexpected offset % instead of 20", ((cast(*void)(*instance.dimension)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUTextureViewDescriptor.dimension)) == 4, "WGPUTextureViewDescriptor.dimension has unexpected size % instead of 4", size_of(type_of(WGPUTextureViewDescriptor.dimension)));
        assert(((cast(*void)(*instance.baseMipLevel)) - cast(*void)(*instance)) == 24, "WGPUTextureViewDescriptor.baseMipLevel has unexpected offset % instead of 24", ((cast(*void)(*instance.baseMipLevel)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUTextureViewDescriptor.baseMipLevel)) == 4, "WGPUTextureViewDescriptor.baseMipLevel has unexpected size % instead of 4", size_of(type_of(WGPUTextureViewDescriptor.baseMipLevel)));
        assert(((cast(*void)(*instance.mipLevelCount)) - cast(*void)(*instance)) == 28, "WGPUTextureViewDescriptor.mipLevelCount has unexpected offset % instead of 28", ((cast(*void)(*instance.mipLevelCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUTextureViewDescriptor.mipLevelCount)) == 4, "WGPUTextureViewDescriptor.mipLevelCount has unexpected size % instead of 4", size_of(type_of(WGPUTextureViewDescriptor.mipLevelCount)));
        assert(((cast(*void)(*instance.baseArrayLayer)) - cast(*void)(*instance)) == 32, "WGPUTextureViewDescriptor.baseArrayLayer has unexpected offset % instead of 32", ((cast(*void)(*instance.baseArrayLayer)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUTextureViewDescriptor.baseArrayLayer)) == 4, "WGPUTextureViewDescriptor.baseArrayLayer has unexpected size % instead of 4", size_of(type_of(WGPUTextureViewDescriptor.baseArrayLayer)));
        assert(((cast(*void)(*instance.arrayLayerCount)) - cast(*void)(*instance)) == 36, "WGPUTextureViewDescriptor.arrayLayerCount has unexpected offset % instead of 36", ((cast(*void)(*instance.arrayLayerCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUTextureViewDescriptor.arrayLayerCount)) == 4, "WGPUTextureViewDescriptor.arrayLayerCount has unexpected size % instead of 4", size_of(type_of(WGPUTextureViewDescriptor.arrayLayerCount)));
        assert(((cast(*void)(*instance.aspect)) - cast(*void)(*instance)) == 40, "WGPUTextureViewDescriptor.aspect has unexpected offset % instead of 40", ((cast(*void)(*instance.aspect)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUTextureViewDescriptor.aspect)) == 4, "WGPUTextureViewDescriptor.aspect has unexpected size % instead of 4", size_of(type_of(WGPUTextureViewDescriptor.aspect)));
        assert(size_of(WGPUTextureViewDescriptor) == 48, "WGPUTextureViewDescriptor has size % instead of 48", size_of(WGPUTextureViewDescriptor));
    }

    {
        instance: WGPUVertexAttribute;
        assert(((cast(*void)(*instance.format)) - cast(*void)(*instance)) == 0, "WGPUVertexAttribute.format has unexpected offset % instead of 0", ((cast(*void)(*instance.format)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUVertexAttribute.format)) == 4, "WGPUVertexAttribute.format has unexpected size % instead of 4", size_of(type_of(WGPUVertexAttribute.format)));
        assert(((cast(*void)(*instance.offset)) - cast(*void)(*instance)) == 8, "WGPUVertexAttribute.offset has unexpected offset % instead of 8", ((cast(*void)(*instance.offset)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUVertexAttribute.offset)) == 8, "WGPUVertexAttribute.offset has unexpected size % instead of 8", size_of(type_of(WGPUVertexAttribute.offset)));
        assert(((cast(*void)(*instance.shaderLocation)) - cast(*void)(*instance)) == 16, "WGPUVertexAttribute.shaderLocation has unexpected offset % instead of 16", ((cast(*void)(*instance.shaderLocation)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUVertexAttribute.shaderLocation)) == 4, "WGPUVertexAttribute.shaderLocation has unexpected size % instead of 4", size_of(type_of(WGPUVertexAttribute.shaderLocation)));
        assert(size_of(WGPUVertexAttribute) == 24, "WGPUVertexAttribute has size % instead of 24", size_of(WGPUVertexAttribute));
    }

    {
        instance: WGPUBindGroupDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUBindGroupDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBindGroupDescriptor.nextInChain)) == 8, "WGPUBindGroupDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUBindGroupDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "WGPUBindGroupDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBindGroupDescriptor.label)) == 8, "WGPUBindGroupDescriptor.label has unexpected size % instead of 8", size_of(type_of(WGPUBindGroupDescriptor.label)));
        assert(((cast(*void)(*instance.layout)) - cast(*void)(*instance)) == 16, "WGPUBindGroupDescriptor.layout has unexpected offset % instead of 16", ((cast(*void)(*instance.layout)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBindGroupDescriptor.layout)) == 8, "WGPUBindGroupDescriptor.layout has unexpected size % instead of 8", size_of(type_of(WGPUBindGroupDescriptor.layout)));
        assert(((cast(*void)(*instance.entryCount)) - cast(*void)(*instance)) == 24, "WGPUBindGroupDescriptor.entryCount has unexpected offset % instead of 24", ((cast(*void)(*instance.entryCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBindGroupDescriptor.entryCount)) == 8, "WGPUBindGroupDescriptor.entryCount has unexpected size % instead of 8", size_of(type_of(WGPUBindGroupDescriptor.entryCount)));
        assert(((cast(*void)(*instance.entries)) - cast(*void)(*instance)) == 32, "WGPUBindGroupDescriptor.entries has unexpected offset % instead of 32", ((cast(*void)(*instance.entries)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBindGroupDescriptor.entries)) == 8, "WGPUBindGroupDescriptor.entries has unexpected size % instead of 8", size_of(type_of(WGPUBindGroupDescriptor.entries)));
        assert(size_of(WGPUBindGroupDescriptor) == 40, "WGPUBindGroupDescriptor has size % instead of 40", size_of(WGPUBindGroupDescriptor));
    }

    {
        instance: WGPUBindGroupLayoutEntry;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUBindGroupLayoutEntry.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBindGroupLayoutEntry.nextInChain)) == 8, "WGPUBindGroupLayoutEntry.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUBindGroupLayoutEntry.nextInChain)));
        assert(((cast(*void)(*instance.binding)) - cast(*void)(*instance)) == 8, "WGPUBindGroupLayoutEntry.binding has unexpected offset % instead of 8", ((cast(*void)(*instance.binding)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBindGroupLayoutEntry.binding)) == 4, "WGPUBindGroupLayoutEntry.binding has unexpected size % instead of 4", size_of(type_of(WGPUBindGroupLayoutEntry.binding)));
        assert(((cast(*void)(*instance.visibility)) - cast(*void)(*instance)) == 12, "WGPUBindGroupLayoutEntry.visibility has unexpected offset % instead of 12", ((cast(*void)(*instance.visibility)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBindGroupLayoutEntry.visibility)) == 4, "WGPUBindGroupLayoutEntry.visibility has unexpected size % instead of 4", size_of(type_of(WGPUBindGroupLayoutEntry.visibility)));
        assert(((cast(*void)(*instance.buffer)) - cast(*void)(*instance)) == 16, "WGPUBindGroupLayoutEntry.buffer has unexpected offset % instead of 16", ((cast(*void)(*instance.buffer)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBindGroupLayoutEntry.buffer)) == 24, "WGPUBindGroupLayoutEntry.buffer has unexpected size % instead of 24", size_of(type_of(WGPUBindGroupLayoutEntry.buffer)));
        assert(((cast(*void)(*instance.sampler)) - cast(*void)(*instance)) == 40, "WGPUBindGroupLayoutEntry.sampler has unexpected offset % instead of 40", ((cast(*void)(*instance.sampler)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBindGroupLayoutEntry.sampler)) == 16, "WGPUBindGroupLayoutEntry.sampler has unexpected size % instead of 16", size_of(type_of(WGPUBindGroupLayoutEntry.sampler)));
        assert(((cast(*void)(*instance.texture)) - cast(*void)(*instance)) == 56, "WGPUBindGroupLayoutEntry.texture has unexpected offset % instead of 56", ((cast(*void)(*instance.texture)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBindGroupLayoutEntry.texture)) == 24, "WGPUBindGroupLayoutEntry.texture has unexpected size % instead of 24", size_of(type_of(WGPUBindGroupLayoutEntry.texture)));
        assert(((cast(*void)(*instance.storageTexture)) - cast(*void)(*instance)) == 80, "WGPUBindGroupLayoutEntry.storageTexture has unexpected offset % instead of 80", ((cast(*void)(*instance.storageTexture)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBindGroupLayoutEntry.storageTexture)) == 24, "WGPUBindGroupLayoutEntry.storageTexture has unexpected size % instead of 24", size_of(type_of(WGPUBindGroupLayoutEntry.storageTexture)));
        assert(size_of(WGPUBindGroupLayoutEntry) == 104, "WGPUBindGroupLayoutEntry has size % instead of 104", size_of(WGPUBindGroupLayoutEntry));
    }

    {
        instance: WGPUBlendState;
        assert(((cast(*void)(*instance.color)) - cast(*void)(*instance)) == 0, "WGPUBlendState.color has unexpected offset % instead of 0", ((cast(*void)(*instance.color)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBlendState.color)) == 12, "WGPUBlendState.color has unexpected size % instead of 12", size_of(type_of(WGPUBlendState.color)));
        assert(((cast(*void)(*instance.alpha)) - cast(*void)(*instance)) == 12, "WGPUBlendState.alpha has unexpected offset % instead of 12", ((cast(*void)(*instance.alpha)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBlendState.alpha)) == 12, "WGPUBlendState.alpha has unexpected size % instead of 12", size_of(type_of(WGPUBlendState.alpha)));
        assert(size_of(WGPUBlendState) == 24, "WGPUBlendState has size % instead of 24", size_of(WGPUBlendState));
    }

    {
        instance: WGPUCompilationInfo;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUCompilationInfo.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUCompilationInfo.nextInChain)) == 8, "WGPUCompilationInfo.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUCompilationInfo.nextInChain)));
        assert(((cast(*void)(*instance.messageCount)) - cast(*void)(*instance)) == 8, "WGPUCompilationInfo.messageCount has unexpected offset % instead of 8", ((cast(*void)(*instance.messageCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUCompilationInfo.messageCount)) == 8, "WGPUCompilationInfo.messageCount has unexpected size % instead of 8", size_of(type_of(WGPUCompilationInfo.messageCount)));
        assert(((cast(*void)(*instance.messages)) - cast(*void)(*instance)) == 16, "WGPUCompilationInfo.messages has unexpected offset % instead of 16", ((cast(*void)(*instance.messages)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUCompilationInfo.messages)) == 8, "WGPUCompilationInfo.messages has unexpected size % instead of 8", size_of(type_of(WGPUCompilationInfo.messages)));
        assert(size_of(WGPUCompilationInfo) == 24, "WGPUCompilationInfo has size % instead of 24", size_of(WGPUCompilationInfo));
    }

    {
        instance: WGPUComputePassDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUComputePassDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUComputePassDescriptor.nextInChain)) == 8, "WGPUComputePassDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUComputePassDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "WGPUComputePassDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUComputePassDescriptor.label)) == 8, "WGPUComputePassDescriptor.label has unexpected size % instead of 8", size_of(type_of(WGPUComputePassDescriptor.label)));
        assert(((cast(*void)(*instance.timestampWrites)) - cast(*void)(*instance)) == 16, "WGPUComputePassDescriptor.timestampWrites has unexpected offset % instead of 16", ((cast(*void)(*instance.timestampWrites)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUComputePassDescriptor.timestampWrites)) == 8, "WGPUComputePassDescriptor.timestampWrites has unexpected size % instead of 8", size_of(type_of(WGPUComputePassDescriptor.timestampWrites)));
        assert(size_of(WGPUComputePassDescriptor) == 24, "WGPUComputePassDescriptor has size % instead of 24", size_of(WGPUComputePassDescriptor));
    }

    {
        instance: WGPUDepthStencilState;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUDepthStencilState.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUDepthStencilState.nextInChain)) == 8, "WGPUDepthStencilState.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUDepthStencilState.nextInChain)));
        assert(((cast(*void)(*instance.format)) - cast(*void)(*instance)) == 8, "WGPUDepthStencilState.format has unexpected offset % instead of 8", ((cast(*void)(*instance.format)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUDepthStencilState.format)) == 4, "WGPUDepthStencilState.format has unexpected size % instead of 4", size_of(type_of(WGPUDepthStencilState.format)));
        assert(((cast(*void)(*instance.depthWriteEnabled)) - cast(*void)(*instance)) == 12, "WGPUDepthStencilState.depthWriteEnabled has unexpected offset % instead of 12", ((cast(*void)(*instance.depthWriteEnabled)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUDepthStencilState.depthWriteEnabled)) == 4, "WGPUDepthStencilState.depthWriteEnabled has unexpected size % instead of 4", size_of(type_of(WGPUDepthStencilState.depthWriteEnabled)));
        assert(((cast(*void)(*instance.depthCompare)) - cast(*void)(*instance)) == 16, "WGPUDepthStencilState.depthCompare has unexpected offset % instead of 16", ((cast(*void)(*instance.depthCompare)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUDepthStencilState.depthCompare)) == 4, "WGPUDepthStencilState.depthCompare has unexpected size % instead of 4", size_of(type_of(WGPUDepthStencilState.depthCompare)));
        assert(((cast(*void)(*instance.stencilFront)) - cast(*void)(*instance)) == 20, "WGPUDepthStencilState.stencilFront has unexpected offset % instead of 20", ((cast(*void)(*instance.stencilFront)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUDepthStencilState.stencilFront)) == 16, "WGPUDepthStencilState.stencilFront has unexpected size % instead of 16", size_of(type_of(WGPUDepthStencilState.stencilFront)));
        assert(((cast(*void)(*instance.stencilBack)) - cast(*void)(*instance)) == 36, "WGPUDepthStencilState.stencilBack has unexpected offset % instead of 36", ((cast(*void)(*instance.stencilBack)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUDepthStencilState.stencilBack)) == 16, "WGPUDepthStencilState.stencilBack has unexpected size % instead of 16", size_of(type_of(WGPUDepthStencilState.stencilBack)));
        assert(((cast(*void)(*instance.stencilReadMask)) - cast(*void)(*instance)) == 52, "WGPUDepthStencilState.stencilReadMask has unexpected offset % instead of 52", ((cast(*void)(*instance.stencilReadMask)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUDepthStencilState.stencilReadMask)) == 4, "WGPUDepthStencilState.stencilReadMask has unexpected size % instead of 4", size_of(type_of(WGPUDepthStencilState.stencilReadMask)));
        assert(((cast(*void)(*instance.stencilWriteMask)) - cast(*void)(*instance)) == 56, "WGPUDepthStencilState.stencilWriteMask has unexpected offset % instead of 56", ((cast(*void)(*instance.stencilWriteMask)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUDepthStencilState.stencilWriteMask)) == 4, "WGPUDepthStencilState.stencilWriteMask has unexpected size % instead of 4", size_of(type_of(WGPUDepthStencilState.stencilWriteMask)));
        assert(((cast(*void)(*instance.depthBias)) - cast(*void)(*instance)) == 60, "WGPUDepthStencilState.depthBias has unexpected offset % instead of 60", ((cast(*void)(*instance.depthBias)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUDepthStencilState.depthBias)) == 4, "WGPUDepthStencilState.depthBias has unexpected size % instead of 4", size_of(type_of(WGPUDepthStencilState.depthBias)));
        assert(((cast(*void)(*instance.depthBiasSlopeScale)) - cast(*void)(*instance)) == 64, "WGPUDepthStencilState.depthBiasSlopeScale has unexpected offset % instead of 64", ((cast(*void)(*instance.depthBiasSlopeScale)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUDepthStencilState.depthBiasSlopeScale)) == 4, "WGPUDepthStencilState.depthBiasSlopeScale has unexpected size % instead of 4", size_of(type_of(WGPUDepthStencilState.depthBiasSlopeScale)));
        assert(((cast(*void)(*instance.depthBiasClamp)) - cast(*void)(*instance)) == 68, "WGPUDepthStencilState.depthBiasClamp has unexpected offset % instead of 68", ((cast(*void)(*instance.depthBiasClamp)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUDepthStencilState.depthBiasClamp)) == 4, "WGPUDepthStencilState.depthBiasClamp has unexpected size % instead of 4", size_of(type_of(WGPUDepthStencilState.depthBiasClamp)));
        assert(size_of(WGPUDepthStencilState) == 72, "WGPUDepthStencilState has size % instead of 72", size_of(WGPUDepthStencilState));
    }

    {
        instance: WGPUImageCopyBuffer;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUImageCopyBuffer.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUImageCopyBuffer.nextInChain)) == 8, "WGPUImageCopyBuffer.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUImageCopyBuffer.nextInChain)));
        assert(((cast(*void)(*instance.layout)) - cast(*void)(*instance)) == 8, "WGPUImageCopyBuffer.layout has unexpected offset % instead of 8", ((cast(*void)(*instance.layout)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUImageCopyBuffer.layout)) == 24, "WGPUImageCopyBuffer.layout has unexpected size % instead of 24", size_of(type_of(WGPUImageCopyBuffer.layout)));
        assert(((cast(*void)(*instance.buffer)) - cast(*void)(*instance)) == 32, "WGPUImageCopyBuffer.buffer has unexpected offset % instead of 32", ((cast(*void)(*instance.buffer)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUImageCopyBuffer.buffer)) == 8, "WGPUImageCopyBuffer.buffer has unexpected size % instead of 8", size_of(type_of(WGPUImageCopyBuffer.buffer)));
        assert(size_of(WGPUImageCopyBuffer) == 40, "WGPUImageCopyBuffer has size % instead of 40", size_of(WGPUImageCopyBuffer));
    }

    {
        instance: WGPUImageCopyTexture;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUImageCopyTexture.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUImageCopyTexture.nextInChain)) == 8, "WGPUImageCopyTexture.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUImageCopyTexture.nextInChain)));
        assert(((cast(*void)(*instance.texture)) - cast(*void)(*instance)) == 8, "WGPUImageCopyTexture.texture has unexpected offset % instead of 8", ((cast(*void)(*instance.texture)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUImageCopyTexture.texture)) == 8, "WGPUImageCopyTexture.texture has unexpected size % instead of 8", size_of(type_of(WGPUImageCopyTexture.texture)));
        assert(((cast(*void)(*instance.mipLevel)) - cast(*void)(*instance)) == 16, "WGPUImageCopyTexture.mipLevel has unexpected offset % instead of 16", ((cast(*void)(*instance.mipLevel)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUImageCopyTexture.mipLevel)) == 4, "WGPUImageCopyTexture.mipLevel has unexpected size % instead of 4", size_of(type_of(WGPUImageCopyTexture.mipLevel)));
        assert(((cast(*void)(*instance.origin)) - cast(*void)(*instance)) == 20, "WGPUImageCopyTexture.origin has unexpected offset % instead of 20", ((cast(*void)(*instance.origin)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUImageCopyTexture.origin)) == 12, "WGPUImageCopyTexture.origin has unexpected size % instead of 12", size_of(type_of(WGPUImageCopyTexture.origin)));
        assert(((cast(*void)(*instance.aspect)) - cast(*void)(*instance)) == 32, "WGPUImageCopyTexture.aspect has unexpected offset % instead of 32", ((cast(*void)(*instance.aspect)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUImageCopyTexture.aspect)) == 4, "WGPUImageCopyTexture.aspect has unexpected size % instead of 4", size_of(type_of(WGPUImageCopyTexture.aspect)));
        assert(size_of(WGPUImageCopyTexture) == 40, "WGPUImageCopyTexture has size % instead of 40", size_of(WGPUImageCopyTexture));
    }

    {
        instance: WGPUProgrammableStageDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUProgrammableStageDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUProgrammableStageDescriptor.nextInChain)) == 8, "WGPUProgrammableStageDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUProgrammableStageDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.module)) - cast(*void)(*instance)) == 8, "WGPUProgrammableStageDescriptor.module has unexpected offset % instead of 8", ((cast(*void)(*instance.module)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUProgrammableStageDescriptor.module)) == 8, "WGPUProgrammableStageDescriptor.module has unexpected size % instead of 8", size_of(type_of(WGPUProgrammableStageDescriptor.module)));
        assert(((cast(*void)(*instance.entryPoint)) - cast(*void)(*instance)) == 16, "WGPUProgrammableStageDescriptor.entryPoint has unexpected offset % instead of 16", ((cast(*void)(*instance.entryPoint)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUProgrammableStageDescriptor.entryPoint)) == 8, "WGPUProgrammableStageDescriptor.entryPoint has unexpected size % instead of 8", size_of(type_of(WGPUProgrammableStageDescriptor.entryPoint)));
        assert(((cast(*void)(*instance.constantCount)) - cast(*void)(*instance)) == 24, "WGPUProgrammableStageDescriptor.constantCount has unexpected offset % instead of 24", ((cast(*void)(*instance.constantCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUProgrammableStageDescriptor.constantCount)) == 8, "WGPUProgrammableStageDescriptor.constantCount has unexpected size % instead of 8", size_of(type_of(WGPUProgrammableStageDescriptor.constantCount)));
        assert(((cast(*void)(*instance.constants)) - cast(*void)(*instance)) == 32, "WGPUProgrammableStageDescriptor.constants has unexpected offset % instead of 32", ((cast(*void)(*instance.constants)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUProgrammableStageDescriptor.constants)) == 8, "WGPUProgrammableStageDescriptor.constants has unexpected size % instead of 8", size_of(type_of(WGPUProgrammableStageDescriptor.constants)));
        assert(size_of(WGPUProgrammableStageDescriptor) == 40, "WGPUProgrammableStageDescriptor has size % instead of 40", size_of(WGPUProgrammableStageDescriptor));
    }

    {
        instance: WGPURenderPassColorAttachment;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPURenderPassColorAttachment.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderPassColorAttachment.nextInChain)) == 8, "WGPURenderPassColorAttachment.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPURenderPassColorAttachment.nextInChain)));
        assert(((cast(*void)(*instance.view)) - cast(*void)(*instance)) == 8, "WGPURenderPassColorAttachment.view has unexpected offset % instead of 8", ((cast(*void)(*instance.view)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderPassColorAttachment.view)) == 8, "WGPURenderPassColorAttachment.view has unexpected size % instead of 8", size_of(type_of(WGPURenderPassColorAttachment.view)));
        assert(((cast(*void)(*instance.resolveTarget)) - cast(*void)(*instance)) == 16, "WGPURenderPassColorAttachment.resolveTarget has unexpected offset % instead of 16", ((cast(*void)(*instance.resolveTarget)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderPassColorAttachment.resolveTarget)) == 8, "WGPURenderPassColorAttachment.resolveTarget has unexpected size % instead of 8", size_of(type_of(WGPURenderPassColorAttachment.resolveTarget)));
        assert(((cast(*void)(*instance.loadOp)) - cast(*void)(*instance)) == 24, "WGPURenderPassColorAttachment.loadOp has unexpected offset % instead of 24", ((cast(*void)(*instance.loadOp)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderPassColorAttachment.loadOp)) == 4, "WGPURenderPassColorAttachment.loadOp has unexpected size % instead of 4", size_of(type_of(WGPURenderPassColorAttachment.loadOp)));
        assert(((cast(*void)(*instance.storeOp)) - cast(*void)(*instance)) == 28, "WGPURenderPassColorAttachment.storeOp has unexpected offset % instead of 28", ((cast(*void)(*instance.storeOp)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderPassColorAttachment.storeOp)) == 4, "WGPURenderPassColorAttachment.storeOp has unexpected size % instead of 4", size_of(type_of(WGPURenderPassColorAttachment.storeOp)));
        assert(((cast(*void)(*instance.clearValue)) - cast(*void)(*instance)) == 32, "WGPURenderPassColorAttachment.clearValue has unexpected offset % instead of 32", ((cast(*void)(*instance.clearValue)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderPassColorAttachment.clearValue)) == 32, "WGPURenderPassColorAttachment.clearValue has unexpected size % instead of 32", size_of(type_of(WGPURenderPassColorAttachment.clearValue)));
        assert(size_of(WGPURenderPassColorAttachment) == 64, "WGPURenderPassColorAttachment has size % instead of 64", size_of(WGPURenderPassColorAttachment));
    }

    {
        instance: WGPURequiredLimits;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPURequiredLimits.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURequiredLimits.nextInChain)) == 8, "WGPURequiredLimits.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPURequiredLimits.nextInChain)));
        assert(((cast(*void)(*instance.limits)) - cast(*void)(*instance)) == 8, "WGPURequiredLimits.limits has unexpected offset % instead of 8", ((cast(*void)(*instance.limits)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURequiredLimits.limits)) == 144, "WGPURequiredLimits.limits has unexpected size % instead of 144", size_of(type_of(WGPURequiredLimits.limits)));
        assert(size_of(WGPURequiredLimits) == 152, "WGPURequiredLimits has size % instead of 152", size_of(WGPURequiredLimits));
    }

    {
        instance: WGPUShaderModuleDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUShaderModuleDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUShaderModuleDescriptor.nextInChain)) == 8, "WGPUShaderModuleDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUShaderModuleDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "WGPUShaderModuleDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUShaderModuleDescriptor.label)) == 8, "WGPUShaderModuleDescriptor.label has unexpected size % instead of 8", size_of(type_of(WGPUShaderModuleDescriptor.label)));
        assert(((cast(*void)(*instance.hintCount)) - cast(*void)(*instance)) == 16, "WGPUShaderModuleDescriptor.hintCount has unexpected offset % instead of 16", ((cast(*void)(*instance.hintCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUShaderModuleDescriptor.hintCount)) == 8, "WGPUShaderModuleDescriptor.hintCount has unexpected size % instead of 8", size_of(type_of(WGPUShaderModuleDescriptor.hintCount)));
        assert(((cast(*void)(*instance.hints)) - cast(*void)(*instance)) == 24, "WGPUShaderModuleDescriptor.hints has unexpected offset % instead of 24", ((cast(*void)(*instance.hints)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUShaderModuleDescriptor.hints)) == 8, "WGPUShaderModuleDescriptor.hints has unexpected size % instead of 8", size_of(type_of(WGPUShaderModuleDescriptor.hints)));
        assert(size_of(WGPUShaderModuleDescriptor) == 32, "WGPUShaderModuleDescriptor has size % instead of 32", size_of(WGPUShaderModuleDescriptor));
    }

    {
        instance: WGPUSupportedLimits;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUSupportedLimits.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSupportedLimits.nextInChain)) == 8, "WGPUSupportedLimits.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUSupportedLimits.nextInChain)));
        assert(((cast(*void)(*instance.limits)) - cast(*void)(*instance)) == 8, "WGPUSupportedLimits.limits has unexpected offset % instead of 8", ((cast(*void)(*instance.limits)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSupportedLimits.limits)) == 144, "WGPUSupportedLimits.limits has unexpected size % instead of 144", size_of(type_of(WGPUSupportedLimits.limits)));
        assert(size_of(WGPUSupportedLimits) == 152, "WGPUSupportedLimits has size % instead of 152", size_of(WGPUSupportedLimits));
    }

    {
        instance: WGPUTextureDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUTextureDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUTextureDescriptor.nextInChain)) == 8, "WGPUTextureDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUTextureDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "WGPUTextureDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUTextureDescriptor.label)) == 8, "WGPUTextureDescriptor.label has unexpected size % instead of 8", size_of(type_of(WGPUTextureDescriptor.label)));
        assert(((cast(*void)(*instance.usage)) - cast(*void)(*instance)) == 16, "WGPUTextureDescriptor.usage has unexpected offset % instead of 16", ((cast(*void)(*instance.usage)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUTextureDescriptor.usage)) == 4, "WGPUTextureDescriptor.usage has unexpected size % instead of 4", size_of(type_of(WGPUTextureDescriptor.usage)));
        assert(((cast(*void)(*instance.dimension)) - cast(*void)(*instance)) == 20, "WGPUTextureDescriptor.dimension has unexpected offset % instead of 20", ((cast(*void)(*instance.dimension)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUTextureDescriptor.dimension)) == 4, "WGPUTextureDescriptor.dimension has unexpected size % instead of 4", size_of(type_of(WGPUTextureDescriptor.dimension)));
        assert(((cast(*void)(*instance.size)) - cast(*void)(*instance)) == 24, "WGPUTextureDescriptor.size has unexpected offset % instead of 24", ((cast(*void)(*instance.size)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUTextureDescriptor.size)) == 12, "WGPUTextureDescriptor.size has unexpected size % instead of 12", size_of(type_of(WGPUTextureDescriptor.size)));
        assert(((cast(*void)(*instance.format)) - cast(*void)(*instance)) == 36, "WGPUTextureDescriptor.format has unexpected offset % instead of 36", ((cast(*void)(*instance.format)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUTextureDescriptor.format)) == 4, "WGPUTextureDescriptor.format has unexpected size % instead of 4", size_of(type_of(WGPUTextureDescriptor.format)));
        assert(((cast(*void)(*instance.mipLevelCount)) - cast(*void)(*instance)) == 40, "WGPUTextureDescriptor.mipLevelCount has unexpected offset % instead of 40", ((cast(*void)(*instance.mipLevelCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUTextureDescriptor.mipLevelCount)) == 4, "WGPUTextureDescriptor.mipLevelCount has unexpected size % instead of 4", size_of(type_of(WGPUTextureDescriptor.mipLevelCount)));
        assert(((cast(*void)(*instance.sampleCount)) - cast(*void)(*instance)) == 44, "WGPUTextureDescriptor.sampleCount has unexpected offset % instead of 44", ((cast(*void)(*instance.sampleCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUTextureDescriptor.sampleCount)) == 4, "WGPUTextureDescriptor.sampleCount has unexpected size % instead of 4", size_of(type_of(WGPUTextureDescriptor.sampleCount)));
        assert(((cast(*void)(*instance.viewFormatCount)) - cast(*void)(*instance)) == 48, "WGPUTextureDescriptor.viewFormatCount has unexpected offset % instead of 48", ((cast(*void)(*instance.viewFormatCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUTextureDescriptor.viewFormatCount)) == 8, "WGPUTextureDescriptor.viewFormatCount has unexpected size % instead of 8", size_of(type_of(WGPUTextureDescriptor.viewFormatCount)));
        assert(((cast(*void)(*instance.viewFormats)) - cast(*void)(*instance)) == 56, "WGPUTextureDescriptor.viewFormats has unexpected offset % instead of 56", ((cast(*void)(*instance.viewFormats)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUTextureDescriptor.viewFormats)) == 8, "WGPUTextureDescriptor.viewFormats has unexpected size % instead of 8", size_of(type_of(WGPUTextureDescriptor.viewFormats)));
        assert(size_of(WGPUTextureDescriptor) == 64, "WGPUTextureDescriptor has size % instead of 64", size_of(WGPUTextureDescriptor));
    }

    {
        instance: WGPUVertexBufferLayout;
        assert(((cast(*void)(*instance.arrayStride)) - cast(*void)(*instance)) == 0, "WGPUVertexBufferLayout.arrayStride has unexpected offset % instead of 0", ((cast(*void)(*instance.arrayStride)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUVertexBufferLayout.arrayStride)) == 8, "WGPUVertexBufferLayout.arrayStride has unexpected size % instead of 8", size_of(type_of(WGPUVertexBufferLayout.arrayStride)));
        assert(((cast(*void)(*instance.stepMode)) - cast(*void)(*instance)) == 8, "WGPUVertexBufferLayout.stepMode has unexpected offset % instead of 8", ((cast(*void)(*instance.stepMode)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUVertexBufferLayout.stepMode)) == 4, "WGPUVertexBufferLayout.stepMode has unexpected size % instead of 4", size_of(type_of(WGPUVertexBufferLayout.stepMode)));
        assert(((cast(*void)(*instance.attributeCount)) - cast(*void)(*instance)) == 16, "WGPUVertexBufferLayout.attributeCount has unexpected offset % instead of 16", ((cast(*void)(*instance.attributeCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUVertexBufferLayout.attributeCount)) == 8, "WGPUVertexBufferLayout.attributeCount has unexpected size % instead of 8", size_of(type_of(WGPUVertexBufferLayout.attributeCount)));
        assert(((cast(*void)(*instance.attributes)) - cast(*void)(*instance)) == 24, "WGPUVertexBufferLayout.attributes has unexpected offset % instead of 24", ((cast(*void)(*instance.attributes)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUVertexBufferLayout.attributes)) == 8, "WGPUVertexBufferLayout.attributes has unexpected size % instead of 8", size_of(type_of(WGPUVertexBufferLayout.attributes)));
        assert(size_of(WGPUVertexBufferLayout) == 32, "WGPUVertexBufferLayout has size % instead of 32", size_of(WGPUVertexBufferLayout));
    }

    {
        instance: WGPUBindGroupLayoutDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUBindGroupLayoutDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBindGroupLayoutDescriptor.nextInChain)) == 8, "WGPUBindGroupLayoutDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUBindGroupLayoutDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "WGPUBindGroupLayoutDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBindGroupLayoutDescriptor.label)) == 8, "WGPUBindGroupLayoutDescriptor.label has unexpected size % instead of 8", size_of(type_of(WGPUBindGroupLayoutDescriptor.label)));
        assert(((cast(*void)(*instance.entryCount)) - cast(*void)(*instance)) == 16, "WGPUBindGroupLayoutDescriptor.entryCount has unexpected offset % instead of 16", ((cast(*void)(*instance.entryCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBindGroupLayoutDescriptor.entryCount)) == 8, "WGPUBindGroupLayoutDescriptor.entryCount has unexpected size % instead of 8", size_of(type_of(WGPUBindGroupLayoutDescriptor.entryCount)));
        assert(((cast(*void)(*instance.entries)) - cast(*void)(*instance)) == 24, "WGPUBindGroupLayoutDescriptor.entries has unexpected offset % instead of 24", ((cast(*void)(*instance.entries)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBindGroupLayoutDescriptor.entries)) == 8, "WGPUBindGroupLayoutDescriptor.entries has unexpected size % instead of 8", size_of(type_of(WGPUBindGroupLayoutDescriptor.entries)));
        assert(size_of(WGPUBindGroupLayoutDescriptor) == 32, "WGPUBindGroupLayoutDescriptor has size % instead of 32", size_of(WGPUBindGroupLayoutDescriptor));
    }

    {
        instance: WGPUColorTargetState;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUColorTargetState.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUColorTargetState.nextInChain)) == 8, "WGPUColorTargetState.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUColorTargetState.nextInChain)));
        assert(((cast(*void)(*instance.format)) - cast(*void)(*instance)) == 8, "WGPUColorTargetState.format has unexpected offset % instead of 8", ((cast(*void)(*instance.format)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUColorTargetState.format)) == 4, "WGPUColorTargetState.format has unexpected size % instead of 4", size_of(type_of(WGPUColorTargetState.format)));
        assert(((cast(*void)(*instance.blend)) - cast(*void)(*instance)) == 16, "WGPUColorTargetState.blend has unexpected offset % instead of 16", ((cast(*void)(*instance.blend)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUColorTargetState.blend)) == 8, "WGPUColorTargetState.blend has unexpected size % instead of 8", size_of(type_of(WGPUColorTargetState.blend)));
        assert(((cast(*void)(*instance.writeMask)) - cast(*void)(*instance)) == 24, "WGPUColorTargetState.writeMask has unexpected offset % instead of 24", ((cast(*void)(*instance.writeMask)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUColorTargetState.writeMask)) == 4, "WGPUColorTargetState.writeMask has unexpected size % instead of 4", size_of(type_of(WGPUColorTargetState.writeMask)));
        assert(size_of(WGPUColorTargetState) == 32, "WGPUColorTargetState has size % instead of 32", size_of(WGPUColorTargetState));
    }

    {
        instance: WGPUComputePipelineDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUComputePipelineDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUComputePipelineDescriptor.nextInChain)) == 8, "WGPUComputePipelineDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUComputePipelineDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "WGPUComputePipelineDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUComputePipelineDescriptor.label)) == 8, "WGPUComputePipelineDescriptor.label has unexpected size % instead of 8", size_of(type_of(WGPUComputePipelineDescriptor.label)));
        assert(((cast(*void)(*instance.layout)) - cast(*void)(*instance)) == 16, "WGPUComputePipelineDescriptor.layout has unexpected offset % instead of 16", ((cast(*void)(*instance.layout)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUComputePipelineDescriptor.layout)) == 8, "WGPUComputePipelineDescriptor.layout has unexpected size % instead of 8", size_of(type_of(WGPUComputePipelineDescriptor.layout)));
        assert(((cast(*void)(*instance.compute)) - cast(*void)(*instance)) == 24, "WGPUComputePipelineDescriptor.compute has unexpected offset % instead of 24", ((cast(*void)(*instance.compute)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUComputePipelineDescriptor.compute)) == 40, "WGPUComputePipelineDescriptor.compute has unexpected size % instead of 40", size_of(type_of(WGPUComputePipelineDescriptor.compute)));
        assert(size_of(WGPUComputePipelineDescriptor) == 64, "WGPUComputePipelineDescriptor has size % instead of 64", size_of(WGPUComputePipelineDescriptor));
    }

    {
        instance: WGPUDeviceDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUDeviceDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUDeviceDescriptor.nextInChain)) == 8, "WGPUDeviceDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUDeviceDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "WGPUDeviceDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUDeviceDescriptor.label)) == 8, "WGPUDeviceDescriptor.label has unexpected size % instead of 8", size_of(type_of(WGPUDeviceDescriptor.label)));
        assert(((cast(*void)(*instance.requiredFeatureCount)) - cast(*void)(*instance)) == 16, "WGPUDeviceDescriptor.requiredFeatureCount has unexpected offset % instead of 16", ((cast(*void)(*instance.requiredFeatureCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUDeviceDescriptor.requiredFeatureCount)) == 8, "WGPUDeviceDescriptor.requiredFeatureCount has unexpected size % instead of 8", size_of(type_of(WGPUDeviceDescriptor.requiredFeatureCount)));
        assert(((cast(*void)(*instance.requiredFeatures)) - cast(*void)(*instance)) == 24, "WGPUDeviceDescriptor.requiredFeatures has unexpected offset % instead of 24", ((cast(*void)(*instance.requiredFeatures)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUDeviceDescriptor.requiredFeatures)) == 8, "WGPUDeviceDescriptor.requiredFeatures has unexpected size % instead of 8", size_of(type_of(WGPUDeviceDescriptor.requiredFeatures)));
        assert(((cast(*void)(*instance.requiredLimits)) - cast(*void)(*instance)) == 32, "WGPUDeviceDescriptor.requiredLimits has unexpected offset % instead of 32", ((cast(*void)(*instance.requiredLimits)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUDeviceDescriptor.requiredLimits)) == 8, "WGPUDeviceDescriptor.requiredLimits has unexpected size % instead of 8", size_of(type_of(WGPUDeviceDescriptor.requiredLimits)));
        assert(((cast(*void)(*instance.defaultQueue)) - cast(*void)(*instance)) == 40, "WGPUDeviceDescriptor.defaultQueue has unexpected offset % instead of 40", ((cast(*void)(*instance.defaultQueue)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUDeviceDescriptor.defaultQueue)) == 16, "WGPUDeviceDescriptor.defaultQueue has unexpected size % instead of 16", size_of(type_of(WGPUDeviceDescriptor.defaultQueue)));
        assert(((cast(*void)(*instance.deviceLostCallback)) - cast(*void)(*instance)) == 56, "WGPUDeviceDescriptor.deviceLostCallback has unexpected offset % instead of 56", ((cast(*void)(*instance.deviceLostCallback)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUDeviceDescriptor.deviceLostCallback)) == 8, "WGPUDeviceDescriptor.deviceLostCallback has unexpected size % instead of 8", size_of(type_of(WGPUDeviceDescriptor.deviceLostCallback)));
        assert(((cast(*void)(*instance.deviceLostUserdata)) - cast(*void)(*instance)) == 64, "WGPUDeviceDescriptor.deviceLostUserdata has unexpected offset % instead of 64", ((cast(*void)(*instance.deviceLostUserdata)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUDeviceDescriptor.deviceLostUserdata)) == 8, "WGPUDeviceDescriptor.deviceLostUserdata has unexpected size % instead of 8", size_of(type_of(WGPUDeviceDescriptor.deviceLostUserdata)));
        assert(size_of(WGPUDeviceDescriptor) == 72, "WGPUDeviceDescriptor has size % instead of 72", size_of(WGPUDeviceDescriptor));
    }

    {
        instance: WGPURenderPassDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPURenderPassDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderPassDescriptor.nextInChain)) == 8, "WGPURenderPassDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPURenderPassDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "WGPURenderPassDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderPassDescriptor.label)) == 8, "WGPURenderPassDescriptor.label has unexpected size % instead of 8", size_of(type_of(WGPURenderPassDescriptor.label)));
        assert(((cast(*void)(*instance.colorAttachmentCount)) - cast(*void)(*instance)) == 16, "WGPURenderPassDescriptor.colorAttachmentCount has unexpected offset % instead of 16", ((cast(*void)(*instance.colorAttachmentCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderPassDescriptor.colorAttachmentCount)) == 8, "WGPURenderPassDescriptor.colorAttachmentCount has unexpected size % instead of 8", size_of(type_of(WGPURenderPassDescriptor.colorAttachmentCount)));
        assert(((cast(*void)(*instance.colorAttachments)) - cast(*void)(*instance)) == 24, "WGPURenderPassDescriptor.colorAttachments has unexpected offset % instead of 24", ((cast(*void)(*instance.colorAttachments)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderPassDescriptor.colorAttachments)) == 8, "WGPURenderPassDescriptor.colorAttachments has unexpected size % instead of 8", size_of(type_of(WGPURenderPassDescriptor.colorAttachments)));
        assert(((cast(*void)(*instance.depthStencilAttachment)) - cast(*void)(*instance)) == 32, "WGPURenderPassDescriptor.depthStencilAttachment has unexpected offset % instead of 32", ((cast(*void)(*instance.depthStencilAttachment)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderPassDescriptor.depthStencilAttachment)) == 8, "WGPURenderPassDescriptor.depthStencilAttachment has unexpected size % instead of 8", size_of(type_of(WGPURenderPassDescriptor.depthStencilAttachment)));
        assert(((cast(*void)(*instance.occlusionQuerySet)) - cast(*void)(*instance)) == 40, "WGPURenderPassDescriptor.occlusionQuerySet has unexpected offset % instead of 40", ((cast(*void)(*instance.occlusionQuerySet)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderPassDescriptor.occlusionQuerySet)) == 8, "WGPURenderPassDescriptor.occlusionQuerySet has unexpected size % instead of 8", size_of(type_of(WGPURenderPassDescriptor.occlusionQuerySet)));
        assert(((cast(*void)(*instance.timestampWrites)) - cast(*void)(*instance)) == 48, "WGPURenderPassDescriptor.timestampWrites has unexpected offset % instead of 48", ((cast(*void)(*instance.timestampWrites)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderPassDescriptor.timestampWrites)) == 8, "WGPURenderPassDescriptor.timestampWrites has unexpected size % instead of 8", size_of(type_of(WGPURenderPassDescriptor.timestampWrites)));
        assert(size_of(WGPURenderPassDescriptor) == 56, "WGPURenderPassDescriptor has size % instead of 56", size_of(WGPURenderPassDescriptor));
    }

    {
        instance: WGPUVertexState;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUVertexState.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUVertexState.nextInChain)) == 8, "WGPUVertexState.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUVertexState.nextInChain)));
        assert(((cast(*void)(*instance.module)) - cast(*void)(*instance)) == 8, "WGPUVertexState.module has unexpected offset % instead of 8", ((cast(*void)(*instance.module)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUVertexState.module)) == 8, "WGPUVertexState.module has unexpected size % instead of 8", size_of(type_of(WGPUVertexState.module)));
        assert(((cast(*void)(*instance.entryPoint)) - cast(*void)(*instance)) == 16, "WGPUVertexState.entryPoint has unexpected offset % instead of 16", ((cast(*void)(*instance.entryPoint)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUVertexState.entryPoint)) == 8, "WGPUVertexState.entryPoint has unexpected size % instead of 8", size_of(type_of(WGPUVertexState.entryPoint)));
        assert(((cast(*void)(*instance.constantCount)) - cast(*void)(*instance)) == 24, "WGPUVertexState.constantCount has unexpected offset % instead of 24", ((cast(*void)(*instance.constantCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUVertexState.constantCount)) == 8, "WGPUVertexState.constantCount has unexpected size % instead of 8", size_of(type_of(WGPUVertexState.constantCount)));
        assert(((cast(*void)(*instance.constants)) - cast(*void)(*instance)) == 32, "WGPUVertexState.constants has unexpected offset % instead of 32", ((cast(*void)(*instance.constants)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUVertexState.constants)) == 8, "WGPUVertexState.constants has unexpected size % instead of 8", size_of(type_of(WGPUVertexState.constants)));
        assert(((cast(*void)(*instance.bufferCount)) - cast(*void)(*instance)) == 40, "WGPUVertexState.bufferCount has unexpected offset % instead of 40", ((cast(*void)(*instance.bufferCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUVertexState.bufferCount)) == 8, "WGPUVertexState.bufferCount has unexpected size % instead of 8", size_of(type_of(WGPUVertexState.bufferCount)));
        assert(((cast(*void)(*instance.buffers)) - cast(*void)(*instance)) == 48, "WGPUVertexState.buffers has unexpected offset % instead of 48", ((cast(*void)(*instance.buffers)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUVertexState.buffers)) == 8, "WGPUVertexState.buffers has unexpected size % instead of 8", size_of(type_of(WGPUVertexState.buffers)));
        assert(size_of(WGPUVertexState) == 56, "WGPUVertexState has size % instead of 56", size_of(WGPUVertexState));
    }

    {
        instance: WGPUFragmentState;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUFragmentState.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUFragmentState.nextInChain)) == 8, "WGPUFragmentState.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUFragmentState.nextInChain)));
        assert(((cast(*void)(*instance.module)) - cast(*void)(*instance)) == 8, "WGPUFragmentState.module has unexpected offset % instead of 8", ((cast(*void)(*instance.module)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUFragmentState.module)) == 8, "WGPUFragmentState.module has unexpected size % instead of 8", size_of(type_of(WGPUFragmentState.module)));
        assert(((cast(*void)(*instance.entryPoint)) - cast(*void)(*instance)) == 16, "WGPUFragmentState.entryPoint has unexpected offset % instead of 16", ((cast(*void)(*instance.entryPoint)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUFragmentState.entryPoint)) == 8, "WGPUFragmentState.entryPoint has unexpected size % instead of 8", size_of(type_of(WGPUFragmentState.entryPoint)));
        assert(((cast(*void)(*instance.constantCount)) - cast(*void)(*instance)) == 24, "WGPUFragmentState.constantCount has unexpected offset % instead of 24", ((cast(*void)(*instance.constantCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUFragmentState.constantCount)) == 8, "WGPUFragmentState.constantCount has unexpected size % instead of 8", size_of(type_of(WGPUFragmentState.constantCount)));
        assert(((cast(*void)(*instance.constants)) - cast(*void)(*instance)) == 32, "WGPUFragmentState.constants has unexpected offset % instead of 32", ((cast(*void)(*instance.constants)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUFragmentState.constants)) == 8, "WGPUFragmentState.constants has unexpected size % instead of 8", size_of(type_of(WGPUFragmentState.constants)));
        assert(((cast(*void)(*instance.targetCount)) - cast(*void)(*instance)) == 40, "WGPUFragmentState.targetCount has unexpected offset % instead of 40", ((cast(*void)(*instance.targetCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUFragmentState.targetCount)) == 8, "WGPUFragmentState.targetCount has unexpected size % instead of 8", size_of(type_of(WGPUFragmentState.targetCount)));
        assert(((cast(*void)(*instance.targets)) - cast(*void)(*instance)) == 48, "WGPUFragmentState.targets has unexpected offset % instead of 48", ((cast(*void)(*instance.targets)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUFragmentState.targets)) == 8, "WGPUFragmentState.targets has unexpected size % instead of 8", size_of(type_of(WGPUFragmentState.targets)));
        assert(size_of(WGPUFragmentState) == 56, "WGPUFragmentState has size % instead of 56", size_of(WGPUFragmentState));
    }

    {
        instance: WGPURenderPipelineDescriptor;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPURenderPipelineDescriptor.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderPipelineDescriptor.nextInChain)) == 8, "WGPURenderPipelineDescriptor.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPURenderPipelineDescriptor.nextInChain)));
        assert(((cast(*void)(*instance.label)) - cast(*void)(*instance)) == 8, "WGPURenderPipelineDescriptor.label has unexpected offset % instead of 8", ((cast(*void)(*instance.label)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderPipelineDescriptor.label)) == 8, "WGPURenderPipelineDescriptor.label has unexpected size % instead of 8", size_of(type_of(WGPURenderPipelineDescriptor.label)));
        assert(((cast(*void)(*instance.layout)) - cast(*void)(*instance)) == 16, "WGPURenderPipelineDescriptor.layout has unexpected offset % instead of 16", ((cast(*void)(*instance.layout)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderPipelineDescriptor.layout)) == 8, "WGPURenderPipelineDescriptor.layout has unexpected size % instead of 8", size_of(type_of(WGPURenderPipelineDescriptor.layout)));
        assert(((cast(*void)(*instance.vertex)) - cast(*void)(*instance)) == 24, "WGPURenderPipelineDescriptor.vertex has unexpected offset % instead of 24", ((cast(*void)(*instance.vertex)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderPipelineDescriptor.vertex)) == 56, "WGPURenderPipelineDescriptor.vertex has unexpected size % instead of 56", size_of(type_of(WGPURenderPipelineDescriptor.vertex)));
        assert(((cast(*void)(*instance.primitive)) - cast(*void)(*instance)) == 80, "WGPURenderPipelineDescriptor.primitive has unexpected offset % instead of 80", ((cast(*void)(*instance.primitive)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderPipelineDescriptor.primitive)) == 24, "WGPURenderPipelineDescriptor.primitive has unexpected size % instead of 24", size_of(type_of(WGPURenderPipelineDescriptor.primitive)));
        assert(((cast(*void)(*instance.depthStencil)) - cast(*void)(*instance)) == 104, "WGPURenderPipelineDescriptor.depthStencil has unexpected offset % instead of 104", ((cast(*void)(*instance.depthStencil)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderPipelineDescriptor.depthStencil)) == 8, "WGPURenderPipelineDescriptor.depthStencil has unexpected size % instead of 8", size_of(type_of(WGPURenderPipelineDescriptor.depthStencil)));
        assert(((cast(*void)(*instance.multisample)) - cast(*void)(*instance)) == 112, "WGPURenderPipelineDescriptor.multisample has unexpected offset % instead of 112", ((cast(*void)(*instance.multisample)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderPipelineDescriptor.multisample)) == 24, "WGPURenderPipelineDescriptor.multisample has unexpected size % instead of 24", size_of(type_of(WGPURenderPipelineDescriptor.multisample)));
        assert(((cast(*void)(*instance.fragment)) - cast(*void)(*instance)) == 136, "WGPURenderPipelineDescriptor.fragment has unexpected offset % instead of 136", ((cast(*void)(*instance.fragment)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURenderPipelineDescriptor.fragment)) == 8, "WGPURenderPipelineDescriptor.fragment has unexpected size % instead of 8", size_of(type_of(WGPURenderPipelineDescriptor.fragment)));
        assert(size_of(WGPURenderPipelineDescriptor) == 144, "WGPURenderPipelineDescriptor has size % instead of 144", size_of(WGPURenderPipelineDescriptor));
    }

    {
        instance: WGPUInstanceExtras;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "WGPUInstanceExtras.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUInstanceExtras.chain)) == 16, "WGPUInstanceExtras.chain has unexpected size % instead of 16", size_of(type_of(WGPUInstanceExtras.chain)));
        assert(((cast(*void)(*instance.backends)) - cast(*void)(*instance)) == 16, "WGPUInstanceExtras.backends has unexpected offset % instead of 16", ((cast(*void)(*instance.backends)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUInstanceExtras.backends)) == 4, "WGPUInstanceExtras.backends has unexpected size % instead of 4", size_of(type_of(WGPUInstanceExtras.backends)));
        assert(((cast(*void)(*instance.flags)) - cast(*void)(*instance)) == 20, "WGPUInstanceExtras.flags has unexpected offset % instead of 20", ((cast(*void)(*instance.flags)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUInstanceExtras.flags)) == 4, "WGPUInstanceExtras.flags has unexpected size % instead of 4", size_of(type_of(WGPUInstanceExtras.flags)));
        assert(((cast(*void)(*instance.dx12ShaderCompiler)) - cast(*void)(*instance)) == 24, "WGPUInstanceExtras.dx12ShaderCompiler has unexpected offset % instead of 24", ((cast(*void)(*instance.dx12ShaderCompiler)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUInstanceExtras.dx12ShaderCompiler)) == 4, "WGPUInstanceExtras.dx12ShaderCompiler has unexpected size % instead of 4", size_of(type_of(WGPUInstanceExtras.dx12ShaderCompiler)));
        assert(((cast(*void)(*instance.gles3MinorVersion)) - cast(*void)(*instance)) == 28, "WGPUInstanceExtras.gles3MinorVersion has unexpected offset % instead of 28", ((cast(*void)(*instance.gles3MinorVersion)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUInstanceExtras.gles3MinorVersion)) == 4, "WGPUInstanceExtras.gles3MinorVersion has unexpected size % instead of 4", size_of(type_of(WGPUInstanceExtras.gles3MinorVersion)));
        assert(((cast(*void)(*instance.dxilPath)) - cast(*void)(*instance)) == 32, "WGPUInstanceExtras.dxilPath has unexpected offset % instead of 32", ((cast(*void)(*instance.dxilPath)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUInstanceExtras.dxilPath)) == 8, "WGPUInstanceExtras.dxilPath has unexpected size % instead of 8", size_of(type_of(WGPUInstanceExtras.dxilPath)));
        assert(((cast(*void)(*instance.dxcPath)) - cast(*void)(*instance)) == 40, "WGPUInstanceExtras.dxcPath has unexpected offset % instead of 40", ((cast(*void)(*instance.dxcPath)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUInstanceExtras.dxcPath)) == 8, "WGPUInstanceExtras.dxcPath has unexpected size % instead of 8", size_of(type_of(WGPUInstanceExtras.dxcPath)));
        assert(size_of(WGPUInstanceExtras) == 48, "WGPUInstanceExtras has size % instead of 48", size_of(WGPUInstanceExtras));
    }

    {
        instance: WGPUDeviceExtras;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "WGPUDeviceExtras.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUDeviceExtras.chain)) == 16, "WGPUDeviceExtras.chain has unexpected size % instead of 16", size_of(type_of(WGPUDeviceExtras.chain)));
        assert(((cast(*void)(*instance.tracePath)) - cast(*void)(*instance)) == 16, "WGPUDeviceExtras.tracePath has unexpected offset % instead of 16", ((cast(*void)(*instance.tracePath)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUDeviceExtras.tracePath)) == 8, "WGPUDeviceExtras.tracePath has unexpected size % instead of 8", size_of(type_of(WGPUDeviceExtras.tracePath)));
        assert(size_of(WGPUDeviceExtras) == 24, "WGPUDeviceExtras has size % instead of 24", size_of(WGPUDeviceExtras));
    }

    {
        instance: WGPUNativeLimits;
        assert(((cast(*void)(*instance.maxPushConstantSize)) - cast(*void)(*instance)) == 0, "WGPUNativeLimits.maxPushConstantSize has unexpected offset % instead of 0", ((cast(*void)(*instance.maxPushConstantSize)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUNativeLimits.maxPushConstantSize)) == 4, "WGPUNativeLimits.maxPushConstantSize has unexpected size % instead of 4", size_of(type_of(WGPUNativeLimits.maxPushConstantSize)));
        assert(((cast(*void)(*instance.maxNonSamplerBindings)) - cast(*void)(*instance)) == 4, "WGPUNativeLimits.maxNonSamplerBindings has unexpected offset % instead of 4", ((cast(*void)(*instance.maxNonSamplerBindings)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUNativeLimits.maxNonSamplerBindings)) == 4, "WGPUNativeLimits.maxNonSamplerBindings has unexpected size % instead of 4", size_of(type_of(WGPUNativeLimits.maxNonSamplerBindings)));
        assert(size_of(WGPUNativeLimits) == 8, "WGPUNativeLimits has size % instead of 8", size_of(WGPUNativeLimits));
    }

    {
        instance: WGPURequiredLimitsExtras;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "WGPURequiredLimitsExtras.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURequiredLimitsExtras.chain)) == 16, "WGPURequiredLimitsExtras.chain has unexpected size % instead of 16", size_of(type_of(WGPURequiredLimitsExtras.chain)));
        assert(((cast(*void)(*instance.limits)) - cast(*void)(*instance)) == 16, "WGPURequiredLimitsExtras.limits has unexpected offset % instead of 16", ((cast(*void)(*instance.limits)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURequiredLimitsExtras.limits)) == 8, "WGPURequiredLimitsExtras.limits has unexpected size % instead of 8", size_of(type_of(WGPURequiredLimitsExtras.limits)));
        assert(size_of(WGPURequiredLimitsExtras) == 24, "WGPURequiredLimitsExtras has size % instead of 24", size_of(WGPURequiredLimitsExtras));
    }

    {
        instance: WGPUSupportedLimitsExtras;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "WGPUSupportedLimitsExtras.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSupportedLimitsExtras.chain)) == 16, "WGPUSupportedLimitsExtras.chain has unexpected size % instead of 16", size_of(type_of(WGPUSupportedLimitsExtras.chain)));
        assert(((cast(*void)(*instance.limits)) - cast(*void)(*instance)) == 16, "WGPUSupportedLimitsExtras.limits has unexpected offset % instead of 16", ((cast(*void)(*instance.limits)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSupportedLimitsExtras.limits)) == 8, "WGPUSupportedLimitsExtras.limits has unexpected size % instead of 8", size_of(type_of(WGPUSupportedLimitsExtras.limits)));
        assert(size_of(WGPUSupportedLimitsExtras) == 24, "WGPUSupportedLimitsExtras has size % instead of 24", size_of(WGPUSupportedLimitsExtras));
    }

    {
        instance: WGPUPushConstantRange;
        assert(((cast(*void)(*instance.stages)) - cast(*void)(*instance)) == 0, "WGPUPushConstantRange.stages has unexpected offset % instead of 0", ((cast(*void)(*instance.stages)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUPushConstantRange.stages)) == 4, "WGPUPushConstantRange.stages has unexpected size % instead of 4", size_of(type_of(WGPUPushConstantRange.stages)));
        assert(((cast(*void)(*instance.start)) - cast(*void)(*instance)) == 4, "WGPUPushConstantRange.start has unexpected offset % instead of 4", ((cast(*void)(*instance.start)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUPushConstantRange.start)) == 4, "WGPUPushConstantRange.start has unexpected size % instead of 4", size_of(type_of(WGPUPushConstantRange.start)));
        assert(((cast(*void)(*instance.end)) - cast(*void)(*instance)) == 8, "WGPUPushConstantRange.end has unexpected offset % instead of 8", ((cast(*void)(*instance.end)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUPushConstantRange.end)) == 4, "WGPUPushConstantRange.end has unexpected size % instead of 4", size_of(type_of(WGPUPushConstantRange.end)));
        assert(size_of(WGPUPushConstantRange) == 12, "WGPUPushConstantRange has size % instead of 12", size_of(WGPUPushConstantRange));
    }

    {
        instance: WGPUPipelineLayoutExtras;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "WGPUPipelineLayoutExtras.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUPipelineLayoutExtras.chain)) == 16, "WGPUPipelineLayoutExtras.chain has unexpected size % instead of 16", size_of(type_of(WGPUPipelineLayoutExtras.chain)));
        assert(((cast(*void)(*instance.pushConstantRangeCount)) - cast(*void)(*instance)) == 16, "WGPUPipelineLayoutExtras.pushConstantRangeCount has unexpected offset % instead of 16", ((cast(*void)(*instance.pushConstantRangeCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUPipelineLayoutExtras.pushConstantRangeCount)) == 8, "WGPUPipelineLayoutExtras.pushConstantRangeCount has unexpected size % instead of 8", size_of(type_of(WGPUPipelineLayoutExtras.pushConstantRangeCount)));
        assert(((cast(*void)(*instance.pushConstantRanges)) - cast(*void)(*instance)) == 24, "WGPUPipelineLayoutExtras.pushConstantRanges has unexpected offset % instead of 24", ((cast(*void)(*instance.pushConstantRanges)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUPipelineLayoutExtras.pushConstantRanges)) == 8, "WGPUPipelineLayoutExtras.pushConstantRanges has unexpected size % instead of 8", size_of(type_of(WGPUPipelineLayoutExtras.pushConstantRanges)));
        assert(size_of(WGPUPipelineLayoutExtras) == 32, "WGPUPipelineLayoutExtras has size % instead of 32", size_of(WGPUPipelineLayoutExtras));
    }

    {
        instance: WGPUWrappedSubmissionIndex;
        assert(((cast(*void)(*instance.queue)) - cast(*void)(*instance)) == 0, "WGPUWrappedSubmissionIndex.queue has unexpected offset % instead of 0", ((cast(*void)(*instance.queue)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUWrappedSubmissionIndex.queue)) == 8, "WGPUWrappedSubmissionIndex.queue has unexpected size % instead of 8", size_of(type_of(WGPUWrappedSubmissionIndex.queue)));
        assert(((cast(*void)(*instance.submissionIndex)) - cast(*void)(*instance)) == 8, "WGPUWrappedSubmissionIndex.submissionIndex has unexpected offset % instead of 8", ((cast(*void)(*instance.submissionIndex)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUWrappedSubmissionIndex.submissionIndex)) == 8, "WGPUWrappedSubmissionIndex.submissionIndex has unexpected size % instead of 8", size_of(type_of(WGPUWrappedSubmissionIndex.submissionIndex)));
        assert(size_of(WGPUWrappedSubmissionIndex) == 16, "WGPUWrappedSubmissionIndex has size % instead of 16", size_of(WGPUWrappedSubmissionIndex));
    }

    {
        instance: WGPUShaderDefine;
        assert(((cast(*void)(*instance.name)) - cast(*void)(*instance)) == 0, "WGPUShaderDefine.name has unexpected offset % instead of 0", ((cast(*void)(*instance.name)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUShaderDefine.name)) == 8, "WGPUShaderDefine.name has unexpected size % instead of 8", size_of(type_of(WGPUShaderDefine.name)));
        assert(((cast(*void)(*instance.value)) - cast(*void)(*instance)) == 8, "WGPUShaderDefine.value has unexpected offset % instead of 8", ((cast(*void)(*instance.value)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUShaderDefine.value)) == 8, "WGPUShaderDefine.value has unexpected size % instead of 8", size_of(type_of(WGPUShaderDefine.value)));
        assert(size_of(WGPUShaderDefine) == 16, "WGPUShaderDefine has size % instead of 16", size_of(WGPUShaderDefine));
    }

    {
        instance: WGPUShaderModuleGLSLDescriptor;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "WGPUShaderModuleGLSLDescriptor.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUShaderModuleGLSLDescriptor.chain)) == 16, "WGPUShaderModuleGLSLDescriptor.chain has unexpected size % instead of 16", size_of(type_of(WGPUShaderModuleGLSLDescriptor.chain)));
        assert(((cast(*void)(*instance.stage)) - cast(*void)(*instance)) == 16, "WGPUShaderModuleGLSLDescriptor.stage has unexpected offset % instead of 16", ((cast(*void)(*instance.stage)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUShaderModuleGLSLDescriptor.stage)) == 4, "WGPUShaderModuleGLSLDescriptor.stage has unexpected size % instead of 4", size_of(type_of(WGPUShaderModuleGLSLDescriptor.stage)));
        assert(((cast(*void)(*instance.code)) - cast(*void)(*instance)) == 24, "WGPUShaderModuleGLSLDescriptor.code has unexpected offset % instead of 24", ((cast(*void)(*instance.code)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUShaderModuleGLSLDescriptor.code)) == 8, "WGPUShaderModuleGLSLDescriptor.code has unexpected size % instead of 8", size_of(type_of(WGPUShaderModuleGLSLDescriptor.code)));
        assert(((cast(*void)(*instance.defineCount)) - cast(*void)(*instance)) == 32, "WGPUShaderModuleGLSLDescriptor.defineCount has unexpected offset % instead of 32", ((cast(*void)(*instance.defineCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUShaderModuleGLSLDescriptor.defineCount)) == 4, "WGPUShaderModuleGLSLDescriptor.defineCount has unexpected size % instead of 4", size_of(type_of(WGPUShaderModuleGLSLDescriptor.defineCount)));
        assert(((cast(*void)(*instance.defines)) - cast(*void)(*instance)) == 40, "WGPUShaderModuleGLSLDescriptor.defines has unexpected offset % instead of 40", ((cast(*void)(*instance.defines)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUShaderModuleGLSLDescriptor.defines)) == 8, "WGPUShaderModuleGLSLDescriptor.defines has unexpected size % instead of 8", size_of(type_of(WGPUShaderModuleGLSLDescriptor.defines)));
        assert(size_of(WGPUShaderModuleGLSLDescriptor) == 48, "WGPUShaderModuleGLSLDescriptor has size % instead of 48", size_of(WGPUShaderModuleGLSLDescriptor));
    }

    {
        instance: WGPURegistryReport;
        assert(((cast(*void)(*instance.numAllocated)) - cast(*void)(*instance)) == 0, "WGPURegistryReport.numAllocated has unexpected offset % instead of 0", ((cast(*void)(*instance.numAllocated)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURegistryReport.numAllocated)) == 8, "WGPURegistryReport.numAllocated has unexpected size % instead of 8", size_of(type_of(WGPURegistryReport.numAllocated)));
        assert(((cast(*void)(*instance.numKeptFromUser)) - cast(*void)(*instance)) == 8, "WGPURegistryReport.numKeptFromUser has unexpected offset % instead of 8", ((cast(*void)(*instance.numKeptFromUser)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURegistryReport.numKeptFromUser)) == 8, "WGPURegistryReport.numKeptFromUser has unexpected size % instead of 8", size_of(type_of(WGPURegistryReport.numKeptFromUser)));
        assert(((cast(*void)(*instance.numReleasedFromUser)) - cast(*void)(*instance)) == 16, "WGPURegistryReport.numReleasedFromUser has unexpected offset % instead of 16", ((cast(*void)(*instance.numReleasedFromUser)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURegistryReport.numReleasedFromUser)) == 8, "WGPURegistryReport.numReleasedFromUser has unexpected size % instead of 8", size_of(type_of(WGPURegistryReport.numReleasedFromUser)));
        assert(((cast(*void)(*instance.numError)) - cast(*void)(*instance)) == 24, "WGPURegistryReport.numError has unexpected offset % instead of 24", ((cast(*void)(*instance.numError)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURegistryReport.numError)) == 8, "WGPURegistryReport.numError has unexpected size % instead of 8", size_of(type_of(WGPURegistryReport.numError)));
        assert(((cast(*void)(*instance.elementSize)) - cast(*void)(*instance)) == 32, "WGPURegistryReport.elementSize has unexpected offset % instead of 32", ((cast(*void)(*instance.elementSize)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPURegistryReport.elementSize)) == 8, "WGPURegistryReport.elementSize has unexpected size % instead of 8", size_of(type_of(WGPURegistryReport.elementSize)));
        assert(size_of(WGPURegistryReport) == 40, "WGPURegistryReport has size % instead of 40", size_of(WGPURegistryReport));
    }

    {
        instance: WGPUHubReport;
        assert(((cast(*void)(*instance.adapters)) - cast(*void)(*instance)) == 0, "WGPUHubReport.adapters has unexpected offset % instead of 0", ((cast(*void)(*instance.adapters)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUHubReport.adapters)) == 40, "WGPUHubReport.adapters has unexpected size % instead of 40", size_of(type_of(WGPUHubReport.adapters)));
        assert(((cast(*void)(*instance.devices)) - cast(*void)(*instance)) == 40, "WGPUHubReport.devices has unexpected offset % instead of 40", ((cast(*void)(*instance.devices)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUHubReport.devices)) == 40, "WGPUHubReport.devices has unexpected size % instead of 40", size_of(type_of(WGPUHubReport.devices)));
        assert(((cast(*void)(*instance.queues)) - cast(*void)(*instance)) == 80, "WGPUHubReport.queues has unexpected offset % instead of 80", ((cast(*void)(*instance.queues)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUHubReport.queues)) == 40, "WGPUHubReport.queues has unexpected size % instead of 40", size_of(type_of(WGPUHubReport.queues)));
        assert(((cast(*void)(*instance.pipelineLayouts)) - cast(*void)(*instance)) == 120, "WGPUHubReport.pipelineLayouts has unexpected offset % instead of 120", ((cast(*void)(*instance.pipelineLayouts)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUHubReport.pipelineLayouts)) == 40, "WGPUHubReport.pipelineLayouts has unexpected size % instead of 40", size_of(type_of(WGPUHubReport.pipelineLayouts)));
        assert(((cast(*void)(*instance.shaderModules)) - cast(*void)(*instance)) == 160, "WGPUHubReport.shaderModules has unexpected offset % instead of 160", ((cast(*void)(*instance.shaderModules)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUHubReport.shaderModules)) == 40, "WGPUHubReport.shaderModules has unexpected size % instead of 40", size_of(type_of(WGPUHubReport.shaderModules)));
        assert(((cast(*void)(*instance.bindGroupLayouts)) - cast(*void)(*instance)) == 200, "WGPUHubReport.bindGroupLayouts has unexpected offset % instead of 200", ((cast(*void)(*instance.bindGroupLayouts)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUHubReport.bindGroupLayouts)) == 40, "WGPUHubReport.bindGroupLayouts has unexpected size % instead of 40", size_of(type_of(WGPUHubReport.bindGroupLayouts)));
        assert(((cast(*void)(*instance.bindGroups)) - cast(*void)(*instance)) == 240, "WGPUHubReport.bindGroups has unexpected offset % instead of 240", ((cast(*void)(*instance.bindGroups)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUHubReport.bindGroups)) == 40, "WGPUHubReport.bindGroups has unexpected size % instead of 40", size_of(type_of(WGPUHubReport.bindGroups)));
        assert(((cast(*void)(*instance.commandBuffers)) - cast(*void)(*instance)) == 280, "WGPUHubReport.commandBuffers has unexpected offset % instead of 280", ((cast(*void)(*instance.commandBuffers)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUHubReport.commandBuffers)) == 40, "WGPUHubReport.commandBuffers has unexpected size % instead of 40", size_of(type_of(WGPUHubReport.commandBuffers)));
        assert(((cast(*void)(*instance.renderBundles)) - cast(*void)(*instance)) == 320, "WGPUHubReport.renderBundles has unexpected offset % instead of 320", ((cast(*void)(*instance.renderBundles)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUHubReport.renderBundles)) == 40, "WGPUHubReport.renderBundles has unexpected size % instead of 40", size_of(type_of(WGPUHubReport.renderBundles)));
        assert(((cast(*void)(*instance.renderPipelines)) - cast(*void)(*instance)) == 360, "WGPUHubReport.renderPipelines has unexpected offset % instead of 360", ((cast(*void)(*instance.renderPipelines)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUHubReport.renderPipelines)) == 40, "WGPUHubReport.renderPipelines has unexpected size % instead of 40", size_of(type_of(WGPUHubReport.renderPipelines)));
        assert(((cast(*void)(*instance.computePipelines)) - cast(*void)(*instance)) == 400, "WGPUHubReport.computePipelines has unexpected offset % instead of 400", ((cast(*void)(*instance.computePipelines)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUHubReport.computePipelines)) == 40, "WGPUHubReport.computePipelines has unexpected size % instead of 40", size_of(type_of(WGPUHubReport.computePipelines)));
        assert(((cast(*void)(*instance.querySets)) - cast(*void)(*instance)) == 440, "WGPUHubReport.querySets has unexpected offset % instead of 440", ((cast(*void)(*instance.querySets)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUHubReport.querySets)) == 40, "WGPUHubReport.querySets has unexpected size % instead of 40", size_of(type_of(WGPUHubReport.querySets)));
        assert(((cast(*void)(*instance.buffers)) - cast(*void)(*instance)) == 480, "WGPUHubReport.buffers has unexpected offset % instead of 480", ((cast(*void)(*instance.buffers)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUHubReport.buffers)) == 40, "WGPUHubReport.buffers has unexpected size % instead of 40", size_of(type_of(WGPUHubReport.buffers)));
        assert(((cast(*void)(*instance.textures)) - cast(*void)(*instance)) == 520, "WGPUHubReport.textures has unexpected offset % instead of 520", ((cast(*void)(*instance.textures)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUHubReport.textures)) == 40, "WGPUHubReport.textures has unexpected size % instead of 40", size_of(type_of(WGPUHubReport.textures)));
        assert(((cast(*void)(*instance.textureViews)) - cast(*void)(*instance)) == 560, "WGPUHubReport.textureViews has unexpected offset % instead of 560", ((cast(*void)(*instance.textureViews)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUHubReport.textureViews)) == 40, "WGPUHubReport.textureViews has unexpected size % instead of 40", size_of(type_of(WGPUHubReport.textureViews)));
        assert(((cast(*void)(*instance.samplers)) - cast(*void)(*instance)) == 600, "WGPUHubReport.samplers has unexpected offset % instead of 600", ((cast(*void)(*instance.samplers)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUHubReport.samplers)) == 40, "WGPUHubReport.samplers has unexpected size % instead of 40", size_of(type_of(WGPUHubReport.samplers)));
        assert(size_of(WGPUHubReport) == 640, "WGPUHubReport has size % instead of 640", size_of(WGPUHubReport));
    }

    {
        instance: WGPUGlobalReport;
        assert(((cast(*void)(*instance.surfaces)) - cast(*void)(*instance)) == 0, "WGPUGlobalReport.surfaces has unexpected offset % instead of 0", ((cast(*void)(*instance.surfaces)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUGlobalReport.surfaces)) == 40, "WGPUGlobalReport.surfaces has unexpected size % instead of 40", size_of(type_of(WGPUGlobalReport.surfaces)));
        assert(((cast(*void)(*instance.backendType)) - cast(*void)(*instance)) == 40, "WGPUGlobalReport.backendType has unexpected offset % instead of 40", ((cast(*void)(*instance.backendType)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUGlobalReport.backendType)) == 4, "WGPUGlobalReport.backendType has unexpected size % instead of 4", size_of(type_of(WGPUGlobalReport.backendType)));
        assert(((cast(*void)(*instance.vulkan)) - cast(*void)(*instance)) == 48, "WGPUGlobalReport.vulkan has unexpected offset % instead of 48", ((cast(*void)(*instance.vulkan)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUGlobalReport.vulkan)) == 640, "WGPUGlobalReport.vulkan has unexpected size % instead of 640", size_of(type_of(WGPUGlobalReport.vulkan)));
        assert(((cast(*void)(*instance.metal)) - cast(*void)(*instance)) == 688, "WGPUGlobalReport.metal has unexpected offset % instead of 688", ((cast(*void)(*instance.metal)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUGlobalReport.metal)) == 640, "WGPUGlobalReport.metal has unexpected size % instead of 640", size_of(type_of(WGPUGlobalReport.metal)));
        assert(((cast(*void)(*instance.dx12)) - cast(*void)(*instance)) == 1328, "WGPUGlobalReport.dx12 has unexpected offset % instead of 1328", ((cast(*void)(*instance.dx12)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUGlobalReport.dx12)) == 640, "WGPUGlobalReport.dx12 has unexpected size % instead of 640", size_of(type_of(WGPUGlobalReport.dx12)));
        assert(((cast(*void)(*instance.gl)) - cast(*void)(*instance)) == 1968, "WGPUGlobalReport.gl has unexpected offset % instead of 1968", ((cast(*void)(*instance.gl)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUGlobalReport.gl)) == 640, "WGPUGlobalReport.gl has unexpected size % instead of 640", size_of(type_of(WGPUGlobalReport.gl)));
        assert(size_of(WGPUGlobalReport) == 2608, "WGPUGlobalReport has size % instead of 2608", size_of(WGPUGlobalReport));
    }

    {
        instance: WGPUInstanceEnumerateAdapterOptions;
        assert(((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)) == 0, "WGPUInstanceEnumerateAdapterOptions.nextInChain has unexpected offset % instead of 0", ((cast(*void)(*instance.nextInChain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUInstanceEnumerateAdapterOptions.nextInChain)) == 8, "WGPUInstanceEnumerateAdapterOptions.nextInChain has unexpected size % instead of 8", size_of(type_of(WGPUInstanceEnumerateAdapterOptions.nextInChain)));
        assert(((cast(*void)(*instance.backends)) - cast(*void)(*instance)) == 8, "WGPUInstanceEnumerateAdapterOptions.backends has unexpected offset % instead of 8", ((cast(*void)(*instance.backends)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUInstanceEnumerateAdapterOptions.backends)) == 4, "WGPUInstanceEnumerateAdapterOptions.backends has unexpected size % instead of 4", size_of(type_of(WGPUInstanceEnumerateAdapterOptions.backends)));
        assert(size_of(WGPUInstanceEnumerateAdapterOptions) == 16, "WGPUInstanceEnumerateAdapterOptions has size % instead of 16", size_of(WGPUInstanceEnumerateAdapterOptions));
    }

    {
        instance: WGPUBindGroupEntryExtras;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "WGPUBindGroupEntryExtras.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBindGroupEntryExtras.chain)) == 16, "WGPUBindGroupEntryExtras.chain has unexpected size % instead of 16", size_of(type_of(WGPUBindGroupEntryExtras.chain)));
        assert(((cast(*void)(*instance.buffers)) - cast(*void)(*instance)) == 16, "WGPUBindGroupEntryExtras.buffers has unexpected offset % instead of 16", ((cast(*void)(*instance.buffers)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBindGroupEntryExtras.buffers)) == 8, "WGPUBindGroupEntryExtras.buffers has unexpected size % instead of 8", size_of(type_of(WGPUBindGroupEntryExtras.buffers)));
        assert(((cast(*void)(*instance.bufferCount)) - cast(*void)(*instance)) == 24, "WGPUBindGroupEntryExtras.bufferCount has unexpected offset % instead of 24", ((cast(*void)(*instance.bufferCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBindGroupEntryExtras.bufferCount)) == 8, "WGPUBindGroupEntryExtras.bufferCount has unexpected size % instead of 8", size_of(type_of(WGPUBindGroupEntryExtras.bufferCount)));
        assert(((cast(*void)(*instance.samplers)) - cast(*void)(*instance)) == 32, "WGPUBindGroupEntryExtras.samplers has unexpected offset % instead of 32", ((cast(*void)(*instance.samplers)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBindGroupEntryExtras.samplers)) == 8, "WGPUBindGroupEntryExtras.samplers has unexpected size % instead of 8", size_of(type_of(WGPUBindGroupEntryExtras.samplers)));
        assert(((cast(*void)(*instance.samplerCount)) - cast(*void)(*instance)) == 40, "WGPUBindGroupEntryExtras.samplerCount has unexpected offset % instead of 40", ((cast(*void)(*instance.samplerCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBindGroupEntryExtras.samplerCount)) == 8, "WGPUBindGroupEntryExtras.samplerCount has unexpected size % instead of 8", size_of(type_of(WGPUBindGroupEntryExtras.samplerCount)));
        assert(((cast(*void)(*instance.textureViews)) - cast(*void)(*instance)) == 48, "WGPUBindGroupEntryExtras.textureViews has unexpected offset % instead of 48", ((cast(*void)(*instance.textureViews)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBindGroupEntryExtras.textureViews)) == 8, "WGPUBindGroupEntryExtras.textureViews has unexpected size % instead of 8", size_of(type_of(WGPUBindGroupEntryExtras.textureViews)));
        assert(((cast(*void)(*instance.textureViewCount)) - cast(*void)(*instance)) == 56, "WGPUBindGroupEntryExtras.textureViewCount has unexpected offset % instead of 56", ((cast(*void)(*instance.textureViewCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBindGroupEntryExtras.textureViewCount)) == 8, "WGPUBindGroupEntryExtras.textureViewCount has unexpected size % instead of 8", size_of(type_of(WGPUBindGroupEntryExtras.textureViewCount)));
        assert(size_of(WGPUBindGroupEntryExtras) == 64, "WGPUBindGroupEntryExtras has size % instead of 64", size_of(WGPUBindGroupEntryExtras));
    }

    {
        instance: WGPUBindGroupLayoutEntryExtras;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "WGPUBindGroupLayoutEntryExtras.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBindGroupLayoutEntryExtras.chain)) == 16, "WGPUBindGroupLayoutEntryExtras.chain has unexpected size % instead of 16", size_of(type_of(WGPUBindGroupLayoutEntryExtras.chain)));
        assert(((cast(*void)(*instance.count)) - cast(*void)(*instance)) == 16, "WGPUBindGroupLayoutEntryExtras.count has unexpected offset % instead of 16", ((cast(*void)(*instance.count)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUBindGroupLayoutEntryExtras.count)) == 4, "WGPUBindGroupLayoutEntryExtras.count has unexpected size % instead of 4", size_of(type_of(WGPUBindGroupLayoutEntryExtras.count)));
        assert(size_of(WGPUBindGroupLayoutEntryExtras) == 24, "WGPUBindGroupLayoutEntryExtras has size % instead of 24", size_of(WGPUBindGroupLayoutEntryExtras));
    }

    {
        instance: WGPUQuerySetDescriptorExtras;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "WGPUQuerySetDescriptorExtras.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUQuerySetDescriptorExtras.chain)) == 16, "WGPUQuerySetDescriptorExtras.chain has unexpected size % instead of 16", size_of(type_of(WGPUQuerySetDescriptorExtras.chain)));
        assert(((cast(*void)(*instance.pipelineStatistics)) - cast(*void)(*instance)) == 16, "WGPUQuerySetDescriptorExtras.pipelineStatistics has unexpected offset % instead of 16", ((cast(*void)(*instance.pipelineStatistics)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUQuerySetDescriptorExtras.pipelineStatistics)) == 8, "WGPUQuerySetDescriptorExtras.pipelineStatistics has unexpected size % instead of 8", size_of(type_of(WGPUQuerySetDescriptorExtras.pipelineStatistics)));
        assert(((cast(*void)(*instance.pipelineStatisticCount)) - cast(*void)(*instance)) == 24, "WGPUQuerySetDescriptorExtras.pipelineStatisticCount has unexpected offset % instead of 24", ((cast(*void)(*instance.pipelineStatisticCount)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUQuerySetDescriptorExtras.pipelineStatisticCount)) == 8, "WGPUQuerySetDescriptorExtras.pipelineStatisticCount has unexpected size % instead of 8", size_of(type_of(WGPUQuerySetDescriptorExtras.pipelineStatisticCount)));
        assert(size_of(WGPUQuerySetDescriptorExtras) == 32, "WGPUQuerySetDescriptorExtras has size % instead of 32", size_of(WGPUQuerySetDescriptorExtras));
    }

    {
        instance: WGPUSurfaceConfigurationExtras;
        assert(((cast(*void)(*instance.chain)) - cast(*void)(*instance)) == 0, "WGPUSurfaceConfigurationExtras.chain has unexpected offset % instead of 0", ((cast(*void)(*instance.chain)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceConfigurationExtras.chain)) == 16, "WGPUSurfaceConfigurationExtras.chain has unexpected size % instead of 16", size_of(type_of(WGPUSurfaceConfigurationExtras.chain)));
        assert(((cast(*void)(*instance.desiredMaximumFrameLatency)) - cast(*void)(*instance)) == 16, "WGPUSurfaceConfigurationExtras.desiredMaximumFrameLatency has unexpected offset % instead of 16", ((cast(*void)(*instance.desiredMaximumFrameLatency)) - cast(*void)(*instance)));
        assert(size_of(type_of(WGPUSurfaceConfigurationExtras.desiredMaximumFrameLatency)) == 4, "WGPUSurfaceConfigurationExtras.desiredMaximumFrameLatency has unexpected size % instead of 4", size_of(type_of(WGPUSurfaceConfigurationExtras.desiredMaximumFrameLatency)));
        assert(size_of(WGPUSurfaceConfigurationExtras) == 24, "WGPUSurfaceConfigurationExtras has size % instead of 24", size_of(WGPUSurfaceConfigurationExtras));
    }
}

