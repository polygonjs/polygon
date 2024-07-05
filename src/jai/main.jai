#import "Basic";
#import "Math";
// A basic "Hello WASM World" program

time :s64= 0;

main :: ()  {
	print("Hello Jai 17!\n");
	// write_strings("These", " will", " cause", " multiple", " calls", " to" , " write_string_unsynchronized!\n");
	// log("Hello logger");

	numbers: [..] int;
	array_add(*numbers, 10);
	array_add(*numbers, 20);
	array_add(*numbers, 30);

	// for numbers {
	// 	print("numbers[%]: %\n", it_index, it);
	// }

	debug_break();

	builder: String_Builder;
	// for 0..10 {
	// 	append(*builder, sprint("Entry-%\n", it));
	// }
	print("Builder result: \n%", builder_to_string(*builder));

	// Enable this if you want to see a nice stack trace:
	// assert(false, "Assert test");

	log("Type info test: The type of the builder is %", type_of(builder));
	info := type_info(type_of(builder));
	log("It contains the following members:");
	for info.members {
		log("%: % of type %", it_index, it.name, type_to_string(it.type));
	}

	// Lets try something fancier
	context.logger = dom_logger;
	log("Logging to the DOM via Jai.");
	log_error("We can also log errors.");

	// shader :: #string __MY_SHADER__
	// 	@vertex fn vs(
	// 	@builtin(vertex_index) vertexIndex : u32
	// 	) -> @builtin(position) vec4f {
	// 	let pos = array(
	// 		vec2f( 0.0,  0.5),  // top center
	// 		vec2f(-0.5, -0.5),  // bottom left
	// 		vec2f( 0.5, -0.5)   // bottom right
	// 	);
	
	// 	return vec4f(pos[vertexIndex], 0.0, 1.0);
	// 	}
	
	// 	@fragment fn fs() -> @location(0) vec4f {
	// 	return vec4f(1.0, 0.0, 0.0, 1.0);
	// 	}
	// __MY_SHADER__
	// set_webgpu_shader(shader);
	// time:float=0;
	// while (true) {
    //     time += 0.00001;
	// 	offset := sin(time);
	// 	set_webgpu_data(offset);
	// }
}

dom_logger :: (message: string, data: *void, info: Log_Info) {
	is_error := (info.common_flags & .ERROR) != 0;
	wasm_log_dom(message.count, message.data, is_error);
}
// set_webgpu_shader :: (message: string) {
// 	set_webgpu_shader_js(message.count, message.data);
// }


// We need to declare all the JS functions that will be passed to our WebAssembly
// instance from the JS file that loads us.
wasm_log_dom :: (count: s64, data: *u8, is_error: bool) #foreign;
// set_webgpu_shader_js :: (count: s64, data: *u8) #foreign;
set_webgpu_data :: (value: s64) #foreign;

set_time :: (new_time: s64) {
	time = new_time;// / 1000.0;
	// context.logger = dom_logger;
	// log("time");
	// log(time);

	// offset := sin(time/1000.0);
	// log(offset);
	d :s64 = 1;
	set_webgpu_data(d);
}


