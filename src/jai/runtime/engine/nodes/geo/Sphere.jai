// SphereGeoParams :: struct {
// 	radius: FloatParam;
// }
// SphereGeoNode :: struct {
// 	#as using contextNode: GeoNode(SphereGeoParams, init, cook, nodeCompute);
// };

// cook :GeoNodeCookMethod: (node: *NODE_TYPE, inputs:GeoNodeCookInput)->GeoNodeCookOutput {
// 	// mat := newMaterial(NormalMeshMaterial);
// 	mesh := newObject3D(Mesh);
// 	print("sphere cook not implemented\n");

// 	// geometry_box_attributes_set(mesh.geometry, .{
// 	// 	size = mult(node.p.size.value, node.p.scale.value),
// 	// 	segments = node.p.segments.value
// 	// });
// 	// geometryAttributesValidate(mesh.geometry);
// 	// normals_compute(mesh.geometry);

// 	// mesh.material = mat;
// 	// mesh.position = .{x = 0.0, y = 0.0, z = 0.0};
// 	// transformableUpdateMatrix(mesh);
	
// 	return mesh;
// }

// #scope_file

// NODE_TYPE :: SphereGeoNode;

// init :: (_node: *BaseNodeAny) {
// 	node := cast(*SphereGeoNode)_node;
// }



