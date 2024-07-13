#if OS == .WINDOWS {
	#load "windows.jai";
} else #if OS == .LINUX {
	#load "linux.jai";
} else #if OS == .MACOS {
	#load "mac.jai";
} else {
	assert(false);
}

#scope_module

#if OS == .WINDOWS  libwgpu_native :: #library "win/libwgpu_native";
#if OS == .MACOS    libwgpu_native :: #library "mac/libwgpu_native";
#if OS == .LINUX    libwgpu_native :: #library "linux/libwgpu_native";