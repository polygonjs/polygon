//
// This file was auto-generated using the following command:
//
// jai generate.jai
//
#import "imgui";
#import "wgpu";


// Initialization data, for ImGui_ImplWGPU_Init()
ImGui_ImplWGPU_InitInfo :: struct {
    Device:                   WGPUDevice;
    NumFramesInFlight:        s32 = 3;
    RenderTargetFormat:       WGPUTextureFormat = .Undefined;
    DepthStencilFormat:       WGPUTextureFormat = .Undefined;
    PipelineMultisampleState: WGPUMultisampleState;
}

ImGui_ImplWGPU_Init :: (init_info: *ImGui_ImplWGPU_InitInfo) -> bool #foreign imgui_impl_wgpu "_Z19ImGui_ImplWGPU_InitP23ImGui_ImplWGPU_InitInfo";
ImGui_ImplWGPU_Shutdown :: () -> void #foreign imgui_impl_wgpu "_Z23ImGui_ImplWGPU_Shutdownv";
ImGui_ImplWGPU_NewFrame :: () -> void #foreign imgui_impl_wgpu "_Z23ImGui_ImplWGPU_NewFramev";
ImGui_ImplWGPU_RenderDrawData :: (draw_data: *ImDrawData, pass_encoder: WGPURenderPassEncoder) -> void #foreign imgui_impl_wgpu "_Z29ImGui_ImplWGPU_RenderDrawDataP10ImDrawDataP25WGPURenderPassEncoderImpl";

// Use if you want to reset your rendering device without losing Dear ImGui state.
// ImGui_ImplWGPU_InvalidateDeviceObjects :: () -> void #foreign imgui_impl_wgpu "_Z38ImGui_ImplWGPU_InvalidateDeviceObjectsv";
// ImGui_ImplWGPU_CreateDeviceObjects :: () -> bool #foreign imgui_impl_wgpu "_Z34ImGui_ImplWGPU_CreateDeviceObjectsv";

#scope_file

#import "Basic"; // For assert, push_context

imgui_impl_wgpu :: #library "./linux/imgui_impl_wgpu";

#run {
    {
        instance: ImGui_ImplWGPU_InitInfo;
        assert(((cast(*void)(*instance.Device)) - cast(*void)(*instance)) == 0, "ImGui_ImplWGPU_InitInfo.Device has unexpected offset % instead of 0", ((cast(*void)(*instance.Device)) - cast(*void)(*instance)));
        assert(size_of(type_of(ImGui_ImplWGPU_InitInfo.Device)) == 8, "ImGui_ImplWGPU_InitInfo.Device has unexpected size % instead of 8", size_of(type_of(ImGui_ImplWGPU_InitInfo.Device)));
        assert(((cast(*void)(*instance.NumFramesInFlight)) - cast(*void)(*instance)) == 8, "ImGui_ImplWGPU_InitInfo.NumFramesInFlight has unexpected offset % instead of 8", ((cast(*void)(*instance.NumFramesInFlight)) - cast(*void)(*instance)));
        assert(size_of(type_of(ImGui_ImplWGPU_InitInfo.NumFramesInFlight)) == 4, "ImGui_ImplWGPU_InitInfo.NumFramesInFlight has unexpected size % instead of 4", size_of(type_of(ImGui_ImplWGPU_InitInfo.NumFramesInFlight)));
        assert(((cast(*void)(*instance.RenderTargetFormat)) - cast(*void)(*instance)) == 12, "ImGui_ImplWGPU_InitInfo.RenderTargetFormat has unexpected offset % instead of 12", ((cast(*void)(*instance.RenderTargetFormat)) - cast(*void)(*instance)));
        assert(size_of(type_of(ImGui_ImplWGPU_InitInfo.RenderTargetFormat)) == 4, "ImGui_ImplWGPU_InitInfo.RenderTargetFormat has unexpected size % instead of 4", size_of(type_of(ImGui_ImplWGPU_InitInfo.RenderTargetFormat)));
        assert(((cast(*void)(*instance.DepthStencilFormat)) - cast(*void)(*instance)) == 16, "ImGui_ImplWGPU_InitInfo.DepthStencilFormat has unexpected offset % instead of 16", ((cast(*void)(*instance.DepthStencilFormat)) - cast(*void)(*instance)));
        assert(size_of(type_of(ImGui_ImplWGPU_InitInfo.DepthStencilFormat)) == 4, "ImGui_ImplWGPU_InitInfo.DepthStencilFormat has unexpected size % instead of 4", size_of(type_of(ImGui_ImplWGPU_InitInfo.DepthStencilFormat)));
        assert(((cast(*void)(*instance.PipelineMultisampleState)) - cast(*void)(*instance)) == 24, "ImGui_ImplWGPU_InitInfo.PipelineMultisampleState has unexpected offset % instead of 24", ((cast(*void)(*instance.PipelineMultisampleState)) - cast(*void)(*instance)));
        assert(size_of(type_of(ImGui_ImplWGPU_InitInfo.PipelineMultisampleState)) == 24, "ImGui_ImplWGPU_InitInfo.PipelineMultisampleState has unexpected size % instead of 24", size_of(type_of(ImGui_ImplWGPU_InitInfo.PipelineMultisampleState)));
        assert(size_of(ImGui_ImplWGPU_InitInfo) == 48, "ImGui_ImplWGPU_InitInfo has size % instead of 48", size_of(ImGui_ImplWGPU_InitInfo));
    }
}

