#load "generate_ts_common.jai";
#load "../../runtime/engine/scene/NodesSceneThreeReportCommon.jai";



// jai src/jai/build/ts/generate_ts_three.jai

generate_ts :: () {
    file_path := join(#filepath, "../../../javascript/three/ThreeReportStructInfos.ts");
    builder: String_Builder;
    append(*builder, "// Auto-generated struct information for WebGPU bindings\n\n");
    append(*builder, "import { GetArrayFunction, getU64 } from \"../Common\";\n");
    append(*builder, "import { WASM_DATA_SIZE } from \"../wasm/WasmDataSize\";\n\n");
    append(*builder, "export interface MemberInfo {\n");
    append(*builder, "  size: bigint;\n");
    append(*builder, "  offset: bigint;\n");
    append(*builder, "  arrayView: GetArrayFunction;\n");
    append(*builder, "}\n\n");
    append(*builder, "export interface StructInfo<T extends string> {\n");
    append(*builder, "  size: bigint;\n");
    append(*builder, "  members: Record<T, MemberInfo>;\n");
    append(*builder, "}\n\n");


    print_type_info(*builder, NodesSceneThreeReportBufferItem);
    print_type_info(*builder, NodesSceneThreeReport);
    
    content := builder_to_string(*builder);
    write_success := write_entire_file(file_path, content);
    if(write_success){
        print("file updated: %\n", file_path);
    } else {
        print("Failed to write to file %\n", file_path);
    }
}

#run {
    set_build_options_dc(.{do_output=false});

    generate_ts();
}

#import "Compiler";