#import "File";

create_shaders :: ()-> string {

	filepath :: #run tprint("%../../shaders/basic.wgsl", #filepath);
	print("%\n",filepath);
	SHADER, success :: #run read_entire_file(filepath);
	if !success {
		log_error("Could not read file \"%\"", filepath);
		exit(1);
	}

	return SHADER;
}
