
Vertex :: struct {
	position: Vector3;
	color: Vector3;
}
VertexIndex :: u32;

create_vertices :: ()-> [..]Vertex, [..]VertexIndex {
	vertices : [..]Vertex;
	array_add(*vertices, Vertex.{ position=.{0.0, 0.5, 0.0}, color=.{1.0, 0.0, 0.0} });
	array_add(*vertices, Vertex.{ position=.{-0.5, -0.5, 0.0}, color=.{0.0, 1.0, 0.0} });
	array_add(*vertices, Vertex.{ position=.{0.5, -0.5, 0.0}, color=.{0.0, 0.0, 1.0} });
	array_add(*vertices, Vertex.{ position=.{1.5, 0.5, 0.0}, color=.{1.0, 0.0, 1.0} });
	
	indices:[..]VertexIndex;
	array_add(*indices, 0);
	array_add(*indices, 1);
	array_add(*indices, 2);
	array_add(*indices, 2);
	array_add(*indices, 1);
	array_add(*indices, 3);

	return vertices, indices;
}

SceneData :: struct {
	vertices: [..]Vertex;
	indices: [..]VertexIndex;
};

update_scene_data :: (scene_data: *SceneData, time:float) {
	position_offset := 1*sin(time);
	scene_data.vertices[0].position.x = -0.6;
	scene_data.vertices[0].position.y = position_offset;
}