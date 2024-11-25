EmptyUniforms :: struct {};

MaterialBase :: struct ($UniformType: Type) {
	allocator: Allocator;
	type: Type;
	uniformType: Type=UniformType;
	uniformTypeSize: u32=size_of(UniformType);
	id: u64;
	//
	name: string;
	shader: string;
	uniforms: UniformType;
}
Material :: MaterialBase(Any);


newMaterial :: (scene: *Scene, $T: Type) -> *T {
	return newMaterial(T, scene.allocator);
}
newMaterial :: ($T: Type, allocator: Allocator) -> *T {
	material: *T = New(T,,allocator);
	material.allocator = allocator;
	material.type = T;

	material.id = NEXT_MATERIAL_ID;
	NEXT_MATERIAL_ID += 1;

	materialInit(material);

	return material;
}
materialDelete :: (material: *$T) {
	free(material,, material.allocator);
}
materialUpdatePipelineControllerLayout :: (material: *Material, pc : *PipelineController) {

	_attributeToVertexBufferLayout :: (format:WGPUVertexFormat, stride: u64, location: u32) -> WGPUVertexBufferLayout, WGPUVertexAttribute {
		assert(format != WGPUVertexFormat.Undefined, "format is Undefined\n");
		attribute:WGPUVertexAttribute= .{
			format=format,
			offset=0,
			shaderLocation=location,
		};
		layout := WGPUVertexBufferLayout.{
			arrayStride=stride, //size_of(type),
			stepMode=.Vertex,
			attributeCount=1,
			// attributes=attributes.data
		};
		return layout, attribute;
	}

	array_reset(*pc.vertexBufferLayouts);
	array_reset(*pc.vertexAttributes);

	i :u32= 0; // position
	{
		layout, attribute := _attributeToVertexBufferLayout(.Float32x3, xx size_of(Vector3), i);
		array_add(*pc.vertexBufferLayouts, layout);
		array_add(*pc.vertexAttributes, attribute);
		pc.vertexBufferLayouts[i].attributes = *pc.vertexAttributes[i];
	}
	i+=1; // normal
	{
		layout, attribute := _attributeToVertexBufferLayout(.Float32x3, xx size_of(Vector3), i);
		array_add(*pc.vertexBufferLayouts, layout);
		array_add(*pc.vertexAttributes, attribute);
		pc.vertexBufferLayouts[i].attributes = *pc.vertexAttributes[i];
	}
	i+=1; // uv
	{
		layout, attribute := _attributeToVertexBufferLayout(.Float32x2, xx size_of(Vector2), i);
		array_add(*pc.vertexBufferLayouts, layout);
		array_add(*pc.vertexAttributes, attribute);
		pc.vertexBufferLayouts[i].attributes = *pc.vertexAttributes[i];
	}
}

#scope_file

NEXT_MATERIAL_ID :u64= 0;

materialInit :: (material: *Material) {
}