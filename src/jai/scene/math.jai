Vector2Int :: struct {
	x: s32;
	y: s32;
}
Vector2UInt :: struct {
	x: u32;
	y: u32;
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

operator == :: (a:Vector3UInt, b:Vector3UInt) -> bool {
	return a.x == b.x && a.y == b.y && a.z == b.z;
}
operator == :: (a:Vector3Int, b:Vector3Int) -> bool {
	return a.x == b.x && a.y == b.y && a.z == b.z;
}
