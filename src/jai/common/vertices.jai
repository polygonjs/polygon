
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