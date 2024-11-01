// BoxGeoType :: struct {
// 	// type::"box";
// }
// BoxGeoType :string: "box";
BoxGeoParams :: struct {
	size: Vector3Param = .{value=.{1,1,1}};
	scale: FloatParam = .{value=1};
	segments: Vector3UIntParam = .{value=.{1,1,1}};
}
BoxGeoNode :: struct {
	#as using geoNode: GeoNode(BoxGeoNode, BoxGeoParams, init);
	// geoNode.initTypedNode = initBoxGeoNode;
};


cook :GeoNodeCookMethod: (node: *TYPE, inputs:GeoNodeCookInput)->GeoNodeCookOutput {
	mat := newMaterial(NormalMeshMaterial);
	mesh := newObject3D(Mesh);

	geometry_box_attributes_set(mesh.geometry, .{
		size = mult(node.p.size.value, node.p.scale.value),
		segments = node.p.segments.value
	});
	geometry_attributes_validate(mesh.geometry);
	normals_compute(mesh.geometry);

	mesh.material = mat;
	mesh.position = .{x = 0.0, y = 0.0, z = 0.0};
	transformable_update_matrix(mesh);

	return mesh;
}

#scope_file

TYPE :: BoxGeoNode;

init :: (_node: *BaseNodeAny) {
	node := cast(*TYPE)_node;
	// print("init_box_geo_node\n");
	// print("node.params.count 2: %, %\n", node.params.count, node.params);
	// init_geo_node(node);
}
// nodeComputeBoxGeoNode :NodeComputeMethod: (node: *TYPE, depth:u8=0)->GeoNodeCookOutput {
// 	return nodeCompute(cast(*TYPE)node, depth);
// }

