


firstGeometry :: (nodesScene:*NodesScene)->*Geometry {
	if nodesScene.worldScene.children.count == 0 {
		return null;
	}
	firstObject := nodesScene.worldScene.children[0];
	return (cast(*Mesh)firstObject).geometry;
}
firstGeometryBbox :: (nodesScene:*NodesScene)->Box3 {
	box3:Box3;
	box3SetFromGeometry(*box3, firstGeometry(nodesScene));
	return box3;
}
firstGeometryBboxSize :: (nodesScene:*NodesScene)->Vector3 {
	box3:Box3;
	box3SetFromGeometry(*box3, firstGeometry(nodesScene));
	return box3Size(*box3);
}
