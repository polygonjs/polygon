#import "File";

Shaders :: struct {
	render: string;
	compute: string;
}

create_shaders :: ()-> Shaders {
	shaders :Shaders= .{};
	// filepath_render :: #run tprint("%../../shaders/basic.wgsl", #filepath);
	filepath_render :: #run tprint("%../../shaders/raymarching.wgsl", #filepath);
	filepath_compute :: #run tprint("%../../shaders/compute3.wgsl", #filepath);
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
