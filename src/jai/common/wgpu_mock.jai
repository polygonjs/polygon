
/**
 * copy of vertex layout from wgpu.h
 * so that we can create it for wasm, without importing wgpu
 */
size_t :: u64;

Wasm_VertexStepMode :: enum u32 {
	Vertex              :: 0;
	Instance            :: 1;
	VertexBufferNotUsed :: 2;
	Force32             :: 2147483647;

	WGPUVertexStepMode_Vertex              :: Vertex;
	WGPUVertexStepMode_Instance            :: Instance;
	WGPUVertexStepMode_VertexBufferNotUsed :: VertexBufferNotUsed;
	WGPUVertexStepMode_Force32             :: Force32;
}
Wasm_VertexFormat :: enum u32 {
	Undefined :: 0;
	Uint8x2   :: 1;
	Uint8x4   :: 2;
	Sint8x2   :: 3;
	Sint8x4   :: 4;
	Unorm8x2  :: 5;
	Unorm8x4  :: 6;
	Snorm8x2  :: 7;
	Snorm8x4  :: 8;
	Uint16x2  :: 9;
	Uint16x4  :: 10;
	Sint16x2  :: 11;
	Sint16x4  :: 12;
	Unorm16x2 :: 13;
	Unorm16x4 :: 14;
	Snorm16x2 :: 15;
	Snorm16x4 :: 16;
	Float16x2 :: 17;
	Float16x4 :: 18;
	Float32   :: 19;
	Float32x2 :: 20;
	Float32x3 :: 21;
	Float32x4 :: 22;
	Uint32    :: 23;
	Uint32x2  :: 24;
	Uint32x3  :: 25;
	Uint32x4  :: 26;
	Sint32    :: 27;
	Sint32x2  :: 28;
	Sint32x3  :: 29;
	Sint32x4  :: 30;
	Force32   :: 2147483647;

	WGPUVertexFormat_Undefined :: Undefined;
	WGPUVertexFormat_Uint8x2   :: Uint8x2;
	WGPUVertexFormat_Uint8x4   :: Uint8x4;
	WGPUVertexFormat_Sint8x2   :: Sint8x2;
	WGPUVertexFormat_Sint8x4   :: Sint8x4;
	WGPUVertexFormat_Unorm8x2  :: Unorm8x2;
	WGPUVertexFormat_Unorm8x4  :: Unorm8x4;
	WGPUVertexFormat_Snorm8x2  :: Snorm8x2;
	WGPUVertexFormat_Snorm8x4  :: Snorm8x4;
	WGPUVertexFormat_Uint16x2  :: Uint16x2;
	WGPUVertexFormat_Uint16x4  :: Uint16x4;
	WGPUVertexFormat_Sint16x2  :: Sint16x2;
	WGPUVertexFormat_Sint16x4  :: Sint16x4;
	WGPUVertexFormat_Unorm16x2 :: Unorm16x2;
	WGPUVertexFormat_Unorm16x4 :: Unorm16x4;
	WGPUVertexFormat_Snorm16x2 :: Snorm16x2;
	WGPUVertexFormat_Snorm16x4 :: Snorm16x4;
	WGPUVertexFormat_Float16x2 :: Float16x2;
	WGPUVertexFormat_Float16x4 :: Float16x4;
	WGPUVertexFormat_Float32   :: Float32;
	WGPUVertexFormat_Float32x2 :: Float32x2;
	WGPUVertexFormat_Float32x3 :: Float32x3;
	WGPUVertexFormat_Float32x4 :: Float32x4;
	WGPUVertexFormat_Uint32    :: Uint32;
	WGPUVertexFormat_Uint32x2  :: Uint32x2;
	WGPUVertexFormat_Uint32x3  :: Uint32x3;
	WGPUVertexFormat_Uint32x4  :: Uint32x4;
	WGPUVertexFormat_Sint32    :: Sint32;
	WGPUVertexFormat_Sint32x2  :: Sint32x2;
	WGPUVertexFormat_Sint32x3  :: Sint32x3;
	WGPUVertexFormat_Sint32x4  :: Sint32x4;
	WGPUVertexFormat_Force32   :: Force32;
}
Wasm_VertexAttribute :: struct {
	format:         Wasm_VertexFormat;
	offset:         u64;
	shaderLocation: u32;
}
Wasm_VertexBufferLayout :: struct {
	arrayStride:    u64;
	stepMode:       Wasm_VertexStepMode;
	attributeCount: size_t;
	attributes:     *Wasm_VertexAttribute;
}

wasm_make_vertex_layout :: ($type: Type) -> Wasm_VertexBufferLayout, []Wasm_VertexAttribute {
	info := type_info(type);

	vertex_buffer_layout := Wasm_VertexBufferLayout.{
		arrayStride=size_of(type),
		stepMode=.Vertex,
	};

	vertex_attributes := NewArray(info.members.count, Wasm_VertexAttribute);
	// defer array_reset(*vertex_attributes);

	for info.members {
		vertex_attribute: Wasm_VertexAttribute;

		if it.type.type == {
			case .BOOL;
				vertex_attribute.format = .Sint32;

			case .INTEGER;
				int_type_info := cast(*Type_Info_Integer) it.type;

				if int_type_info.signed {
					vertex_attribute.format = .Sint32;
				} else {
					vertex_attribute.format = .Uint32;
				}

			case .FLOAT;
				assert(it.type.runtime_size <= 4, "Only float32 is supported in Vertex Attribute Data.");
				vertex_attribute.format = .Float32;

			case .STRUCT;
				struct_type_info := cast(*Type_Info_Struct) it.type;

				if struct_type_info.name == {
					case "Vector4";
						vertex_attribute.format = .Float32x4;
					case "Vector3";
						vertex_attribute.format = .Float32x3;
					case "Vector2";
						vertex_attribute.format = .Float32x2;
					case;
						assert(false, tprint("Unsupported struct type (%). Only Vector2, Vector3, Vector4 are supported", struct_type_info.name));
				}

		}

		vertex_attribute.offset= xx it.offset_in_bytes;
		vertex_attribute.shaderLocation= xx it_index;

		vertex_attributes[it_index] = vertex_attribute;
	}

	vertex_buffer_layout.attributeCount = xx vertex_attributes.count;
	vertex_buffer_layout.attributes = vertex_attributes.data;

	return vertex_buffer_layout, vertex_attributes;
}


Wasm_VertexBufferLayout_to_buffer :: (layout: *Wasm_VertexBufferLayout)-> []VertexLayoutBuffer {
	buffer: [..]VertexLayoutBuffer;
	array_add(*buffer, cast(VertexLayoutBuffer) layout.arrayStride);
	array_add(*buffer, cast(VertexLayoutBuffer) layout.stepMode);
	array_add(*buffer, cast(VertexLayoutBuffer) layout.attributeCount);

	for 0..(layout.attributeCount-1) {
		attribute := layout.attributes[it];
		array_add(*buffer, cast(VertexLayoutBuffer) attribute.shaderLocation);
		array_add(*buffer, cast(VertexLayoutBuffer) attribute.offset);
		array_add(*buffer, cast(VertexLayoutBuffer) attribute.format);
	}

	return buffer;
}