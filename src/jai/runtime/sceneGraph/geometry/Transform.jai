geometryTranslate :: (geometry: *Geometry, t: Vector3) {

	using geometry.attributes.position;
	for v, i: values {
		values[i] = v+t;
	}

}
