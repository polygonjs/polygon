// Inspired by threejs PlaneGeometry (https://github.com/mrdoob/three.js/blob/dev/src/geometries/PlaneGeometry.js)


PlaneGeometryParams :: struct {
	size:Vector2 = .{1,1};
	segments:Vector2UInt = .{1,1};
}

geometryPlaneAttributesSet :: (geometry: *Geometry, params: PlaneGeometryParams) {

	width := params.size.x;
	height := params.size.y;
	widthSegments := params.segments.x;
	heightSegments := params.segments.y;

	widthHalf := width / 2;
	heightHalf := height / 2;

	gridX := widthSegments + 1;
	gridY := heightSegments + 1;

	segmentWidth := width / cast(float) widthSegments;
	segmentHeight := height / cast(float) heightSegments;

	pointsCount := gridX * gridY;
	indicesCount := widthSegments * heightSegments * 6;

	array_resize(*geometry.attributes.position.values, pointsCount, false);
	array_resize(*geometry.attributes.normal.values, pointsCount, false);
	array_resize(*geometry.attributes.uv.values, pointsCount, false);
	array_resize(*geometry.indices, indicesCount, false);

	// Generate vertices, normals, and uvs
	for iy: 0..gridY-1 {
		y := cast(float) iy * segmentHeight - heightHalf;
		for ix: 0..gridX-1 {
			x := cast(float) ix * segmentWidth - widthHalf;

			index := iy * gridX + ix;
			
			geometry.attributes.position.values[index] = .{x, -y, 0};
			geometry.attributes.normal.values[index] = .{0, 0, 1};
			geometry.attributes.uv.values[index] = .{cast(float) ix / widthSegments, 1.0 - (cast(float) iy / heightSegments)};
		}
	}

	// Generate indices
	index := 0;
	for iy: 0..heightSegments-1 {
		for ix: 0..widthSegments-1 {
			a := iy * gridX + ix;
			b := iy * gridX + ix + 1;
			c := (iy + 1) * gridX + ix + 1;
			d := (iy + 1) * gridX + ix;

			// First triangle
			geometry.indices[index] = xx a;
			geometry.indices[index + 1] = xx b;
			geometry.indices[index + 2] = xx d;

			// Second triangle
			geometry.indices[index + 3] = xx b;
			geometry.indices[index + 4] = xx c;
			geometry.indices[index + 5] = xx d;

			index += 6;
		}
	}

}

