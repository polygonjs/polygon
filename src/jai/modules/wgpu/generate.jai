

#run build();

build :: () {
	set_build_options_dc(.{do_output=false});

	if !generate_bindings() {
		compiler_set_workspace_status(.FAILED);
		return;
	}

}

generate_bindings :: () -> bool {
	output_filename: string;
	opts: Generate_Bindings_Options;
	{
		using opts;

		#if OS == .WINDOWS {
			output_filename          = "windows.jai";
			strip_flags = 0;
		} else #if OS == .LINUX {
			output_filename          = "linux.jai";
			array_add(*libpaths,       "./linux");
			strip_flags = .INLINED_FUNCTIONS; // Inlined constructor doesn't exist in the library
		} else #if OS == .MACOS {
			output_filename          = "macos.jai";
			strip_flags = .INLINED_FUNCTIONS; // Inlined constructor doesn't exist in the library
		} else {
			assert(false);
		}
		// strip_flags &= ~(Strip_Flags.CONSTRUCTORS | .DESTRUCTORS);

		array_add(*libnames,      "libwgpu_native");
		array_add(*source_files,  "linux/webgpu.h");
		array_add(*source_files,  "linux/wgpu.h");
		array_add(*strip_prefixes, "wgpu");
		array_add(*strip_prefixes, "WGPU");
		array_add(*extra_clang_arguments, "-x", "c++", "-DWIN32_LEAN_AND_MEAN");

	}

	return generate_bindings(opts, output_filename);
}

#scope_file

#import "Basic";
#import "Compiler";
#import "BuildCpp";
#import "Check";
#import "Bindings_Generator";
#import "File";
