
ShadersContainer :: struct {
	render: string;
	compute_box: string;
	compute_offset: string;
}

// wgpu_make_vertex_layout :: ($type: Type) -> WGPUVertexBufferLayout, []WGPUVertexAttribute {
// 	info := type_info(type);

// 	vertex_buffer_layout := WGPUVertexBufferLayout.{
// 		arrayStride=size_of(type),
// 		stepMode=.Vertex,
// 	};
// 	// print("vertex_buffer_layout:%\n", vertex_buffer_layout);

// 	vertex_attributes := NewArray(info.members.count, WGPUVertexAttribute);
// 	// defer array_reset(*vertex_attributes); // do not reset here, this will lead to corrupt data in wasm

// 	for info.members {
// 		vertex_attribute: WGPUVertexAttribute;

// 		if it.type.type == {
// 			case .BOOL;
// 				vertex_attribute.format = .Sint32;

// 			case .INTEGER;
// 				int_type_info := cast(*Type_Info_Integer) it.type;

// 				if int_type_info.signed {
// 					vertex_attribute.format = .Sint32;
// 				} else {
// 					vertex_attribute.format = .Uint32;
// 				}

// 			case .FLOAT;
// 				assert(it.type.runtime_size <= 4, "Only float32 is supported in Vertex Attribute Data.");
// 				vertex_attribute.format = .Float32;

// 			case .STRUCT;
// 				struct_type_info := cast(*Type_Info_Struct) it.type;

// 				if struct_type_info.name == {
// 					case "Vector4";
// 						vertex_attribute.format = .Float32x4;
// 					case "Vector3";
// 						vertex_attribute.format = .Float32x3;
// 					case "Vector2";
// 						vertex_attribute.format = .Float32x2;
// 					case;
// 						assert(false, tprint("Unsupported struct type (%). Only Vector2, Vector3, Vector4 are supported", struct_type_info.name));
// 				}

// 		}

// 		vertex_attribute.offset= xx it.offset_in_bytes;
// 		vertex_attribute.shaderLocation= xx it_index;
// 		vertex_attributes[it_index] = vertex_attribute;
// 	}

// 	vertex_buffer_layout.attributeCount = xx vertex_attributes.count;
// 	vertex_buffer_layout.attributes = vertex_attributes.data;

// 	return vertex_buffer_layout, vertex_attributes;
// }









wgpu_surface_create_current_view :: (wgpu_context: *WGPUContext) -> WGPUTextureView {
	current_view_descriptor := WGPUTextureViewDescriptor.{
		format = wgpu_context.preferred_texture_format,
		dimension = WGPUTextureViewDimension._2D,
		aspect = WGPUTextureAspect.All,
		baseMipLevel = 0,
		mipLevelCount = 1,
		baseArrayLayer = 0,
		arrayLayerCount = 1,
	};
	#if WASM {
		wgpu_context.surface_texture.texture = wgpuSurfaceGetCurrentTexture();
		return wgpuTextureCreateView(wgpu_context.surface_texture.texture, *current_view_descriptor);
	} else {
		wgpuSurfaceGetCurrentTexture(wgpu_context.surface, *(wgpu_context.surface_texture));
		return wgpuTextureCreateView(wgpu_context.surface_texture.texture, *current_view_descriptor);
	}
}

