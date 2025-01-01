// inspired by threejs sphere.js ( https://github.com/mrdoob/three.js/blob/dev/src/geometries/SphereGeometry.js )

SphereGeometryParams :: struct {
	radius: float = 1.0;
	widthSegments: u32 = 32;
	heightSegments: u32 = 16;
	phiStart: float = 0;
	phiLength: float = TAU;
	thetaStart: float = 0;
	thetaLength: float = PI;
}

geometry_sphere_attributes_set :: (geometry: *Geometry, params: SphereGeometryParams) {
	// Calculate the number of vertices and indices
	pointsCount := (params.widthSegments + 1) * (params.heightSegments + 1);
	indicesCount := params.widthSegments * params.heightSegments * 6;
	// print("points_count:u64=%;\n", points_count);
	// print("index_count:u64=%;\n", indices_count);

	// Resize geometry arrays
	geometrySetPointsCount(geometry, pointsCount);
	geometrySetIndicesCount(geometry, indicesCount);

	// Generate vertices, normals, and UVs
	index := 0;
	for y: 0..params.heightSegments {
		for x: 0..params.widthSegments {
			u := cast(float)x / params.widthSegments;
			v := cast(float)y / params.heightSegments;

			// Calculate vertex position
			theta := params.thetaStart + v * params.thetaLength;
			phi := params.phiStart + u * params.phiLength;

			vertex := Vector3.{
				-params.radius * sin(theta) * cos(phi),
				params.radius * cos(theta),
				params.radius * sin(theta) * sin(phi)
			};

			geometry.attributes.position.values[index] = vertex;
			geometry.attributes.normal.values[index] = normalize(vertex);
			geometry.attributes.uv.values[index] = .{u, 1 - v};

			index += 1;
		}
	}

	// Generate indices
	index = 0;
	for y: 0..params.heightSegments-1 {
		for x: 0..params.widthSegments-1 {
			a := y * (params.widthSegments + 1) + x;
			b := a + params.widthSegments + 1;

			geometry.indices[index] = a;
			geometry.indices[index + 1] = b;
			geometry.indices[index + 2] = a + 1;
			geometry.indices[index + 3] = b;
			geometry.indices[index + 4] = b + 1;
			geometry.indices[index + 5] = a + 1;

			index += 6;
		}
	}
}

#scope_file

TAU :: 2 * PI;