#import "Basic";
#import "Math";
#load "common/math_helper.jai";
#load "common/wgpu_mock.jai";
#load "common/scene_data.jai";
#placeholder SHADER;

SCENE_DATA :SceneData;

main :: () {
	// print("Hello Jai 24!\n");
	// write_strings("These", " will", " cause", " multiple", " calls", " to" , " write_string_unsynchronized!\n");
	// log("Hello logger");

	// numbers: [..] int;
	// array_add(*numbers, 10);
	// array_add(*numbers, 20);
	// array_add(*numbers, 30);

	// for numbers {
	// 	print("numbers[%]: %\n", it_index, it);
	// }

	// debug_break();

	// builder: String_Builder;
	// for 0..10 {
	// 	append(*builder, sprint("Entry-%\n", it));
	// }
	// print("Builder result: \n%", builder_to_string(*builder));

	// Enable this if you want to see a nice stack trace:
	// assert(false, "Assert test");

	// log("Type info test: The type of the builder is %", type_of(builder));
	// info := type_info(type_of(builder));
	// log("It contains the following members:");
	// for info.members {
	// 	log("%: % of type %", it_index, it.name, type_to_string(it.type));
	// }

	// Lets try something fancier
	context.logger = dom_logger;
	// log("Logging to the DOM via Jai.");
	// log_error("We can also log errors.");

	SCENE_DATA = create_scene_data(1);

	vertex_buffer_layout := wasm_make_vertex_layout(Vertex);
	vertex_buffer_layout_buffer := Wasm_VertexBufferLayout_to_buffer(*vertex_buffer_layout);
	set_webgpu_vertex_layout(vertex_buffer_layout_buffer);

	set_webgpu_vertex_data(SCENE_DATA.vertices);
	set_webgpu_index_data(SCENE_DATA.indices);
	set_webgpu_object_uniforms_data(SCENE_DATA.object_uniforms);
	set_webgpu_camera_uniforms_data(SCENE_DATA.camera_uniforms);
	set_webgpu_shader(SHADER);
	// time:float=0;
	// while (true) {
    //     time += 0.00001;
	// 	offset := sin(time);
	// 	set_webgpu_data(offset);
	// }

	// main_call_completed();
}

// vertices_to_buffer :: (vertices: []Vertex, buffer: []float32){
// 	buffer.count = 2*3*vertices.count;
// 	for vertex: vertices {
// 		offset := it_index*6;
// 		buffer[offset+0] = vertex.position.x;
// 		buffer[offset+1] = vertex.position.y;
// 		buffer[offset+2] = vertex.position.z;
// 		buffer[offset+3] = vertex.color.x;
// 		buffer[offset+4] = vertex.color.y;
// 		buffer[offset+5] = vertex.color.z;
// 	}
// }

dom_logger :: (message: string, data: *void, info: Log_Info) {
	is_error := (info.common_flags & .ERROR) != 0;
	wasm_log_dom(message.count, message.data, is_error);
}
set_webgpu_shader :: (message: string) {
	set_webgpu_shader_js(message.count, message.data);
}
set_webgpu_vertex_data :: (vertices: []Vertex) {
	set_webgpu_vertex_data_js(vertices.count * VERTEX_FLOATS_COUNT, vertices.data, size_of(float32));
}
set_webgpu_index_data :: (indices: []VertexIndex) {
	set_webgpu_index_data_js(indices.count, indices.data, size_of(VertexIndex));
}
set_webgpu_vertex_layout :: (buffer: []VertexLayoutBuffer) {
	set_webgpu_vertex_layout_js(buffer.count, buffer.data, size_of(VertexLayoutBuffer));
}

set_webgpu_object_uniforms_data :: (object_uniforms: [1]ObjectUniforms) {
	set_webgpu_object_uniforms_js(16, object_uniforms.data, size_of(float));
}
set_webgpu_camera_uniforms_data :: (camera_uniforms: [1]CameraUniforms) {
	set_webgpu_camera_uniforms_js(16*2, camera_uniforms.data, size_of(float));
}


// We need to declare all the JS functions that will be passed to our WebAssembly
// instance from the JS file that loads us.
wasm_log_dom :: (count: s64, data: *u8, is_error: bool) #foreign;
set_webgpu_shader_js :: (count: s64, data: *u8) #foreign;
set_webgpu_vertex_data_js :: (count: s64, data: *Vertex, element_size:u8) #foreign;
set_webgpu_index_data_js :: (count: s64, data: *VertexIndex, element_size:u8) #foreign;
set_webgpu_vertex_layout_js :: (count: s64, data: *VertexLayoutBuffer, element_size:u8) #foreign;
set_webgpu_object_uniforms_js :: (count: s64, data: *ObjectUniforms, element_size:u8) #foreign;
set_webgpu_camera_uniforms_js :: (count: s64, data: *CameraUniforms, element_size:u8) #foreign;
// set_webgpu_data :: (value: float) #foreign;
// main_call_completed :: () #foreign;

set_wasm_time :: (new_time: s64) {
	time:float = new_time / 1000.0;

	update_scene_data(*SCENE_DATA, time);

	update_scene_data_uniforms(*SCENE_DATA);
	set_webgpu_object_uniforms_data(SCENE_DATA.object_uniforms);
	set_webgpu_camera_uniforms_data(SCENE_DATA.camera_uniforms);
}


