

// jai src/jai/build/ts/generate_ts_wgpu.jai

generate_ts :: () {
    file_path := join(#filepath, "../../../javascript/WebGPU/utils/WGPUStructInfos.ts");
    builder: String_Builder;
    append(*builder, "// Auto-generated struct information for WebGPU bindings\n\n");
    append(*builder, "import { GetArrayFunction, getU8, getU16,getU32, getU64, getS32, getFLOAT32, getFLOAT64 } from \"../../Common\";\n");
    append(*builder, "import { WASM_DATA_SIZE, ENUM_SIZE } from \"../../wasm/WasmDataSize\";\n\n");
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



#scope_file

print_type_info :: (builder: *String_Builder, $T: Type){
    print_type_info(builder, T, prefix="WGPU");
}


#load "../../modules/wgpu_wasm/module.jai";
#load "generate_ts_common.jai";
