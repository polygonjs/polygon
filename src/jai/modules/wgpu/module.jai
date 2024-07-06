#load "native.jai";
#load "helpers.jai";

#scope_module

#if OS == .WINDOWS  libwgpu_native :: #library "win/libwgpu_native";
#if OS == .MACOS    libwgpu_native :: #library "mac/libwgpu_native";
#if OS == .LINUX    libwgpu_native :: #library "linux/libwgpu_native";