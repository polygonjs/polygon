// // SphereGeoType :: struct {}
// SphereGeoParams :: struct {
// 	radius: FloatParam;
// }
// SphereGeoNode :: struct {
// 	#as using geoNode: GeoNode(SphereGeoParams, init, cook, nodeCompute);
// 	// geoNode.initTypedNode = initSphereGeoNode;
// };

// #scope_file

// NODE_TYPE :: SphereGeoNode;

// init :: (_node: *BaseNodeAny) {
// 	node := cast(*SphereGeoNode)_node;
// 	// print("init_sphere_geo_node\n");
// 	// init_geo_node(node);
// }
// nodeCompute :NodeComputeMethod: (node: *$T, depth:u8=0)->GeoNodeCookOutput {
// 	return nodeCompute(cast(*TYPE)node, depth);
// }

// cook :GeoNodeCookMethod: (node: *NODE_TYPE, inputs:GeoNodeCookInput)->GeoNodeCookOutput {
// 	// mat := newMaterial(NormalMeshMaterial);
// 	mesh := newObject3D(Mesh);
// 	print("sphere cook not implemented\n");

// 	// geometry_box_attributes_set(mesh.geometry, .{
// 	// 	size = mult(node.p.size.value, node.p.scale.value),
// 	// 	segments = node.p.segments.value
// 	// });
// 	// geometry_attributes_validate(mesh.geometry);
// 	// normals_compute(mesh.geometry);

// 	// mesh.material = mat;
// 	// mesh.position = .{x = 0.0, y = 0.0, z = 0.0};
// 	// transformable_update_matrix(mesh);
	
// 	return mesh;
// }
