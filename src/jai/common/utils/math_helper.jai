// https://discord.com/channels/661732390355337246/784843664651190273/1143770377957425184
// Degrees :: #type,isa float;
// Radians :: #type,isa float;

// PI :: 3.1415927;

// radians :: inline (degrees : Degrees) -> Radians {
//     return cast(Radians) (degrees * PI / 180.0);
// }

Matrix4x4Buffer :: [16]float;

deg_to_rad :: inline (degrees : float) -> float {
    return cast(float) (degrees * PI / 180.0);
}

matrix4x4_to_buffer :: (matrix: *Matrix4, buffer: *Matrix4x4Buffer) #expand {
	memcpy(buffer.data, matrix, 16 * size_of(float));
}

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
