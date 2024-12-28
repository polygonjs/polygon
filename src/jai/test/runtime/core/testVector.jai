testVector :: (){
	test("testVector vector3 applyMatrix",(options:TestProcedureOptions) {
		matrix :Matrix4;
		identity(*matrix);
		translate(*matrix, .{1,2,3});

		vector3 :Vector3= .{0,0,0};
		vector3b := applyMatrix4(vector3, matrix);
		assertEqual(vector3b.x, 1);
		assertEqual(vector3b.y, 2);
		assertEqual(vector3b.z, 3);
		endTest();
	});
}
