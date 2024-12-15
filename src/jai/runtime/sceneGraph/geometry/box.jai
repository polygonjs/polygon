// inspired by threejs box ( https://github.com/mrdoob/three.js/blob/dev/src/geometries/BoxGeometry.js )

BoxGeometryParams :: struct {
	size:Vector3 = .{1,1,1};
	segments:Vector3UInt = .{1,1,1};
}

geometryBoxUpdate :: (geometry: *Geometry, params: BoxGeometryParams) {
	geometryBoxAttributesSet(geometry, params);
	geometryAttributesValidate(geometry);
	normals_compute(geometry);
}

geometryBoxAttributesSet :: (geometry: *Geometry, params: BoxGeometryParams) {

	count0 := plane_points_and_indices_count(params.segments.x, params.segments.y);
	count1 := plane_points_and_indices_count(params.segments.x, params.segments.z);
	count2 := plane_points_and_indices_count(params.segments.y, params.segments.z);
	pointsCount := (count0.pointsCount + count1.pointsCount + count2.pointsCount) * 2;
	// print("box points_count:u64=%;\n", points_count);
	indicesCount := (count0.indicesCount + count1.indicesCount + count2.indicesCount) * 2;
	// print("index_count:u64=%;\n", indices_count);

	array_resize(*geometry.attributes.position.values, pointsCount, false);
	array_resize(*geometry.attributes.normal.values, pointsCount, false);
	// array_resize(*geometry.attributes.color.values, points_count, false);
	array_resize(*geometry.attributes.uv.values, pointsCount, false);
	array_resize(*geometry.indices, indicesCount, false);

	offset:BuildPlaneOffset = .{points = 0, indices = 0};

	build_plane(geometry, .{normal = .{1.0, 0.0, 0.0}, size = params.size, segments = .{params.segments.y, params.segments.z}, offset = *offset}); // px
	build_plane(geometry, .{normal = .{-1.0, 0.0, 0.0}, size = params.size, segments = .{params.segments.y, params.segments.z}, offset = *offset}); // nx
	build_plane(geometry, .{normal = .{0.0, 1.0, 0.0}, size = params.size, segments = .{params.segments.x, params.segments.z}, offset = *offset}); // py
	build_plane(geometry, .{normal = .{0.0, -1.0, 0.0}, size = params.size, segments = .{params.segments.x, params.segments.z}, offset = *offset}); // ny
	build_plane(geometry, .{normal = .{0.0, 0.0, 1.0}, size = params.size, segments = .{params.segments.x, params.segments.y}, offset = *offset}); // pz
	build_plane(geometry, .{normal = .{0.0, 0.0, -1.0}, size = params.size, segments = .{params.segments.x, params.segments.y}, offset = *offset}); // nz

}

#scope_file


PointsAndIndicesCount :: struct {
	pointsCount: u32;
	indicesCount: u32;
}
plane_points_and_indices_count :: ( segmentsX: u32, segmentsY: u32 ) -> PointsAndIndicesCount {
	pointsCount := (segmentsX+1) * (segmentsY+1);
	indicesCount := segmentsX * segmentsY * 6;
	return .{pointsCount, indicesCount};
}
BuildPlaneOffset :: struct {
	points: u32;
	indices: u32;
}
BuildPlaneParams :: struct {
	normal: Vector3;
	size:Vector3;
	segments:Vector2UInt;
	offset: *BuildPlaneOffset;
}
build_plane :: ( geometry: *Geometry, params: BuildPlaneParams ) {
	normal := params.normal;
	size := params.size;
	segments := params.segments;
	offset := params.offset;

	udir:Vector3= ifx abs(normal.x) > 0.5
		then .{0, 1, 0} else
		{ifx abs(normal.y) > 0.5 then Vector3.{1, 0, 0} else .{1, 0, 0};}
	vdir:Vector3= ifx abs(normal.x) > 0.5
		then .{0, 0, 1} else
		{ifx abs(normal.y) > 0.5 then Vector3.{0, 0, 1} else .{0, 1, 0};}

	segmentWidth := size.x / segments.x;
	segmentHeight := size.y / segments.y;

	widthHalf := size.x / 2;
	heightHalf := size.y / 2;
	depthHalf := size.z / 2;

	segments_x1 := segments.x + 1;
	segments_y1 := segments.y + 1;

	// 1 segment = 2 faces
	// count = 2*3* segments count
	{
		using geometry;
		for iy:0..(segments.y-1) {
			for ix:0..(segments.x-1) {
				a :VertexIndex= offset.points + ix + segments_x1 * iy;
				b :VertexIndex= offset.points + ix + segments_x1 * (iy + 1);
				c :VertexIndex= offset.points + (ix + 1) + segments_x1 * (iy + 1);
				d :VertexIndex= offset.points + (ix + 1) + segments_x1 * iy;

				i := offset.indices;
				indices[i] = a;
				indices[i+1] = b;
				indices[i+2] = d;
				indices[i+3] = b;
				indices[i+4] = c;
				indices[i+5] = d;

				offset.indices += 6;
			}
		}
	}

	for iy:0..(segments_y1-1) {
		for ix:0..(segments_x1-1) {
			y := iy * segmentHeight - heightHalf;
			x := ix * segmentWidth - widthHalf;
			{
				using geometry.attributes.position;
				values[offset.points] = normal*depthHalf + udir*cast(float) x + vdir*cast(float) y;
			}
			{
				using geometry.attributes.normal;
				values[offset.points] = normal;
			}
			{
				using geometry.attributes.uv;
				values[offset.points] = .{(cast(float) ix) / segments.x, 1 - (cast(float) iy / segments.y)};
			}

			offset.points+=1;
		}
	}

}
