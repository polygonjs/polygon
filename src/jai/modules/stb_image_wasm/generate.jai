AT_COMPILE_TIME :: true;

// jai src/jai/modules/stb_image_wasm/generate.jai - -wasm -compile
// cd src/jai/modules/stb_image_wasm && jai generate.jai - -wasm -compile

STB_SOURCE_PATH :: "/home/gui/work/web/github/stb";
LIB_BASE_NAME :: "stb_image";
EMSDK_PATH :: "/home/gui/work/web/games/emsdk";
STB_IMAGE_WASM_MODULE_PATH :: "/home/gui/work/web/games/polygon-next/src/jai/modules/stb_image_wasm";

#if AT_COMPILE_TIME {
    #run,stallable {
        set_build_options_dc(.{do_output=false});
        options := get_build_options();
        args := options.compile_time_command_line;
        if !generate_bindings(args, options.minimum_os_version) {
            compiler_set_workspace_status(.FAILED);
        }
    }
} else {
    #import "System";

    main :: () {
        set_working_directory(path_strip_filename(get_path_of_running_executable()));
        if !generate_bindings(get_command_line_arguments(), #run get_build_options().minimum_os_version) {
            exit(1);
        }
    }
}

generate_bindings :: (args: [] string, minimum_os_version: type_of(Build_Options.minimum_os_version)) -> bool {
    target_wasm := array_find(args, "-wasm");
	target_android := array_find(args, "-android");
    target_x64     := array_find(args, "-x64");
    target_arm     := array_find(args, "-arm64");
    compile        := array_find(args, "-compile");
    compile_debug  := array_find(args, "-debug");

    os_target  := OS;
    cpu_target := CPU;
    if target_wasm    os_target  = .WASM;
    if target_android os_target  = .ANDROID;
    if target_x64     cpu_target = .X64;
    if target_arm     cpu_target = .ARM64;

    lib_directory: string;
    if os_target == {
        case .WINDOWS;
            lib_directory = "windows";
        case .LINUX;
            lib_directory = "linux";
        case .MACOS;
            lib_directory = "macos";
        case .WASM;
            lib_directory = "wasm";
        case .ANDROID;
            lib_directory = ifx cpu_target == .X64 then "android/x64" else "android/arm64";
        case .PS5;
            lib_directory = "ps5";
        case;
            assert(false, "Unsupported target");
    }

    if compile {
        source_file := tprint("%/stb_image.h", STB_SOURCE_PATH);

		print("lib_directory: %\n", lib_directory);
        make_directory_if_it_does_not_exist(lib_directory, recursive = true);
        lib_path := tprint("%/%", lib_directory, LIB_BASE_NAME);
        success := true;
		if os_target == .WASM {
			success := true;

			args :[11]string = .[
				"-Oz",
				// "-fno-builtin",
				// "--target=wasm64",
				"--target=wasm64-unknown-emscripten",
				tprint("--sysroot=%/upstream/emscripten/cache/sysroot", EMSDK_PATH),
				"-fPIC",
				"-DSTB_IMAGE_IMPLEMENTATION",
				// "--no-standard-libraries",
				// "-Wl,--no-entry",
				// "-Wl,--export=stbi_load_from_memory",
				
				// "-Wl,--export=malloc",
				// "-Wl,--export=heap_reset",
				// "-Wl,--allow-undefined",
				// -x c is important to have clang understand
				// the .h file as a c file
				"-x","c",
				"-c",
				"-o",
				"wasm/stb_image.o",
				source_file,
			];
			cmd_o_file := tprint("clang %", join(..args, " "));
			print("%\n", cmd_o_file);
			run_result := run_command(..split(cmd_o_file, " "), working_directory=STB_IMAGE_WASM_MODULE_PATH);
			success &&= (run_result.exit_code == 0);
			print("run_result: %\n", run_result);

			cmd_emar := tprint("emar rcs wasm/stb_image.a wasm/stb_image.o");
			print("%\n", cmd_emar);
			run_result = run_command(..split(cmd_emar, " "), working_directory=STB_IMAGE_WASM_MODULE_PATH);
			success &&= (run_result.exit_code == 0);
			if !success     return false;

            // Try both ranlib and emranlib
			cmd_ranlib := "emranlib wasm/stb_image.a";
			print("%\n", cmd_ranlib);
			run_result = run_command(..split(cmd_ranlib, " "), working_directory=STB_IMAGE_WASM_MODULE_PATH);
			success &&= (run_result.exit_code == 0);


// '-I./c/',
//     '-Os',
//     '-fno-builtin',
//     '--target=wasm32',
//     '--no-standard-libraries',
//     '-Wl,--no-entry',
//     '-Wl,--export=stbi_load_from_memory',
//     '-Wl,--export=malloc',
//     '-Wl,--export=heap_reset',
//     '-Wl,--allow-undefined',
//     '-o', 'wasm/stb_image.wasm',
//     'c/stb_image.c'

// 			cmd_o_file := tprint("clang -Oz --target=wasm64 --sysroot=%/upstream/emscripten/cache/sysroot -D_LIBCPP_HAS_NO_THREADS -c -o % %", EMSDK_PATH, o_file, it);
// 			run_result := run_command(..split(cmd_o_file, " "), working_directory=IMGUI_WASM_MODULE_PATH);
// 				success &&= (run_result.exit_code == 0);
		} else
        if os_target == .MACOS {
            lib_path_x64   := tprint("%_x64", lib_path);
            lib_path_arm64 := tprint("%_arm64", lib_path);
            macos_x64_version_arg   := "-mmacos-version-min=10.13"; // Our current x64 min version
            macos_arm64_version_arg := "-mmacos-version-min=11.0";  // Earliest version that supports arm64
            // x64 variant
            success &&= build_cpp_dynamic_lib(lib_path_x64,   source_file, extra = .["-arch", "x86_64", macos_x64_version_arg],   debug=compile_debug);
            success &&= build_cpp_static_lib( lib_path_x64,   source_file, extra = .["-arch", "x86_64", macos_x64_version_arg],   debug=compile_debug);
            // arm64 variant
            success &&= build_cpp_dynamic_lib(lib_path_arm64, source_file, extra = .["-arch", "arm64",  macos_arm64_version_arg], debug=compile_debug);
            success &&= build_cpp_static_lib( lib_path_arm64, source_file, extra = .["-arch", "arm64",  macos_arm64_version_arg], debug=compile_debug);
            // create universal binaries
            run_result := run_command("lipo", "-create", tprint("%.dylib", lib_path_x64), tprint("%.dylib", lib_path_arm64), "-output", tprint("%.dylib", lib_path));
            success &&= (run_result.exit_code == 0);
            run_result  = run_command("lipo", "-create", tprint("%.a",     lib_path_x64), tprint("%.a",     lib_path_arm64), "-output", tprint("%.a",     lib_path));
            success &&= (run_result.exit_code == 0);
        } else {
            extra: [] string;
            if os_target == .ANDROID {
                _, target_triple_with_sdk := get_android_target_triple(cpu_target);
                extra = .["-target", target_triple_with_sdk];
            }

            if os_target != .PS5 {
                success &&= build_cpp_dynamic_lib(lib_path, source_file, target = os_target, debug = compile_debug, extra = extra);
            }
            success &&= build_cpp_static_lib(lib_path, source_file, target = os_target, debug = compile_debug, extra = extra);
        }

        if !success     return false;
    }

    options: Generate_Bindings_Options;
    options.os = os_target;
    options.cpu = cpu_target;
    print("options: %\n", options);
    {
        using options;

        array_add(*libpaths, lib_directory);
        array_add(*libnames, LIB_BASE_NAME);
        array_add(*source_files, tprint("%/stb_image.h", STB_SOURCE_PATH));
        array_add(*typedef_prefixes_to_unwrap, "stbi_");


        generate_library_declarations = false;
        footer = tprint(FOOTER_TEMPLATE, LIB_BASE_NAME);

        auto_detect_enum_prefixes = true;
        log_stripped_declarations = false;
        generate_compile_time_struct_checks = false;
    }
    print("generating...\n");

    output_filename := "bindings.jai";
    return generate_bindings(options, output_filename);
}

FOOTER_TEMPLATE :: #string END

#if OS == .WINDOWS {
    %1 :: #library "windows/%1";
} else #if OS == .LINUX {
    %1 :: #library "linux/%1";
} else #if OS == .MACOS {
    %1 :: #library "macos/%1";
} else #if OS == .ANDROID {
    #if CPU == .X64 {
        %1 :: #library "android/x64/%1";
    } else #if CPU == .ARM64 {
        %1 :: #library "android/arm64/%1";
    }
} else #if OS == .PS5 {
    %1 :: #library "ps5/%1";
}  else #if OS == .WASM {
    %1 :: #library "wasm/%1";
} else {
    #assert false;
}

END

#import "Basic";
#import "Bindings_Generator";
#import "BuildCpp";
#import "Compiler";
#import "File";
#import "Process";
#import "Toolchains/Android";
#import "String";

