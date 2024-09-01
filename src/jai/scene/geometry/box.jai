
geometry_box_attributes_create::(geometry: *Geometry) {
	{
		using geometry.attributes.position;
		array_add(*values, .{-0.5, -0.5, 0.5});
		array_add(*values, .{0.5, -0.5, 0.5});
		array_add(*values, .{0.5, 0.5, 0.5});
		array_add(*values, .{-0.5, 0.5, 0.5});

		array_add(*values, .{-0.5, -0.5, -0.5});
		array_add(*values, .{0.5, -0.5, -0.5});
		array_add(*values, .{0.5, 0.5, -0.5});
		array_add(*values, .{-0.5, 0.5, -0.5});
	}

	{
		using geometry.attributes.normal;
		for 0..7 array_add(*values, geometry.attributes.position.values[it]);
	}

	{
		using geometry.attributes.color;
		array_add(*values, .{1.0, 0.0, 0.0});
		array_add(*values, .{0.0, 1.0, 0.0});
		array_add(*values, .{0.0, 0.0, 1.0});
		array_add(*values, .{1.0, 1.0, 0.0});

		array_add(*values, .{1.0, 0.0, 1.0});
		array_add(*values, .{0.0, 1.0, 1.0});
		array_add(*values, .{1.0, 1.0, 1.0});
		array_add(*values, .{0.5, 0.5, 0.5});
	}

	{
		using geometry.attributes.uv;
		array_add(*values, .{0.0, 0.0});
		array_add(*values, .{1.0, 0.0});
		array_add(*values, .{1.0, 1.0});
		array_add(*values, .{0.0, 1.0});

		array_add(*values, .{0.0, 0.0});
		array_add(*values, .{1.0, 0.0});
		array_add(*values, .{1.0, 1.0});
		array_add(*values, .{0.0, 1.0});
	}
}


geometry_box_indices_create :: (geometry: *Geometry) {
	array_reset(*geometry.indices);
	using geometry;
	// Front face
	array_add(*indices, 0);
	array_add(*indices, 1);
	array_add(*indices, 2);
	array_add(*indices, 2);
	array_add(*indices, 3);
	array_add(*indices, 0);

	// Back face
	array_add(*indices, 5);
	array_add(*indices, 4);
	array_add(*indices, 7);
	array_add(*indices, 7);
	array_add(*indices, 6);
	array_add(*indices, 5);

	// Left face
	array_add(*indices, 4);
	array_add(*indices, 0);
	array_add(*indices, 3);
	array_add(*indices, 3);
	array_add(*indices, 7);
	array_add(*indices, 4);

	// Right face
	array_add(*indices, 1);
	array_add(*indices, 5);
	array_add(*indices, 6);
	array_add(*indices, 6);
	array_add(*indices, 2);
	array_add(*indices, 1);

	// // Top face
	array_add(*indices, 3);
	array_add(*indices, 2);
	array_add(*indices, 6);
	array_add(*indices, 6);
	array_add(*indices, 7);
	array_add(*indices, 3);

	// // Bottom face
	array_add(*indices, 4);
	array_add(*indices, 5);
	array_add(*indices, 1);
	array_add(*indices, 1);
	array_add(*indices, 0);
	array_add(*indices, 4);
}
