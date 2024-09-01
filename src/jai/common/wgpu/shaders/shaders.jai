#import "File";

// if we load common.jai, the compiler crashes,
// so we duplicate the struct here for now
// (but we probably should load it from a file on its own)
// #load "../common.jai";
ShadersContainer :: struct {
	render: string;
	compute_box: string;
	compute_offset: string;
}

create_shaders :: ()-> ShadersContainer {
	shaders :ShadersContainer= .{};
	// filepath_render :: #run tprint("%../../../../shaders/basic.pos.wgsl", #filepath);
	filepath_render :: #run tprint("%../../../../shaders/raymarching.wgsl", #filepath);
	filepath_compute_box :: #run tprint("%../../../../shaders/compute3.wgsl", #filepath);
	filepath_compute_offset :: #run tprint("%../../../../shaders/compute_offset.wgsl", #filepath);
	shader_render, success_render :: #run read_entire_file(filepath_render);
	if !success_render {
		log_error("Could not read file \"%\"", filepath_render);
		exit(1);
	}
	shader_compute_box, success_compute :: #run read_entire_file(filepath_compute_box);
	if !success_compute {
		log_error("Could not read file \"%\"", filepath_compute_box);
		exit(1);
	}
	shader_compute_offset, success_compute_offset :: #run read_entire_file(filepath_compute_offset);
	if !success_compute_offset {
		log_error("Could not read file \"%\"", filepath_compute_offset);
		exit(1);
	}

	shaders.render = shader_render;
	shaders.compute_box = shader_compute_box;
	shaders.compute_offset = shader_compute_offset;

	return shaders;
}
