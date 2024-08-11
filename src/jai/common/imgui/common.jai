UiData :: struct {
	f:float = 0.0;
	counter:u32 = 0;
	show_another_window:bool = true;
}

RenderResources :: struct {
	FontTexture:WGPUTexture=null;          // Font texture
	FontTextureView:WGPUTextureView=null;      // Texture view for font texture
	Sampler :WGPUSampler=null;              // Sampler for the font texture
	Uniforms:WGPUBuffer=null;             // Shader uniforms
	CommonBindGroup:WGPUBindGroup=null;      // Resources bind-group to bind the common resources to pipeline
	ImageBindGroups:ImGuiStorage;                // Resources bind-group to bind the font/image resources to pipeline (this is a key->value map)
	ImageBindGroup:WGPUBindGroup=null;       // Default font-resource of Dear ImGui
	ImageBindGroupLayout:WGPUBindGroupLayout=null; // Cache layout used for the image bind group. Avoids allocating unnecessary JS objects when working with WebASM
};

FrameResources :: struct {
	IndexBuffer:WGPUBuffer;
	VertexBuffer:WGPUBuffer;
	IndexBufferHost:*ImDrawIdx;
	VertexBufferHost:*ImDrawVert;
	IndexBufferSize:u64;
	VertexBufferSize:u64;
};
WindowContext :: struct {
	#if WASM {

	} else {
		window:*SDL_Window;
	}
}
ImGui_WGPU_Uniforms :: struct {
	MVP: Matrix4;
	Gamma: float;
};
ImGui_ImplWGPU_Data_Resolution :: struct {
	width : u32;
	height : u32;
}
ImGui_ImplWGPU_Data :: struct {
	wgpuDevice:	WGPUDevice=null;
	defaultQueue: WGPUQueue=null;
	renderTargetFormat:WGPUTextureFormat = WGPUTextureFormat.Undefined;
	depthStencilFormat:WGPUTextureFormat = WGPUTextureFormat.Undefined;
	pipeline:WGPURenderPipeline=null;

	renderResources:RenderResources;
	pFrameResources: [..]FrameResources;
	numFramesInFlight:u64 = 0;
	frameIndex:u64 = U64_MAX;//UINT_MAX;

	resolution: ImGui_ImplWGPU_Data_Resolution = .{width=1, height=1};
};
ImGui_ImplWGPU_InitInfo :: struct {
	// Device:WGPUDevice;
	NumFramesInFlight:u8 = 3;
	RenderTargetFormat:WGPUTextureFormat = WGPUTextureFormat.Undefined;
	DepthStencilFormat:WGPUTextureFormat = WGPUTextureFormat.Undefined;
	PipelineMultisampleState:WGPUMultisampleState = .{
		count = 1,
		mask = U32_MAX,
		alphaToCoverageEnabled = xx false
	};
};

ImGui_WGPU_Common_ShaderModule :: struct {
	wgsl_desc : WGPUShaderModuleWGSLDescriptor;
	desc :WGPUShaderModuleDescriptor;
	stage_desc :WGPUProgrammableStageDescriptor;
}
ImGui_WGPU_Common_FontTexture :: struct {
	tex_desc:WGPUTextureDescriptor;
	tex_view_desc:WGPUTextureViewDescriptor;
	dst_view:WGPUImageCopyTexture;
	size: WGPUExtent3D;
	layout:WGPUTextureDataLayout;
	sampler_desc:WGPUSamplerDescriptor;
}
ImGui_WGPU_Common_Uniforms :: struct {
	ub_desc:WGPUBufferDescriptor;
}
ImGui_WGPU_Common_Draw :: struct {
	im_draw_verts :[..]ImDrawVert;
	im_draw_idxs :[..]ImDrawIdx;
}


ImGui_WGPU_Common :: struct {
	graphics_pipeline_desc : WGPURenderPipelineDescriptor;
	common_bg_layout_entries: [2]WGPUBindGroupLayoutEntry;
	image_bg_layout_entries:[1]WGPUBindGroupLayoutEntry;
	common_bg_layout_desc:WGPUBindGroupLayoutDescriptor=.{label="common_bg_layout_desc (imgui)"};
	image_bg_layout_desc:WGPUBindGroupLayoutDescriptor=.{label="image_bg_layout_desc (imgui)"};
	bg_layouts:[2]WGPUBindGroupLayout;
	layout_desc:WGPUPipelineLayoutDescriptor;
	vert : ImGui_WGPU_Common_ShaderModule;
	frag :ImGui_WGPU_Common_ShaderModule;
	vertex_shader_desc:WGPUProgrammableStageDescriptor;
	attribute_desc:[3]WGPUVertexAttribute;
	buffer_layouts:[1]WGPUVertexBufferLayout;
	pixel_shader_desc :WGPUProgrammableStageDescriptor;
	blend_state:WGPUBlendState;
	color_state:WGPUColorTargetState;
	fragment_state:WGPUFragmentState;
	depth_stencil_state:WGPUDepthStencilState;
	common_bg_entries:[2]WGPUBindGroupEntry;
	common_bg_descriptor:WGPUBindGroupDescriptor=.{label="common_bg_descriptor (imgui)"};
	image_bind_group:WGPUBindGroup;
	font_texture: ImGui_WGPU_Common_FontTexture;
	uniforms: ImGui_WGPU_Common_Uniforms;
	draw: ImGui_WGPU_Common_Draw;
}