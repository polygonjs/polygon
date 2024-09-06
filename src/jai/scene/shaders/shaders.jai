#import "File";

// if we load common.jai, the compiler crashes,
// so we duplicate the struct here for now
// (but we probably should load it from a file on its own)
// #load "../common.jai";
ShadersContainer :: struct {
	render_basic: string;
	render_raymarching: string;
	compute_box: string;
	compute_offset: string;
}

read_shader :: (filepath: string)-> string {
	shader, success := read_entire_file(filepath);
	if !success {
		log_error("Could not read file \"%\"", filepath);
		exit(1);
	}
	return shader;
}

create_shaders :: ()-> ShadersContainer {
	shaders :ShadersContainer= .{};
	filepath_render_basic :: #run tprint("%../../../shaders/basic.pos.wgsl", #filepath);
	filepath_render_raymarching :: #run tprint("%./raymarching/raymarching.wgsl", #filepath);
	filepath_compute_box :: #run tprint("%../../../shaders/compute3.wgsl", #filepath);
	filepath_compute_offset :: #run tprint("%../../../shaders/compute_offset.wgsl", #filepath);
	{
		shader :: #run read_shader(filepath_render_basic);
		shaders.render_basic = shader;
	}
	{
		shader :: #run read_shader(filepath_render_raymarching);
		shaders.render_raymarching = shader;
	}
	{
		shader :: #run read_shader(filepath_compute_box);
		shaders.compute_box = shader;
	}
	{
		shader :: #run read_shader(filepath_compute_offset);
		shaders.compute_offset = shader;
	}


	return shaders;
}
