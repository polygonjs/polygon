#import "Basic";
#import "Compiler";
#import "BuildCpp";
#import "Check";
#import "Bindings_Generator";
#import "File";

#run{
	compile();
	generate_bindings();
}

main :: () {
	print("main\n");
}

IMGUI_PATH :: "/home/gui/work/web/github/imgui";
MODULES_PATH :: "/home/gui/work/web/games/polygon-next/src/jai/modules";
PREFIX_TO_KEEP :: "ImGui_ImplWGPU_";

compile :: (){
	WEBGPU_PATH := tprint("%/wgpu", MODULES_PATH);

	// static lib
	{
		cmd1 := tprint(
			"clang++ -c -fpic -I% -I%/linux %/imgui/backends/imgui_impl_wgpu.cpp -o imgui_impl_wgpu.o",
			IMGUI_PATH,
			WEBGPU_PATH,
			MODULES_PATH
		);
		cmd2 :=	"ar rcs linux/imgui_impl_wgpu.a imgui_impl_wgpu.o";
		print("------------\n");
		print("%\n", cmd1);
		print("%\n", cmd2);
		print("------------\n");
	}
	// dynamic lib
	{
		cmd1 := tprint(
			"clang++ -c -fpic -I% -I%/linux %/imgui/backends/imgui_impl_wgpu.cpp -o imgui_impl_wgpu.o",
			IMGUI_PATH,
			WEBGPU_PATH,
			MODULES_PATH,
		);
		cmd2 := tprint(
			"clang++ -shared -o linux/imgui_impl_wgpu.so imgui_impl_wgpu.o -L%/imgui/linux -l:ImGui.a -L%/wgpu/linux -lwgpu_native -Wl,-rpath=/home/gui/work/web/games/polygon-next/src/jai/modules/wgpu/linux -lstdc++",
			MODULES_PATH,
			MODULES_PATH
		);
		print("------------\n");
		print("%\n", cmd1);
		print("%\n", cmd2);
		print("------------\n");
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
			output_filename          = "unix.jai";
			array_add(*libpaths,       tprint("%/imgui_impl_wgpu/linux", MODULES_PATH));
			array_add(*include_paths,  tprint("%", IMGUI_PATH));
			array_add(*include_paths,  tprint("%/imgui_impl_wgpu/linux", MODULES_PATH));
			array_add(*include_paths,  tprint("%/wgpu/linux", MODULES_PATH));
			strip_flags = .INLINED_FUNCTIONS; // Inlined constructor doesn't exist in the library
		} else #if OS == .MACOS {
			output_filename          = "macos.jai";
			strip_flags = .INLINED_FUNCTIONS; // Inlined constructor doesn't exist in the library
		} else {
			assert(false);
		}
		// strip_flags &= ~(Strip_Flags.CONSTRUCTORS | .DESTRUCTORS);

		array_add(*libnames,      "imgui_impl_wgpu");
		array_add(*source_files,  tprint("%/imgui/backends/imgui_impl_wgpu.h", MODULES_PATH));
		// array_add(*strip_prefixes, "wgpu");
		// array_add(*strip_prefixes, "WGPU");
		array_add(*extra_clang_arguments, "-x", "c++", "-DWIN32_LEAN_AND_MEAN");

		log_stripped_declarations = false;
		visitor   = imgui_impl_wgpu_visitor;

	}

	return generate_bindings(opts, output_filename);
}

string_contain :: (a:string, b:string)->bool {
	min_count := ifx a.count < b.count then a.count else b.count;
	for 0..(min_count-1) {
		if( a[it] != b[it] ) {
			return false;
		}
	}
	return true;
}

imgui_impl_wgpu_visitor :: (decl: *Declaration, parent_decl: *Declaration) -> Declaration_Visit_Result {
	if !parent_decl {
		if( string_contain(PREFIX_TO_KEEP, decl.name) == false ){
			decl.decl_flags |= .OMIT_FROM_OUTPUT;
			return .STOP;
		}
	}

	return .RECURSE;
}