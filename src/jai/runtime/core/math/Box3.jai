Box3 :: struct {
	min: Vector3;
	max: Vector3;
}

box3MakeEmpty :: (box: *Box3) {
	box.min = .{+FLOAT32_INFINITY, +FLOAT32_INFINITY, +FLOAT32_INFINITY};
	box.max = .{-FLOAT32_INFINITY, -FLOAT32_INFINITY, -FLOAT32_INFINITY};
}

box3ExpandByPoint :: (box: *Box3, point: Vector3) {
	box.min = min(box.min, point);
	box.max = max(box.max, point);
}

box3SetFromGeometry :: (box: *Box3, geometry: *Geometry) {
	box3MakeEmpty(box);
	using geometry.attributes.position;
	for position:values {
		box3ExpandByPoint(box, position);
	}
}
box3Size :: (box: *Box3)->Vector3 {
	return ifx box3IsEmpty(box) then .{0,0,0} else box.max - box.min;
}
box3IsEmpty :: (box: *Box3) -> bool {
	return box.max.x < box.min.x || box.max.y < box.min.y || box.max.z < box.min.z;
}