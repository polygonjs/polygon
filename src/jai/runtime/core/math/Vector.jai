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

Vector2All :: Type.[Vector2, Vector2Int, Vector2UInt, Vector2UInt64];
Vector3All :: Type.[Vector3, Vector3Int, Vector3UInt];
// VectorAll :: #run array_concat(Vector2All, Vector3All);

operator == :: (a:$T/Vector2All, b:T) -> bool {
	return a.x == b.x && a.y == b.y;
}
operator == :: (a:$T/Vector3All, b:T) -> bool {
	return a.x == b.x && a.y == b.y && a.z == b.z;
}
valueEquals :: (tmpValue: [2] float, vector2: Vector2) -> bool #expand {
	return tmpValue[0] == vector2.x && tmpValue[1] == vector2.y;
}
valueEquals :: (tmpValue: [2] s32, vector2: Vector2UInt) -> bool #expand {
	return tmpValue[0] == xx vector2.x && tmpValue[1] == xx vector2.y;
}
valueEquals :: (tmpValue: [3] float, vector3: Vector3) -> bool #expand {
	return tmpValue[0] == vector3.x && tmpValue[1] == vector3.y && tmpValue[2] == vector3.z;
}
valueEquals :: (tmpValue: [3] s32, vector3: Vector3UInt) -> bool #expand {
	return tmpValue[0] == xx vector3.x && tmpValue[1] == xx vector3.y && tmpValue[2] == xx vector3.z;
}

operator - :: (a:$T/Vector2All, b:T) -> T {
	return .{a.x - b.x, a.y - b.y};
}

mult :: inline (a: $T/Vector2All, s: float) -> Vector2 {
	return .{a.x * s, a.y * s};
}
mult :: inline (a: $T/Vector3All, s: float) -> Vector3 {
	return .{a.x * s, a.y * s, a.z * s};
}
length :: (a: $T/Vector2All) -> float {
	return sqrt(a.x*a.x + a.y*a.y);
}

// 0 1 2 3
// 4 5 6 7
// 8 9 10 11
// 12 13 14 15

// 0 4 8 12
// 1 5 9 13
// 2 6 10 14
// 3 7 11 15

// _11 _21 _31 _41
// _12 _22 _32 _42
// _13 _23 _33 _43
// _14 _24 _34 _44

transformDirection :: ( v: $T/Vector3All, m:Matrix4 ) -> T {

	v2 :T = .{
		x = m._11 * v.x + m._12 * v.y + m._13 * v.z,
		y = m._21 * v.x + m._22 * v.y + m._23 * v.z,
		z = m._31 * v.x + m._32 * v.y + m._33 * v.z
	};

	normalize(*v2);

	return v2;
}
ndcToWorld :: ( v: $T/Vector3All, camera:*CameraAny ) -> T {
	v2 := applyMatrix4( v, camera.projectionMatrixInverse );
	v3 := applyMatrix4( v2, camera.matrix ); // .matrixWorld
	return v3;
}
worldToNDC :: ( v: $T/Vector3All, camera:*CameraAny ) -> T {
	v2 := applyMatrix4( v, camera.matrixInverse );
	v3 := applyMatrix4( v2, camera.projectionMatrix );
	return v3;
}

applyMatrix4 :: ( v: $T/Vector3All, m:Matrix4 ) -> T {
	w := 1 / ( m._41 * v.x + m._42 * v.y + m._43 * v.z + m._44 );

	v2 :T = .{
		x = ( m._11 * v.x + m._12 * v.y + m._13 * v.z + m._14 ) * w,
		y = ( m._21 * v.x + m._22 * v.y + m._23 * v.z + m._24 ) * w,
		z = ( m._31 * v.x + m._32 * v.y + m._33 * v.z + m._34 ) * w
	};

	return v2;

}

angle :: (v: $T/Vector2All) -> float {
	return atan2(-v.y, -v.x) + PI;
}
// angle :: (v: $T/Vector2All, to: $T/Vector2All) -> float {
// 	enominator = Math.sqrt( this.lengthSq() * v.lengthSq() )
// }



// 	angleTo( v ) {

// 		const denominator = Math.sqrt( this.lengthSq() * v.lengthSq() );

// 		if ( denominator === 0 ) return Math.PI / 2;

// 		const theta = this.dot( v ) / denominator;

// 		// clamp, to handle numerical problems

// 		return Math.acos( MathUtils.clamp( theta, - 1, 1 ) );

// 	}