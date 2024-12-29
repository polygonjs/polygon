

generatedSetBindGroup :: (computeController: *$T, computePassEncoder: *WGPUComputePassEncoder, commandEncoder: *WGPUCommandEncoder) {
	#insert GENERATED_CODE_COMPUTE_SET_BIND_GROUP;
	assert(false, tprint("generatedSetBindGroup: computeController type '%' is not implemented", computeController.type));
}
generatedHandleMappedBuffer :: (computeController: *$T) {
	#insert GENERATED_CODE_COMPUTE_HANDLE_MAPPED_BUFFERS;
	assert(false, tprint("generatedHandleMappedBuffer: computeController type '%' is not implemented", computeController.type));
}
generatedEntitiesCount :: (computeController: *$T)->u64 {
	#insert GENERATED_CODE_COMPUTE_ENTITIES_COUNT;
	assert(false, tprint("generatedEntitiesCount: computeController type '%' is not implemented", computeController.type));
	return 0;
}

registerComputeControllers :: () #compile_time {

	array_reset_keeping_memory(*TMP_METADATAS);

	registerComputeControllerAttributeSet();
	registerComputeControllerAttributeNormalize();
	registerComputeControllerBoxCreate();
	registerComputeControllerComputeNormals();
	registerComputeControllerNoise();
	registerComputeControllerTranslate();
}
computeControllersMetaDatasCount :: ()->u64 #compile_time  {
	registerComputeControllers();
	return xx TMP_METADATAS.count;
}
computeControllersMetaDatas :: ()->[COMPUTE_CONTROLLER_METADATAS_COUNT]ComputeControllerMetaData #compile_time {
	registerComputeControllers();

	list:[COMPUTE_CONTROLLER_METADATAS_COUNT]ComputeControllerMetaData;

	for metaData, i: TMP_METADATAS {
		list[i] = metaData;
	}
	return list;
}

registerComputeControllersAndGenerateCode :: () -> (
	setBindGroup:string,
	handleMappedBuffers:string,
	entitiesCount:string
) #compile_time {

	registerComputeControllers();

	setBindGroup := generateSetBindGroup();
	handleMappedBuffers := generateHandleMappedBuffer();
	entitiesCount := generateEntitiesCount();

	return 	setBindGroup,
		handleMappedBuffers,
		entitiesCount;
}

computeControllerRegister :: (
	$T:Type
	) #compile_time {
	array_add(*TMP_METADATAS, .{
		type = T,
	});
}

ComputeControllerMetaData :: struct {
	type: Type;
}

#no_reset COMPUTE_CONTROLLER_METADATAS_COUNT :u64: #run computeControllersMetaDatasCount();
#no_reset COMPUTE_CONTROLLER_METADATAS :[COMPUTE_CONTROLLER_METADATAS_COUNT]ComputeControllerMetaData: #run computeControllersMetaDatas();


#scope_file

TMP_METADATAS: [..]ComputeControllerMetaData;


GENERATED_CODE_COMPUTE_SET_BIND_GROUP,
GENERATED_CODE_COMPUTE_HANDLE_MAPPED_BUFFERS,
GENERATED_CODE_COMPUTE_ENTITIES_COUNT :: #run registerComputeControllersAndGenerateCode();







generateSetBindGroup :: ()->string #compile_time {
	builder: String_Builder;
	print_to_builder(*builder, "if computeController.type == {\n");
	for metaData: COMPUTE_CONTROLLER_METADATAS {
		type := metaData.type;
		print_to_builder(*builder, tprint("\tcase %; setBindGroup(cast(*%) computeController, computePassEncoder, commandEncoder); return;\n", type, type));
	}
	print_to_builder(*builder, "}");

	result := builder_to_string(*builder);
	reset(*builder);
	return result;
}
generateHandleMappedBuffer :: ()->string #compile_time {
	builder: String_Builder;
	print_to_builder(*builder, "if computeController.type == {\n");
	for metaData: COMPUTE_CONTROLLER_METADATAS {
		type := metaData.type;
		print_to_builder(*builder, tprint("\tcase %; handleMappedBuffer(cast(*%) computeController); return;\n", type, type));
	}
	print_to_builder(*builder, "}");

	result := builder_to_string(*builder);
	reset(*builder);
	return result;
}
generateEntitiesCount :: ()->string #compile_time {
	builder: String_Builder;
	print_to_builder(*builder, "if computeController.type == {\n");
	for metaData: COMPUTE_CONTROLLER_METADATAS {
		type := metaData.type;
		print_to_builder(*builder, tprint("\tcase %; return entitiesCount(cast(*%) computeController);\n", type, type));

	}
	print_to_builder(*builder, "}");

	result := builder_to_string(*builder);
	reset(*builder);
	return result;
}

