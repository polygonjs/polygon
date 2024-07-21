// Bindings for Dear ImGui_Impl_WGPU.


#scope_module

#import "Basic";
#import "Math";

#if OS == .WINDOWS {
    #load "windows.jai";
    #system_library,link_always "user32"; // Needed by imgui unless ImGui is compiled it with "IMGUI_DISABLE_WIN32_DEFAULT_CLIPBOARD_FUNCS"
} else {
    #load "unix.jai";
}

