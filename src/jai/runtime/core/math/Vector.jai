Vector2Int :: struct {
	x: s32;
	y: s32;
}
Vector2UInt :: struct {
	x: u32;
	y: u32;
}
Vector2UInt64 :: struct {
	x: u64;
	y: u64;
}

Vector3Int :: struct {
	x: s32;
	y: s32;
	z: s32;
}
Vector3UInt :: struct {
	x: u32;
	y: u32;
	z: u32;
}

Vector2All :: Type.[Vector2, Vector2UInt, Vector2UInt64];
Vector3All :: Type.[Vector3, Vector3Int, Vector3UInt];
VectorAll :: #run array_concat(Vector2All, Vector3All);

operator == :: (a:$T/Vector2All, b:T) -> bool {
	return a.x == b.x && a.y == b.y;
}
operator == :: (a:$T/Vector3All, b:T) -> bool {
	return a.x == b.x && a.y == b.y && a.z == b.z;
}

mult :: inline (a: $T/Vector3All, s: float) -> Vector3 {
	return .{a.x * s, a.y * s, a.z * s};
}