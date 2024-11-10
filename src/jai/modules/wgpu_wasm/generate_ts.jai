#import "Basic";
#import "File";
#import "String";
#load "module.jai";

#load "../../runtime/core/utils/Type.jai";

// jai src/jai/modules/wgpu_wasm/generate_ts.jai && src/jai/modules/wgpu_wasm/generate_ts

print_type_info :: (builder: *String_Builder, $T: Type){
    // info := type_info(T);
    // print(info);

    // print_to_builder(*builder, "#import \"Basic\"; // For %\n\n", join(..basic_reasons, separator = ", "));

    info := type_info(T);
    member_names: [..]string;
    for info.members {
        array_add(*member_names, it.name);
    }
    generic_member_names := join(..member_names, separator = "\" | \"");


    append(builder, tprint("export const %:StructInfo<\"%\"> = {\n", T, generic_member_names));
    append(builder, tprint("size: BigInt(%),\n", size_of(T)));
	// print("% (with size=%) contains the following members:\n", T, size_of(T));
    append(builder, "members: {\n");
	for info.members {
        member_name := it.name;
        member_offset := it.offset_in_bytes;
        member_type := type_to_string(it.type);
        // pointer_to := tprint("pointerTo(%)", slice(member_type, 1, member_type.count-1));
        // member_type_wrapped := ifx contains(member_type, "*") then pointer_to else member_type;
        // size := size_of(it.type) ;
        member_type_size := ifx contains(member_type, "WGPU") then
            ifx it.type.type == Type_Info_Tag.ENUM then "ENUM_SIZE" else  tprint("%.size", member_type)
        else
            tprint("WGPU_SIZE.%", member_type);
        size := ifx contains(member_type, "*") then "WGPU_SIZE.u64" else member_type_size;
        // size := size_of(it.type);

        // array_view := ifx contains(member_type, "WGPU") then
        //     ifx it.type.type == Type_Info_Tag.ENUM then "getU32" else "getU8"
        // else
        //     ifx contains(member_type, "*") then "getU64" else tprint("get%", to_upper_copy_new(member_type));
        array_view := "getU8";
        if type_to_string(it.type) == {
            case "u8"; {array_view = "getU8";}
            case "u16"; {array_view = "getU16";}
            case "u32"; {array_view = "getU32";}
            case "u64"; {array_view = "getU64";}
            case "s32"; {array_view = "getS32";}
            case "float32"; {array_view = "getFLOAT32";}
            case "float64"; {array_view = "getFLOAT64";}
        }
        if contains(type_to_string(it.type), "*") {
            array_view = "getU64";
        }
        ifx it.type.type == Type_Info_Tag.ENUM {
            array_view = "getU32";
        }

        // print("---- \n");
        // print("member_name: %\n", member_name);
        // print("type: %\n", type_to_string(it.type));
        // print("member_type_size: %\n", member_type_size);
        // print("size: %\n", size);
        // print("array_view: %\n", array_view);
        append(builder, tprint("%: {size: %, offset: BigInt(%), arrayView: %},", member_name, size, member_offset, array_view));
	}
    append(builder, "}};\n\n");
}

main :: (){
    file_path := "src/javascript/WebGPU/utils/WGPUStructInfos.ts";
    builder: String_Builder;
    append(*builder, "// Auto-generated struct information for WebGPU bindings\n\n");
    append(*builder, "import { GetArrayFunction, getU8, getU16,getU32, getU64, getS32, getFLOAT32, getFLOAT64 } from \"../../Common\";\n");
    append(*builder, "import { WGPU_SIZE, ENUM_SIZE } from \"./WebGPUOffset\";\n\n");
    append(*builder, "export interface MemberInfo {\n");
    append(*builder, "  size: bigint;\n");
    append(*builder, "  offset: bigint;\n");
    append(*builder, "  arrayView: GetArrayFunction;\n");
    append(*builder, "}\n\n");
    append(*builder, "export interface StructInfo<T extends string> {\n");
    append(*builder, "  size: bigint;\n");
    append(*builder, "  members: Record<T, MemberInfo>;\n");
    append(*builder, "}\n\n");


    print_type_info(*builder, WGPUOrigin3D);
    print_type_info(*builder, WGPUExtent3D);
    print_type_info(*builder, WGPUBindGroupDescriptor);
    print_type_info(*builder, WGPUBindGroupEntry);
    print_type_info(*builder, WGPUSamplerBindingLayout);
    print_type_info(*builder, WGPUTextureBindingLayout);
    print_type_info(*builder, WGPUStorageTextureBindingLayout);
    print_type_info(*builder, WGPUBufferBindingLayout);
    print_type_info(*builder, WGPUBufferDescriptor);
    print_type_info(*builder, WGPUBindGroupLayoutDescriptor);
    print_type_info(*builder, WGPUBindGroupLayoutEntry);
    print_type_info(*builder, WGPUBlendComponent);
    print_type_info(*builder, WGPUBlendState);
    print_type_info(*builder, WGPUColor);
    print_type_info(*builder, WGPUColorTargetState);
    print_type_info(*builder, WGPUProgrammableStageDescriptor);
    print_type_info(*builder, WGPUStencilFaceState);
    print_type_info(*builder, WGPUCommandBufferDescriptor);
    print_type_info(*builder, WGPUCommandEncoderDescriptor);
    print_type_info(*builder, WGPUComputePassDescriptor);
    print_type_info(*builder, WGPUComputePipelineDescriptor);
    print_type_info(*builder, WGPUDepthStencilState);
    print_type_info(*builder, WGPUFragmentState);
    print_type_info(*builder, WGPUImageCopyTexture);
    print_type_info(*builder, WGPUMultisampleState);
    print_type_info(*builder, WGPUPipelineLayoutDescriptor);
    print_type_info(*builder, WGPUPrimitiveState);
    print_type_info(*builder, WGPURenderPassColorAttachment);
    print_type_info(*builder, WGPURenderPassDepthStencilAttachment);
    print_type_info(*builder, WGPURenderPassDescriptor);
    print_type_info(*builder, WGPUVertexState);
    print_type_info(*builder, WGPUChainedStruct);
    print_type_info(*builder, WGPURenderPipelineDescriptor);
    print_type_info(*builder, WGPUSamplerDescriptor);
    print_type_info(*builder, WGPUShaderModuleDescriptor);
    print_type_info(*builder, WGPUShaderModuleWGSLDescriptor);
    print_type_info(*builder, WGPUTextureDataLayout);
    print_type_info(*builder, WGPUImageCopyBuffer);
    print_type_info(*builder, WGPUTextureDescriptor);
    print_type_info(*builder, WGPUVertexAttribute);
    print_type_info(*builder, WGPUVertexBufferLayout);
    print_type_info(*builder, WGPUTextureViewDescriptor);
    
    content := builder_to_string(*builder);
    write_success := write_entire_file(file_path, content);
    if(!write_success){
        print("Failed to write to file %\n", file_path);
    }
}