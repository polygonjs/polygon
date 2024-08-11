#import "File";

// if we load common.jai, the compiler crashes,
// so we duplicate the struct here for now
// (but we probably should load it from a file on its own)
// #load "../common.jai";
ShadersContainer :: struct {
	render: string;
	compute: string;
}

create_shaders :: ()-> ShadersContainer {
	shaders :ShadersContainer= .{};
	filepath_render :: #run tprint("%../../../../shaders/basic.wgsl", #filepath);
	// filepath_render :: #run tprint("%../../../../shaders/raymarching.wgsl", #filepath);
	filepath_compute :: #run tprint("%../../../../shaders/compute3.wgsl", #filepath);
	shader_render, success_render :: #run read_entire_file(filepath_render);
	if !success_render {
		log_error("Could not read file \"%\"", filepath_render);
		exit(1);
	}
	shader_compute, success_compute :: #run read_entire_file(filepath_compute);
	if !success_compute {
		log_error("Could not read file \"%\"", filepath_compute);
		exit(1);
	}

	shaders.render = shader_render;
	shaders.compute = shader_compute;

	return shaders;
}
