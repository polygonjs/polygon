#import "File";

create_shaders :: ()-> string {

	filepath :: #run tprint("%../shaders/basic.wgsl", #filepath);
	print("%\n",filepath);
	SHADER, success :: #run read_entire_file(filepath);
	if !success {
		log_error("Could not read file \"%\"", filepath);
		exit(1);
	}

	return SHADER;
}

Vertex :: struct {
	position: Vector3;
	color: Vector3;
}

create_vertices :: ()-> [3]Vertex {
	VERTICES := Vertex.[
		.{ position=.{0.0, 0.5, 0.0}, color=.{1.0, 0.0, 0.0} },
		.{ position=.{-0.5, -0.5, 0.0}, color=.{0.0, 1.0, 0.0} },
		.{ position=.{0.5, -0.5, 0.0}, color=.{0.0, 0.0, 1.0} },
	];
	return VERTICES;
}