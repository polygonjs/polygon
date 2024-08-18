AT_COMPILE_TIME :: true;

// We don’t ship the Dear ImGui source with the compiler. Download a Dear ImGui release and update this path if you want to re-generate the bindings.
// cd /home/gui/work/web/github/imgui && git checkout v1.90.9
//
// also git clone https://github.com/nothings/stb
// and ensure that we have #define stbsp__uintptr stbsp__uint64
// by commenting out the lines before and after
// (or maybe we could just add "#define __x86_64__" to force it despite compiling for wasm)
//
// and make sure to uncomment
// #define IMGUI_DISABLE_FILE_FUNCTIONS
// #define IMGUI_DISABLE_DEFAULT_FILE_FUNCTIONS
// #define IMGUI_STB_SPRINTF_FILENAME    "../stb/stb_sprintf.h"
// #define IMGUI_USE_STB_SPRINTF
// #define ImDrawIdx unsigned int
// in imconfig.h
//
// and in generated file:
// ImDrawIdx :: u32; // instead of u16
//
//
// jai generate.jai - -compile -native -debug
// jai generate.jai - -native -debug
//
// or
//
// jai generate.jai - -wasm -debug
// jai generate.jai - -compile -wasm -no_generate -debug
//
// or
//
// jai generate.jai - -compile -wasm && jai generate.jai - -compile -native
//
// test with: nm -g linux/ImGui.a | grep Impl
IMGUI_PATH :: "/home/gui/work/web/github/imgui";
MODULES_PATH :: "/home/gui/work/web/games/polygon-next/src/jai/modules";
EMSDK_PATH :: "/home/gui/work/web/games/emsdk";


DECLARATIONS_TO_OMIT :: string.[
	// We have custom declarations for these in module.jai:
	"ImVec2",
	"ImVec4",
	"ImColor",
	"ImVector",
	"ImDrawCallback",

	// Jai has its own, better "String_Builder"
	"ImGuiTextBuffer",

	"ImDrawCallback_ResetRenderState", // casting an integer to a function pointer is not supported in Jai.
];

#import "String";

#if AT_COMPILE_TIME {
	#import "Process";

	#run,stallable {
		set_build_options_dc(.{do_output=false});
		root_options := get_build_options();
		args := root_options.compile_time_command_line;
		if !generate_bindings(args) {
			compiler_set_workspace_status(.FAILED);
		}
	}
} else {
	#import "System";

	main :: () {
		set_working_directory(path_strip_filename(get_path_of_running_executable()));
		args := get_command_line_arguments();
		if !generate_bindings(args) {
			exit(1);
		}
	}
}

generate_bindings :: (args: [] string) -> bool {
	compile        := array_find(args, "-compile");
	native         := array_find(args, "-native");
	wasm           := array_find(args, "-wasm");
	compile_debug  := array_find(args, "-debug");
	no_generate    := array_find(args, "-no_generate");

	imgui_src_files: [..] string;
	array_add(*imgui_src_files, tprint("%/imgui.cpp", IMGUI_PATH));
	array_add(*imgui_src_files, tprint("%/imgui_widgets.cpp", IMGUI_PATH));
	array_add(*imgui_src_files, tprint("%/imgui_draw.cpp", IMGUI_PATH));
	array_add(*imgui_src_files, tprint("%/imgui_tables.cpp", IMGUI_PATH));
	// @ToDo: Maybe add an option to exclude imgui_demo?
	array_add(*imgui_src_files, tprint("%/imgui_demo.cpp", IMGUI_PATH));

	IMGUI_MODULE_PATH := tprint("%/imgui", MODULES_PATH);
	IMGUI_WASM_MODULE_PATH := tprint("%/wasm", IMGUI_MODULE_PATH);

	if compile {

		success := true;
		if native {
			#if OS == .WINDOWS {
				make_directory_if_it_does_not_exist("windows");
				success &&= build_cpp_dynamic_lib("windows/ImGui", ..imgui_src_files, extra = .["/DIMGUI_API=__declspec(dllexport)"], debug=compile_debug);
				// We set IMGUI_DISABLE_WIN32_DEFAULT_IME_FUNCTIONS. Otherwise all users of the ImGui module have to link against "imm32".
				success &&= build_cpp_static_lib("windows/ImGui", ..imgui_src_files, extra = .["/DIMGUI_API=__declspec(dllexport)", "/DIMGUI_DISABLE_WIN32_DEFAULT_IME_FUNCTIONS"], debug=compile_debug);
			} else #if OS == .LINUX {
				make_directory_if_it_does_not_exist("linux");
				success &&= build_cpp_dynamic_lib("linux/ImGui", ..imgui_src_files, debug=compile_debug);
				// @Hack: Is -fno-threadsafe-statics really the way to go? Without it, we get linker errors when using the static library
				// due to "__cxa_guard_acquire" et al not being defined. The library users probably need to link agains libc++ or something. But do we really want to enforce that?
				success &&= build_cpp_static_lib("linux/ImGui", ..imgui_src_files, extra = .["-fno-exceptions", "-fno-rtti", "-fno-threadsafe-statics"], debug=compile_debug);

				// generate the .so and .a in the wasm folder with those commands:
				// em++ --target=wasm64-unknown-emscripten -g -O2 -c -fpic -o imgui.o /home/gui/work/web/github/imgui/imgui.cpp
				// em++ --target=wasm64-unknown-emscripten -g -O2 -c -fpic -o imgui_widgets.o /home/gui/work/web/github/imgui/imgui_widgets.cpp
				// em++ --target=wasm64-unknown-emscripten -g -O2 -c -fpic -o imgui_draw.o /home/gui/work/web/github/imgui/imgui_draw.cpp
				// em++ --target=wasm64-unknown-emscripten -g -O2 -c -fpic -o imgui_tables.o /home/gui/work/web/github/imgui/imgui_tables.cpp
				// em++ --target=wasm64-unknown-emscripten -g -O2 -c -fpic -o imgui_demo.o /home/gui/work/web/github/imgui/imgui_demo.cpp
				// emar rcs ImGui.a imgui.o imgui_widgets.o imgui_draw.o imgui_tables.o imgui_demo.o
				// em++ -v --target=wasm64-unknown-emscripten -g -O2 -s SIDE_MODULE=1 -o ImGui.so imgui.o imgui_widgets.o imgui_draw.o imgui_tables.o imgui_demo.o
			} else #if OS == .MACOS {
				#import "Process";
				make_directory_if_it_does_not_exist("macos");
				macos_x64_version_arg   := "-mmacos-version-min=10.13"; // Our current x64 min version
				macos_arm64_version_arg := "-mmacos-version-min=11.0";  // Earliest version that supports arm64
				// x64 variant
				success &&= build_cpp_dynamic_lib("macos/ImGui_x64",   ..imgui_src_files, extra = .["-arch", "x86_64", "-std=c++20", macos_x64_version_arg], debug=compile_debug);
				// @Hack: Is -fno-threadsafe-statics really the way to go? Without it, we get linker errors when using the static library
				// due to "__cxa_guard_acquire" et al not being defined. The library users probably need to link agains libc++ or something. But do we really want to enforce that?
				success &&= build_cpp_static_lib( "macos/ImGui_x64",   ..imgui_src_files, extra = .["-arch", "x86_64", "-std=c++20", "-fno-exceptions", "-fno-rtti", "-fno-threadsafe-statics", macos_x64_version_arg], debug=compile_debug);
				// arm64 variant
				success &&= build_cpp_dynamic_lib("macos/ImGui_arm64", ..imgui_src_files, extra = .["-arch", "arm64",  "-std=c++20", macos_arm64_version_arg], debug=compile_debug);
				success &&= build_cpp_static_lib( "macos/ImGui_arm64", ..imgui_src_files, extra = .["-arch", "arm64",  "-std=c++20", "-fno-exceptions", "-fno-rtti", "-fno-threadsafe-statics", macos_arm64_version_arg], debug=compile_debug);
				// create universal binaries
				run_result := run_command("lipo", "-create", "macos/ImGui_x64.dylib", "macos/ImGui_arm64.dylib", "-output", "macos/ImGui.dylib");
				success &&= (run_result.exit_code == 0);
				run_result =  run_command("lipo", "-create", "macos/ImGui_x64.a", "macos/ImGui_arm64.a", "-output", "macos/ImGui.a");
				success &&= (run_result.exit_code == 0);
			} else {
				assert(false);
			}
		}

		if !success     return false;

		if wasm {
			success := true;
			o_files:[..]string;
			run_result := run_command("pwd");
			for imgui_src_files {
				o_file := replace(it, ".cpp", ".o");
				o_file = replace(o_file, tprint("%/", IMGUI_PATH), "");
				array_add(*o_files, o_file);
				// cmd_o_file := tprint("em++ --target=wasm64-unknown-emscripten -g -O2 -c -fpic -pthread -o % % ", o_file, it);
				cmd_o_file := tprint("clang++ -Oz --target=wasm64 --sysroot=%/upstream/emscripten/cache/sysroot -D_LIBCPP_HAS_NO_THREADS -c -o % %", EMSDK_PATH, o_file, it);

				print("%\n", cmd_o_file);
				run_result := run_command(..split(cmd_o_file, " "), working_directory=IMGUI_WASM_MODULE_PATH);
				success &&= (run_result.exit_code == 0);
			}

			cmd_emar := tprint("emar rcs ImGui.a imgui.o %", join(..o_files, " "));
			print("%\n", cmd_emar);
			run_result = run_command(..split(cmd_emar, " "), working_directory=IMGUI_WASM_MODULE_PATH);
			success &&= (run_result.exit_code == 0);
			if !success     return false;

			cmd_empp := tprint("em++ -v --target=wasm64-unknown-emscripten -g -O2 -o ImGui.so %", join(..o_files, " "));
			print("%\n", cmd_empp);
			run_result = run_command(..split(cmd_empp, " "), working_directory=IMGUI_WASM_MODULE_PATH);
			success &&= (run_result.exit_code == 0);
			if !success     return false;

			cmd_clean := tprint("rm % ImGui.wasm", join(..o_files, " "));
			print("%\n", cmd_clean);
			run_result = run_command(..split(cmd_clean, " "), working_directory=IMGUI_WASM_MODULE_PATH);
			success &&= (run_result.exit_code == 0);

			if !success     return false;
		}
	}
	if(no_generate) return true;

	defer array_reset(*begin_end_string_args);

	output_filename: string;
	opts: Generate_Bindings_Options;
	{
		using opts;

		#if OS == .WINDOWS {
			array_add(*libpaths, "windows");
			output_filename = "windows.jai";
		} else {
			if wasm {
				array_add(*libpaths, "wasm");
				footer = FOOTER_WASM;
			} else {
				#if OS == .LINUX {
					array_add(*libpaths, "linux");
				} else #if OS == .MACOS {
					array_add(*libpaths, "macos");
				} else {
					assert(false);
				}
				footer = FOOTER_UNIX;
			}
			output_filename = ifx wasm then "wasm.jai"  else "unix.jai";
			generate_library_declarations = false;
		}

		array_add(*libnames,      "ImGui");
		array_add(*include_paths, IMGUI_PATH);
		array_add(*source_files,  tprint("%/imgui.h", IMGUI_PATH));
		array_add(*extra_clang_arguments, "-x", "c++", "-DWIN32_LEAN_AND_MEAN");
		// array_add(*flatten_namespaces, "ImGui");
		// array_add(*strip_prefixes, "ImGui");
		auto_detect_enum_prefixes = false;
		log_stripped_declarations = false;
		generate_compile_time_struct_checks = false;
		strip_flags |= .INLINED_FUNCTIONS; // "inline" functions are not present in the static library.

		visitor   = imgui_visitor;
		get_func_args_for_printing = imgui_get_function_arg_for_printing;
	}

	return generate_bindings(opts, output_filename);
}

begin_end_string_args: [..]*Declaration;

enums_for_typedefs: Table(string, *Enum);

imgui_visitor :: (decl: *Declaration, parent_decl: *Declaration) -> Declaration_Visit_Result {
	// ImGui has "typedef ints" for each enum. but we want to just use the enums directly,
	// so we get nice type safety, and .unary dots, etc.
	//
	// Look for declarations inside functions (i.e., arguments) or structs (i.e., fields)
	get_associated_enum_name :: (name: string) -> string {
		if name.count > 1 && name[name.count - 1] != #char "_" {
			return tprint("%_", name);
		}
		return name;
	}

	if !parent_decl {
		if array_find(DECLARATIONS_TO_OMIT, decl.name) {
			decl.decl_flags |= .OMIT_FROM_OUTPUT;
			return .STOP;
		}
		if decl.name == "ImGuiContext" {
			decl.output_name = decl.name; // Don’t shorten ImGuiContext to Context as this would conflict
		}

		
		if decl.kind == .TYPEDEF {
			old_name := decl.name;
			if old_name {
				new_name := get_associated_enum_name(old_name);
				for context.generator.global_scope.members {
					if it.kind != .ENUM  || it.name != new_name     continue;

					en := cast(*Enum)it;

					// Don't output the integer typedef
					decl.decl_flags |= .OMIT_FROM_OUTPUT;

					// Make sure the enums like "FocusFlags_" get outputted as "FocusFlags"
					if en.output_name.count > 2 && en.output_name[en.output_name.count - 1] == #char "_" {
						en.output_name.count -= 1;
					}

					// Keep the comment, if there is one:
					if decl.comment.text && !en.comment.text {
						en.comment = decl.comment;
					}

					table_add(*enums_for_typedefs, old_name, en);
					break;
				}
			}
		}
	}

	// Look for function arguments with "typedef" types.
	if parent_decl &&
		(parent_decl.kind == .FUNCTION || parent_decl.kind == .STRUCT) &&
		decl.kind == .DECLARATION && decl.type.type_of_typedef != null
	{
		old_name := decl.type.type_of_typedef.name;
		if old_name {
			en, found := table_find(*enums_for_typedefs, old_name);
			if found {
				change_type_to_enum(decl, en);
			}
		}
	}

	if decl.kind == .ENUM {
		// ImGui has lots of enums that should be enum flags. Luckily, they all end in "…Flags_".
		if ends_with(decl.name, "Flags_") {
			en := cast(*Enum)decl;
			en.flags |= .IS_ENUM_FLAGS;
			en.flags |= .VALUES_IN_HEX;
		}
	}

	if decl.kind == .FUNCTION {
		func := cast(*Function)decl;
		type := func.type.type_of_function;
		// if(ends_with(decl.name, "GetIO")) {
			// print("%: %\n", decl.name, parent_decl.kind);
			// if (parent_decl && parent_decl.kind == .NAMESPACE) {
			// 	// print("%: %\n", decl.name, parent_decl.kind);
			// 	func.output_name = tprint("ImGui_JAI_%", decl.name);
			// }
		// }
		// ImGui also has functions with pairs of arguments like "text_begin" and "text_end"
		// for the pointers to the beginning and end of a string. We'll generate wrappers for
		// those function which take a jai string.
		//
		// Here we collect pointers to "_begin" arguments, and use them in
		// get_func_args_for_printing below.
		for type.arguments {
			if it_index == 0 || !ends_with(it.name, "_end")     continue;
			arg_type := find_underlying_type(it.type);
			if !arg_type.pointer_to || !(arg_type.pointer_to.number_flags & ._8BIT) continue; // Only convert *u8 ranges to string

			name_part := slice(it.name, 0, it.name.count - "_end".count);
			if !name_part   continue;

			// the first arg may appear as "text_begin" or just "text"
			name_part_with_begin := tprint("%_begin", name_part);
			prev_arg := type.arguments[it_index - 1];
			if prev_arg.name == name_part || prev_arg.name == name_part_with_begin {
				array_add(*begin_end_string_args, prev_arg);
				func.decl_flags |= .NEEDS_ARGUMENT_WRAPPER;
			}
		}
	}

	return .RECURSE;
}

// Modify function with _begin and _end string arguments as they get printed.
// See the note above about "text_begin".
imgui_get_function_arg_for_printing :: (func: *Function, type: *Function_Type, mode: Arg_Print_Mode) -> []*Declaration {
	args: [..]*Declaration;
	for type.arguments {
		if array_find(begin_end_string_args, it) {
			if mode == {
				case .OUTER_WRAPPER;
					// For the outer wrapper, remove any "_begin" part of the argument, and
					// change its type to a jai string
					arg_copy := New(Declaration);
					(<<arg_copy) = <<it;
					arg_copy.type = context.generator.type_def_jai_string;
					if ends_with(it.name, "_begin") {
						arg_copy.output_name = slice(it.name, 0, it.name.count - "_begin".count);
					}
					array_add(*args, arg_copy);

					it_index += 1; // skip the next argument-we collpase the _begin and _end args into one string arg

					continue;
				case .INNER_WRAPPER_CALL;
					// For the inner wrapper function call, we pass the incoming arg
					// as two arguments: "jai_string.data, jai_string.data + jai_string.count" -- corresponding
					// to the _begin and _end parts.
					base_arg_name := it.name;
					if ends_with(it.name, "_begin") {
						base_arg_name = slice(it.name, 0, it.name.count - "_begin".count);
					}

					arg_copy := New(Declaration);
					(<<arg_copy) = <<it;
					arg_copy.output_name = tprint("%.data", base_arg_name);
					array_add(*args, arg_copy);

					arg_copy_2 := New(Declaration);
					(<<arg_copy_2) = <<it;
					arg_copy_2.output_name = tprint("%.data + %.count", base_arg_name, base_arg_name);
					array_add(*args, arg_copy_2);

					it_index += 1; // skip the next arg, since we already added a second one above
					continue;
			}
		}

		array_add(*args, it);
	}

	return args;
}

#import "Basic";
#import "Bindings_Generator";
#import "BuildCpp";
#import "Compiler";
#import "File";
#import "Hash_Table";
#import "String";

FOOTER_UNIX :: #string END

#if OS == .MACOS    imgui :: #library "macos/ImGui";
#if OS == .LINUX    imgui :: #library "linux/ImGui";

END

FOOTER_WASM :: #string END

imgui :: #library "wasm/ImGui";

END
