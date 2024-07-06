
Vertex :: struct {
	position: Vector3;
	color: Vector3;
}

create_vertices :: ()-> [..]Vertex {
	list : [..]Vertex;
	array_add(*list, Vertex.{ position=.{0.0, 0.5, 0.0}, color=.{1.0, 0.0, 0.0} });
	array_add(*list, Vertex.{ position=.{-0.5, -0.5, 0.0}, color=.{0.0, 1.0, 0.0} });
	array_add(*list, Vertex.{ position=.{0.5, -0.5, 0.0}, color=.{0.0, 0.0, 1.0} });
	return list;
}

SceneData :: struct {
	vertices: [..]Vertex;
};

update_scene_data :: (scene_data: *SceneData, time:float) {
	position_offset := 0.2*sin(time);
	scene_data.vertices[0].position.x = -0.6;
	scene_data.vertices[0].position.y = position_offset;
}